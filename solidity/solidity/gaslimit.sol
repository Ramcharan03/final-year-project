pragma solidity ^0.8.0;

contract GasLimit {
    uint256[] public values;

    function addValues(uint256[] memory newValues) public {
        // Vulnerability: unbounded loop can exceed gas limit
        for (uint256 i = 0; i < newValues.length; i++) {
            values.push(newValues[i]);
        }
    }
}
