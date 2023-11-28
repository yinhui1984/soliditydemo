// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.10;

// import "lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol";

contract EcrecoverDemo {
    function RecoverFromMessage(
        string calldata message,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public pure returns (address) {
        bytes32 hash = keccak256(abi.encodePacked(message));
        return ecrecover(hash, v, r, s);
    }
}
