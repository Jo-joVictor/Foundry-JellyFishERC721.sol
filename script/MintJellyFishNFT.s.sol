// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {JellyFishNFT} from "../src/JellyFishNFT.sol";

contract MintJellyFishNFT is Script {
    function run() external {
        address contractAddress = vm.envAddress("CONTRACT_ADDRESS");
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        JellyFishNFT jellyFishNFT = JellyFishNFT(contractAddress);

        vm.startBroadcast(deployerPrivateKey);
        jellyFishNFT.mint(vm.addr(deployerPrivateKey));
        vm.stopBroadcast();

        console.log("NFT minted successfully!");
    }
}