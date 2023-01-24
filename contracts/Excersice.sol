// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract Excersice {
    // Creating A todo element that querrys with date

    // first using a struct to contruct the object schema

    struct Todo {
        string title;
        string date;
    }
    // creating An Array instance of the Todo
    Todo[]  todo;

    // Mapping my Todo
    mapping(string => string) public todoToTitle;

    // adding input to the Todo

    function addTodo(string memory _title, string memory _date) public {
        todo.push(Todo({title: _title, date: _date}));
        todoToTitle[_title] = _date;
    }
}
