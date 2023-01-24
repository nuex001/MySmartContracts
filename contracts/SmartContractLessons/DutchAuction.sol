//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

interface IERC721 {
    function transferFrom(
        address _from,
        address _to,
        uint256 _nftId
    ) external;
}

contract DutchAuction {
    uint256 private constant DURATION = 7 days;

    IERC721 public immutable nft;
    uint256 public immutable nftId;
    address payable public immutable seller;
    uint256 public immutable startingPrice;
    uint256 public immutable startAt;
    uint256 public immutable expiresAt;
    uint256 public immutable discountRate;

    constructor(
        uint256 _startingPrice,
        uint256 _discountRate,
        address _nft,
        uint256 _nftId
    ) {
        seller = payable(msg.sender);
        startingPrice = _startingPrice;
        discountRate = _discountRate;
        startAt = block.timestamp;
        expiresAt = block.timestamp + DURATION;
        require(
            _startingPrice >= discountRate * DURATION,
            "starting price is less than discount"
        );
        nft = IERC721(_nft);
        nftId = _nftId;
    }


    function getPrice () public view returns(uint){
        uint timeElasped = block.timestamp  - startAt;
        uint discount = discountRate * timeElasped;
        return startingPrice - discount;
    }

    function buy () external payable {
        require(block.timestamp < expiresAt, "auction expired");
        uint price  = getPrice();

        require(price <= msg.value , "Not enough eth");
        nft.transferFrom(seller, msg.sender,nftId);
        uint refund = msg.value - price;
        if(refund > 0){
            payable(msg.sender).transfer(refund);
        }
        selfdestruct(seller);
    }
}
