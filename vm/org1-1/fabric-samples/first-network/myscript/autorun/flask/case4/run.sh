#run script
rm -rf crypto-config

../../../../../bin/cryptogen generate --config=./crypto-config.yaml

rm -rf channel-artifacts
mkdir channel-artifacts
export FABRIC_CFG_PATH=$PWD

../../../../../bin/configtxgen -profile SampleMultiNodeEtcdRaft -channelID byfn -outputBlock ./channel-artifacts/genesis.block

../../../../../bin/configtxgen -profile AllOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel1.tx -channelID channel1

../../../../../bin/configtxgen -profile AllOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID channel1 -asOrg Org1MSP
../../../../../bin/configtxgen -profile AllOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -channelID channel1 -asOrg Org2MSP

# sleep 3

# ./ssh.sh

# sleep 2

# ./scp.sh