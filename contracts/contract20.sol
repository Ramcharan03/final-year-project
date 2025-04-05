// Vulnerabilities: Unchecked Call Return + Denial of Service
pragma solidity ^0.8.0;

contract UncheckedDOS {
    function sendEther(address payable recipient) public payable {
        recipient.call{value: msg.value}(""); // ❌ Unchecked return value
    }

    function expensiveLoop() public pure {
        while (true) {} // ❌ Infinite Loop (Denial of Service)
    }
}
