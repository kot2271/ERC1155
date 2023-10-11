// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";  

contract NFT is ERC1155, Ownable {
    uint256 public tokenCount;

  mapping(uint256 => string) private _tokenUris;

  event Minted(address owner, uint256 tokenId);

  event Burned(address indexed burner, address indexed from, uint256 id, uint256 amount);

  constructor() ERC1155("") {
  }

  function mint(address _owner, string memory tokenUri) public onlyOwner {
    uint256 currentTokenId = tokenCount;
    tokenCount ++;
    _mint(_owner, currentTokenId, 1, "");
    setURI(currentTokenId, tokenUri);
    emit Minted(_owner, currentTokenId);
  }

  function burn(address _owner, uint256 tokenId) public onlyOwner {
    require(balanceOf(_owner, tokenId) > 0, "Owner does not own token");
    tokenCount --;
    _burn(_owner, tokenId, 1);
    emit Burned(msg.sender, _owner, tokenId, 1);
  }

  function setURI(uint256 tokenId, string memory tokenUri) internal {
     _tokenUris[tokenId] = tokenUri;
  }

  function uri(uint256 tokenId) public view override returns (string memory) {
    return _tokenUris[tokenId]; 
  }
}