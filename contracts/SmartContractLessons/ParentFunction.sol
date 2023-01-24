//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;


/*
*calling parent function
*Direct
*Super
*/
contract E {
    event Log(string message);

    function foo() public virtual {
        emit Log("E.foo");
    }

    function bar() public virtual {
        emit Log("E.bar");
    }
}

contract F is E {
    function foo() public virtual override {
        emit Log("F.foo");
        E.foo(); //-> would call the foo function on the E contract
    }

    function bar() public virtual override {
        emit Log("F.bar");
        super.bar(); //-> would call the parent bar function on the E contract
    }
}

contract H is E, F {
    function foo() public override(E,F) {
        F.foo(); //-> would call the foo function on the E contract
    }

    function bar() public override(E,F) {
        super.bar(); //-> would call all the parent bar function on both E and F contract 
    }
}
