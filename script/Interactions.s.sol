// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract MintBasicNft is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid
        );
        mintNftContract(mostRecentlyDeployed);
    }

    function mintNftContract(address basicNftAddress) internal {
        vm.startBroadcast();
        BasicNft basicNft = BasicNft(basicNftAddress);
        basicNft.mintNft("https://example.com/token/1");
        vm.stopBroadcast();
    }
}
