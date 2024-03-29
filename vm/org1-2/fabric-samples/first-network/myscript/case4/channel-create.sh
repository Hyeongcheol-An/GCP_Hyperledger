#!/bin/bash

#export FABRIC_CFG_PATH=/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network

# export CHANNEL_NAME=mychannel
export FABRIC_CFG_PATH=/home/an/GCP_Hyperledger/vm/org1-2/fabric-samples/config
export PATH=$PATH:/home/an/GCP_Hyperledger/vm/org1-2/fabric-samples/bin

# export CORE_PEER_TLS_ENABLED=true
# export CORE_PEER_TLS_ROOTCERT_FILE=/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/case4/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
# export CORE_PEER_TLS_KEY_FILE=/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/case4/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/server.key
# export CORE_PEER_TLS_CERT_FILE=/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/case4/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/server.crt
export CORE_PEER_LOCALMSPID=Org1MSP
export CORE_PEER_MSPCONFIGPATH=/home/an/GCP_Hyperledger/vm/org1-2/fabric-samples/first-network/myscript/case4/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=peer1.org1.example.com:7051

#docker cp orderer.example.com:/etc/hyperledger/fabric/msp $FABRIC_CFG_PATH

peer channel create -o orderer2.example.com:7050 -c mychannel -f \
/home/an/GCP_Hyperledger/vm/org1-2/fabric-samples/first-network/myscript/case4/channel-artifacts/channel.tx --tls true --cafile /home/an/GCP_Hyperledger/vm/org1-2/fabric-samples/first-network/myscript/case4/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

# peer channel update -o orderer.example.com:7050 -c mychannel -f \
# /home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/case4/channel-artifacts/channel.tx --tls true --cafile /home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/case4/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
