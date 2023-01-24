//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// 2 ways to call a parent constructor
//Order of initilization -> follows the way we first state it

contract S {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

contract T {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

// STATIC INPUT
//Order of execution
//S
//T
//U
contract U is S("s"), T("t") {
    //code
}

//DYNAMIC INPUT
//Order of execution
//S
//T
//V
contract V is S, T {
    constructor(string memory _name, string memory _text) S(_name) T(_text) {
        //code
    }
}

//Dynamic input and Static input
//Order of execution
//S
//T
//W
contract VV is S("s"), T {
    constructor(string memory _text) T(_text) {
        //code
    }
}

//Order of execution
//T
//S
//V2
contract V2 is T, S {
    constructor(string memory _name, string memory _text) S(_name) T(_text) {
        //order in constructor doesn;t matter
        //code
    }
}
