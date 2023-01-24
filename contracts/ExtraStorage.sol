// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

// IHERITANCE

contract ExtraStorage is SimpleStorage {
    //   + 5
    // to override a function in our parent or extended contract,we need to use two specifiers
    // virtual -> parent
    // override -> overrider

    function store( uint256 _favoriteNumber) public override  {
        favouriteNumber = _favoriteNumber + 5 ;
    }
}