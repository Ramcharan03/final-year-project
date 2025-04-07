pragma solidity ^0.8.0;

contract DelegatedSpending {
    mapping(address => mapping(address => uint256)) public allowances;

    function approve(address spender, uint256 amount) public {
        allowances[msg.sender][spender] = amount;
    }

    function transferFrom(address from, address to, uint256 amount) public {
        require(allowances[from][msg.sender] >= amount, "Allowance exceeded");
        allowances[from][msg.sender] -= amount;
        // Delegate can spend tokens on behalf of 'from'
    }
}
