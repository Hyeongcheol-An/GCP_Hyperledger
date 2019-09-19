export PATH=$PATH:/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/bin
export FABRIC_CFG_PATH=/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/config/
export CORE_PEER_TLS_ENABLED=true
export GOPATH=/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/chaincode

export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/case4/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/case4/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051

# peer chaincode list --installed

peer chaincode install -n fabcar -v 1 -l golang -p fabcar/go

export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/home/orderer/fabric-samples/first-network/crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/home/orderer/fabric-samples/first-network/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=peer1.org1.example.com:7051

peer chaincode install -n fabcar -v 0 -l golang -p fabcar/go

export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/home/orderer/fabric-samples/first-network/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/home/orderer/fabric-samples/first-network/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
export CORE_PEER_ADDRESS=peer0.org2.example.com:7051

peer chaincode install -n fabcar -v 0 -l golang -p fabcar/go

export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/home/orderer/fabric-samples/first-network/crypto-config/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/home/orderer/fabric-samples/first-network/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
export CORE_PEER_ADDRESS=peer1.org2.example.com:7051

peer chaincode install -n fabcar -v 0 -l golang -p fabcar/go