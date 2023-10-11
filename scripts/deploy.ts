import { ethers, run, network } from "hardhat";

const delay = async (time: number) => {
  return new Promise((resolve: any) => {
    setInterval(() => {
      resolve()
    }, time)
  })
}

async function main() {
    const nftName = "NFT";

  const NFT = await ethers.getContractFactory(nftName);
  const nft = await NFT.deploy();

  await nft.deployed();

  console.log(`${nftName} contract deployed to: ${nft.address}`);
  console.log('Wait for delay...');
  await delay(20000); // 20 seconds
  console.log(`Starting verify ${nftName}...`);

  try {
    await run('verify', {
      address: nft!.address,
      constructorArguments: [],
      contract: 'contracts/NFT.sol:NFT',
    });
    console.log('Verify success')
  } catch(e: any) {
    console.log(e.message)
  }
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });