pragma solidity ^0.8.0;

contract TimestampDependency {
    function isDeadlinePassed(uint256 deadline) public view returns (bool) {
        // Vulnerability: using block.timestamp for critical conditions
        return block.timestamp > deadline;
    }
}
