#!/bin/sh

CHANNEL_NAME="market"
PROJPATH=$(pwd)
CLIPATH=$PROJPATH/cli
TOOLS=$PROJPATH/tools
ORGANISATIONS_PATH=$CLIPATH/organisations
ANCHOR_TRANSACTIONS_PATH=$CLIPATH/anchorTransactions
CHANNEL_TRANSACTIONS_PATH=$CLIPATH/channelTransactions
GENESIS_BLOCK_TRANSACTIONS_PATH=$CLIPATH/genesisBlockTransaction

export FABRIC_CFG_PATH=./configs

echo
echo "##########################################################"
echo "#########  Generating Orderer Genesis block ##############"
echo "##########################################################"
$TOOLS/configtxgen -profile FiveOrgsGenesis -outputBlock $GENESIS_BLOCK_TRANSACTIONS_PATH/genesis.block

echo
echo "#################################################################"
echo "### Generating channel configuration transaction 'channel.tx' ###"
echo "#################################################################"
$TOOLS/configtxgen -profile FiveOrgsChannel -outputCreateChannelTx $CHANNEL_TRANSACTIONS_PATH/channel.tx -channelID $CHANNEL_NAME
cp $CHANNEL_TRANSACTIONS_PATH/channel.tx $PROJPATH/web/channelTransactions

echo
echo "#################################################################"
echo "####### Generating anchor peer update for MPBroker ##########"
echo "#################################################################"
$TOOLS/configtxgen -profile FiveOrgsChannel -outputAnchorPeersUpdate $ANCHOR_TRANSACTIONS_PATH/MPBrokerAnchors.tx -channelID $CHANNEL_NAME -asOrg MPBrokerOrg

echo
echo "#################################################################"
echo "####### Generating anchor peer update for CustomerA ##########"
echo "#################################################################"
$TOOLS/configtxgen -profile FiveOrgsChannel -outputAnchorPeersUpdate $ANCHOR_TRANSACTIONS_PATH/CustomerAAnchors.tx -channelID $CHANNEL_NAME -asOrg CustomerAOrg

echo
echo "#################################################################"
echo "#######    Generating anchor peer update for CustomerB   ##########"
echo "#################################################################"
$TOOLS/configtxgen -profile FiveOrgsChannel -outputAnchorPeersUpdate $ANCHOR_TRANSACTIONS_PATH/CustomerBAnchors.tx -channelID $CHANNEL_NAME -asOrg CustomerBOrg

echo
echo "##################################################################"
echo "####### Generating anchor peer update for CustomerC ##########"
echo "##################################################################"
$TOOLS/configtxgen -profile FiveOrgsChannel -outputAnchorPeersUpdate $ANCHOR_TRANSACTIONS_PATH/CustomerCAnchors.tx -channelID $CHANNEL_NAME -asOrg CustomerCOrg

echo
echo "##################################################################"
echo "#######   Generating anchor peer update for CustomerD   ##########"
echo "##################################################################"
$TOOLS/configtxgen -profile FiveOrgsChannel -outputAnchorPeersUpdate $ANCHOR_TRANSACTIONS_PATH/CustomerDAnchors.tx -channelID $CHANNEL_NAME -asOrg CustomerDOrg
