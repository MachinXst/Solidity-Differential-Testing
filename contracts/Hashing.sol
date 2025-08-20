// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Hashing {

    function getMessageHash(
        address _to,
        uint _amount,
        string memory _message,
        uint _nonce
    ) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_to, _amount, _message, _nonce));
    }

    function getMessageHash2(
        address _to,
        uint _amount,
        string memory _message,
        uint _nonce
    ) public pure returns (bytes32) {
        // Explicitly encode each parameter and concatenate them
        bytes memory encodedTo = abi.encodePacked(_to);
        bytes memory encodedAmount = abi.encodePacked(bytes32(_amount));
        bytes memory encodedMessage = abi.encodePacked(_message);
        bytes memory encodedNonce = abi.encodePacked(bytes32(_nonce));

        // Concatenate the encoded parameters
        bytes memory concatenated = abi.encodePacked(encodedTo, encodedAmount, encodedMessage, encodedNonce);

        // Hash the concatenated bytes
        bytes32 hashValue = keccak256(concatenated);

        return hashValue;
    }
}
