// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {JellyFishNFT} from "../src/JellyFishNFT.sol";

contract JellyFishTest is Test {
    JellyFishNFT public nft;
    address public owner;
    address public alice;
    address public bob;

    function setUp() public {
        owner = makeAddr("owner");
        alice = makeAddr("alice");
        alice = makeAddr("bob");

        vm.prank(owner);
        nft = new JellyFishNFT(owner);
    }

    function test_InitialState() public view {
        assertEq(nft.name(), "JellyFish");
        assertEq(nft.symbol(), "JELLY");
        assertEq(nft.totalSupply(), 0);
    }

    function test_Mint() public {
        vm.prank(owner);
        nft.mint(alice);

        assertEq(nft.totalSupply(), 1);
        assertEq(nft.ownerOf(0), alice);
    }

    function test_OnlyOwnerCanMint() public {
        vm.prank(alice);
        vm.expectRevert();
        nft.mint(alice);
    }

    function test_MintToZeroAddressReverts() public {
        vm.prank(owner);
        vm.expectRevert("Zero address");
        nft.mint(address(0));
    }

    function test_OwnershipTransfer() public {
        assertEq(nft.owner(), owner);

        vm.prank(owner);
        nft.transferOwnership(alice);

        assertEq(nft.owner(), alice);

        // Alice should now be able to mint
        vm.prank(alice);
        nft.mint(alice);

        assertEq(nft.totalSupply(), 1);
        assertEq(nft.ownerOf(0), alice);

        // Owner should no longer be able to mint
        vm.prank(owner);
        vm.expectRevert();
        nft.mint(owner);
    } 
}