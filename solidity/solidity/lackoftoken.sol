pragma solidity ^0.8.0;

contract NoBurnFunction {
    mapping(address => uint256) public balances;

    function mint(uint256 amount) public {
        balances[msg.sender] += amount;
    }
}
