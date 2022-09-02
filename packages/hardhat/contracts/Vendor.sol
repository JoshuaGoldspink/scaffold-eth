pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";


contract Vendor is Ownable {

  address burnAddress = 0x000000000000000000000000000000000000dEaD;

  uint256 public tokensPerEth = 100;

  event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);
  event SellTokens(address seller, uint256 amountOfETH, uint256 amountOfTokens);
  event BurnTokens(address burner, uint256 amountToBurn);

  YourToken public yourToken;

  constructor(address tokenAddress) {
    yourToken = YourToken(tokenAddress);
  }


  function buyTokens() public payable {
    yourToken.transfer(msg.sender, msg.value * tokensPerEth);
    emit BuyTokens(msg.sender, msg.value, msg.value * tokensPerEth);
  }


  function withdraw() payable onlyOwner public {
    payable(msg.sender).transfer(address(this).balance);
  } 

  function sellTokens(uint256 _amountToSell) public payable {
    yourToken.transferFrom(msg.sender, address(this), _amountToSell);
    payable(msg.sender).transfer(_amountToSell / tokensPerEth);
    emit SellTokens(msg.sender, _amountToSell, _amountToSell / tokensPerEth);
  }


  function burn(uint256 amountToBurn) public payable {
    yourToken.transfer(burnAddress, amountToBurn);
    emit BurnTokens(msg.sender, amountToBurn);
  }

}
