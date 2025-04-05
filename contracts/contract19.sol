// Vulnerabilities: Reentrancy + Integer Overflow
pragma solidity ^0.4.24;

contract MultiVuln {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value; // ❌ Integer Overflow (Solidity <0.8.0)
    }

    function withdraw() public {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No balance to withdraw");
        msg.sender.call{value: amount}(""); // ❌ Reentrancy Attack
        balances[msg.sender] = 0;
    }
}
