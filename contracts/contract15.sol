// tx.origin Authentication Vulnerability Example
pragma solidity ^0.8.28;

contract TXOriginVulnerable {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    function transferOwnership(address newOwner) public {
        require(tx.origin == owner, "Not authorized"); // ⚠️ Can be bypassed with a contract call
        owner = newOwner;
    }
}
