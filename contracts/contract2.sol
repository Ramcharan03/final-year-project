// SPDX-License-Identifier: MIT
pragma solidity ^0.4.24;

contract OldVersionContract {
    uint8 public count = 255;

    function increment() public {
        count += 1; // Integer Overflow (in old Solidity versions)
    }
}

contract AccessControl {
    address owner;

    function setOwner(address newOwner) public {
        owner = newOwner; // Missing onlyOwner modifier
    }
}
