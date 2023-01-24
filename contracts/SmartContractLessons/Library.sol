//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// visibility recommended is internal
library Math {
    function max(uint256 x, uint256 y) internal pure returns (uint256) {
        return x >= y ? x : y;
    }
}

contract Test {
    function testMath(uint256 x, uint256 y) external pure returns (uint256) {
        return Math.max(x, y);
    }
}

library ArrayLib {
    function find(uint256[] storage arr, uint256 x)
        internal
        view
        returns (uint256)
    {
        for (uint256 i = 0; i < arr.length; i++) {
            if (arr[i] == x) {
                return i;
            }
        }
        revert("not found");
    }
}

contract TestArray {
    using ArrayLib for uint256[];
    uint256[] public arr = [3, 2, 1];

    function testFind() external view returns (uint256 i) {
        // return ArrayLib.find(arr, 2);
        // or
        return arr.find(2);
    }
}

library PrimeNo {
    function findPrime(uint num) internal pure returns(bool prime) {
        if (num < 1){
           return false;
        } else{
        for(uint i = 2; i < num ; i++){
            if(num % i == 0){
             return false;
            }
            return true;
        }
        }
    }
}

contract MyExercise {
    // using PrimeNo for bool ;
    bool public isPrime;
    function checkPrimeNumbers(uint no) external  returns (bool){
    //    return bool.findPrime(no);
    isPrime = PrimeNo.findPrime(no);
    return isPrime;
    }
}