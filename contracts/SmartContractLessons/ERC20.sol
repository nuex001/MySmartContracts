//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipitent, uint256 amount)
        external
        returns (bool);

    function allowance(address owner, address spender)
        external
        returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipitent,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 amount
    );
}

contract ERC20 is IERC20 {
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    string public name = "test";
    string public symbol = "TEST";
    uint256 public decimal = 18;

    // function totalSupply() external view returns (uint){}

    //     function balanceOf(address account) external view returns (uint){}

    function transfer(address recipitent, uint256 amount)
        external
        returns (bool)
    {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipitent] -= amount;
        emit Transfer(msg.sender, recipitent, amount);
        return true;
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipitent,
        uint256 amount
    ) external returns (bool) {
        allowance[msg.sender][sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipitent] -= amount;
        emit Transfer(sender, recipitent, amount);
        return true;
    }

    function mint(uint256 amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint256 amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}
