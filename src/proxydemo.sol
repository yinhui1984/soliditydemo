// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.11;

contract LogicContractV1 {
    uint256 private value;

    function setValue(uint256 _value) public {
        value = _value;
    }

    function getValue() public view returns (uint256) {
        return value;
    }
}

contract LogicContractV2 {
    uint256 private value;

    function setValue(uint256 _value) public {
        value = _value;
    }

    function getValue() public view returns (uint256) {
        return value * 10;
    }
}

contract ProxyContract {
    // 为什么这里需要 uint256 private value:  逻辑合约和代理合约之间的存储布局必须保持一致。这是因为虽然逻辑合约的代码是在代理合约的上下文中执行的，但所有状态变量实际上是存储在代理合约中的。
    uint256 private value;
    address public currentLogic;
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner can call this function");
        _;
    }

    constructor(address _logic) {
        owner = msg.sender;
        currentLogic = _logic;
    }

    function updateLogic(address _newLogic) public onlyOwner {
        currentLogic = _newLogic;
    }

    //对该合约进行函数调用时，如果该合约没有实现该函数，那么就会调用fallback函数
    fallback() external payable {
        // 当前逻辑合约地址
        address _impl = currentLogic;
        require(_impl != address(0), "Logic contract address is not set");

        // https://docs.soliditylang.org/zh/latest/yul.html#evm

        assembly {
            // 1. 复制calldata到内存中
            // 为什么是0x40:在EVM中内存地址0x40（64）用作一个特殊的位置，它存储了下一个可用的空闲内存指针(它存储着指向内存中当前未使用部分的指针)。前面的内存位置（比如从0x00到0x3f）通常被保留用于执行环境的特定用途。
            let ptr := mload(0x40)
            calldatacopy(ptr, 0, calldatasize())
            // 2. 执行delegatecall，将执行结果保存到result中, result为0表示执行失败，非0表示执行成功
            let result := delegatecall(gas(), _impl, ptr, calldatasize(), 0, 0)
            // 3. 处理返回数据
            let size := returndatasize()
            returndatacopy(ptr, 0, size)

            switch result
            case 0 {
                // 4. 如果执行失败，revert
                revert(ptr, size)
            }
            default {
                // 5. 如果执行成功，返回数据
                return(ptr, size)
            }
        }
    }

    receive() external payable {}
}
