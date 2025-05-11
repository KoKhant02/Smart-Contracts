// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract CoraERC20 is ERC20Pausable, Ownable {

    constructor(string memory name, string memory symbol, uint256 initialSupply) ERC20(name, symbol) Ownable(msg.sender){
        _mint(msg.sender, initialSupply); 
    }

    /**
     * @dev Function to mint new tokens.
     * Can only be called by the owner.
     * @param account Address to receive the newly minted tokens.
     * @param amount Amount of tokens to mint (in smallest units).
     */
    function mint(address account, uint256 amount) external onlyOwner {
        _mint(account, amount);
    }

    /**
     * @dev Function to burn tokens.
     * @param amount Amount of tokens to burn (in smallest units).
     */
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    /**
     * @dev Pause the contract.
     * Prevents transfers, minting, and burning while paused.
     * Can only be called by the owner.
     */
    function pause() external onlyOwner {
        _pause();
    }

    /**
     * @dev Unpause the contract.
     * Resumes all operations.
     * Can only be called by the owner.
     */
    function unpause() external onlyOwner {
        _unpause();
    }

    /**
     * @dev Provide a fallback function to reject ETH transfers.
     */
    receive() external payable {
        revert("Direct ETH transfers not allowed.");
    }

    /**
     * @dev Provide a way to withdraw accidentally sent ETH or ERC20 tokens.
     * Can only be called by the owner.
     */
    function rescueFunds(address token, uint256 amount) external onlyOwner {
        if (token == address(0)) {
            payable(owner()).transfer(amount);
        } else {
            IERC20(token).transfer(owner(), amount); // Use IERC20 to handle token transfers
        }
    }
}