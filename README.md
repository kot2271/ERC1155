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
npx hardhat mint --nft {CONTRACT_ADDRESS} --uri {IMAGE_URI} --network polygon-mumbai
```

Running a burn task:
```shell
npx hardhat burn --nft {CONTRACT_ADDRESS} --token-id {TOKEN_ID}  --network polygon-mumbai
```


## Verify
Verify the installation by running the following command:
```shell
npx hardhat verify --network polygon-mumbai {CONTRACT_ADDRESS}
```

```shell
{CONTRACT_ADDRESS}: 0xA6f57aF6d87365b0c4B916C62a583C75bB7F15f6
0x2ECc2744e85869B64dAD3D3E2C7BE06402d8D3d6
```
[Ghost NFT](https://testnets.opensea.io/assets/mumbai/0xa6f57af6d87365b0c4b916c62a583c75bb7f15f6/4)