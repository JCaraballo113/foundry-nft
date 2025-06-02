// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
    uint256 private s_tokenCounter;
    mapping (uint256 => string) private s_tokenURIs;
    constructor() ERC721("Dogie", "DOG") {
        s_tokenCounter = 0;
    }

    function mintNft(string memory tokenUri) public {
        s_tokenURIs[s_tokenCounter] = tokenUri;
        s_tokenCounter++;
        _safeMint(msg.sender, s_tokenCounter - 1);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return s_tokenURIs[tokenId];
    }
}