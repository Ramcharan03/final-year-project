pragma solidity ^0.8.0;

contract InsecureDelegateCall {
    address public implementation;

    function setImplementation(address _impl) public {
        implementation = _impl;
    }

    function delegateExecute(bytes memory data) public {
        (bool success, ) = implementation.delegatecall(data);
        require(success, "Delegatecall failed");
    }
}
