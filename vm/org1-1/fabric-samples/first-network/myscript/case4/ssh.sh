sudo ssh -T -i ./tmp.pem an@34.67.110.38 << \EOF
cd /home/an/GCP_Hyperledger/vm/org1-2/fabric-samples/first-network/myscript/case4
./delete_folder.sh
EOF

sudo ssh -T -i ./tmp.pem an@35.232.221.188 << \EOF
cd /home/an/GCP_Hyperledger/vm/org2-1/fabric-samples/first-network/myscript/case4
./delete_folder.sh
EOF

sudo ssh -T -i ./tmp.pem an@35.222.162.181 << \EOF
cd /home/an/GCP_Hyperledger/vm/org2-2/fabric-samples/first-network/myscript/case4
./delete_folder.sh
EOF

sudo ssh -T -i ./tmp.pem an@35.232.167.182 << \EOF
cd /home/an/GCP_Hyperledger/vm/orderer1/fabric-samples/first-network/myscript/case4
./delete_folder.sh
EOF