#!/bin/bash
set -eu

dockerFabricPull() {
  local FABRIC_TAG=$1
  for IMAGES in peer orderer ccenv; do
      echo "==> FABRIC IMAGE: $IMAGES"
      echo
      docker pull hyperledger/fabric-$IMAGES:$FABRIC_TAG
      docker tag hyperledger/fabric-$IMAGES:$FABRIC_TAG hyperledger/fabric-$IMAGES
  done
}

dockerCaPull() {
      local CA_TAG=$1
      echo "==> FABRIC CA IMAGE"
      echo
      docker pull hyperledger/fabric-ca:$CA_TAG
      docker tag hyperledger/fabric-ca:$CA_TAG hyperledger/fabric-ca
}

BUILD=
DOWNLOAD=
if [ $# -eq 0 ]; then
    BUILD=true
    PUSH=true
    DOWNLOAD=true
else
    for arg in "$@"
        do
            if [ $arg == "build" ]; then
                BUILD=true
            fi
            if [ $arg == "download" ]; then
                DOWNLOAD=true
            fi
    done
fi

if [ $DOWNLOAD ]; then
    : ${CA_TAG:="1.4"}
    : ${FABRIC_TAG:="1.4"}

    echo "===> Pulling fabric Images"
    dockerFabricPull ${FABRIC_TAG}

    echo "===> Pulling fabric ca Image"
    dockerCaPull ${CA_TAG}
    echo
    echo "===> List out hyperledger docker images"
    docker images | grep hyperledger*
fi

if [ $BUILD ];
    then
    echo '############################################################'
    echo '#                 BUILDING CONTAINER IMAGES                #'
    echo '############################################################'
    docker build -t orderer:latest orderer/

    docker build -t customer-a-peer:latest peers/customerAPeer/
    docker build -t customer-b-peer:latest peers/customerBPeer/
    docker build -t customer-c-peer:latest peers/customerCPeer/
    docker build -t customer-d-peer:latest peers/customerDPeer/
    docker build -t mp-broker-peer:latest peers/mpBrokerPeer/

    docker build -t customer-a-ca:latest ca/customerACA/
    docker build -t customer-b-ca:latest ca/customerBCA/
    docker build -t customer-c-ca:latest ca/customerCCA/
    docker build -t customer-d-ca:latest ca/customerDCA/
    docker build -t mp-broker-ca:latest ca/mpBrokerCA/
fi
