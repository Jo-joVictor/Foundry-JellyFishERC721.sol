// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {JellyFishNFT} from "../src/JellyFishNFT.sol";

contract DeployJellyFishNFT is Script {
    function run() external returns (JellyFishNFT) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);

        console.log("Deploying JellyFishNFT...");

        vm.startBroadcast(deployerPrivateKey);
        JellyFishNFT jellyFishNFT = new JellyFishNFT(deployer);
        vm.stopBroadcast();

        console.log("Contract deployed at:", address(jellyFishNFT));
        
        return jellyFishNFT;
    }
}