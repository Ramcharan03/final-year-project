pragma solidity ^0.8.0;

contract UnencryptedData {
    bytes public sensitiveData;

    function storeData(bytes memory data) public {
        sensitiveData = data;  // Storing unencrypted data
    }
}
