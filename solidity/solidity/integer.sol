pragma solidity ^0.8.0;

contract OverflowUnderflow {
    uint256 public totalSupply;

    function add(uint256 value) public {
        // Vulnerability: integer overflow
        totalSupply += value;
    }

    function subtract(uint256 value) public {
        // Vulnerability: integer underflow
        totalSupply -= value;
    }
}
