//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract Payable {
    address payable public owner; //by declearing an address as payable i:e this address will now be able to send ether

   constructor () {
    //    owner = msg.sender; //not casted
       owner = payable(msg.sender); //have to cast it to payable
   }

    function deposit() external payable {} //function recieve ether 

    function getBalance () external view returns(uint) {
        return address(this).balance; //returns in wei
    }
}
