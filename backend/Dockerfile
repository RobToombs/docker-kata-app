FROM openjdk:8-jre-alpine

# Add a toombs group/user to avoid using superuser
RUN addgroup -S toombs && adduser -S toombs -G toombs
USER toombs:toombs

# Copy our built application into the Docker image
ARG DEPENDENCY=build/dependency
COPY ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY ${DEPENDENCY}/META-INF /app/META-INF
COPY ${DEPENDENCY}/BOOT-INF/classes /app

EXPOSE 8080

# Set application environment variables, these are referenced in the application.yml
ENV DB_SERVER=kata-postgres-container
ENV POSTGRES_PASSWORD=admin
ENV POSTGRES_USER=postgres
ENV POSTGRES_DB=postgres

ENTRYPOINT ["java","-cp","app:app/lib/*","com.toombs.backend.BackendApplication"]