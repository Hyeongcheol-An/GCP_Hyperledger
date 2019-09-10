export PATH=$PATH:/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/bin
export FABRIC_CFG_PATH=/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/config/
export CORE_PEER_TLS_ENABLED=true
export GOPATH=/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/chaincode

export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/case4/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/case4/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051
export GOPATH=/opt/gopath

# peer chaincode install -n mycc -v 0 -p "/fabcar/go"

# ../../../bin/peer lifecycle chaincode package mycc.tar.gz --path abstore/go/ --lang golang --label mycc_1
# peer lifecycle chaincode package mycc.tar.gz --path ../../chaincode/marbles02/go --lang golang --label mycc_1
# peer chaincode install -n myNewCC -v 1.0 -p 
# peer lifecycle chaincode package mycc.tar.gz --path github.com/chaincode/abstore/go/ --lang golang --label mycc_1

echo $GOPATH


peer chaincode list --installed

# peer chaincode install -n marbles02 -v 1 -l golang -p marbles02/go
peer chaincode install -n evmcc -l golang -v 0 -p github.com/hyperledger/fabric-chaincode-evm/evmcc