pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// learn more: https://docs.openzeppelin.com/contracts/3.x/erc20

contract YourToken is ERC20 {

    address director = 0xef8B0213988E779A1dF86547165b3C424C27eB96;

    event MintTokens(address minter, uint256 amountOfTokens);

    constructor() ERC20("Clearly", "CLRL") {
        _mint(msg.sender, 1000 * 10 ** 18);
    }

    modifier onlyDirector {
    require(msg.sender == director);
    _;
    }

    function directorMint(uint256 newTokens, address _vendor) onlyDirector public {
        _mint(_vendor, newTokens * 10 ** 18);
        emit MintTokens(msg.sender, newTokens * 10 ** 18);
    }
   
}
