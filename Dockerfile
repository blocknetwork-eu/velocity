FROM docker.io/library/eclipse-temurin:21-jre-noble

ARG VELOCITY_VERSION
ARG VELOCITY_BUILD

WORKDIR /opt/velocity

RUN wget https://api.papermc.io/v2/projects/velocity/versions/${VELOCITY_VERSION}/builds/${VELOCITY_BUILD}/downloads/velocity-${VELOCITY_VERSION}-${VELOCITY_BUILD}.jar -O velocity.jar

RUN mkdir -p plugins/bStats/ && echo "enabled=false" > plugins/bStats/config.txt

ENTRYPOINT ["java", "-Xms1G", "-Xmx1G", "-XX:+UseG1GC", "-XX:G1HeapRegionSize=4M", "-XX:+UnlockExperimentalVMOptions", "-XX:+ParallelRefProcEnabled", "-XX:+AlwaysPreTouch", "-XX:MaxInlineLevel=15", "-jar", "velocity.jar"]