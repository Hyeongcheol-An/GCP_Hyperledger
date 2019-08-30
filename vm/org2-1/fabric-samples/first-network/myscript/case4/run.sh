#run script

../../../bin/cryptogen generate --config=./crypto-config.yaml

rm -rf channel-artifacts
mkdir channel-artifacts
export FABRIC_CFG_PATH=$PWD

../../../bin/configtxgen -profile TwoOrgsOrdererGenesis -channelID byfn -outputBlock ./channel-artifacts/genesis.block

../../../bin/configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel2.tx -channelID channel1

../../../bin/configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID channel1 -asOrg Org1MSP
../../../bin/configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -channelID channel1 -asOrg Org2MSP

