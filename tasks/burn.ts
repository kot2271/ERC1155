import { task } from "hardhat/config";
import { BigNumber, ContractTransaction, ContractReceipt } from "ethers";
import { Address } from 'cluster';


task("burn", "Burn an NFT token")
  .addParam("nft", "The NFT contract address")
  .addParam("tokenId", "The token id to burn")
  .setAction(async ({ nft, tokenId }, { ethers }) => {
    const [owner] = await ethers.getSigners();

    const NFT = await ethers.getContractFactory("NFT");
    const token = NFT.attach(nft);

    const burnTx: ContractTransaction = await token.burn(owner.address, tokenId);
    
    const contractReceipt: ContractReceipt = await burnTx.wait();
    const event = contractReceipt.events?.find(event => event.event === 'Burned');
    const sender: Address = event?.args!['burner'];
    const nftOwner: Address = event?.args!['from'];
    const nftId: BigNumber = event?.args!['id'];
    const amount: BigNumber = event?.args!['amount'];

    console.log(`The token burner: ${sender}`);
    console.log(`Burned ${amount} token ${nftId} for account ${nftOwner}`);
  });