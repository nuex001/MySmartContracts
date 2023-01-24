//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// self destruct  -> selfdestruct(takes in a single input as an argument) , will can force send over to the extended contract 
// - delete contract
// - force send Ether to any address

contract Kill {
    constructor() payable{

    }
    function kill () external {
        selfdestruct(payable(msg.sender)); //deletes a contract from the blockchain
    }

    function testCall () external pure returns(uint256) {
        return 123;
    }
}

contract Helper {
    function getBalance () external view returns (uint) {
        return address(this).balance;
    }
    function kill(Kill _kill) external {
        _kill.kill(); 
    }
}