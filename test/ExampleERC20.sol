// SPDX-License-Identifier: MIT
pragma solidity >=0.8.25;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ExampleERC20 is ERC20 {
    constructor() ERC20("ExampleERC20", "E20") { }

    function mint(address to, uint256 tokenId) public {
        _mint(to, tokenId);
    }
}
