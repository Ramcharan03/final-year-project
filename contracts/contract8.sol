// Vulnerability: Unprotected Self-Destruct
pragma solidity ^0.8.0;

contract UnprotectedDestroy {
    function kill() public {
        selfdestruct(payable(msg.sender)); // ❌ No access control
    }
}
