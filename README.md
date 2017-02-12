
# Default sitespeed.io dashboards for Graphite

Run this container to get a default Graphite datasource linked with the default sitespeed.io dashboards.

The following environment variables can be set:

* *GF_USER* - Grafana user that has privileges to setup dashboards & datasources (default: sitespeedio)
* *GF_PASSWORD* - password for the Grafana user (default: hdeAga76VG6ga7plZ1)
* *GF_API*  - path to the Grafana API (default: ["http://grafana:3000/api"](http://grafana:3000/api)).

Example: `docker run -it --link graphite_grafana_1:grafana --network graphite_default sitespeedio_dashboards`

# Add a new dashboard

1. Export json from Grafana (see [Grafana Doc](http://docs.grafana.org/reference/export_import/)) and put it in the /dashboards folder
1. Rebuild the container `docker build -t sitespeedio_dashboards .`
1. Run the container `docker run -it --link <name of your grafana container>:grafana --network <name of your grafana network> sitespeedio_dashboards`
