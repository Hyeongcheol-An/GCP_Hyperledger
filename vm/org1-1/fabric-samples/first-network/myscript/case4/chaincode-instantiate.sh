# Chaincode Instantiate

export PATH=$PATH:/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/bin
export FABRIC_CFG_PATH=/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/config/
export CORE_PEER_TLS_ENABLED=true

export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/case4/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/case4/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051

peer chaincode instantiate -o orderer.example.com:7050 -C channel1 \
-n fabcar -l golang -v 0 -c '{"Args":["init"]}' \
--tls true --cafile /home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/case4/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
