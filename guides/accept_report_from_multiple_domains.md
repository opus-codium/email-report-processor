# Accept reports from multiple domains

When configuring a first domain name (e.g. `example.com`) DMARC record to send reports to an e-mail address on a different domain name (e.g. `example.org`), the receiving domain must announce it accepts reports for the first domain.
This is done by publishing a DNS record as stated in section 7.1 of [RFC7489](https://www.rfc-editor.org/rfc/rfc7489):

```
example.com._report._dmarc.example.org IN TXT "v=DMARC1"
```

For convenience, one can configure a wildcard to accept reports for all domain names:

```
*._report._dmarc.example.org IN TXT "v=DMARC1"
```

Refer to RFC7489 for drawbacks of "disabling" this check.
