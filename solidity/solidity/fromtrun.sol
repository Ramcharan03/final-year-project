pragma solidity ^0.8.0;

contract FrontRunning {
    mapping(address => uint256) public balances;

    function buyTokens() public payable {
        // Vulnerability: front running potential
        uint256 tokensToBuy = msg.value * 100; // Example conversion rate
        balances[msg.sender] += tokensToBuy;
    }
}
