pragma solidity ^0.8.0;

contract UnboundedLoop {
    uint256[] public data;

    function processLoop() public {
        for (uint i = 0; i < data.length; i++) {
            // Unbounded loop over dynamic array
        }
    }
}
