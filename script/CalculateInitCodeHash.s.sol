// SPDX-License-Identifier: MIT
pragma solidity >=0.8.27 <0.9.0;

import { DishonestWork } from "../src/DishonestWork.sol";
import { Script } from "forge-std/src/Script.sol";

contract CalculateInitCodeHash is Script {
    function run() public pure returns (bytes32 initCodeHash) {
        initCodeHash = keccak256(type(DishonestWork).creationCode);
    }
}
