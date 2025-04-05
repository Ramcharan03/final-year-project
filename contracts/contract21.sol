// Vulnerabilities: Public Variable Exposure + Front-Running
pragma solidity ^0.8.0;

contract FrontRunVuln {
    uint public secretBidAmount = 1 ether; // ❌ Public variable exposed

    function bid() public payable {
        require(msg.value > secretBidAmount, "Bid too low");  // ❌ Front-Running Possible
    }
}
