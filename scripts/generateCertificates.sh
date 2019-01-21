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
CLIPATH=$PROJPATH/cli/peers
CLIPATHORDERERS=$CLIPATH/ordererOrganizations
CLIPATHPEERS=$CLIPATH/peerOrganizations


rm -rf $CLIPATH
$TOOLS/cryptogen generate --config=$CONFIGS/crypto-config.yaml --output=$CLIPATH

sh ./scripts/generateConfigTX.sh

rm -rf $ORDERER/crypto
mkdir $ORDERER/crypto
rm -rf $PEERS/{MPBrokerPeer,CustomerAPeer,CustomerBPeer,CustomerCPeer,CustomerDPeer}/crypto
mkdir $PEERS/{MPBrokerPeer,CustomerAPeer,CustomerBPeer,CustomerCPeer,CustomerDPeer}/crypto
cp -r $CLIPATHORDERERS/orderer-org/orderers/orderer0/{msp,tls} $ORDERER/crypto
cp -r $CLIPATHPEERS/mp-broker-org/peers/mp-broker-peer/{msp,tls} $PEERS/MPBrokerPeer/crypto
cp -r $CLIPATHPEERS/customer-a-org/peers/customer-a-peer/{msp,tls} $PEERS/CustomerAPeer/crypto
cp -r $CLIPATHPEERS/customer-b-org/peers/customer-b-peer/{msp,tls} $PEERS/CustomerBPeer/crypto
cp -r $CLIPATHPEERS/customer-c-org/peers/customer-c-peer/{msp,tls} $PEERS/CustomerCPeer/crypto
cp -r $CLIPATHPEERS/customer-d-org/peers/customer-d-peer/{msp,tls} $PEERS/CustomerDPeer/crypto

cp $CLIPATH/genesis.block $ORDERER

# INSURANCECAPATH=$PROJPATH/insuranceCA
# POLICECAPATH=$PROJPATH/policeCA
# REPAIRSHOPCAPATH=$PROJPATH/repairShopCA
# SHOPCAPATH=$PROJPATH/shopCA

# rm -rf {$INSURANCECAPATH,$POLICECAPATH,$REPAIRSHOPCAPATH,$SHOPCAPATH}/{ca,tls}
# mkdir -p {$INSURANCECAPATH,$POLICECAPATH,$REPAIRSHOPCAPATH,$SHOPCAPATH}/{ca,tls}
# cp $CLIPATHPEERS/insurance-org/ca/* $INSURANCECAPATH/ca
# cp $CLIPATHPEERS/insurance-org/tlsca/* $INSURANCECAPATH/tls
# mv $INSURANCECAPATH/ca/*_sk $INSURANCECAPATH/ca/key.pem
# mv $INSURANCECAPATH/ca/*-cert.pem $INSURANCECAPATH/ca/cert.pem
# mv $INSURANCECAPATH/tls/*_sk $INSURANCECAPATH/tls/key.pem
# mv $INSURANCECAPATH/tls/*-cert.pem $INSURANCECAPATH/tls/cert.pem

# cp $CLIPATHPEERS/police-org/ca/* $POLICECAPATH/ca
# cp $CLIPATHPEERS/police-org/tlsca/* $POLICECAPATH/tls
# mv $POLICECAPATH/ca/*_sk $POLICECAPATH/ca/key.pem
# mv $POLICECAPATH/ca/*-cert.pem $POLICECAPATH/ca/cert.pem
# mv $POLICECAPATH/tls/*_sk $POLICECAPATH/tls/key.pem
# mv $POLICECAPATH/tls/*-cert.pem $POLICECAPATH/tls/cert.pem

# cp $CLIPATHPEERS/repairshop-org/ca/* $REPAIRSHOPCAPATH/ca
# cp $CLIPATHPEERS/repairshop-org/tlsca/* $REPAIRSHOPCAPATH/tls
# mv $REPAIRSHOPCAPATH/ca/*_sk $REPAIRSHOPCAPATH/ca/key.pem
# mv $REPAIRSHOPCAPATH/ca/*-cert.pem $REPAIRSHOPCAPATH/ca/cert.pem
# mv $REPAIRSHOPCAPATH/tls/*_sk $REPAIRSHOPCAPATH/tls/key.pem
# mv $REPAIRSHOPCAPATH/tls/*-cert.pem $REPAIRSHOPCAPATH/tls/cert.pem

# cp $CLIPATHPEERS/shop-org/ca/* $SHOPCAPATH/ca
# cp $CLIPATHPEERS/shop-org/tlsca/* $SHOPCAPATH/tls
# mv $SHOPCAPATH/ca/*_sk $SHOPCAPATH/ca/key.pem
# mv $SHOPCAPATH/ca/*-cert.pem $SHOPCAPATH/ca/cert.pem
# mv $SHOPCAPATH/tls/*_sk $SHOPCAPATH/tls/key.pem
# mv $SHOPCAPATH/tls/*-cert.pem $SHOPCAPATH/tls/cert.pem

# WEBCERTS=$PROJPATH/web/certs
# rm -rf $WEBCERTS
# mkdir -p $WEBCERTS
# cp $PROJPATH/orderer/crypto/tls/ca.crt $WEBCERTS/ordererOrg.pem
# cp $PROJPATH/customerAPeer/crypto/tls/ca.crt $WEBCERTS/insuranceOrg.pem
# cp $PROJPATH/policePeer/crypto/tls/ca.crt $WEBCERTS/policeOrg.pem
# cp $PROJPATH/repairShopPeer/crypto/tls/ca.crt $WEBCERTS/repairShopOrg.pem
# cp $PROJPATH/shopPeer/crypto/tls/ca.crt $WEBCERTS/shopOrg.pem
# cp $CLIPATHPEERS/insurance-org/users/Admin@insurance-org/msp/keystore/* $WEBCERTS/Admin@insurance-org-key.pem
# cp $CLIPATHPEERS/insurance-org/users/Admin@insurance-org/msp/signcerts/* $WEBCERTS/
# cp $CLIPATHPEERS/shop-org/users/Admin@shop-org/msp/keystore/* $WEBCERTS/Admin@shop-org-key.pem
# cp $CLIPATHPEERS/shop-org/users/Admin@shop-org/msp/signcerts/* $WEBCERTS/
# cp $CLIPATHPEERS/police-org/users/Admin@police-org/msp/keystore/* $WEBCERTS/Admin@police-org-key.pem
# cp $CLIPATHPEERS/police-org/users/Admin@police-org/msp/signcerts/* $WEBCERTS/
# cp $CLIPATHPEERS/repairshop-org/users/Admin@repairshop-org/msp/keystore/* $WEBCERTS/Admin@repairshop-org-key.pem
# cp $CLIPATHPEERS/repairshop-org/users/Admin@repairshop-org/msp/signcerts/* $WEBCERTS/
