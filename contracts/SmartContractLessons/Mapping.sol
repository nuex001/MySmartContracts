//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// contract Mapping {
//     // mapping(key=>value) type name;
//     mapping(address => uint256) public balances;
//     mapping(address => mapping(address => bool)) public isFriend;

//     function examples() external {
//         balances[msg.sender] = 123; //initialize set
//         uint256 bal = balances[msg.sender]; //get value
//         balances[msg.sender] += 456; //update value

//         delete balances[msg.sender]; // defaults to 0
//         isFriend[msg.sender][address(this)] = true;
//     }
// }

contract IterableMapping {
    mapping(address => uint256) public balances;
    mapping(address => bool) public inserted;
    address[] public keys;

    function set(address _key, uint256 _val) external {
        balances[_key] = _val;
        if (!inserted[_key]) {
            inserted[_key] = true;
            keys.push(_key);
        }
    }

    function getSize() external view returns (uint256) {
        return keys.length;
    }

    function first() external view returns (uint256) {
        return balances[keys[0]];
    }

    function last() external view returns (uint256) {
        return balances[keys[keys.length - 1]];
    }

    modifier check(uint256 x) {
        require(x < keys.length, "Array is less than number");
        _;
    }

    function get(uint256 _i) external view check(_i) returns (uint256) {
        return balances[keys[keys.length - 1]];
    }
}
