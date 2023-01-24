//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./SimpleStorage.sol";

contract StorageFactory {
    //  SimpleStorage public simpleStorage; SimpleStorage as the type
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    // getting the store function in simpleStorage
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber)
        public
    {
        /**to interact with any contract we are always gonna need this two thins 
        //Address 
        //ABI -> Application binary interface
        **/
        // SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex]; //the single simpleStorage instance
        // simpleStorage.store(_simpleStorageNumber); //then access the store of that single instance
        // or
        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        // SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        //  return simpleStorage.retrieve();
        // or
        return simpleStorageArray[_simpleStorageIndex].retrieve();
    }
}
