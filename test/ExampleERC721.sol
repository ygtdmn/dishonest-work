// SPDX-License-Identifier: MIT
pragma solidity >=0.8.27;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { IHonestWork } from "../src/IHonestWork.sol";

contract ExampleERC721 is IHonestWork, ERC721 {
    mapping(uint256 => uint256) transferCounter;
    mapping(address => uint256[]) ownerMap;

    constructor() ERC721("ExampleERC721", "E721") {
        _mint(msg.sender, 0);
        ownerMap[msg.sender].push(0);
    }

    function mint(address to, uint256 tokenId) public {
        _mint(to, tokenId);
        ownerMap[to].push(tokenId);
    }

    function transferFrom(address from, address to, uint256 tokenId) public override(ERC721, IERC721) {
        // Remove token from previous owner's array
        uint256[] storage fromTokens = ownerMap[from];
        for (uint256 i = 0; i < fromTokens.length; i++) {
            if (fromTokens[i] == tokenId) {
                // Move the last element to this position and pop
                fromTokens[i] = fromTokens[fromTokens.length - 1];
                fromTokens.pop();
                break;
            }
        }
        
        // Add token to new owner's array
        ownerMap[to].push(tokenId);
        
        super.transferFrom(from, to, tokenId);
        transferCounter[tokenId]++;
    }

    function getTransferCount(uint256 tokenId) public view returns (uint256) {
        return transferCounter[tokenId];
    }

    function tokensOf(address owner) public view returns (uint256[] memory) {
        return ownerMap[owner];
    }
}
