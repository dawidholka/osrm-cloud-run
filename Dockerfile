FROM osrm/osrm-backend

RUN mkdir -p /data
ADD http://download.geofabrik.de/europe/poland/pomorskie-latest.osm.pbf /data

RUN osrm-extract -p /opt/car.lua /data/pomorskie-latest.osm.pbf && \
     osrm-partition /data/pomorskie-latest.osrm &&  osrm-customize \
    /data/pomorskie-latest.osrm  && rm /data/pomorskie-latest.osm.pbf

EXPOSE 5000

CMD osrm-routed --algorithm mld /data/pomorskie-latest.osrm
