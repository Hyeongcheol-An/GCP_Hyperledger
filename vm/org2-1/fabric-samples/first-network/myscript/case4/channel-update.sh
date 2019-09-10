export PATH=$PATH:/home/an/GCP_Hyperledger/vm/org2-1/fabric-samples/bin
export FABRIC_CFG_PATH=/home/an/GCP_Hyperledger/vm/org2-1/fabric-samples/config/
export CORE_PEER_TLS_ENABLED=true

export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/home/an/GCP_Hyperledger/vm/org2-1/fabric-samples/first-network/myscript/case4/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/home/an/GCP_Hyperledger/vm/org2-1/fabric-samples/first-network/myscript/case4/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
export CORE_PEER_ADDRESS=peer0.org2.example.com:7051

peer channel update -o orderer2.example.com:7050 -c channel1 \
-f ./channel-artifacts/Org2MSPanchors.tx --tls \
--cafile /home/an/GCP_Hyperledger/vm/org2-1/fabric-samples/first-network/myscript/case4/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
