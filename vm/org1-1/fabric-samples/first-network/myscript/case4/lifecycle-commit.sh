# 4. Chaincode commit

export PATH=$PATH:/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/bin
export FABRIC_CFG_PATH=/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/config/
export CORE_PEER_TLS_ENABLED=true
export GOPATH=/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/chaincode

export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/case4/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/case4/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051

peer lifecycle chaincode queryapprovalstatus -o orderer.example.com:7050 --channelID channel1 --name fabcar --version 1.0 \
--init-required --sequence 1 --tls true \
--cafile /home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/case4/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

# --signature-policy "AND ('Org1MSP.peer','Org2MSP.peer')" \

peer lifecycle chaincode commit -o orderer.example.com:7050 --channelID channel1 --name fabcar --signature-policy "AND ('Org1MSP.member')" \
--version 1.0 --sequence 1 --init-required --tls true \
--cafile /home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/case4/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
# --channel-config-policy Channel/Application/Admins


peer chaincode invoke -o orderer.example.com:7050 --channelID channel1 --name fabcar -c '{"Args":["init"]}' --isInit --tls true \
--cafile /home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/case4/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

