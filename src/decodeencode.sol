// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.11;

struct People {
    string name;
    uint age;
}

contract EncodeExample {
    function EncodeString(
        string memory str
    ) public pure returns (bytes memory) {
        return abi.encode(str);
    }

    function EncodeBytes(bytes memory b) public pure returns (bytes memory) {
        return abi.encode(b);
    }

    function EncodeStruct(People memory p) public pure returns (bytes memory) {
        return abi.encode(p);
    }

    function Add(uint a, uint b) public pure returns (uint) {
        return a + b;
    }

    function EncodeCallAdd() public view returns (bytes memory) {
        return abi.encodeCall(this.Add, (1, 2));
    }

    function EncodePackedHelloWorld() public pure returns (bytes memory) {
        return abi.encodePacked("hello", "world");
    }
}

contract DecodeExample {
    function DecodeString(
        bytes memory encoded
    ) public pure returns (string memory) {
        return abi.decode(encoded, (string));
    }

    function DecodeBytes(
        bytes memory encoded
    ) public pure returns (bytes memory) {
        return abi.decode(encoded, (bytes));
    }

    function DecodeStruct(
        bytes memory encoded
    ) public pure returns (People memory) {
        return abi.decode(encoded, (People));
    }

    // ERROR:
    // function DecodePackedHelloWorld(
    //     bytes memory encoded
    // ) public pure returns (string memory, string memory) {
    //     return abi.decode(encoded, (string, string));
    // }

    function DecodePackedHelloWorld(
        bytes memory data
    ) public pure returns (string memory, string memory) {
        require(data.length == 10, "Invalid data length");

        bytes memory str1 = new bytes(5);
        bytes memory str2 = new bytes(5);

        for (uint i = 0; i < 5; i++) {
            str1[i] = data[i];
            str2[i] = data[i + 5];
        }

        return (string(str1), string(str2));
    }
}
