#run script
rm -rf crypto-config

../../../bin/cryptogen generate --config=./crypto-config.yaml

rm -rf channel-artifacts
mkdir channel-artifacts
export FABRIC_CFG_PATH=$PWD

../../../bin/configtxgen -profile SampleMultiNodeEtcdRaft -channelID byfn -outputBlock ./channel-artifacts/genesis.block

../../../bin/configtxgen -profile AllOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID mychannel

../../../bin/configtxgen -profile AllOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID mychannel -asOrg Org1MSP
../../../bin/configtxgen -profile AllOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -channelID mychannel -asOrg Org2MSP

sleep 3

./ssh.sh

sleep 2

./scp.sh