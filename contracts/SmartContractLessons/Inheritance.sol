//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract X {
    function foo() public pure virtual returns (string memory) {
        return "X";
    }

    function bar() public pure virtual returns (string memory) {
        return "X";
    }

    function x() public pure virtual returns (string memory) {
        return "X";
    }
}

contract Y is X {
    function foo() public pure virtual override returns (string memory) {
        return "Y";
    }

    function bar() public pure virtual override returns (string memory) {
        return "Y";
    }

    function y() public pure returns (string memory) {
        return "Y";
    }
}

contract Z is X, Y {
    function foo() public pure override(X, Y) returns (string memory) {
        return "Z";
    }
    function bar() public pure override(X, Y) returns (string memory) {
        return "Z";
    }
}

//Encountered an error -> the z contract was throwing an error because i have to override all the functions both of them had overided 