//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// keccak256 -> accepts only bytes,so we have to encode it to bytes -> abi.encodePacked(values)
// keccak256 -> returns bytes
// abi.encodePacked --> has a problem when the same type is next to it in other ,so be care to take precaution

contract HashFunc {
    function hash(string memory text , uint num , address addr) external pure returns (bytes32) {
    //   return  keccak256(abi.encode(text,num,addr)); //--> gives larger output
      return  keccak256(abi.encodePacked(text,num,addr)); // --> compiles to make it smaller
    }
}