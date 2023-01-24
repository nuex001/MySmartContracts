//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract Hotel {
    address public owner;
    uint256[] public rooms;
    uint256 public pricePerDay;
    mapping(uint256 => bool) public isbooked;
    mapping(address => mapping(uint256 => uint256)) public bookingsMap;

    event Deposit(address indexed, uint256 amounnt);
    event CheckOut(uint256 indexed no);

    constructor(uint256[] memory _rooms, uint256 _pricePerDay) {
        require(_rooms.length > 0, "Rooms Required");
        require(
            msg.sender != address(0) && _pricePerDay != 0,
            "Empty input fields"
        );

        for (uint256 i; i < _rooms.length; i++) {
            rooms.push(_rooms[i]);
            isbooked[i] = false;
        }
        pricePerDay = _pricePerDay;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender != owner, "Not Authorized");
        _;
    }

    function bookings(uint256 _no, uint256 _days)
        external
        payable
        returns (bool)
    {
        require(!isbooked[_no], "Already Booked");
        uint256 _price = (pricePerDay * _days) * 1e18;
        address creditor = msg.sender;
        require(
            getConversionRate(msg.value) >= _price,
            "Didn't send enough eth"
        );
        isbooked[_no] = true;
        bookingsMap[creditor][_no] = _days;
        payable(owner).transfer(msg.value);
        emit Deposit(owner, msg.value);
        return true;
    }

    function checkOut(uint256 _no) external onlyOwner {
        require(isbooked[_no], "Already checked out");
        isbooked[_no] = false;
        emit CheckOut(_no);
    }

    function getBalance() external view returns (uint256) {
        return owner.balance; //returns in wei
    }

    function getPrice() internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        );
        (, int256 price, , , ) = priceFeed.latestRoundData();
        // ETH in terms of USD
        // 3000.00000000
        return uint256(price * 1e10); //1**10 = 10000000000
    }

    function getConversionRate(uint256 ethAmount)
        internal
        view
        returns (uint256)
    {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}
// [1,2,3,4],100
// 0.00091
// had a problem can't see my address
