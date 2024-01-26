# email-report-processor

A tool to submit e-mail reports (DMARC, SMTP TLS) into OpenSearch.

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

### DMARC Aggregate Reports

DMARC aggregate feedback reports are defined in [RFC7489, section 7.2](https://datatracker.ietf.org/doc/html/rfc7489#section-7.2).
They include information about SPF and DKIM check results for e-mail you send.

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

SMTP TLS reports are defined in [RFC8460](https://datatracker.ietf.org/doc/html/rfc8460).
They include information about cryptography usage for mail you receive.

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
