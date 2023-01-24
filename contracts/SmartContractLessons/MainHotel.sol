//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract MainHotel {
    struct Roles {
        address worker;
        string role;
        uint256 duration;
        uint256 expiresAt;
        bool status;
    }
    struct Request {
        address applicant;
        string role;
        bool approved;
    }

    address public immutable owner;
    uint256[] public rooms;
    Roles[] public roles;
    uint256 public immutable pricePerDay;
    mapping(uint256 => bool) public isbooked;
    mapping(address => mapping(uint256 => uint256)) public bookingsMap;
    mapping(string => uint256) public mappedRoles;
    mapping(string => uint256) public mappedRolesPrices;
    mapping(string => bool) public checkRoles;
    Request[] public requests;
    mapping(address => uint256) public mappedRequest;
    mapping(address => bool) public checkRequest;

    event Deposit(address indexed owner);
    event AddRole(string role, string duration);
    event Submit(address indexed applicant, string _role);
    event Approve(address indexed applicant, string role);
    event Terminate(address indexed applicant, string role);
    event Reset(address indexed applicant);
    event Salary(uint256 currentTime, uint256 expiresAt);
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
        emit Deposit(msg.sender);
    }

    /*Modifiers*/
    modifier onlyOwner() {
        require(msg.sender == owner, "Not Authorized");
        _;
    }
    modifier ifRoleIsEmpty() {
        require(roles.length > 0, " Role empty");
        _;
    }
    modifier checkIfRolesExist(string calldata _role) {
        require(checkRoles[_role], " Role does not exist");
        _;
    }
    modifier checkIfRequestExists(address _applicant) {
        require(!checkRequest[_applicant], "request exists");
        _;
    }

    /* Main Functions*/

    receive() external payable {}

    /*ADD ROLES*/
    function addRole(
        string calldata _role,
        string memory _time,
        uint256 price
    ) external  onlyOwner {
        mappedRolesPrices[_role] = price;
        require(!checkRoles[_role], " Role exists");
        uint256 time = checkDate(_time);
        roles.push(
            Roles({
                worker: address(0),
                role: _role,
                expiresAt: 12345,
                duration: time,
                status: false
            })
        );
        mappedRoles[_role] = roles.length - 1;
        checkRoles[_role] = true;
        emit AddRole(_role, _time);
    }

    /*Request */
    function SubmitRequest(string calldata _role)
        external
        ifRoleIsEmpty
        checkIfRolesExist(_role)
        checkIfRequestExists(msg.sender)
    {
        requests.push(
            Request({applicant: msg.sender, role: _role, approved: false})
        );
        mappedRequest[msg.sender] = requests.length - 1;
        checkRequest[msg.sender] = true;
        emit Submit(msg.sender, _role);
    }

    /*RESET*/
    function reset() external ifRoleIsEmpty {
        require(
            !requests[mappedRequest[msg.sender]].approved,
            "request approved already"
        );
        require(checkRequest[msg.sender], "Default");
        checkRequest[msg.sender] = false;
        emit Reset(msg.sender);
    }

    /*Approve*/

    function approve(address _applicant) external ifRoleIsEmpty onlyOwner {
        require(
            !requests[mappedRequest[_applicant]].approved,
            "request approved already"
        );
        require(
            checkRequest[_applicant] ,
            "request Not avaialable"
        );

        Request storage request = requests[mappedRequest[_applicant]];
        Roles storage role = roles[mappedRoles[request.role]];
        role.worker = _applicant;
        role.expiresAt = block.timestamp + role.duration;
        role.status = true;
        request.approved = true;
        emit Approve(_applicant, role.role);
    }

    function terminate(address _applicant)
        external
        payable
        ifRoleIsEmpty
        onlyOwner
    {
        Request storage request = requests[mappedRequest[_applicant]];
        Roles storage role = roles[mappedRoles[request.role]];
        require(role.worker != address(0), "Invalid address");
        payable(role.worker).transfer(123);
        role.worker = address(0);
        role.expiresAt = 12345;
        role.status = false;
        request.approved = false;
        emit Terminate(_applicant, role.role);
    }

    function salary() public {
        require(checkRequest[msg.sender], "Not Authorized");

        Request storage request = requests[mappedRequest[msg.sender]];
        Roles storage role = roles[mappedRoles[request.role]];
        require(role.expiresAt < block.timestamp, "Not yet"); //can comment this out
        require(
            address(this).balance >
                mappedRolesPrices[role.role],
            "Lack of fund currently Try again later"
        );
        role.expiresAt = block.timestamp + role.duration;
        payable(msg.sender).transfer(mappedRolesPrices[role.role]);
        emit Salary(block.timestamp, role.expiresAt);
    }

    /*BOOKING*/
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
        payable(address(this)).transfer(msg.value);
        emit Deposit(owner, msg.value);
        return true;
    }

    function checkOut(uint256 _no) external onlyOwner {
        require(isbooked[_no], "Already checked out");
        isbooked[_no] = false;
        emit CheckOut(_no);
    }

    function getBalance() external view returns (uint256) {
        return address(address(this)).balance; //returns in wei
    }

    /*HELPERS --> Predefined Functions */
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

    // check for time
    function checkDate(string memory _time) internal pure returns (uint256) {
        uint256 time;
        if (
            keccak256(abi.encodePacked(_time)) ==
            keccak256(abi.encodePacked("days"))
        ) {
            time = 30 days;
        } else if (
            keccak256(abi.encodePacked(_time)) ==
            keccak256(abi.encodePacked("week"))
        ) {
            time = 7 days;
        } else if (
            keccak256(abi.encodePacked(_time)) ==
            keccak256(abi.encodePacked("day"))
        ) {
            time = 24 hours;
        } else if (
            keccak256(abi.encodePacked(_time)) ==
            keccak256(abi.encodePacked("hour"))
        ) {
            time = 1 hours;
        } else {
            time = 30 days;
        }
        return time;
    }
}
// had an error about time converting
// [1,2,3,4,5],50
// chef,hour,1000000000000000000