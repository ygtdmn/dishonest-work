// SPDX-License-Identifier: MIT
pragma solidity >=0.8.25;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract Depositor {
    constructor(IERC721 honestWork, address dishonestWork) {
        honestWork.setApprovalForAll(dishonestWork, true);
    }
}
