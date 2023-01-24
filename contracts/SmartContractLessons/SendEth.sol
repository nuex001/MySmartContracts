//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// 3 ways to send ETH
// transfer - 2300 gas, reverts - _to.transfer(number of eths)
//  send - 2300 gas , returns bool - _to.send(number of eths)
//  call - all gas, returns bool and data  -  _to.call{value : number of eths}("")

contract SendEth {
    constructor() payable {} // sends ether into the smart contract

    // or
    receive() external payable {} // sends ether into the smart contract

    function sendViaTransfer(address payable _to) external payable {
        _to.transfer(123);
    }

    function sendViaSend(address payable _to) external payable {
       bool sent =  _to.send(123);
       require(sent,"Sent failed");
    }

    function sendViaCall(address payable _to) external payable {
      (bool success , )  = _to.call{value : 123}(""); 
      require(success , "Call failed");
    }
}

contract EthReciever {
    event Log(uint amount,uint gas);
    receive() external payable {
        emit Log(msg.value,gasleft());
    }
}

