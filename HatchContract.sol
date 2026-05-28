// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./EggContract.sol";
import "./NFTContract.sol";

contract HatchContract {
    EggContract public eggContract;
    NFTContract public nftContract;

    constructor(address _eggContract, address _nftContract) {
        eggContract = EggContract(_eggContract);
        nftContract = NFTContract(_nftContract);
    }

    function hatchEgg() public {
        eggContract.useEgg(msg.sender);

        string memory rarity = generateRarity(msg.sender);
        string memory animalType = generateAnimal(msg.sender);

        nftContract.mintNFT(msg.sender, animalType, rarity);
    }

    function generateRarity(address player) public view returns (string memory) {
        uint256 random = uint256(
            keccak256(abi.encodePacked(block.timestamp, player))
        ) % 100;

        if (random < 55) return "Common";
        if (random < 80) return "Rare";
        if (random < 95) return "Epic";
        return "Legendary";
    }

    function generateAnimal(address player) public view returns (string memory) {
        uint256 random = uint256(
            keccak256(abi.encodePacked(block.timestamp, player, "ANIMAL"))
        ) % 5;

        if (random == 0) return "Dragon";
        if (random == 1) return "Tiger";
        if (random == 2) return "Phoenix";
        if (random == 3) return "Wolf";
        return "Snail";
    }
}