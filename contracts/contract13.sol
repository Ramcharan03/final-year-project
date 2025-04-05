// Reentrancy Attack Vulnerability Example
pragma solidity ^0.8.28;

contract ReentrancyVulnerable {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No balance available");
        (bool success,) = msg.sender.call{value: amount}(""); // ⚠️ Vulnerability: Reentrancy possible
        require(success, "Transfer failed");
        balances[msg.sender] = 0; // State change after external call ⚠️
    }
}
