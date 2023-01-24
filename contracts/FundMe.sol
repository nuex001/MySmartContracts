// Get Funds from users
// Withdraw Funds
//Set a minimum funding value in USD

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8; //First thing to add in a solidity file is it's version

contract FundMe {
    uint256 public minimumUsd = 50;

    function fund() public payable {
        //  msg.value; -> to access the value of the ammount, it is in wei format
        //   require(msg.value > 1e18, "Didn't send enough")  -> conditional Rendering (jst lyk a date function) be atLeast 1eth;
        //   msg.value;

        require(msg.value > minimumUsd, "Didn't send enough!");
    }

     function viewminimumUsd () public view returns(uint256){
         return minimumUsd + ((minimumUsd * 10) / 10);
     }

    function getPrice() public {}

    function getConversionRate() public {}

    // function Withdraw(){};
}
