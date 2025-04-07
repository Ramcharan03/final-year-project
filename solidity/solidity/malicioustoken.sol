pragma solidity ^0.8.0;

contract MaliciousToken {
    mapping(address => uint256) balances;

    function mint(uint256 amount) public {
        balances[msg.sender] += amount;
        // Malicious contract, no checks on minting
    }
}
