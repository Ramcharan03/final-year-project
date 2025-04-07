// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract ReplayAttackVulnerable {
    mapping(bytes32 => bool) usedNonces;

    function sendEther(address payable _to, uint256 _amount, uint256 _nonce) public {
        bytes32 txHash = keccak256(abi.encodePacked(_to, _amount, _nonce));
        require(!usedNonces[txHash], "Nonce already used");
        usedNonces[txHash] = true;
        _to.transfer(_amount);
    }
}
