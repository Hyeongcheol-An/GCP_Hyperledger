#scp transport shell

if [ $# -eq 3 ];then
    echo "IP 주소: $1, hostname: $2, file: $3"
    sudo scp -r -i ./tmp.pem /home/an/GCP_Hyperledger/vm/org1-1/fabric-samples/first-network/myscript/autorun/${3} \
    an@$1:/home/an/GCP_Hyperledger/vm/$2/fabric-samples/first-network/myscript/autorun/
else
    echo "[Usage] ./trans_scp.sh [IP address] [hostname] [file]"
fi
