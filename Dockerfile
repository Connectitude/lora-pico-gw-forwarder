FROM buildpack-deps:buster as build

RUN git clone -b master https://github.com/Lora-net/picoGW_hal.git && \
    git clone -b master https://github.com/Lora-net/picoGW_packet_forwarder.git && \
    cd /picoGW_hal && make clean all && \
    cd /picoGW_packet_forwarder && make clean all

FROM alpine:3.9

WORKDIR /gateway
COPY --from=build /. .

WORKDIR /gateway/picoGW_packet_forwarder/lora_pkt_fwd

EXPOSE 1680/udp

CMD ["./lora_pkt_fwd"]