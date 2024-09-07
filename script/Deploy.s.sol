// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.25 <0.9.0;

import { DishonestWork } from "../src/DishonestWork.sol";

import { BaseScript } from "./Base.s.sol";

import { IERC721 } from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract Deploy is BaseScript {
    function run() public broadcast returns (DishonestWork dishonestWork) {
        address _0xff = 0x8C9A4427e991c6485e559E3c4F79a88128d8be3E;
        IERC721 honestWork = IERC721(0xCfED1cC741F68AF4778c2Eb8efDcFc0F9ab28466);
        address balancerVault = address(0xBA12222222228d8Ba445958a75a0704d566BF2C8);
        dishonestWork = new DishonestWork(honestWork, _0xff, balancerVault);
    }
}
