//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

/* DelegateCall
updates the contracts own state variable instead of the main one containingthe function
just like it runs on the delegate contract
we can't change anything in our state variable
and when using delegate the two contract state variables has to be the same in the same order
*/

contract TestDelegateCall {
    uint256 public num;
    address public sender;
    uint256 public value;

    function setVars(uint256 _num) external payable {
        num = 2 * _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract DelegateCall {
    uint256 public num;
    address public sender;
    uint256 public value;

    function setVars(address _test, uint256 _num) external payable {
        // _test.delegatecall(abi.encodeWithSignature("setVars(uint256)", _num));
        // or
       (bool success , /*bytes memory data*/) = _test.delegatecall(
            abi.encodeWithSelector(TestDelegateCall.setVars.selector, _num)
        );
        require(success,"delegatecall failed");
    }
}

