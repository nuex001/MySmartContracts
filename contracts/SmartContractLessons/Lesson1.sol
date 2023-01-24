//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// contract Counter {
//     uint256 public count;

//     //external-> won't show unless the contract has been successfully deployed
//     function inc() external {
//         count += 1;
//     }

//     function dec() external {
//         count -= 1;
//     }
//     address public constant MY_ADDRESS = 0xd9145CCE52D386f254917e481eB44e9943F39138;
//     // calling a constant variable reduces the gas fee

// }

// contract DefaultValues{
//   bool public b; //false
//   uint public u;//0
//   int public i;//0
//   address public a; // 0x0000000000000000000000000000000000000000
//   bytes32 public b32; //0x000000 -> 62 00 0x0000000000000000000000000000000000000000000000000000000000000000
// }

// contract IfElse {
//   function example(uint _x) external pure returns (uint){
//     if(_x < 10) {
//       return 1;
//     } else if (_x < 20) {
//      return 2;
//     }else{
//       return 3;
//     }
//   }
// TENARY OPERATOR
//    function tenary(uint _x) external pure returns (uint){
//      /** if(_x < 10) {
//       return 1;
//     }
//      return 2;
//     */
//     return _x < 10 ? 1 : 2;
//   }
// }

//LOOPS
//continue -> skips the current iteration
//break -> exists out of the loop
//while -> takes boolen as an argument and stops when it is true

// contract ForAndWhileLoops {
//   function loops() external pure {
//     for (uint i = 0; i < 10; i++){
//       //code
//       if(i == 3){
//         continue;
//       }
//       //more code
//         if(i == 5){
//         break;
//       }
//     }
//     // WHILE
//     uint j = 0;
//     while(j < 10){
//       //code
//       j++;
//     }
//   }

//   // Sum
//   function sum (uint _n) external pure returns (uint) {
//     uint s; //initializing sum variable
//     for(uint i = 1 ; i <= _n; i++){
//      s += i;
//     }
//     return s;
//   }
// }

/*CUSTOM ERROS
 *require,revert,assert
 *gas refund,state updates are reverted
 * custom errors saves gas
 */
// contract ERROS {
//     function testRequire(uint256 _i) public pure {
//         require(_i < 10, "i > 10"); //require
//     }

//     //REVERT
//     function testRevert(uint256 _i) public pure {
//         if (_i > 10) {
//             revert("i > 10");
//         }
//     }

//     //ASSESRT -> always true

//     uint256 public num = 123;

//     function testAssert() public view {
//         assert(num == 123);
//     }

//     function foo(uint256 _i) public {
//         num += 1;
//         require(_i < 10);
//     }

//     //  CUSTOME ERRORS

//     error MyError(address caller, uint256 i);

//     function testCustomError(uint256 _i) public view {
//         if (_i < 10) {
//             revert MyError(msg.sender, _i);
//         }
//     }
// }

// contract functionModifier {
//     bool public paused;
//     uint256 public count;

//     function setPause(bool _paused) external {
//         paused = _paused;
//     }

//     modifier whenNotPaused() {
//         require(!paused, "paused");
//         _; //call it
//     }

//     function inc() external whenNotPaused {
//         // require(!paused, "paused");
//         count += 1;
//     }

//     function dec() external whenNotPaused {
//         // require(!paused, "paused");
//         count -= 1;
//     }

//     modifier cap(uint256 _x) {
//         //passing input into a modifier
//         require(_x < 100, "x >= 100");
//         _; //execute the rest of the function it is attached to
//     }

//     function incBy(uint256 _x) external whenNotPaused cap(_x) {
//         count += _x;
//     }

//     modifier sanwitch() {
//         count += 10;
//         _;
//         //more code after the attached function has finished processing
//         count *= 2;
//     }

//     function foo() external sanwitch {
//         count += 1;
//     }
// }

// CONSTRUTOR

contract Constructor {
    address public owner;
    uint256 public x;

// constructor -> like react componentonmount i:e runs only once and it's when the contract has been deployed
    constructor(uint256 _x) {
        owner = msg.sender;
        x = _x;
    }
}
