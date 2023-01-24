//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract Immutable {
    // immutable works like constant,it can't be reinitialized
    // Also uses less Gas
    // address public immutable owner = msg.sender; //Direct initializing
    address public immutable owner ; //Declear
    constructor(){
        owner = msg.sender; //Initailize
    }
}