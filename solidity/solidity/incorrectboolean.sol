pragma solidity ^0.8.0;

contract IncorrectBoolean {
    function checkCondition(uint256 a, uint256 b) public pure returns (bool) {
        if (a = b) {  // Assignment instead of comparison
            return true;
        }
        return false;
    }
}
