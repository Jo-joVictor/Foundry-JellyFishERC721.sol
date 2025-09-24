// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract JellyFishNFT is ERC721, Ownable {
    // Counter for token IDs
    uint256 private _tokenIdCounter;

    constructor(address initialOwner) ERC721("JellyFish", "JELLY") Ownable(initialOwner) {}

    /**
     * @dev Mint function - only callable by owner
     * @param to Address to mint the NFT to
     */
    function mint(address to) external onlyOwner {
        require(to != address(0), "Zero address");

        uint256 tokenId = _tokenIdCounter;
        _tokenIdCounter++;

        _safeMint(to, tokenId);
    }

    /**
     * @dev Get total supply of minted tokens
     */
    function totalSupply() external view returns (uint256) {
        return _tokenIdCounter;
    }

    function _exists(uint256 tokenId) internal view returns (bool) {
        return tokenId < _tokenIdCounter && _ownerOf(tokenId) != address(0);
    }

    /**
     * @dev tokenURI cycles through 3 JSON files pinned on IPFS
     */
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        // Switch metadata every 15 seconds
        uint256 index = (block.timestamp / 15) % 3;

        if (index == 0) {
            return "ipfs://bafkreifdmrhseuxj76q6fcgzwjedc2stp2uiny73z2jayqm2ia4ihvglgu"; // 1.json
        } else if (index == 1) {
            return "ipfs://bafkreihrmkvo5ihl4ejf7opofrsyzgddk6ollw64y23jjngolnguuozbpe"; // 2.json
        } else {
            return "ipfs://bafkreie2zjw6pzo72gzmwgneoaqxgqooqgj2qrmwdvvntqm6aek4unrlvq"; // 3.json
        }
    }
}