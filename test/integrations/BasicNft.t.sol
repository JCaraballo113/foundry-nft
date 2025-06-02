// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";
import {console2} from "forge-std/console2.sol";

contract BasicNftTest is Test {
    BasicNft public basicNft;
    DeployBasicNft public deployer;

    address public USER = makeAddr("USER");

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();
        assertEq(
            actualName,
            expectedName,
            "NFT name does not match expected value"
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.startPrank(USER);
        basicNft.mintNft("https://example.com/token/1");
        assertEq(basicNft.balanceOf(USER), 1, "User should own 1 NFT");
        assertEq(
            basicNft.tokenURI(0),
            "https://example.com/token/1",
            "Token URI does not match expected value"
        );
        vm.stopPrank();
        console2.log("NFT minted successfully and balance is correct.");
    }
}
