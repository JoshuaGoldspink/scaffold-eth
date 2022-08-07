pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";


contract Vendor is Ownable {

  uint256 public tokensPerEth = 100;

  event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);
  event SellTokens(address seller, uint256 amountOfETH, uint256 amountOfTokens);

  YourToken public yourToken;

  constructor(address tokenAddress) {
    yourToken = YourToken(tokenAddress);
  }



  // ToDo: create a payable buyTokens() function:
  function buyTokens() public payable {
    yourToken.transfer(msg.sender, msg.value * tokensPerEth);
    emit BuyTokens(msg.sender, msg.value, msg.value * tokensPerEth);
  }


  // ToDo: create a withdraw() function that lets the owner withdraw ETH
  function withdraw() payable onlyOwner public {
    payable(msg.sender).transfer(address(this).balance);
  } 



  // ToDo: create a sellTokens(uint256 _amount) function:
  function sellTokens(uint256 _amountToSell) public payable {
    
    yourToken.transferFrom(msg.sender, address(this), _amountToSell);
    payable(msg.sender).transfer(_amountToSell / tokensPerEth);
    emit SellTokens(msg.sender, _amountToSell, _amountToSell / tokensPerEth);
  }

}