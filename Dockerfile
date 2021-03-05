FROM alpine:3.9 as build

# Install all build dependencies
RUN apk update && \
   apk add --virtual build-dependencies \
       build-base gcc git
#RUN apk del build-dependencies

# ADD the GitHub API's representation of repo to a dummy location. 
# The API call will return different results when the head changes, invalidating the docker cache.
ADD https://api.github.com/repos/Connectitude/picoGW_hal/git/refs/heads/master version.json
RUN git clone -b master https://github.com/Connectitude/picoGW_hal.git && \
    cd /picoGW_hal && make clean all

# ADD the GitHub API's representation of repo to a dummy location. 
# The API call will return different results when the head changes, invalidating the docker cache.
ADD https://api.github.com/repos/Connectitude/picoGW_packet_forwarder/git/refs/heads/master version.json
RUN git clone -b master https://github.com/Connectitude/picoGW_packet_forwarder.git && \
    cd /picoGW_packet_forwarder && make clean all

FROM alpine:3.9

WORKDIR /gateway
COPY --from=build /picoGW_hal/util_boot ./util_boot
COPY --from=build /picoGW_hal/util_chip_id ./util_chip_id
COPY --from=build /picoGW_packet_forwarder/lora_pkt_fwd ./lora_pkt_fwd

COPY start.sh ./lora_pkt_fwd/start.sh
RUN chmod +x ./lora_pkt_fwd/start.sh

WORKDIR /gateway/lora_pkt_fwd

EXPOSE 1680/udp

CMD ["./start.sh"]