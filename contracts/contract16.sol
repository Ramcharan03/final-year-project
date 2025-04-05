// Unchecked External Call Example
pragma solidity ^0.8.28;

contract UncheckedCall {
    function unsafeCall(address _addr, bytes memory _data) public {
        _addr.call(_data); // ⚠️ Vulnerability: Call return value is ignored
    }
}
