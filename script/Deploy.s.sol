// SPDX-License-Identifier: MIT
pragma solidity >=0.8.27 <0.9.0;

import { DishonestWork } from "../src/DishonestWork.sol";

import { BaseScript } from "./Base.s.sol";

import { IHonestWork } from "../src/IHonestWork.sol";

contract Deploy is BaseScript {
    function run() public broadcast returns (DishonestWork dishonestWork) {
        address _0xfff = 0x8C9A4427e991c6485e559E3c4F79a88128d8be3E;
        IHonestWork honestWork = IHonestWork(0xCfED1cC741F68AF4778c2Eb8efDcFc0F9ab28466);
        address balancerVault = address(0xBA12222222228d8Ba445958a75a0704d566BF2C8);
        dishonestWork = new DishonestWork(honestWork, _0xfff, balancerVault);
    }
}
