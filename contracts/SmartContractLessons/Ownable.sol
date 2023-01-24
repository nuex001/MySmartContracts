//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

//A function where only the owner of the contract can call
//used modifier
//error handling
//constructor
//function

contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }
    modifier onlyOwner () {
        require(msg.sender == owner,"not Owner");
        _;
    }

    function setOwner(address _newOwner) external onlyOwner {
        require(_newOwner != address(0),"invalid  address");
        owner = _newOwner;
    }

    function onlyOwnerCanCallThisFunc() external onlyOwner {
        // code
    }

    function  anyOneCanCall () external {
        // code
    }
}

// address(0) -> means default address