// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFT is ERC1155, Ownable {
    // Total count of tokens minted
    uint256 public tokenCount;

    // Mapping to store token URIs
    mapping(uint256 => string) private _tokenUris;

    // Event emitted when a new token is minted
    event Minted(address owner, uint256 tokenId);

    // Event emitted when a token is burned
    event Burned(
        address indexed burner,
        address indexed from,
        uint256 id,
        uint256 amount
    );

    // Constructor to initialize ERC1155
    constructor() ERC1155("") {}

    /**
     * @dev Mint a new token and assign it to the specified owner.
     * Only accessible by the contract owner.
     * Emits a Minted event upon successful minting.
     * @param _owner The address that will own the minted token.
     * @param tokenUri The URI associated with the minted token.
     */
    function mint(address _owner, string memory tokenUri) public onlyOwner {
        uint256 currentTokenId = tokenCount;
        tokenCount++;
        _mint(_owner, currentTokenId, 1, "");
        setURI(currentTokenId, tokenUri);
        emit Minted(_owner, currentTokenId);
    }

    /**
     * @dev Burn a specific amount of a token owned by the specified owner.
     * Only accessible by the contract owner.
     * Emits a Burned event upon successful burning.
     * @param _owner The address of the owner of the token.
     * @param tokenId The ID of the token to be burned.
     */
    function burn(address _owner, uint256 tokenId) public onlyOwner {
        require(balanceOf(_owner, tokenId) > 0, "Owner does not own token");
        tokenCount--;
        _burn(_owner, tokenId, 1);
        emit Burned(msg.sender, _owner, tokenId, 1);
    }

    /**
     * @dev Set the URI associated with a specific token ID.
     * @param tokenId The ID of the token.
     * @param tokenUri The URI to be associated with the token.
     */
    function setURI(uint256 tokenId, string memory tokenUri) internal {
        _tokenUris[tokenId] = tokenUri;
    }

    /**
     * @dev Get the URI associated with a specific token ID.
     * @param tokenId The ID of the token.
     * @return The URI associated with the token.
     */
    function uri(uint256 tokenId) public view override returns (string memory) {
        return _tokenUris[tokenId];
    }
}
