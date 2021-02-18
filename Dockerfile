FROM buildpack-deps:buster as build

RUN git clone -b master https://github.com/Lora-net/picoGW_hal.git && \
    git clone -b master https://github.com/Lora-net/picoGW_packet_forwarder.git && \
    cd /picoGW_hal && make clean all && \
    cd /picoGW_packet_forwarder && make clean all

FROM alpine:3.9

WORKDIR /gateway
COPY --from=build /picoGW_hal/util_boot ./util_boot
COPY --from=build /picoGW_hal/util_chip_id ./util_chip_id
COPY --from=build /picoGW_packet_forwarder/lora_pkt_fwd ./lora_pkt_fwd

WORKDIR /gateway/lora_pkt_fwd

EXPOSE 1680/udp

CMD ["./lora_pkt_fwd"]