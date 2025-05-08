// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract VariantERC1155 is ERC1155URIStorage, Ownable {

    string public name;
    string public symbol;

    uint256 private _currentTokenId;

    event Mint(address indexed to, uint256 tokenId, uint256 amount, string tokenURI);

    constructor(string memory _name, string memory _symbol) ERC1155("") Ownable(msg.sender) {
        name = _name;
        symbol = _symbol;
        _currentTokenId = 0;
    }

    /**
     * @dev Mint new ERC1155 tokens.
     * @param to The address receiving the minted tokens.
     * @param amount The number of tokens to mint.
     * @param tokenURI Optional URI for the minted token.
     * If no URI is provided, the tokenURI will be set as an empty string.
     */
    function mint(address to, uint256 amount, string memory tokenURI) external onlyOwner {
        uint256 tokenId = _getNextTokenId();

        _mint(to, tokenId, amount, "");

        if (bytes(tokenURI).length > 0) {
            _setURI(tokenId, tokenURI);
        }

        emit Mint(to, tokenId, amount, tokenURI);

        _incrementTokenId();
    }

    /**
     * @dev Internal function to get the next token ID.
     * @return The next available token ID.
     */
    function _getNextTokenId() private view returns (uint256) {
        return _currentTokenId;
    }

    /**
     * @dev Internal function to increment the current token ID.
     */
    function _incrementTokenId() private {
        _currentTokenId++;
    }

    /**
     * @dev Set the URI for a specific token ID.
     * This can be called after minting if needed.
     * @param tokenId The token ID to set the URI for.
     * @param tokenURI The URI for the token.
     */
    function setTokenURI(uint256 tokenId, string memory tokenURI) external onlyOwner {
        if (bytes(tokenURI).length == 0) {
            _setURI(tokenId, "");
        } else {
            _setURI(tokenId, tokenURI);
        }
    }

    function burn(address from, uint256 id, uint256 value) public {
        require(from == msg.sender || isApprovedForAll(from, msg.sender), "Not approved");
        _burn(from, id, value);
    }

}
