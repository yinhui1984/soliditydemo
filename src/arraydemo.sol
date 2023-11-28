// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.10;

contract ArrayDemo {
    uint[3] fixedArray = [1, 2, 3];
    uint[] dynamicArray = [9, 99, 999];

    function GetFixedArray() public view returns (uint[3] memory) {
        return fixedArray;
    }

    function ModifyFixedArray(uint index, uint value) public {
        if (index < fixedArray.length) {
            fixedArray[index] = value;
        }
    }

    function DeleteFixedArray() public {
        delete fixedArray;
    }

    function GetDynamicArray() public view returns (uint[] memory) {
        return dynamicArray;
    }

    function ModifyDynamicArray(uint index, uint value) public {
        require(index < dynamicArray.length, "Index out of bounds");
        dynamicArray[index] = value;
    }

    function DeleteDynamicArray() public {
        delete dynamicArray;
    }

    function PopFromDynamicArray() public {
        dynamicArray.pop();
    }

    function PushToDynamicArray(uint value) public {
        dynamicArray.push(value);
    }

    function SliceFromDynamicArray(
        uint start,
        uint end
    ) public view returns (uint[] memory) {
        require(end > start, "Invalid index range");
        require(end <= dynamicArray.length, "End index out of bounds");

        uint[] memory slicedArray = new uint[](end - start);
        for (uint i = start; i < end; i++) {
            slicedArray[i - start] = dynamicArray[i];
        }

        return slicedArray;
    }
}
