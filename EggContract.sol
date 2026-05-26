// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EggContract {
    mapping(address => uint256) public eggBalance;

    event EggBought(address indexed player, uint256 newBalance);

    function buyEgg() public payable {
        require(msg.value >= 0.01 ether, "Egg costs 1 ETH");

        eggBalance[msg.sender] += 1;

        emit EggBought(msg.sender, eggBalance[msg.sender]);
    }

    function useEgg(address player) external {
        require(eggBalance[player] > 0, "No eggs available");

        eggBalance[player] -= 1;
    }

    function getEggBalance(address player) public view returns (uint256) {
        return eggBalance[player];
    }
}