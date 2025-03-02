// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";


// ---------------------------------------------------------------
// ERC-20: Aerospace Supply Token (AST)
// ---------------------------------------------------------------
contract AerospaceSupplyToken is ERC20Burnable, ERC20Pausable, Ownable {
    constructor(uint256 initialSupply) ERC20("AerospaceSupplyToken", "AST") {
        _mint(msg.sender, initialSupply);
    }

    // Standard ERC-20 Token Transfer
    function transfer(address to, uint256 amount) public override returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

    // Approving Token Spending by a Third Party
    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    // Enabling transfer from approved third parties
    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        _spendAllowance(from, msg.sender, amount);
        _transfer(from, to, amount);
        return true;
    }

    // Burn AST to Reduce Supply
    function burn(uint256 amount) public override {
        _burn(msg.sender, amount);
    }

    // Staking AST for governance participation
    function stakeTokens(uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        _burn(msg.sender, amount); // Tokens are locked in staking (removed from circulation)
    }

    // Mint new AST tokens (restricted to owner)
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
