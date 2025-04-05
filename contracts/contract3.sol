// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SelfDestructVuln {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    function destroy() public {
        require(tx.origin == owner, "Not authorized"); // tx.origin authentication flaw
        selfdestruct(payable(msg.sender));
    }
}
