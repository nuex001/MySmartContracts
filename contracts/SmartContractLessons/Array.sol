//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// Array - dynamic or fixed size
//Initialization
//Insert (push) , get ,update,delete,pop,length
//Creating array in memory
//Returning array from function

// contract Array {
//     uint256[] public nums = [1, 2, 3]; //dynamic
//     uint256[3] public numsFixed = [4, 5, 6]; //fixed

//     function examples() external {
//         nums.push(4); //[1,2,3,4]
//         uint256 x = nums[1]; //getting a value from array and assigning it to a variable;
//         nums[2] = 777; //[1,2,777,4] -> updating an array
//         delete nums[1]; // [1,0,777,4] -> it takes it's initial state being 0;
//         nums.pop(); //[1,0,777] -> removes the last value
//         uint256 len = nums.length; //gives you the length of array

//         //Create an Array in memory
//         uint256[] memory a = new uint256[](5); // has to be fixed array
//         // a.push(1) -> doesn't support push,pop,array methods
//         a[1] = 123; //supports initializtion directly
//     }

// //This function costs a lot of gas
// //The bigger the Array the more gas used
// //Not Recommended!!!
//     function returnArray () external view returns (uint256 [] memory) {
//         return nums;
//     }
// }

// contract ArrayShift {
//     uint[] public arr ;

//     //[1,2,3] -- remove(1) ---> [1,3,3] --> [1,3];
//     function remove(uint _index) public {
//         require(_index < arr.length, "Index is out of bond");
//         for ( uint i = _index ; i < arr.length - 1 ; i++){
//             arr[i] = arr[i + 1];
//         }
//         arr.pop();
//     }

//   function test () external {
//       arr = [1,2,3,4,5];
//       remove(2);
//       //[1,2,4,5]
//       assert(arr[0] == 1);
//       assert(arr[1] == 2);
//       assert(arr[2] == 4);
//       assert(arr[3] == 5);

//       arr = [1];
//       remove(0);
//       assert(arr.length == 0);
//   }

// }

//Doesn't work in a sorted way
//But more efficient and less Gas useage
contract ArrayReplaceLast {
    uint256[] public arr;

    function remove(uint256 _index) public {
        arr[_index] = arr[arr.length - 1];
        arr.pop();
    }

    function test() external {
        arr = [1, 2, 3, 4];
        remove(1);
        assert(arr.length == 3);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr[2] == 3);
    }
}
