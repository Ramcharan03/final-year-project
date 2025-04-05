// Vulnerability: Reentrancy
pragma solidity ^0.8.0;

contract ReentrancyAttack {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No balance to withdraw");
        (bool success, ) = msg.sender.call{value: amount}(""); // ❌ Reentrancy issue
        require(success, "Transfer failed");
        balances[msg.sender] = 0;
    }
}
