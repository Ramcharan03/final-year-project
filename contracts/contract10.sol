// Vulnerability: Delegatecall Exploit
pragma solidity ^0.8.0;

contract Victim {
    address public owner;
    
    function changeOwner(address _newOwner) public {
        owner = _newOwner;
    }
}

contract Attacker {
    function attack(address _victim) public {
        (bool success,) = _victim.delegatecall(
            abi.encodeWithSignature("changeOwner(address)", msg.sender)
        );
        require(success, "Attack failed"); // ❌ Delegatecall Exploit
    }
}
