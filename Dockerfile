FROM osrm/osrm-backend

ARG DOWNLOAD_LINK=http://download.geofabrik.de/europe/poland/pomorskie-latest.osm.pbf
ENV DOWNLOAD_LINK ${DOWNLOAD_LINK}

ARG FILENAME=pomorskie-latest
ENV FILENAME ${FILENAME}

RUN mkdir -p /data
ADD $DOWNLOAD_LINK /data

RUN osrm-extract -p /opt/car.lua /data/$FILENAME.osm.pbf && \
     osrm-partition /data/$FILENAME.osrm &&  osrm-customize \
    /data/$FILENAME.osrm  && rm /data/$FILENAME.osm.pbf

EXPOSE 5000

CMD osrm-routed --algorithm mld /data/$FILENAME.osrm
