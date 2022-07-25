// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "openzeppelin-contracts/contracts/utils/Strings.sol";
import "../src/NFT.sol";

contract NFTTest is Test {
    NFT public nftContract;

    function setUp() public {
        nftContract = new NFT("NFT", "NFT");
    }

    function testTokenURI(uint256 index) public {
        string memory result = nftContract.tokenURI(index);
        emit log(result);
        assertTrue(true);
    }
}
