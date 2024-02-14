# Advanced usage

## Add ASN Information to DMARC reports

DMARC reports include the IP address of the machine which sent messages.
In order to ease-up filtering, it is possible to enrich reports with the [GeoLite2 ASN Database](https://dev.maxmind.com/geoip/docs/databases/asn) to add `asn`, `network` and `organization_name` to them.
This can be done using the [IP2Geo processor](https://opensearch.org/docs/latest/ingest-pipelines/processors/ip2geo/) (available since OpenSearch 2.10).

1. Add an `asn` IP2Geo data source:

```
PUT /_plugins/geospatial/ip2geo/datasource/asn
{
  "endpoint": "https://geoip.maps.opensearch.org/v1/geolite2-asn/manifest.json",
  "update_interval_in_days": 3
}
```

2. Add a `dmarc` ingestion pipeline that use the `asn` IP2Geo data source:

```
PUT /_ingest/pipeline/dmarc
{
  "description": "Add ASN metadata for report source IP",
  "processors": [
    {
      "ip2geo": {
        "field": "feedback.record.row.source_ip",
        "datasource": "asn"
      }
    }
  ]
}
```

3. Instruct `email-report-processor` to use the `dmarc` ingestion pipeline:

```sh-session
email-report-processor --dmarc-pipeline=dmarc
```
