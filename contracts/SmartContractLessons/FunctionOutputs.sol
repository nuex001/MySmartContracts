//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract FunctionOutput {
    function returnMany() public pure returns (uint256, bool) {
        return (1, true);
    }

    function named() public pure returns (uint256 x, bool b) {
        return (1, false);
    }

    function assigned() public pure returns (uint256 x, bool b) {
        //better way of returning multiple outputs,saves a little bit of Gas
        x = 1;
        b = true;
    }

    function destructingAssignments()
        public
        pure
        returns (
            uint256,
            bool,
            bool
        )
    {
        (uint256 x, bool b) = returnMany(); //destructing from a returned value;
        (, bool _b) = named(); //destructing one from a returned value;
        //to omit a value,you have to not declear it;
        return (x, b, _b);
    }
}
