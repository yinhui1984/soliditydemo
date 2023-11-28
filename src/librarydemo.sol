// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.11;

library StringLibrary {
    function Slice(
        string memory str,
        uint start,
        uint len
    ) internal pure returns (string memory) {
        bytes memory strBytes = bytes(str);
        bytes memory result = new bytes(len);
        for (uint i = 0; i < len; i++) {
            result[i] = strBytes[i + start];
        }
        return string(result);
    }
}

library ArrayLibrary {
    function Slice(
        uint[] memory arr,
        uint start,
        uint len
    ) external pure returns (uint[] memory) {
        uint[] memory result = new uint[](len);
        for (uint i = 0; i < len; i++) {
            result[i] = arr[i + start];
        }
        return result;
    }
}
