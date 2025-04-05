// Vulnerabilities: Missing Constructor + Unprotected Selfdestruct
pragma solidity ^0.8.0;

contract WeakContract {
    address public owner;

    function WeakContract() public { // ❌ Public function, not a constructor
        owner = msg.sender;
    }

    function destroy() public {
        selfdestruct(payable(msg.sender)); // ❌ Anyone can call this
    }
}
