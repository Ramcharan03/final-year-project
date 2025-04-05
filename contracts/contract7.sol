// Vulnerability: tx.origin Authentication Flaw
pragma solidity ^0.8.0;

contract TxOriginVuln {
    address public owner;

    constructor() { owner = msg.sender; }

    function transfer(address payable to, uint amount) public {
        require(tx.origin == owner, "Not owner"); // ❌ tx.origin Vulnerability
        to.transfer(amount);
    }
}
