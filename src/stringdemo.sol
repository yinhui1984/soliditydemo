// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.11;

contract StringDemo {
    function ConcatString(
        string memory a,
        string memory b
    ) public pure returns (string memory) {
        return string(abi.encodePacked(a, b));
    }

    function GetLength(string memory s) public pure returns (uint) {
        return bytes(s).length;
    }

    function Compare(
        string memory a,
        string memory b
    ) public pure returns (bool) {
        return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    }

    function Compare2(
        string memory a,
        string memory b
    ) public pure returns (bool) {
        return keccak256(bytes(a)) == keccak256(bytes(b));
    }

    function Compare3(
        string memory a,
        string memory b
    ) public pure returns (bool) {
        return keccak256(abi.encodePacked(a)) == keccak256(bytes(b));
    }

    function SubString(
        string memory s,
        uint start,
        uint end
    ) public pure returns (string memory) {
        require(end > start, "Invalid index range");
        end = end > bytes(s).length ? bytes(s).length : end;
        bytes memory b = bytes(s);
        bytes memory sub = new bytes(end - start);
        for (uint i = start; i < end; i++) {
            sub[i - start] = b[i];
        }

        return string(sub);
    }

    function StringToInt(string memory s) public pure returns (int) {
        bytes memory stringBytes = bytes(s);
        int result = 0;
        bool negative = false;
        uint startIndex = 0;

        // Check if the string represents a negative number
        if (stringBytes.length > 0 && stringBytes[0] == "-") {
            negative = true;
            startIndex = 1;
        }

        for (uint i = startIndex; i < stringBytes.length; i++) {
            require(
                stringBytes[i] >= "0" && stringBytes[i] <= "9",
                "String must be a valid integer."
            );
            result = result * 10 + (int8(uint8(stringBytes[i])) - 48);
        }

        if (negative) {
            result = -result;
        }

        return result;
    }

    function IntToString(int i) public pure returns (string memory) {
        if (i == 0) return "0";
        bool negative = i < 0;
        uint len;
        int j = i;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(negative ? len + 1 : len);
        uint k = negative ? len + 1 : len;
        if (negative) {
            i = -i; // Convert to positive to handle the modulus operation
            bstr[0] = bytes1(uint8(45)); // ASCII value for '-'
        }
        while (i != 0) {
            k = k - 1;
            uint8 temp = uint8(48 + uint256(i % 10)); // Convert to uint256 before converting to uint8
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            i /= 10;
        }
        return string(bstr);
    }
}
