//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract EtherWallet {
    address payable public owner;

    constructor () {
        owner = payable(msg.sender);
    }
    receive() external payable {}

    function withdraw(uint _amount) external {
        require(msg.sender == owner,"caller not owner"); //check if not owner
        // owner.transfer(_amount); //consumes much gas - because of the public state(memory)
        payable(msg.sender).transfer(_amount); //consumes less gas

        // or
        // (bool sent, ) =  payable(msg.sender).call{value:_amount}("");
        // require(sent , "Failed to send Eth");
    }

    function getBalance () external view returns(uint) {
        return address(this).balance;
    }
}