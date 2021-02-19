# LoRa Picocell Gateway and packet forwarder from Semtech for Docker
Based on the following repositories
- [LoRa Picocell Gateway HAL](https://github.com/Lora-net/picoGW_hal)
- [LoRa network packet forwarder](https://github.com/Lora-net/picoGW_packet_forwarder)
## Getting started

Start the pico-gateway container by passing the config file (global_conf.json) and the serial device (ex: /dev/ttyACM0)

    docker run -v $PWD/data:/gateway/lora_pkt_fwd/data --device=/dev/ttyACM0 -p 1680:1680/udp connectitude/lora-pico-gw-forwarder:<version>
    docker run -v $PWD/data:/gateway/lora_pkt_fwd/data --device=/dev/ttyACM0 --network host connectitude/lora-pico-gw-forwarder:<version>