// SPDX-License-Identifier: SEE LICENSE IN LICENSE

pragma solidity ^0.8.19;
import {ERC721} from "@openzeppelin/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/utils/Base64.sol";

contract MoodNft is ERC721 {
    error MoodNft__CantFlipMoodIfNotOwnerOrApproved();

    uint256 private s_tokenCounter;
    // aderyn-ignore-next-line(state-variable-could-be-immutable)
    string private i_sadSvgImageUri;
    // aderyn-ignore-next-line(state-variable-could-be-immutable)
    string private i_happySvgImageUri;

    enum Mood {
        HAPPY,
        SAD
    }
    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(
        string memory happySvgImageUri,
        string memory sadSvgImageUri
    ) ERC721("MoodNFT", "MN") {
        s_tokenCounter = 0;
        i_sadSvgImageUri = sadSvgImageUri;
        i_happySvgImageUri = happySvgImageUri;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    function flipMood(uint256 tokenId) public {
        if (
            msg.sender != ownerOf(tokenId) && getApproved(tokenId) != msg.sender
        ) {
            revert MoodNft__CantFlipMoodIfNotOwnerOrApproved();
        }

        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageURI;
        if (s_tokenIdToMood[tokenId] == Mood.SAD) {
            imageURI = i_sadSvgImageUri;
        } else {
            imageURI = i_happySvgImageUri;
        }

        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name": "',
                                name(),
                                "description: An NFT that represents a mood",
                                '", "attributes": [{"trait_type": "mood", "value": 100}], "image": ',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}
