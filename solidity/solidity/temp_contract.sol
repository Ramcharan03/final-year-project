// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Example {
    address payable owner;

    constructor() {
        owner = msg.sender;
    }

    function destroyContract() public {
        require(msg.sender == owner, "Not authorized");
        selfdestruct(owner);
    }
}
