//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

/*
Fallback exectues when 
- function doesn't exist
- directly send ETH
   
    Ether is sent to contract
             |
        is msg.data empty?
              / \
            yes  no
            /     \
receive() exists?  Fallback
         /   \
        yes  no
        /     \
    receive()  fallback();
  
*/




contract FallBack {
    // fallback() external  {}
    event Log(string func , address sender , uint value , bytes data);
    fallback() external payable {
        emit Log("fallback",msg.sender,msg.value,msg.data);
    }
    // receive is executed when msg.data is empty
    receive() external payable {
        emit Log("receive",msg.sender,msg.value,"");
    }
}
