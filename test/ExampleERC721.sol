// SPDX-License-Identifier: MIT
pragma solidity >=0.8.25;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract ExampleERC721 is ERC721 {
    mapping(uint256 => uint256) transferCounter;

    constructor() ERC721("ExampleERC721", "E721") {
        _mint(msg.sender, 0);
    }

    function mint(address to, uint256 tokenId) public {
        _mint(to, tokenId);
    }

    function transferFrom(address from, address to, uint256 tokenId) public override {
        super.transferFrom(from, to, tokenId);
        transferCounter[tokenId]++;
    }

    function getTransferCount(uint256 tokenId) public view returns (uint256) {
        return transferCounter[tokenId];
    }
}
