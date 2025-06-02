// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/utils/Base64.sol";

contract DeployMoodNft is Script {
    function run() external returns (MoodNft) {
        vm.startBroadcast();
        MoodNft moodNft = new MoodNft("images/happy.svg", "images/sad.svg");
        vm.stopBroadcast();
        return moodNft;
    }

    function svgToImageURI(
        string memory svg
    ) public pure returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "data:image/svg+xml;base64,",
                    Base64.encode(bytes(string(abi.encodePacked(svg))))
                )
            );
    }
}
