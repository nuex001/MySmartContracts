//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract PiggyBank {
    event Deposit(uint amount);
    event Withdraw(uint amount);
    address public owner = msg.sender;
    mapping(address => uint256) public mappedTrans;

    receive() external payable {
        mappedTrans[msg.sender] = msg.value;
       emit Deposit(msg.value);
    }

    function withdraw() external {
        require(msg.sender == owner, "Not Owner");
       emit Withdraw(address(this).balance);
        selfdestruct(payable(msg.sender));
    }
}
