#!/bin/sh

CHANNEL_NAME="market"
PROJPATH=$(pwd)
CLIPATH=$PROJPATH/cli/peers
TOOLS=$PROJPATH/tools

export FABRIC_CFG_PATH=./configs

echo
echo "##########################################################"
echo "#########  Generating Orderer Genesis block ##############"
echo "##########################################################"
$TOOLS/configtxgen -profile FiveOrgsGenesis -outputBlock $CLIPATH/genesis.block

echo
echo "#################################################################"
echo "### Generating channel configuration transaction 'channel.tx' ###"
echo "#################################################################"
$TOOLS/configtxgen -profile FiveOrgsChannel -outputCreateChannelTx $CLIPATH/channel.tx -channelID $CHANNEL_NAME
cp $CLIPATH/channel.tx $PROJPATH/web

echo
echo "#################################################################"
echo "####### Generating anchor peer update for MPBroker ##########"
echo "#################################################################"
$TOOLS/configtxgen -profile FiveOrgsChannel -outputAnchorPeersUpdate $CLIPATH/MPBrokerAnchors.tx -channelID $CHANNEL_NAME -asOrg MPBroker

echo
echo "#################################################################"
echo "####### Generating anchor peer update for CustomerA ##########"
echo "#################################################################"
$TOOLS/configtxgen -profile FiveOrgsChannel -outputAnchorPeersUpdate $CLIPATH/CustomerAAnchors.tx -channelID $CHANNEL_NAME -asOrg CustomerA

echo
echo "#################################################################"
echo "#######    Generating anchor peer update for CustomerB   ##########"
echo "#################################################################"
$TOOLS/configtxgen -profile FiveOrgsChannel -outputAnchorPeersUpdate $CLIPATH/CustomerBAnchors.tx -channelID $CHANNEL_NAME -asOrg CustomerB

echo
echo "##################################################################"
echo "####### Generating anchor peer update for CustomerC ##########"
echo "##################################################################"
$TOOLS/configtxgen -profile FiveOrgsChannel -outputAnchorPeersUpdate $CLIPATH/CustomerCAnchors.tx -channelID $CHANNEL_NAME -asOrg CustomerC

echo
echo "##################################################################"
echo "#######   Generating anchor peer update for CustomerD   ##########"
echo "##################################################################"
$TOOLS/configtxgen -profile FiveOrgsChannel -outputAnchorPeersUpdate $CLIPATH/CustomerDAnchors.tx -channelID $CHANNEL_NAME -asOrg CustomerD
