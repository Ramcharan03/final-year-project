// Vulnerability: Integer Overflow
pragma solidity ^0.4.24;

contract OverflowExample {
    uint8 public count = 255;

    function add() public {
        count += 1; // ❌ Overflow occurs (255 + 1 = 0 in uint8)
    }
}
