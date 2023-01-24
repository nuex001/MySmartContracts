//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Counter {
    uint256 public count;
  
  //external-> won't show unless the contract has been successfully deployed
  function inc() external {
      count +=1;
  }
function dec() external {
      count -=1;
  }
}