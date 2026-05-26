// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract NFTContract {
    uint256 public tokenCounter;

    struct Animal {
        uint256 tokenId;
        string animalType;
        string rarity;
        address owner;
    }

    mapping(uint256 => Animal) public animals;
    mapping(address => uint256[]) public ownerToTokens;

    address public hatchContract;

    event NFTMinted(
        address indexed owner,
        uint256 tokenId,
        string animalType,
        string rarity
    );

    modifier onlyHatchContract() {
        require(msg.sender == hatchContract, "Only HatchContract can mint");
        _;
    }

    function setHatchContract(address _hatchContract) public {
        require(hatchContract == address(0), "HatchContract already set");
        hatchContract = _hatchContract;
    }

    function mintNFT(
        address player,
        string memory animalType,
        string memory rarity
    ) external onlyHatchContract returns (uint256) {
        tokenCounter++;

        animals[tokenCounter] = Animal(
            tokenCounter,
            animalType,
            rarity,
            player
        );

        ownerToTokens[player].push(tokenCounter);

        emit NFTMinted(player, tokenCounter, animalType, rarity);

        return tokenCounter;
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        return animals[tokenId].owner;
    }

    function getAnimal(uint256 tokenId) public view returns (
        uint256,
        string memory,
        string memory,
        address
    ) {
        Animal memory animal = animals[tokenId];

        return (
            animal.tokenId,
            animal.animalType,
            animal.rarity,
            animal.owner
        );
    }

    function getMyNFTs(address player) public view returns (uint256[] memory) {
        return ownerToTokens[player];
    }
}