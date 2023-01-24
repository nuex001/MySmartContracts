//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

interface IERC721 {
    function transferFrom(
        address _from,
        address _to,
        uint256 _nftId
    ) external;
}

contract EnglishAuction {
    event Start();
    event Bid(address indexed sender, uint256 amount);
    event Withdraw(address indexed bidder, uint256 amount);
    event End(address highestBidder, uint256 amount);

    IERC721 public immutable nft;
    uint256 public immutable nftId;

    address public immutable seller;
    uint32 public endedAt;
    bool public started;
    bool public ended;
    address public highestBidder;
    uint256 public highestBid;
    mapping(address => uint256) public bids;

    constructor(
        address _nft,
        uint256 _nftId,
        uint256 _startingBid
    ) {
        nft = IERC721(_nft);
        nftId = _nftId;
        seller = payable(msg.sender);
        highestBid = _startingBid;
    }

    function start() external {
        require(msg.sender == seller, "Not seller");
        require(!started, "started");
        started = true;
        endedAt = uint32(block.timestamp + 60);
        nft.transferFrom(seller, address(this), nftId);
        emit Start();
    }

    function bid() external payable {
        require(started, "Not started");
        require(block.timestamp < endedAt, "ended");
        require(msg.value > highestBid, "value < highest");

        if (msg.sender != address(0)) {
            bids[highestBidder] = highestBid;
        }

        highestBid = msg.value;
        highestBidder = msg.sender;

        emit Bid(msg.sender, msg.value);
    }

    function withdrawal() external {
        require(bids[msg.sender] > 0, "Empty");
        uint256 bal = bids[msg.sender];
        bids[msg.sender] = 0; //had to reset val to avoid burnout and resending
        payable(msg.sender).transfer(bal);
        emit Withdraw(msg.sender, bal);
    }

    function end() external {
        require(started, "Not started");
        require(!ended, "ended");
        require(block.timestamp >= endedAt, "ended");
        ended = true;
        if (highestBidder != address(0)) {
            nft.transferFrom(address(this), highestBidder, nftId);
            payable(seller).transfer(highestBid);
        } else {
            nft.transferFrom(address(this), seller, nftId);
        }
        emit End(highestBidder, highestBid);
    }
}
