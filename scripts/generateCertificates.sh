# clean all the files in gitignore
sh ./scripts/clean.sh

#!/bin/sh
set -e

echo
echo "#################################################################"
echo "#######        Generating cryptographic material       ##########"
echo "#################################################################"
PROJPATH=$(pwd)
TOOLS=$PROJPATH/tools
CONFIGS=$PROJPATH/configs
PEERS=$PROJPATH/peers
ORDERER=$PROJPATH/orderer
CLIPATH=$PROJPATH/cli
ORGANISATIONS_PATH=$CLIPATH/organisations
ANCHOR_TRANSACTIONS_PATH=$CLIPATH/anchorTransactions
CHANNEL_TRANSACTIONS_PATH=$CLIPATH/channelTransactions
GENESIS_BLOCK_TRANSACTIONS_PATH=$CLIPATH/genesisBlockTransaction
CA=$PROJPATH/ca
CLIPATH_ORDERERS=$ORGANISATIONS_PATH/ordererOrganizations
CLIPATH_PEER_ORGANIZATIONS=$ORGANISATIONS_PATH/peerOrganizations

mkdir $CLIPATH
mkdir $ORGANISATIONS_PATH
mkdir $ANCHOR_TRANSACTIONS_PATH
mkdir $CHANNEL_TRANSACTIONS_PATH
mkdir $GENESIS_BLOCK_TRANSACTIONS_PATH
mkdir $PROJPATH/web/channelTransactions


# rm -rf $CLIPATH
$TOOLS/cryptogen generate --config=$CONFIGS/crypto-config.yaml --output=$ORGANISATIONS_PATH

sh ./scripts/generateConfigTX.sh

rm -rf $ORDERER/crypto
mkdir $ORDERER/crypto
rm -rf $PEERS/{MPBrokerPeer,CustomerAPeer,CustomerBPeer,CustomerCPeer,CustomerDPeer}/crypto
mkdir $PEERS/{MPBrokerPeer,CustomerAPeer,CustomerBPeer,CustomerCPeer,CustomerDPeer}/crypto
cp -r $CLIPATH_ORDERERS/orderer-org/orderers/orderer0/{msp,tls} $ORDERER/crypto
cp -r $CLIPATH_PEER_ORGANIZATIONS/mp-broker-org/peers/mp-broker-peer/{msp,tls} $PEERS/MPBrokerPeer/crypto
cp -r $CLIPATH_PEER_ORGANIZATIONS/customer-a-org/peers/customer-a-peer/{msp,tls} $PEERS/CustomerAPeer/crypto
cp -r $CLIPATH_PEER_ORGANIZATIONS/customer-b-org/peers/customer-b-peer/{msp,tls} $PEERS/CustomerBPeer/crypto
cp -r $CLIPATH_PEER_ORGANIZATIONS/customer-c-org/peers/customer-c-peer/{msp,tls} $PEERS/CustomerCPeer/crypto
cp -r $CLIPATH_PEER_ORGANIZATIONS/customer-d-org/peers/customer-d-peer/{msp,tls} $PEERS/CustomerDPeer/crypto

cp $GENESIS_BLOCK_TRANSACTIONS_PATH/genesis.block $ORDERER

CUSTOMERA_CA_PATH=$PROJPATH/ca/customerACA
CUSTOMERB_CA_PATH=$PROJPATH/ca/customerBCA
CUSTOMERC_CA_PATH=$PROJPATH/ca/customerCCA
CUSTOMERD_CA_PATH=$PROJPATH/ca/customerDCA
MARKET_PLACE_BROKER_CA_PATH=$PROJPATH/ca/mpBrokerCA


rm -rf {$CUSTOMERA_CA_PATH,$CUSTOMERB_CA_PATH,$CUSTOMERC_CA_PATH,$CUSTOMERD_CA_PATH,$MARKET_PLACE_BROKER_CA_PATH}/{ca,tls}
mkdir -p {$CUSTOMERA_CA_PATH,$CUSTOMERB_CA_PATH,$CUSTOMERC_CA_PATH,$CUSTOMERD_CA_PATH,$MARKET_PLACE_BROKER_CA_PATH}/{ca,tls}

cp $CLIPATH_PEER_ORGANIZATIONS/customer-a-org/ca/* $CUSTOMERA_CA_PATH/ca
cp $CLIPATH_PEER_ORGANIZATIONS/customer-a-org/tlsca/* $CUSTOMERA_CA_PATH/tls
mv $CUSTOMERA_CA_PATH/ca/*_sk $CUSTOMERA_CA_PATH/ca/key.pem
mv $CUSTOMERA_CA_PATH/ca/*-cert.pem $CUSTOMERA_CA_PATH/ca/cert.pem
mv $CUSTOMERA_CA_PATH/tls/*_sk $CUSTOMERA_CA_PATH/tls/key.pem
mv $CUSTOMERA_CA_PATH/tls/*-cert.pem $CUSTOMERA_CA_PATH/tls/cert.pem

cp $CLIPATH_PEER_ORGANIZATIONS/customer-b-org/ca/* $CUSTOMERB_CA_PATH/ca
cp $CLIPATH_PEER_ORGANIZATIONS/customer-b-org/tlsca/* $CUSTOMERB_CA_PATH/tls
mv $CUSTOMERB_CA_PATH/ca/*_sk $CUSTOMERB_CA_PATH/ca/key.pem
mv $CUSTOMERB_CA_PATH/ca/*-cert.pem $CUSTOMERB_CA_PATH/ca/cert.pem
mv $CUSTOMERB_CA_PATH/tls/*_sk $CUSTOMERB_CA_PATH/tls/key.pem
mv $CUSTOMERB_CA_PATH/tls/*-cert.pem $CUSTOMERB_CA_PATH/tls/cert.pem

cp $CLIPATH_PEER_ORGANIZATIONS/customer-c-org/ca/* $CUSTOMERC_CA_PATH/ca
cp $CLIPATH_PEER_ORGANIZATIONS/customer-c-org/tlsca/* $CUSTOMERC_CA_PATH/tls
mv $CUSTOMERC_CA_PATH/ca/*_sk $CUSTOMERC_CA_PATH/ca/key.pem
mv $CUSTOMERC_CA_PATH/ca/*-cert.pem $CUSTOMERC_CA_PATH/ca/cert.pem
mv $CUSTOMERC_CA_PATH/tls/*_sk $CUSTOMERC_CA_PATH/tls/key.pem
mv $CUSTOMERC_CA_PATH/tls/*-cert.pem $CUSTOMERC_CA_PATH/tls/cert.pem

cp $CLIPATH_PEER_ORGANIZATIONS/customer-d-org/ca/* $CUSTOMERD_CA_PATH/ca
cp $CLIPATH_PEER_ORGANIZATIONS/customer-d-org/tlsca/* $CUSTOMERD_CA_PATH/tls
mv $CUSTOMERD_CA_PATH/ca/*_sk $CUSTOMERD_CA_PATH/ca/key.pem
mv $CUSTOMERD_CA_PATH/ca/*-cert.pem $CUSTOMERD_CA_PATH/ca/cert.pem
mv $CUSTOMERD_CA_PATH/tls/*_sk $CUSTOMERD_CA_PATH/tls/key.pem
mv $CUSTOMERD_CA_PATH/tls/*-cert.pem $CUSTOMERD_CA_PATH/tls/cert.pem

cp $CLIPATH_PEER_ORGANIZATIONS/mp-broker-org/ca/* $MARKET_PLACE_BROKER_CA_PATH/ca
cp $CLIPATH_PEER_ORGANIZATIONS/mp-broker-org/tlsca/* $MARKET_PLACE_BROKER_CA_PATH/tls
mv $MARKET_PLACE_BROKER_CA_PATH/ca/*_sk $MARKET_PLACE_BROKER_CA_PATH/ca/key.pem
mv $MARKET_PLACE_BROKER_CA_PATH/ca/*-cert.pem $MARKET_PLACE_BROKER_CA_PATH/ca/cert.pem
mv $MARKET_PLACE_BROKER_CA_PATH/tls/*_sk $MARKET_PLACE_BROKER_CA_PATH/tls/key.pem
mv $MARKET_PLACE_BROKER_CA_PATH/tls/*-cert.pem $MARKET_PLACE_BROKER_CA_PATH/tls/cert.pem

WEBCERTS=$PROJPATH/web/certs
rm -rf $WEBCERTS
mkdir -p $WEBCERTS

cp $ORDERER/crypto/tls/ca.crt $WEBCERTS/ordererOrg.pem
cp $PEERS/CustomerAPeer/crypto/tls/ca.crt $WEBCERTS/customerAPeer.pem
cp $PEERS/CustomerBPeer/crypto/tls/ca.crt $WEBCERTS/customerBPeer.pem
cp $PEERS/CustomerCPeer/crypto/tls/ca.crt $WEBCERTS/customerCPeer.pem
cp $PEERS/CustomerDPeer/crypto/tls/ca.crt $WEBCERTS/customerDPeer.pem
cp $PEERS/MPBrokerPeer/crypto/tls/ca.crt $WEBCERTS/mpBrokerPeer.pem
cp $CLIPATH_PEER_ORGANIZATIONS/customer-a-org/users/Admin@customer-a-org/msp/keystore/* $WEBCERTS/Admin@customer-a-org-key.pem
cp $CLIPATH_PEER_ORGANIZATIONS/customer-a-org/users/Admin@customer-a-org/msp/signcerts/* $WEBCERTS/
cp $CLIPATH_PEER_ORGANIZATIONS/customer-b-org/users/Admin@customer-b-org/msp/keystore/* $WEBCERTS/Admin@customer-b-org-key.pem
cp $CLIPATH_PEER_ORGANIZATIONS/customer-b-org/users/Admin@customer-b-org/msp/signcerts/* $WEBCERTS/
cp $CLIPATH_PEER_ORGANIZATIONS/customer-c-org/users/Admin@customer-c-org/msp/keystore/* $WEBCERTS/Admin@customer-c-org-key.pem
cp $CLIPATH_PEER_ORGANIZATIONS/customer-c-org/users/Admin@customer-c-org/msp/signcerts/* $WEBCERTS/
cp $CLIPATH_PEER_ORGANIZATIONS/customer-d-org/users/Admin@customer-d-org/msp/keystore/* $WEBCERTS/Admin@customer-d-org-key.pem
cp $CLIPATH_PEER_ORGANIZATIONS/customer-d-org/users/Admin@customer-d-org/msp/signcerts/* $WEBCERTS/
cp $CLIPATH_PEER_ORGANIZATIONS/mp-broker-org/users/Admin@mp-broker-org/msp/keystore/* $WEBCERTS/Admin@mp-broker-org-key.pem
cp $CLIPATH_PEER_ORGANIZATIONS/mp-broker-org/users/Admin@mp-broker-org/msp/signcerts/* $WEBCERTS/
