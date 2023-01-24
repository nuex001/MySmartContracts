//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract Enum {
    enum Status {
        None,
        Pending,
        Shipped,
        Completed,
        Rejected,
        Cancel
    }
    Status public status;

    struct Order {
        address buyer;
        Status status;
    }

    Order[] public orders;

    function get() external view returns (Status) {
        return status;
    }

    function set(Status _status) external {
        status = _status;
    }

    function shipped() external {
        //set defined value
        status = Status.Shipped;
    }

    function reset() external {
        //reset to the default value -> the first value in the struct
        delete status;
    }
}
