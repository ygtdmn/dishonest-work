// SPDX-License-Identifier: MIT
pragma solidity >=0.8.27;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

interface IHonestWork is IERC721 {
    function tokensOf(address owner) external view returns (uint256[] memory);
}
