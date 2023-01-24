//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// VISIBILITY
// Private - only inside a contract
// Internal - only inside contract and child contracts
// Public - inside and outside a contract
// External - only form outside a contract

contract VisibilityBase {
    uint256 private x = 0;
    uint256 internal y = 1;
    uint256 public z = 2;

    function privateFunction() private pure returns (uint256) {
        return 1;
    }

    function internalFunction() internal pure returns (uint256) {
        return 1;
    }

    function publicFunction() public pure returns (uint256) {
        return 1;
    }

    function externalFunction() external pure returns (uint256) {
        return 1;
    }

    function example() external view {
        x + y + z;
        privateFunction();
        internalFunction();
        publicFunction();
        //    this.externalFunction();  but not advisible
    }
}

contract VisibilityChild is VisibilityBase {
    function example2() external view {
         y + z;
    }
}

// contract VisibilityChild2 is VisibilityChild {
//     function example3() external {
//         externalFunction();
//     }
// }
