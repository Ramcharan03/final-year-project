// Vulnerability: Block Timestamp Manipulation
pragma solidity ^0.8.0;

contract WeakRandom {
    function getRandomNumber() public view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % 100; // ❌ Predictable
    }
}
