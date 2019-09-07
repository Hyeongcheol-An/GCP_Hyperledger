# Crypto-config / channel-artifact

#org1-2
sudo scp -r -i ./tmp.pem /home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/case4/channel-artifacts/* \
an@34.67.110.38:/home/an/GCP_Hyperledger/vm/org1-2/fabric-samples/first-network/myscript/case4/channel-artifacts/

sudo scp -r -i ./tmp.pem /home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/case4/crypto-config/* \
an@34.67.110.38:/home/an/GCP_Hyperledger/vm/org1-2/fabric-samples/first-network/myscript/case4/crypto-config/

#org2-1
sudo scp -r -i ./tmp.pem /home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/case4/channel-artifacts/* \
an@35.232.221.188:/home/an/GCP_Hyperledger/vm/org2-1/fabric-samples/first-network/myscript/case4/channel-artifacts/

sudo scp -r -i ./tmp.pem /home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/case4/crypto-config/* \
an@35.232.221.188:/home/an/GCP_Hyperledger/vm/org2-1/fabric-samples/first-network/myscript/case4/crypto-config/

#org2-2
sudo scp -r -i ./tmp.pem /home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/case4/channel-artifacts/* \
an@35.222.162.181:/home/an/GCP_Hyperledger/vm/org2-2/fabric-samples/first-network/myscript/case4/channel-artifacts/

sudo scp -r -i ./tmp.pem /home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/case4/crypto-config/* \
an@35.222.162.181:/home/an/GCP_Hyperledger/vm/org2-2/fabric-samples/first-network/myscript/case4/crypto-config/

#orderer1
sudo scp -r -i ./tmp.pem /home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/case4/channel-artifacts/* \
an@35.232.167.182:/home/an/GCP_Hyperledger/vm/orderer1/fabric-samples/first-network/myscript/case4/channel-artifacts/

sudo scp -r -i ./tmp.pem /home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/case4/crypto-config/* \
an@35.232.167.182:/home/an/GCP_Hyperledger/vm/orderer1/fabric-samples/first-network/myscript/case4/crypto-config/

