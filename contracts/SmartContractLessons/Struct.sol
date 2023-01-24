//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract Struct {
    struct Car {
        string model;
        uint256 year;
        address owner;
    }
    Car public car;
    Car[] public cars;
    mapping(address => Car[]) public carsByOwner;

    function example() external {
        Car memory toyota = Car("Toyota", 1990, msg.sender); //must be in order
        Car memory lambo = Car({
            model: "lamborghini",
            owner: msg.sender,
            year: 1980
        }); //must not be in order
        Car memory tesla; //initailizing
        tesla.model = "tesla";
        tesla.year = 2010;
        tesla.owner = msg.sender;

        cars.push(toyota);
        cars.push(lambo);
        cars.push(tesla);
        carsByOwner[msg.sender] = cars;
        //or
        cars.push(Car("Ferrari", 2020, msg.sender));

        //memory only shows inside the function
        //storage modifies the main state
        Car storage _car = cars[0];
        _car.year = 1999;
        delete _car.owner;
        delete cars[1];
    }
}
