//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract CallOtherContract {
    //Get the address of the contract and then
    //initialized the contract
    // function setX(address _test,uint _x) external {
    //     TestContract(_test).setX(_x);
    // }
    //pass as type
    //initialized the contract
    function setX(TestContract _test, uint256 _x) external {
        _test.setX(_x);
    }

    function getX(TestContract _test) external view returns (uint256 x) {
        x = _test.getX();
    }

    function setXandReceiveEther(TestContract _test, uint256 _x)
        external
        payable
    {
        _test.setXandReceiveEther{value: msg.value}(_x);
    }

    function getXandValue(TestContract _test)
        external
        view
        returns (uint256 x, uint256 value)
    {
        (x, value) = _test.getXandValue();
    }
}

contract TestContract {
    uint256 public x;
    uint256 public value = 123;

    function setX(uint256 _x) external {
        x = _x;
    }

    function getX() external view returns (uint256) {
        return x;
    }

    function setXandReceiveEther(uint256 _x) external payable {
        x = _x;
        value = msg.value;
    }

    function getXandValue() external view returns (uint256, uint256) {
        return (x, value);
    }
}
