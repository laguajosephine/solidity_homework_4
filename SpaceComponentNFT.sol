// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


// ---------------------------------------------------------------
// ERC-721: NFT Contract for Space Component Tracking
// ---------------------------------------------------------------
contract SpaceComponentNFT is ERC721URIStorage, Ownable {
    uint256 private _tokenIdCounter;

    constructor() ERC721("SpaceComponentNFT", "SCNFT") {}

    // Mint a new NFT representing a space component
    function mintComponent(address to, string memory metadataURI) public onlyOwner returns (uint256) {
        uint256 tokenId = _tokenIdCounter;
        _tokenIdCounter += 1;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, metadataURI);
        return tokenId;
    }

    // Update metadata of an existing NFT
    function updateMetadata(uint256 tokenId, string memory newMetadataURI) public onlyOwner {
        require(_exists(tokenId), "NFT does not exist");
        _setTokenURI(tokenId, newMetadataURI);
    }

    // Transfer NFT securely
    function transferOwnership(address from, address to, uint256 tokenId) public {
        require(ownerOf(tokenId) == from, "Not the NFT owner");
        _safeTransfer(from, to, tokenId, "");
    }

    // Approve another address to manage the NFT
    function approve(address approved, uint256 tokenId) public override {
        require(ownerOf(tokenId) == msg.sender, "Not the NFT owner");
        _approve(approved, tokenId);
    }

    // Securely transfer NFT from one owner to another
    function safeTransferFrom(address from, address to, uint256 tokenId) public override {
        require(_isApprovedOrOwner(msg.sender, tokenId), "Not approved");
        _safeTransfer(from, to, tokenId, "");
    }
}

  
