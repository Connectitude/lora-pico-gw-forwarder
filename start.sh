#!/bin/sh

if [[ ! -f "data/local_conf.json" ]]; then
    gatewayIdStatus=1
    while [ $gatewayIdStatus -gt 0 ]
    do
        gatewayId=$("../util_chip_id/util_chip_id")
        echo $gatewayId

        if [[ $gatewayId != *"ERROR: FAIL TO CONNECT BOARD"* ]]; then
            cat > data/local_conf.json << __EOM__
{   
    "gateway_conf": {
        "gateway_ID": "$gatewayId"
    }
}
__EOM__
            gatewayIdStatus=0
        fi

        sleep 5
    done
fi

./lora_pkt_fwd