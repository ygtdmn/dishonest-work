// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.25 <0.9.0;

import { DishonestWork } from "../src/DishonestWork.sol";

import { BaseScript } from "./Base.s.sol";

import { IERC721 } from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract Deploy is BaseScript {
    function run() public broadcast returns (DishonestWork dishonestWork) {
        dishonestWork = new DishonestWork(IERC721(0xCfED1cC741F68AF4778c2Eb8efDcFc0F9ab28466));
    }
}
