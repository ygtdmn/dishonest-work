// SPDX-License-Identifier: MIT
pragma solidity >=0.8.27 <0.9.0;

import { DishonestWork } from "../src/DishonestWork.sol";

import { BaseScript } from "./Base.s.sol";

import { IHonestWork } from "../src/IHonestWork.sol";

contract Deploy is BaseScript {
    function run() public broadcast returns (DishonestWork dishonestWork) {
        return runOnMainnet();
    }

    function runOnMainnet() public returns (DishonestWork dishonestWork) {
        address _0xfff = 0x352628EcE5f47A3daFFE4c38FF92Ba1748bBB5cE;
        IHonestWork honestWork = IHonestWork(0xCfED1cC741F68AF4778c2Eb8efDcFc0F9ab28466);
        address balancerVault = address(0xBA12222222228d8Ba445958a75a0704d566BF2C8);
        dishonestWork = new DishonestWork(honestWork, _0xfff, balancerVault);
    }

    function runOnSepolia() public returns (DishonestWork dishonestWork) {
        address _0xfff = 0x352628EcE5f47A3daFFE4c38FF92Ba1748bBB5cE;
        IHonestWork honestWork = IHonestWork(0x47f62429558cFfB91dbD1edF4f1e94F151091fb9);
        address balancerVault = address(0xBA12222222228d8Ba445958a75a0704d566BF2C8);
        dishonestWork = new DishonestWork(honestWork, _0xfff, balancerVault);
    }
}
