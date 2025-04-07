pragma solidity ^0.8.0;

contract FlashLoanVulnerable {
    function flashLoan(uint256 amount) public {
        uint256 balanceBefore = address(this).balance;
        require(balanceBefore >= amount, "Insufficient funds");
        
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
        
        require(address(this).balance >= balanceBefore, "Flash loan not repaid");
    }
}
