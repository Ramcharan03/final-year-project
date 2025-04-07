pragma solidity ^0.8.0;

contract AccessControl {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address newOwner) public {
        // Vulnerability: anyone can change the owner
        owner = newOwner;
    }
}
