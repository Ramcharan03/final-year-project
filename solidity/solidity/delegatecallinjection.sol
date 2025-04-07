pragma solidity ^0.8.0;

contract DelegatecallInjection {
    address public implementation;

    function setImplementation(address _implementation) public {
        // Vulnerability: no access control on implementation address
        implementation = _implementation;
    }

    function execute(bytes memory data) public {
        // Vulnerability: delegatecall can lead to unexpected behavior
        (bool success, ) = implementation.delegatecall(data);
        require(success, "Delegatecall failed");
    }
}
