# prometheus-template

LabRamen template for Prometheus on Ubuntu 24.04 LXC.

Installs the latest Prometheus release from GitHub as a systemd service on port 9090. Ships with the upstream default config that scrapes only Prometheus itself — no pre-configured targets, alerting rules, or recording rules. A blank slate ready for your monitoring setup.

## Defaults

| Resource | Default |
|----------|---------|
| CPU | 2 cores |
| Memory | 2048 MB |
| Disk | 12 GB |
| OS | Ubuntu 24.04 |
| Prometheus Port | 9090 |

## After Deployment

1. Edit `/etc/prometheus/prometheus.yml` to add your scrape targets (e.g., node_exporter, your apps)
2. Run `sudo systemctl restart prometheus` to apply config changes
3. Browse to `http://<container-ip>:9090` to query metrics
4. Point your Grafana instance at this Prometheus as a datasource to build dashboards
