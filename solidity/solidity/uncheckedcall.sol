pragma solidity ^0.8.0;

contract UncheckedCall {
    function transfer(address payable recipient, uint256 amount) public {
        // Vulnerability: no check on call return value
        recipient.transfer(amount);
    }
}
