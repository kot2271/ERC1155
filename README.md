# ERC1155 Token Example


## Install
```shell
npm install
```

## Deploy
Deploy contract to the chain (polygon-mumbai testnet)
```shell
npx hardhat run scripts/deploy.ts --network polygon-mumbai
```

## Tasks
Create a new task(s) and save it(them) in the folder "tasks". Add a new task_name in the file "tasks/index.ts"

Running a mint task:
```shell
npx hardhat mint --nft {CONTRACT_ADDRESS} --uri {IMAGE_URI}  --network polygon-mumbai
```


## Verify
Verify the installation by running the following command:
```shell
npx hardhat verify --network polygon-mumbai {CONTRACT_ADDRESS}
```

```shell
{CONTRACT_ADDRESS} : 0x462cEF234707C9a4Bd9149dF47Df48344773B14F

```