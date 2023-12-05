// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.11;

import "forge-std/Test.sol";
import "../src/proxydemo.sol";

contract ProxyDemoTest is Test {
    LogicContractV1 logicV1;
    ProxyContract proxy;

    function setUp() public {
        vm.createSelectFork("theNet");
        logicV1 = new LogicContractV1();
        proxy = new ProxyContract(address(logicV1));
    }

    function testProxyCall() public {
        address _impl = address(logicV1);
        address _proxy = address(proxy);
        console2.logAddress(_impl);
        console2.logAddress(_proxy);

        uint256 value = 123;
        (bool ok, bytes memory data) = _proxy.call(
            abi.encodeWithSignature("setValue(uint256)", value)
        );
        assertTrue(ok, "call to proxy failed");

        (ok, data) = _proxy.call(abi.encodeWithSignature("getValue()"));
        assertTrue(ok, "call to proxy failed");
        console2.logBytes(data);
        uint256 ret = abi.decode(data, (uint256));
        console2.logUint(ret);
        assertTrue(ret == value, "value not set");
    }

    function testUpgrade() public {
        address _impl = address(logicV1);
        address _proxy = address(proxy);
        console2.logAddress(_impl);
        console2.logAddress(_proxy);

        uint256 value = 123;
        (bool ok, bytes memory data) = _proxy.call(
            abi.encodeWithSignature("setValue(uint256)", value)
        );
        assertTrue(ok, "call to proxy failed");

        //使用v1版本的逻辑合约设置值123

        (ok, data) = _proxy.call(abi.encodeWithSignature("getValue()"));
        assertTrue(ok, "call to proxy failed");
        console2.logBytes(data);
        uint256 ret = abi.decode(data, (uint256));
        console2.logUint(ret);
        assertTrue(ret == value, "value not set");

        // 升级到v2版本的逻辑合约，返回的值应该为（123*10）：1230
        LogicContractV2 logicV2 = new LogicContractV2();
        proxy.updateLogic(address(logicV2));

        (ok, data) = _proxy.call(abi.encodeWithSignature("getValue()"));
        assertTrue(ok, "call to proxy failed");
        console2.logBytes(data);
        ret = abi.decode(data, (uint256));
        console2.logUint(ret);
        assertTrue(ret == value * 10, "upgrade failed");
    }
}
