//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract TodoList {
    struct Todo {
        string text;
        bool completed;
    }
    Todo[] public todos;
    mapping(string => Todo) public mappedTodo;

    function create(string calldata _text) external {
        Todo memory newTodo = Todo({text: _text, completed: false});
        todos.push(newTodo);
        mappedTodo[_text] = newTodo;
    }

    function updateText(uint256 _index, string calldata _text) external {
        todos[_index].text = _text;
        mappedTodo[_text] = Todo({
            text: _text,
            completed: todos[_index].completed
        });
        //choose this if we are modifying more than one fields
        // Todo storage todo = todos[_index];
        // todo.text = _text;
    }

    function get(uint256 _index) external view returns (string memory, bool) {
        Todo storage todo = todos[_index];
        return (todo.text, todo.completed);
    }

    function toggleCompleted(uint256 _index) external {
        mappedTodo[todos[_index].text].completed = !todos[_index].completed;
        todos[_index].completed = !todos[_index].completed; //toggle it's and Reassigns
    }
}
