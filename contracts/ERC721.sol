// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MeowjestyNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;
    
    address public owner;

    constructor() ERC721("MeowjestyNFT", "MJ") {
        owner = msg.sender;
    }

    function mintNFT(string memory tokenURI) public returns (uint256) {
        require(msg.sender != address(0), "Invalid address");
        require(msg.sender == owner, "Only the owner can mint NFTs");
        
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURI);
        
        return tokenId;
    }

    function getCurrentTokenId() public view returns (uint256) {
        return _tokenIdCounter.current();
    }
}
