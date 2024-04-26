// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.25 <0.9.0;

import { DishonestWork } from "../src/DishonestWork.sol";

import { BaseScript } from "./Base.s.sol";

import { IERC721 } from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract Deploy is BaseScript {
    function run() public broadcast returns (DishonestWork dishonestWork) {
        dishonestWork = new DishonestWork(IERC721(0x47f62429558cFfB91dbD1edF4f1e94F151091fb9)); // sepolia contract
    }
}
