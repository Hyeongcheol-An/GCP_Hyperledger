#Docker-compose down

echo '========================================================================='
echo '==========================Start Connection==============================='
echo '========================================================================='

echo '=======================Access the Org1-2 VM=============================='
sudo ssh -T -i ./tmp.pem an@34.67.110.38 << \EOF
cd /home/an/GCP_Hyperledger/vm/org1-2/fabric-samples/first-network/myscript/case4
./down.sh
EOF

echo '=======================Access the Org2-1 VM=============================='
sudo ssh -T -i ./tmp.pem an@35.232.221.188 << \EOF
cd /home/an/GCP_Hyperledger/vm/org2-1/fabric-samples/first-network/myscript/case4
./down.sh
EOF

echo '=======================Access the Org2-2 VM============================'
sudo ssh -T -i ./tmp.pem an@35.222.162.181 << \EOF
cd /home/an/GCP_Hyperledger/vm/org2-2/fabric-samples/first-network/myscript/case4
./down.sh
EOF

# echo '=======================Access the Orderer1 VM============================'
# sudo ssh -T -i ./tmp.pem an@35.232.167.182 << \EOF
# cd /home/an/GCP_Hyperledger/vm/orderer1/fabric-samples/first-network/myscript/case4
# ./down.sh
# EOF

echo '========================================================================='
echo '===========================Docker Logs==================================='
echo '========================================================================='

echo '=======================Access the Org1-2 VM=============================='
sudo ssh -T -i ./tmp.pem an@34.67.110.38 << \EOF
cd /home/an/GCP_Hyperledger/vm/org1-2/fabric-samples/first-network/myscript/case4
docker ps -a
EOF

echo '=======================Access the Org2-1 VM=============================='
sudo ssh -T -i ./tmp.pem an@35.232.221.188 << \EOF
cd /home/an/GCP_Hyperledger/vm/org2-1/fabric-samples/first-network/myscript/case4
docker ps -a
EOF

echo '=======================Access the Org2-2 VM============================'
sudo ssh -T -i ./tmp.pem an@35.222.162.181 << \EOF
cd /home/an/GCP_Hyperledger/vm/org2-2/fabric-samples/first-network/myscript/case4
docker ps -a
EOF

# echo '=======================Access the Orderer1 VM============================'
# sudo ssh -T -i ./tmp.pem an@35.232.167.182 << \EOF
# cd /home/an/GCP_Hyperledger/vm/orderer1/fabric-samples/first-network/myscript/case4
# docker ps -a
# EOF

echo '========================================================================='
echo '============================End Connection==============================='
echo '========================================================================='