# email-report-processor

A tool to submit e-mail reports (DMARC, SMTP TLS) into OpenSearch.

> [!CAUTION]
> This is work-in-progress, expect things to change.

## Configuration

### Mail server

It is recommended to configure an e-mail address that will handle the reports (dedicated to this usage).  When a mail is received, it must be piped to `email-report-processor`.
This can be done using a `forward(5)` file for example:

```
echo "| email-report-processor" > ~reports/.forward
```

Alternatively check mail headers, set filters and pipe messages using your preferred tooling.

### DMARC Aggregate Reports

DMARC aggregate feedback reports are defined in [RFC7489, section 7.2](https://datatracker.ietf.org/doc/html/rfc7489#section-7.2).
They include information about SPF and DKIM check results for e-mail you send.

#### Configuration

Setup the e-mail address to send aggregate reports using the `rua` field of the DMARC DNS record:

```
_dmarc.<domain>. 10800	IN      TXT "v=DMARC1; rua=mailto:dmarc-rua@<domain>;"
```

### SMTP TLS Reporting

SMTP TLS reports are defined in [RFC8460](https://datatracker.ietf.org/doc/html/rfc8460).
They include information about cryptography usage for mail you receive.

#### Configuration

Configure the e-mail address to send reports to using the `rua` field of the SMTP TLS DNS record:

```
_smtp._tls.<domain>. 10800	IN	TXT	"v=TLSRPTv1; rua=mailto:smtl-tls-rua@<domain>"
```

### OpenSearch Dashboards

We provide example dashboards in the `contrib/dashboards` directory.
To import them in OpenSearch Dashboards, as an administrator, go to Management → Dashboards Management → Saved Objects → Import and select the .ndjson files.

## Usage

> [!TIP]
> In this section we assume you installed the example dashboards provided in the `contrib/dashboards` directory of the project.

After importing reports, open the "DMARC Aggregated Report" dashboard and adjust the date range in the top-right corner so see some data.

If you process reports for multiple domains, it is probably better to check them one by one: in the "DMARC Reports Messages by Domain" visualization, select a single domain to view only reports related to this domain.

Filtering by source IP is then the most straightforward way to dig into the data: the first addresses (those which correspond to the ones that sent more messages) are likely the IP addresses of your mail servers and should have passing SPF and DKIM.
Filter on the first one to verify this, and when verified, exclude it to focus on the remaining source IP addresses.
Rinse and repeat until you find a source IP that has failed DMARC checks.

Reports with passing SPF and failing DKIM are issues on your side: mail is sent from an authorized IP address but does not have the expected DKIM signature.
Check the logs and configuration of the service that handle DKIM on your server.

Reports with passing DKIM and failing SPF correspond to mail sent from an unauthorized IP address but which has a passing signature: either the IP address should be authorized (your problem), or someone is relaying your mail without doing address rewriting (they send e-mail from _their_ server pretending being you, which is probably what you don't want to see).

Reports with both failing DKIM and failing SPF are likely spammers trying to impersonate you, and may not deserve much attention.
But if a single IP address is regularly attempting to send messages, better double-check this: some companies try to do _weird_ things!
