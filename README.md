# Default sitespeed.io dashboards for Graphite
Run this container to get a default Graphite datasource linked with the default sitespeed.io dashboards.

To run it you need to set following environment variables:
* *GF_USER* - The Grafana user that has privileges to setup dashboards & datasources
* *GF_PASSWORD* - The password for the Grafana user

You can also set the path to the Grafana API with *GF_API* (default is http://grafana:3000/api).

# Add a new dashboard
1. Export from Grafana and put in in the /dashboards-original/ folder
2. ./convert.js
3. Rebuild the container
4. Run the container
