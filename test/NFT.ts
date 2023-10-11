import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { expect } from "chai";
import { BigNumber } from "ethers";
import { ethers } from "hardhat";

import { NFT } from "../src/types/NFT";
import { NFT__factory } from "../src/types/factories/NFT__factory";

const CONTRACT_NAME = "NFT";

describe("NFT", () => {

    let nft: NFT;
    let owner: SignerWithAddress;
  
    beforeEach(async () => {
      [owner] = await ethers.getSigners();
      const nftFactory = (await ethers.getContractFactory(CONTRACT_NAME, owner)) as NFT__factory;
      nft = await nftFactory.deploy();
    });
  
    describe("mint", () => {
  
      it("should mint new token", async () => {
        const tokenId: BigNumber = BigNumber.from(0);
        const uri = "https://ipfs.io/ipfs/QmXWCpuTCHeCKK19vTWUHArzUjDtv3SJss5LRdy8YZ2rSA?filename=Ghost.png";
        
        await nft.connect(owner).mint(owner.address, uri);
        
        expect(await nft.balanceOf(owner.address, tokenId)).to.equal(1);
        expect(await nft.uri(tokenId)).to.equal(uri);
      });
  
    });
  
    describe("burn", () => {
  
      it("should burn token", async () => {
        const tokenId: BigNumber = BigNumber.from(0);
        const uri = "https://ipfs.io/ipfs/QmXWCpuTCHeCKK19vTWUHArzUjDtv3SJss5LRdy8YZ2rSA?filename=Ghost.png";
        
        await nft.connect(owner).mint(owner.address, uri);
        await nft.connect(owner).burn(owner.address, tokenId);
        
        expect(await nft.balanceOf(owner.address, tokenId)).to.equal(0);
      });
  
    });
    
  });