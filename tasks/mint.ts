import { task } from "hardhat/config";
import { BigNumber, ContractTransaction, ContractReceipt } from "ethers";
import { Address } from 'cluster';

task("mint", "Mint ERC1155 token")
  .addParam("nft", "The token address")
  .addParam("uri", "Token uri")
  .setAction(async ({ nft, uri }, { ethers }) => {
    const [owner] = await ethers.getSigners();

    const NFT = await ethers.getContractFactory("NFT");
    const token = NFT.attach(nft);

    const mintTx: ContractTransaction = await token.mint(owner.address, uri);

    const contractReceipt: ContractReceipt = await mintTx.wait();
    const event = contractReceipt.events?.find(event => event.event === 'Minted');
    const eInitiator: Address = event?.args!['owner'];
    const tokenId: BigNumber = event?.args!['tokenId'];

    console.log(`Minted new NFT token with id ${tokenId} to ${eInitiator}`);
  });