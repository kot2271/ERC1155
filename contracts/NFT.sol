// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";  

contract NFT is ERC1155, Ownable {
    uint256 public tokenCount;

  mapping(uint256 => string) private _tokenUris;

  mapping(string => uint256) private _uriToTokenId;

  event Minted(address owner, uint256 tokenId);

  event Burned(address owner, uint256 tokenId);

  constructor() ERC1155("") {
  }

  function mint(address _owner, string memory tokenUri) public onlyOwner {
    uint256 currentTokenId = tokenCount;
    tokenCount ++;
    _mint(_owner, currentTokenId, 1, "");
    setURI(currentTokenId, tokenUri);
    _uriToTokenId[tokenUri] = currentTokenId;
    emit Minted(_owner, currentTokenId);
  }

  function burn(address owner, string memory tokenUri) public onlyOwner {
    uint256 tokenId = _uriToTokenId[tokenUri];
    require(balanceOf(owner, tokenId) > 0, "Owner does not own token");
    tokenCount --;
    _burn(owner, tokenId, 1);
    emit Burned(owner, tokenId);
  }

  function setURI(uint256 tokenId, string memory tokenUri) internal {
     _tokenUris[tokenId] = tokenUri;
  }

  function uri(uint256 tokenId) public view override returns (string memory) {
    return _tokenUris[tokenId]; 
  }

}