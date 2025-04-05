// Vulnerability: Gas Limit Denial of Service
pragma solidity ^0.8.0;

contract DOSVuln {
    mapping(address => uint) public balances;
    address[] public users;

    function withdraw() public {
        require(balances[msg.sender] > 0, "No balance");

        for (uint i = 0; i < users.length; i++) {  
            // ❌ Unbounded loop causes Gas Limit DOS
        }

        balances[msg.sender] = 0;
    }
}
