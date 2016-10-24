# Default sitespeed.io dashboards for Graphite
Run this container to get a default Graphite datasource linked with the default sitespeed.io dashboards.

The following environment variables can be set:
* *GF_USER* - Grafana user that has privileges to setup dashboards & datasources (default: admin)
* *GF_PASSWORD* - password for the Grafana user (default: admin)
* *GF_API*  - path to the Grafana API (default: http://grafana:3000/api).

# Add a new dashboard
1. Export json from Grafana and put in in the /dashboards folder
1. Rebuild the container
1. Run the container
