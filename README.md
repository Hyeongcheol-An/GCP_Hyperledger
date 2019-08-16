Hyperledger Fabric with Google Cloud Platform
---

# 1. GCP VM Network

## 1.1. VM IP Address

| VM           | IP             | 
| :----------: | :-------------: | 
| `org1-1`     | **34.66.226.174**  |
| `org1-2`     | **34.67.110.38**   | 
| `org2-1`     | **35.232.221.188** | 
| `org2-2`     | **35.222.162.181** | 
| `orderer1`   | **35.232.167.182** | 
| `orderer2`   | **34.67.71.72**    | 
| `orderer3`   | **34.66.179.76**   | 




## 1.2. Hyperledger Network  Case

| VM                         | IP  | 용도        |
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
