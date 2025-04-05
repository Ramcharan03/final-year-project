// Selfdestruct Vulnerability Example
pragma solidity ^0.8.28;

contract SelfdestructVulnerable {
    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function destroy() public {
        require(msg.sender == owner, "Not authorized");
        selfdestruct(owner); // ⚠️ Funds will be forcibly transferred
    }
}
