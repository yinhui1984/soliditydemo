// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.11;


contract HelloContract {
    function hello() public pure returns (string memory) {
        return "Hello World";
    }
}

contract HelloContractWithArgs {

    string private greetings;
    constructor(string memory _greetings) {
        greetings = _greetings;
    }

    function hello() public view returns (string memory) {
        return greetings;
    }
}

contract NewCreateDemo{

    function NewHelloContract() public returns (address) {
        HelloContract hello = new HelloContract();
        return address(hello);
    }

    function CreateHelloContract() public returns (address) {
        bytes memory creationCode = type(HelloContract).creationCode;
        address addr;

        assembly {
            // Yul的create函数，参数分别是：value，code的起始位置，code的长度
            // creationCode是一个指向内存某个位置的指针（这里是指向bytes动态数组位置）
            // 0x20 是因为前面0x20个字节(也就是32个字节)是指针的长度，
            // 因为存储动态长度数据（如字节数组）时，会在数据本身之前存储一个32字节的长度前缀。这个长度前缀表示数据的长度
            // 所以add(creationCode, 0x20) 是指针指向数据的位置（跳过长度前缀，数据的实际位置）
            // mload(xxx)读取指针指向的数据，其返回xxx位置开始的32个字节的数据，也就是creationCode指针指向的数据的前32个字节，也就是长度前缀
            // 所以mload(creationCode)就返回了creationCode的长度
            addr := create(0, add(creationCode, 0x20), mload(creationCode))
        }

        // 如果创建失败，create会返回0x0地址
        require(addr != address(0), "create failed");

        return addr;
    }

    function CreateHelloContractWithArgs(string calldata greetings) public returns (address) {
        bytes memory creationCode = type(HelloContractWithArgs).creationCode;
        bytes memory creationCodeWithArgs = abi.encodePacked(creationCode, abi.encode(greetings));
        address addr;

        assembly {
            addr := create(0, add(creationCodeWithArgs, 0x20), mload(creationCodeWithArgs))
        }

        require(addr != address(0), "create failed");

        return addr;
    }

    function Create2HelloContractWithArgs(string calldata greetings,  bytes32 salt) public returns (address) {

        // 方式1

        bytes memory creationCode = type(HelloContractWithArgs).creationCode;
        bytes memory CreationCodeWithArgs = abi.encodePacked(creationCode, abi.encode(greetings));
        address addr;

        assembly {
            addr := create2(0, add(CreationCodeWithArgs, 0x20), mload(CreationCodeWithArgs), salt)
        }


        // 方式2
        // address addr = address(new HelloContractWithArgs{salt: salt}(greetings));
        
        
        require(addr != address(0), "create failed");
        return addr;
    }

}