pragma solidity ^0.8.0;

contract ImproperAccessControl {
    address public owner;

    function setOwner(address newOwner) public {
        owner = newOwner;  // No access control
    }
}
