pragma solidity ^0.8.0;

contract ImproperUse {
    function check(uint256 amount) public {
        assert(amount > 0);  // Improper use of assert
    }
}
