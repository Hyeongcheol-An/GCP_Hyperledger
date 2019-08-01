# Hyperledger Fabric Org 구성

## 3org 6peer Network 구성

### Network 구성 순서

1. **/etc/hosts** 파일 수정
    - 새로운 org 및 peer 도메인 등록
1. **crypto-config.yaml** 파일 수정
    - 새로운 org 및 peer 정의
1. **configtx.yaml** 파일 수정
    - 새로운 org 및 peer 정의
1. **sh** 파일 작성
    - configtx.yaml 파일 적용을 위한 script 작성
1. **docker-compose.yaml** 파일 수정
    - container에 org3를 올리기 위하여 파일 수정
1. vm 네트워크 포트포워딩
    - org3에 대한 각 peer 포트포워딩
1. **peer_base.yaml** 수정
    - 경로 `C:\Uplus_Dev\workspace\ucare.hfn.env\3org6peer\peer_base.yaml`
1. **collections_config.yaml** 작성
    - 경로 `C:\Uplus_Dev\workspace\ucare.hfn.env\3org6peer\peer_base.yaml`
1. channel 생성
    - channel 생성
1. Chaincode Instantiation
    - chaincode instantiation
1. **local_3org6peer-network-config.yaml** 작성
    - 경로 `C:\Uplus_Dev\workspace\ucare.cmd.sdk\config\local_3org6peer-network-config.yaml`
1. **framework-config_3org6peer.yaml** 작성
    - 경로 `C:\Uplus_Dev\workspace\ucare.cmd.sdk\framework-config_3org6peer.yaml`
1. SDK 작성
    - Java SDK 작성

## Network Port 구성

| Container                         | Environment  | Port        |
| :-------------------------------: | -----------: | :---------: |
| `orderer.local.com`               |              | **7050**    |
| `peer0.org1.local.com`            | Addr<br>CC_Listen_Addr<br>Event_Addr | **7051**<br>**7052**<br>**7053** |
| `peer1.org1.local.com`            | Addr<br>CC_Listen_Addr<br>Event_Addr | **7061**<br>**7062**<br>**7063** |
| `peer0.org2.local.com`            | Addr<br>CC_Listen_Addr<br>Event_Addr | **7071**<br>**7072**<br>**7073** |
| `peer1.org2.local.com`            | Addr<br>CC_Listen_Addr<br>Event_Addr | **7081**<br>**7082**<br>**7083** |
| `peer0.org3.local.com`            | Addr<br>CC_Listen_Addr<br>Event_Addr | **7151**<br>**7152**<br>**7153** |
| `peer1.org3.local.com`            | Addr<br>CC_Listen_Addr<br>Event_Addr | **7161**<br>**7162**<br>**7163** |
| `couchdb0.peer0.org1.local.com`   |              | **5984:5984** |
| `couchdb1.peer1.org1.local.com`   |              | **5983:5984** |
| `couchdb0.peer0.org2.local.com`   |              | **5884:5984** |
| `couchdb1.peer1.org2.local.com`   |              | **5883:5984** |
| `couchdb0.peer0.org3.local.com`   |              | **5784:5984** |
| `couchdb1.peer1.org3.local.com`   |              | **5783:5984** |



### 1. **/etc/hosts** 파일 수정
3org 6peer 환경을 구성을 위하여

```bash
$ sudo vim /etc/hosts
```

명령어로 도메인을 등록한다.
본 구성은 2org 4peer 환경이 구성되어 있다는 가정 하에 작성한 문서로 2org 4peer 환경이 구성되어 있지 않은 경우
아래에 나와있는 도메인 예시를 따라 org1과 org2에 대한 도메인을 등록한다.

```yaml
...
127.0.0.1   peer0.org3.local.com
127.0.0.1   peer1.org3.local.com
```

### 0. **crypto-config.yaml** 파일 수정

Organizations section에 Org3에 대한 내용을 추가한다.

```yaml
...
  - Name: Org3
    Domain: org3.local.com
    Template:
      Count: 2
    Users:
      Count: 1
```




### 0. **configtx.yaml** 파일 수정

Organizations section에 Org3에 대한 내용을 추가한다.

```yaml
    - &Org3
        Name: Org3MSP

        ID: Org3MSP

        MSPDir: crypto-config/peerOrganizations/org3.local.com/msp

        Policies: &Org3Policies
            Readers:
                Type: Signature
                Rule: "OR('Org3MSP.member')"
            Writers:
                Type: Signature
                Rule: "OR('Org3MSP.member')"
            Admins:
                Type: Signature
                Rule: "OR('Org3MSP.admin')"

        AnchorPeers:
            - Host: peer1.org3.local.com
              Port: 7161
```


새로 추가된 org3에 대한 policy 추가(Application section)

```yaml
        Org3MemberPolicy:
            Type: Signature
            Rule: "OR('Org3MSP.member')"
        Org1Org3MemberPolicy:
            Type: Signature
            Rule: "OR('Org1MSP.member','Org3MSP.member')"
        Org2Org3MemberPolicy:
            Type: Signature
            Rule: "OR('Org2MSP.member','Org3MSP.member')"
        Org1Org2Org3MemberPolicy:
            Type: Signature
            Rule: "OR('Org1MSP.member','Org2MSP.member','Org3MSP.member')"
```


profile section에 org3 추가

```yaml
Profiles:

    ThreeOrgsOrdererGenesis:
        <<: *ChannelDefaults
        Orderer:
            <<: *OrdererDefaults
            Organizations:
                - <<: *OrdererOrg
                  Policies:
                      <<: *OrdererOrgPolicies
                      Admins:
                          Type: Signature
                          Rule: "OR('OrdererMSP.admin')"
            Capabilities:
                <<: *OrdererCapabilities
        Consortiums:
            TestConsortium:
                Organizations:
                - <<: *Org1
                  Policies:
                      <<: *Org1Policies
                      Admins:
                          Type: Signature
                          Rule: "OR('Org1MSP.admin')"

            SampleConsortium:
                Organizations:
                    - <<: *Org1
                      Policies:
                          <<: *Org1Policies
                          Admins:
                              Type: Signature
                              Rule: "OR('Org1MSP.admin')"
                    - <<: *Org2
                      Policies:
                          <<: *Org2Policies
                          Admins:
                              Type: Signature
                              Rule: "OR('Org2MSP.admin')"
                    - <<: *Org3
                      Policies:
                          <<: *Org3Policies
                          Admins:
                              Type: Signature
                              Rule: "OR('Org3MSP.admin')"
                              
        Application:
            <<: *ApplicationDefaults
            Organizations:
                - *OrdererOrg
            Capabilities:
                <<: *ApplicationCapabilities

    ThreeOrgsChannel:
        Consortium: SampleConsortium
        Application:
            <<: *ApplicationDefaults
            Organizations:
                - *Org1
                - *Org2
                - *Org3
            Capabilities:
                <<: *ApplicationCapabilities
```


### 0. **mk_profile.sh** 파일 작성

configtx.yaml 파일 적용을 위한 script 작성한다.

```sh
export CHANNELID=localchannel
export CHANNEL_PATH="./channel-artifacts"
export CORE_PEER_ORG1_NAME=Org1MSP
export CORE_PEER_ORG2_NAME=Org2MSP
export CORE_PEER_ORG3_NAME=Org3MSP



#Delete and Make the Folders
rm -rf crypto-config
echo "delete crypto-config folder"
rm -rf channel-artifacts
echo "delete channel-artifacts folder"
mkdir channel-artifacts
echo "make channel-artifacts folder"


cryptogen generate --config=./crypto-config.yaml
echo "make [crypto-config.yaml] file!"
configtxgen -profile ThreeOrgsOrdererGenesis -outputBlock $CHANNEL_PATH/genesis.block -channelID initchannel -configPath=./
echo "make [genesis.block] file!"
configtxgen -profile ThreeOrgsChannel -outputCreateChannelTx $CHANNEL_PATH/channel.tx -channelID $CHANNELID -configPath=./
echo "make [channel.tx] file _____ channelID is $CHANNELID!"

configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate $CHANNEL_PATH/Org1MSPanchors.tx -channelID $CHANNELID -asOrg $CORE_PEER_ORG1_NAME -configPath=./
echo "make [Org1MSPanchors.tx] _____ $CORE_PEER_ORG1_NAME"
configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate $CHANNEL_PATH/Org1MSPanchors.tx -channelID $CHANNELID -asOrg $CORE_PEER_ORG2_NAME -configPath=./
echo "make [Org2MSPanchors.tx] _____ $CORE_PEER_ORG2_NAME"
configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate $CHANNEL_PATH/Org1MSPanchors.tx -channelID $CHANNELID -asOrg $CORE_PEER_ORG3_NAME -configPath=./
echo "make [Org3MSPanchors.tx] _____ $CORE_PEER_ORG3_NAME"

configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate $CHANNEL_PATH/Org2MSPanchors.tx -channelID $CHANNELID -asOrg $CORE_PEER_ORG1_NAME -configPath=./
echo "make [Org1MSPanchors.tx] _____ $CORE_PEER_ORG1_NAME"
configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate $CHANNEL_PATH/Org2MSPanchors.tx -channelID $CHANNELID -asOrg $CORE_PEER_ORG2_NAME -configPath=./
echo "make [Org2MSPanchors.tx] _____ $CORE_PEER_ORG2_NAME"
configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate $CHANNEL_PATH/Org2MSPanchors.tx -channelID $CHANNELID -asOrg $CORE_PEER_ORG3_NAME -configPath=./
echo "make [Org3MSPanchors.tx] _____ $CORE_PEER_ORG3_NAME"

configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate $CHANNEL_PATH/Org3MSPanchors.tx -channelID $CHANNELID -asOrg $CORE_PEER_ORG1_NAME -configPath=./
echo "make [Org1MSPanchors.tx] _____ $CORE_PEER_ORG1_NAME"
configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate $CHANNEL_PATH/Org3MSPanchors.tx -channelID $CHANNELID -asOrg $CORE_PEER_ORG2_NAME -configPath=./
echo "make [Org2MSPanchors.tx] _____ $CORE_PEER_ORG2_NAME"
configtxgen -profile ThreeOrgsChannel -outputAnchorPeersUpdate $CHANNEL_PATH/Org3MSPanchors.tx -channelID $CHANNELID -asOrg $CORE_PEER_ORG3_NAME -configPath=./
echo "make [Org3MSPanchors.tx] _____ $CORE_PEER_ORG3_NAME"
```

### 0. **docker-compose.yaml** 파일 수정

container에 org3를 올리기 위하여 파일 수정

```yaml
  peer0.org3.local.com:
    container_name: peer0.org3.local.com
    extends:
      file:  base/peer-base.yaml
      service: peer-base
    environment:
      - CORE_PEER_ID=peer0.org3.local.com
      - CORE_PEER_ADDRESS=peer0.org3.local.com:7151
      - CORE_PEER_LISTENADDRESS=0.0.0.0:7151      
      - CORE_PEER_GOSSIP_EXTERNALENDPOINT=peer0.org3.local.com:7151
      - CORE_PEER_GOSSIP_BOOTSTRAP=peer0.org3.local.com:7151
      - CORE_PEER_CHAINCODELISTENADDRESS=peer0.org3.local.com:7152      
      - CORE_PEER_LOCALMSPID=Org3MSP
      - CORE_PEER_EVENTS_ADDRESS=0.0.0.0:7153
      - CORE_LEDGER_STATE_STATEDATABASE=CouchDB
      - CORE_LEDGER_STATE_COUCHDBCONFIG_COUCHDBADDRESS=couchdb0.peer0.org3.local.com:5984
    volumes:
        - /var/run/:/host/var/run/
        - /etc/localtime:/etc/localtime:ro
        - ./crypto-config/peerOrganizations/org3.local.com/peers/peer0.org3.local.com/msp:/etc/hyperledger/fabric/msp
        - ./crypto-config/peerOrganizations/org3.local.com/peers/peer0.org3.local.com/tls:/etc/hyperledger/fabric/tls
    ports:
      - 7151:7151
      - 7152:7152      
      - 7153:7153
    depends_on:
      - couchdb0.peer0.org3.local.com      
    networks:
      - byfn

  peer1.org3.local.com:
    container_name: peer1.org3.local.com
    extends:
      file:  base/peer-base.yaml
      service: peer-base
    environment:
      - CORE_PEER_ID=peer1.org3.local.com
      - CORE_PEER_ADDRESS=peer1.org3.local.com:7161
      - CORE_PEER_LISTENADDRESS=0.0.0.0:7161
      - CORE_PEER_GOSSIP_EXTERNALENDPOINT=peer1.org3.local.com:7161
      - CORE_PEER_GOSSIP_BOOTSTRAP=peer1.org3.local.com:7161
      - CORE_PEER_CHAINCODELISTENADDRESS=peer1.org3.local.com:7162
      - CORE_PEER_LOCALMSPID=Org3MSP
      - CORE_PEER_EVENTS_ADDRESS=0.0.0.0:7163
      - CORE_LEDGER_STATE_STATEDATABASE=CouchDB
      - CORE_LEDGER_STATE_COUCHDBCONFIG_COUCHDBADDRESS=couchdb1.peer1.org3.local.com:5984
    volumes:
        - /var/run/:/host/var/run/
        - /etc/localtime:/etc/localtime:ro
        - ./crypto-config/peerOrganizations/org3.local.com/peers/peer1.org3.local.com/msp:/etc/hyperledger/fabric/msp
        - ./crypto-config/peerOrganizations/org3.local.com/peers/peer1.org3.local.com/tls:/etc/hyperledger/fabric/tls
    ports:
      - 7161:7161
      - 7162:7162
      - 7163:7163
    depends_on:
      - couchdb1.peer1.org3.local.com
    networks:
      - byfn

...

  couchdb0.peer0.org3.local.com:
    container_name: couchdb0.peer0.org3.local.com
    image: hyperledger/fabric-couchdb
    ports:
      - "5784:5984"
    networks:
      - byfn
      
  couchdb1.peer1.org3.local.com:
    container_name: couchdb1.peer1.org3.local.com
    image: hyperledger/fabric-couchdb
    ports:
      - "5783:5984"
    networks:
      - byfn
```

### 0. peer_base.yaml 수정

경로 `C:\Uplus_Dev\workspace\ucare.hfn.env\3org6peer\peer_base.yaml`

```yaml
...
CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=3org6peer_byfn
...
```

### 0. collections_config.yaml 작성
작성 경로: `C:\Uplus_Dev\workspace\ucare.hfn.env\3org6peer\peer_base.yaml`

```yaml
[
 	{
	 	"name": "dmgInfo",
	 	"policy": "OR('Org1MSP.member', 'Org2MSP.member', 'Org3MSP.member')",
	 	"requiredPeerCount": 0,
	 	"maxPeerCount": 1,
	 	"blockToLive":1000000,
		"memberOnlyRead": false
	},
 	{
	 	"name": "dmgInfoPrivate",
	 	"policy": "OR('Org1MSP.member', 'Org2MSP.member')",
	 	"requiredPeerCount": 0,
	 	"maxPeerCount": 1,
	 	"blockToLive":1000000,
		"memberOnlyRead": true
 	},
 	{
		"name": "dmgInfoPrivate2",
		"policy": "OR('Org1MSP.member', 'Org3MSP.member')",
		"requiredPeerCount": 0,
		"maxPeerCount": 0,
		"blockToLive":1000000,
		"memberOnlyRead": true
	}
]

```



### 0. channel 생성

channel 생성

```bash
export CORE_PEER_ADDRESS=peer0.org3.local.com:7151
export CORE_PEER_LOCALMSPID=Org3MSP
export CORE_PEER_MSPCONFIGPATH=/usr/local/ucare/ucare.hfn.env/3org6peer/crypto-config/peerOrganizations/org3.local.com/users/Admin@org3.local.com/msp/
export CORE_PEER_TLS_CERT_FILE=/usr/local/ucare/ucare.hfn.env/3org6peer/crypto-config/peerOrganizations/org3.local.com/peers/peer0.org3.local.com/tls/server.crt
export CORE_PEER_TLS_ROOTCERT_FILE=/usr/local/ucare/ucare.hfn.env/3org6peer/crypto-config/peerOrganizations/org3.local.com/peers/peer0.org3.local.com/tls/ca.crt
export CORE_PEER_TLS_KEY_FILE=/usr/local/ucare/ucare.hfn.env/3org6peer/crypto-config/peerOrganizations/org3.local.com/peers/peer0.org3.local.com/tls/server.key
peer channel join -b localchannel.block
echo "_______________ Peer [$CORE_PEER_ADDRESS] is joined to [localchannel]!! _______________"

export CORE_PEER_ADDRESS=peer1.org3.local.com:7161
export CORE_PEER_LOCALMSPID=Org3MSP
export CORE_PEER_MSPCONFIGPATH=/usr/local/ucare/ucare.hfn.env/3org6peer/crypto-config/peerOrganizations/org3.local.com/users/Admin@org3.local.com/msp/
export CORE_PEER_TLS_CERT_FILE=/usr/local/ucare/ucare.hfn.env/3org6peer/crypto-config/peerOrganizations/org3.local.com/peers/peer1.org3.local.com/tls/server.crt
export CORE_PEER_TLS_ROOTCERT_FILE=/usr/local/ucare/ucare.hfn.env/3org6peer/crypto-config/peerOrganizations/org3.local.com/peers/peer1.org3.local.com/tls/ca.crt
export CORE_PEER_TLS_KEY_FILE=/usr/local/ucare/ucare.hfn.env/3org6peer/crypto-config/peerOrganizations/org3.local.com/peers/peer1.org3.local.com/tls/server.key
peer channel join -b localchannel.block
echo "_______________ Peer [$CORE_PEER_ADDRESS] is joined to [localchannel]!! _______________"
```

### 0. Chaincode Instantiation

채널 구성 이후에 3org 환경에서 `--collections-config [collection_config file]` 옵션을 사용하여 chaincode instantiation 한다.

```bash
...
# Ucare & Telaio Fabric F/W based Chaincode Instantiation
peer chaincode instantiate -o orderer.local.com:7050 --tls --cafile $ORDERER_CA -n dmg_cc -v $VER -c '{"Args":["init"]}' -C localchannel -P "AND ('Org1MSP.member','Org2MSP.member', 'Org3MSP.member')" --collections-config /usr/local/ucare/ucare.hfn.env/3org6peer/collections_config.json
echo "_______________ Chaincode [dmg_cc] is installed Org [$CORE_PEER_LOCALMSPID]  _______________"
```


### 0. local_3org6peer-network-config.yaml 작성

경로: `C:\Uplus_Dev\workspace\ucare.cmd.sdk\config\local_3org6peer-network-config.yaml`

기존에 작성된 `local_2org4peer-network-config.yaml` 파일에서 새로 추가된 3org에 대한 부분을 작성한다.
3org 내용을 추가하는 field

- channels
- organizations
- peers

```yaml
...
channels:
...
      peer0.org3.local.com:
        endorsingPeer: true
        chaincodeQuery: true
        ledgerQuery: true
        eventSource: true

      peer1.org3.local.com:
        endorsingPeer: true
        chaincodeQuery: true
        ledgerQuery: true
        eventSource: true

organizations:
...
  Org3:
    mspid: Org3MSP
    cryptoPath: "peerOrganizations/org3.example.com/users/{username}@org3.local.com/msp"
    peers:
      - peer0.org3.local.com
      - peer1.org3.local.com

peers:
...
  peer0.org3.local.com:
    url: grpcs://192.168.56.1:7151
#    eventUrl: grpcs://192.168.56.1:7073
    grpcOptions:
      ssl-target-name-override: peer0.org3.local.com
      grpc.http2.keepalive_time: 15
      hostnameOverride: peer0.org3.local.com
    tlsCACerts:
      path: "C:/Uplus_Dev/workspace/ucare.hfn.env/3org6peer/crypto-config/peerOrganizations/org3.local.com/tlsca/tlsca.org3.local.com-cert.pem"

  peer1.org3.local.com:
    url: grpcs://192.168.56.1:7161
#    eventUrl: grpcs://192.168.56.1:7083
    grpcOptions:
      ssl-target-name-override: peer1.org3.local.com
      grpc.http2.keepalive_time: 15
      hostnameOverride: peer1.org3.local.com
    tlsCACerts:
      path: "C:/Uplus_Dev/workspace/ucare.hfn.env/3org6peer/crypto-config/peerOrganizations/org3.local.com/tlsca/tlsca.org3.local.com-cert.pem"
```

### 0. framework-config_3org6peer.properties 작성

경로: `C:\Uplus_Dev\workspace\ucare.cmd.sdk\framework-config_3org6peer.properties`

기존에 작성된 `framework-config_2org4peer.properties` 파일에서 위에 작성한 `local_3org6peer-network-config.yaml` 파일 경로를 지정한다.

```yaml
# network
config.network.filepath=./config/local_3org6peer-network-config.yaml
...
```

### 0. SDK 작성

위에서 작성한 `framework-config_3org6peer.properties` 파일 경로를 `System.setProperty()`를 사용하여 설정한다.

```java
public static void main(String[] args) {
  // 3org6peer
  System.setProperty("com.lgcns.blockchain.framework.configuration",
          "C:\\Uplus_Dev\\workspace\\ucare.cmd.sdk\\framework-config_3org6peer.properties");

  clientStart();
}
```

---

## 기타사항

### 메모리 사용량 확인

```bash
$ sar -r 1
```

---
### Profile 적용

peer log에 대한 alias 적용을 위하여 아래와 같이 명령어를 입력한다.

```bash
$ vim ~/.profile
```

profile 파일에 아래와 같이 peer log alias를 추가한다.

```bash
...
alias plog1='docker logs -f peer1.org1.local.com'
alias plog2='docker logs -f peer1.org2.local.com'
```
profile 적용을 위하여 아래와 같이 명령어를 입력하고, 로그아웃 한다.

```bash
$ source ~/.profile
$ logout
```

profile이 적용된 것을 확인하기 위해서 `alias` 명령어를 입력하면,

```bash
$ alias
...
alias plog1='docker logs -f peer1.org1.local.com'
alias plog2='docker logs -f peer1.org2.local.com'
```

와 같이 profile에 입력한 alias가 나오는 것을 확인 할 수 있다.

---

### docker

#### docker 컨테이너 전부 삭제

```
docker stop [container id]
docker rm [container id]
```

```bash
$ docker rm $(docker ps -q -f status=exited)
```

```bash
$ docker system prune -a 
```