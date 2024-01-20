# email-report-processor

A tool to submit e-mail reports into OpenSearch.

> [!CAUTION]
> This is work-in-progress, expect things to change.

## Configuration

### Mail server

It is recommended to configure an e-mail address that will handle the reports (dedicated to this usage).  When a mail is received, it must be piped to `email-report-processor`.
This can be done unsing a `forward(5)` file for example:

```
echo "| email-report-processor" > ~reports/.forward
```

Alternatively check mail headers, set filters and pipe messages using your preferred tooling.

### DMARC Reporting

Reports SPF / DKIM results when receiving mail from your domain.

#### Configuration

Setup the e-mail address to send aggregate reports using the `rua` field of the DMARC DNS record:

```
_dmarc.<domain>. 10800	IN      TXT "v=DMARC1; rua=mailto:dmarc-rua@<domain>;"
```

In OpenSearch, setup the `dmarc-reports` index with the following mappings:

```
PUT /dmarc-reports
{
  "mappings": {
    "properties": {
      "feedback": {
        "properties": {
          "report_metadata": {
            "properties": {
              "date_range": {
                "properties": {
                  "begin": {
                    "type": "date",
                    "format": "epoch_second"
                  },
                  "end": {
                    "type": "date",
                    "format": "epoch_second"
                  }
                }
              }
            }
          },
          "policy_published": {
            "properties": {
              "pct": {
                "type": "integer"
              }
            }
          },
          "record": {
            "properties": {
              "row": {
                "properties": {
                  "source_ip": {
                    "type": "ip"
                  },
                  "count": {
                    "type": "integer"
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
```

### SMTP TLS Reporting

Reports about TLS usage when contacting your mail server.

#### Configuration

Configure the e-mail address to send reports to using the `rua` field of the SMTP TLS DNS record:

```
_smtp._tls.<domain>. 10800	IN	TXT	"v=TLSRPTv1; rua=mailto:smtl-tls-rua@<domain>"
```

In OpenSearch, setup the `tls-reports` index with the following mappings:

```
PUT /tls-reports
{
  "mappings": {
    "properties": {
      "date-range": {
        "properties": {
          "start-datetime": {
            "type": "date",
            "format": "date_time_no_millis"
          },
          "end-datetime": {
            "type": "date",
            "format": "date_time_no_millis"
          }
        }
      }
    }
  }
}
```

### MTA-STS Reporting

HSTS for SMTP: Indicate that a given server support Encrypted SMTP and STARTTLS MUST be used when talking to it.

> [!NOTE]
> Not supported ATM


#### Configuration

```
_mta-sts.blogreen.org.	10800	IN	TXT	"v=STSv1; id=2019020100"
```

## References

DMARC reports
https://support.google.com/a/answer/10032472?hl=en

4. Turn on MTA-STS and TLS reporting
https://support.google.com/a/answer/9276512?hl=en

SMTP MTA Strict Transport Security (MTA-STS)
https://www.rfc-editor.org/rfc/rfc8461.txt

Introducing MTA Strict Transport Security (MTA-STS)
https://www.hardenize.com/blog/mta-sts
