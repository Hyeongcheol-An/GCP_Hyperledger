export FABRIC_CFG_PATH=/home/an/GCP_Hyperledger/vm/org2-1/fabric-samples/config

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_TLS_ROOTCERT_FILE=/home/an/GCP_Hyperledger/vm/org2-1/fabric-samples/first-network/myscript/case1/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_TLS_KEY_FILE=/home/an/GCP_Hyperledger/vm/org2-1/fabric-samples/first-network/myscript/case1/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/server.key
export CORE_PEER_TLS_CERT_FILE=/home/an/GCP_Hyperledger/vm/org2-1/fabric-samples/first-network/myscript/case1/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/server.crt
export CORE_PEER_LOCALMSPID=Org2MSP
export CORE_PEER_MSPCONFIGPATH=/home/an/GCP_Hyperledger/vm/org2-1/fabric-samples/first-network/myscript/case1/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
export CORE_PEER_ADDRESS=peer0.org2.example.com:7051

peer channel join -b ./channel1.block

export FABRIC_CFG_PATH=/home/an/GCP_Hyperledger/vm/org2-1/fabric-samples/config

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_TLS_ROOTCERT_FILE=/home/an/GCP_Hyperledger/vm/org2-1/fabric-samples/first-network/myscript/case1/crypto-config/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/ca.crt
export CORE_PEER_TLS_KEY_FILE=/home/an/GCP_Hyperledger/vm/org2-1/fabric-samples/first-network/myscript/case1/crypto-config/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/server.key
export CORE_PEER_TLS_CERT_FILE=/home/an/GCP_Hyperledger/vm/org2-1/fabric-samples/first-network/myscript/case1/crypto-config/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/server.crt
export CORE_PEER_LOCALMSPID=Org2MSP
export CORE_PEER_MSPCONFIGPATH=/home/an/GCP_Hyperledger/vm/org2-1/fabric-samples/first-network/myscript/case1/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
export CORE_PEER_ADDRESS=peer1.org2.example.com:8051

peer channel join -b ./channel1.block

