// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";
import {Base64} from "@openzeppelin/utils/Base64.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {DeployMoodNft} from "../script/DeployMoodNft.s.sol";

contract DeployMoodNftTest is Test {
    MoodNft private moodNft;
    DeployMoodNft private deployer;

    function setUp() public {
        deployer = new DeployMoodNft();
        moodNft = deployer.run();
    }

    function testSVGToImageURI() public view {
        string memory happySvgRaw = vm.readFile("images/happy.svg");
        console2.log("Happy SVG Raw: %s", happySvgRaw);
        string memory happyImageURI = deployer.svgToImageURI(happySvgRaw);

        assertEq(
            moodNft.tokenURI(0),
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            string(
                                abi.encodePacked(
                                    '{"name": "',
                                    moodNft.name(),
                                    "description: An NFT that represents a mood",
                                    '", "attributes": [{"trait_type": "mood", "value": 100}], "image": ',
                                    happyImageURI,
                                    '"}'
                                )
                            )
                        )
                    )
                )
            )
        );
    }
}
