# Use an Ubuntu base image
FROM ubuntu:18.04

# Set the working directory
WORKDIR /home/cs1.6

# Update and install dependencies
RUN apt-get update && \
    apt-get install -y wget lib32gcc1 && \
    apt-get clean

# Download and extract the Counter-Strike 1.6 server files
RUN wget https://cdn.csdownload.pm/dl/HLDS-CS-1.6.zip && \
    apt-get install -y unzip && \
    unzip HLDS-CS-1.6.zip && \
    rm HLDS-CS-1.6.zip

# Set the environment variables
ENV SERVER_NAME "My CS1.6 Server"
ENV RCON_PASSWORD "changeme"
ENV START_MAP "de_dust2"

# Expose the necessary ports
EXPOSE 27015/udp
EXPOSE 27015/tcp

# Set the entry point to start the server
ENTRYPOINT ./hlds_run -game cstrike -console -nomaster +sv_lan 0 +map $START_MAP +maxplayers 16 +rcon_password $RCON_PASSWORD +hostname "$SERVER_NAME"
