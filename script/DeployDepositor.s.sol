// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.25 <0.9.0;

import { Depositor } from "../src/Depositor.sol";
import { BaseScript } from "./Base.s.sol";
import { IERC721 } from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

/// @dev See the Solidity Scripting tutorial: https://book.getfoundry.sh/tutorials/solidity-scripting
contract DeployDepositor is BaseScript {
    function run() public broadcast returns (Depositor depositor) {
        // sepolia contracts
        IERC721 honestWork = IERC721(0xCfED1cC741F68AF4778c2Eb8efDcFc0F9ab28466);
        address dishonestWork = 0x0a78f07E560E81C9570F9013dbF4E77Fd1aa1E5f;

        // Create beef
        depositor = new Depositor{ salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4ff20b5ff2bac30000000094f6 }(
            honestWork, dishonestWork
        );

        // Create babe
        depositor = new Depositor{ salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4f27bbae2541a8000000014f44 }(
            honestWork, dishonestWork
        );

        // Create deaf
        depositor = new Depositor{ salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4fe7d2adb053bc00000001339e }(
            honestWork, dishonestWork
        );

        // Create dead
        depositor = new Depositor{ salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4f91f422da618e0000000188ba }(
            honestWork, dishonestWork
        );

        // Create face
        depositor = new Depositor{ salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4f4c835bfafe5d00000001cc11 }(
            honestWork, dishonestWork
        );

        // Create feed
        depositor = new Depositor{ salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4f2b6da19824ba0000000002d5 }(
            honestWork, dishonestWork
        );

        // Create fed
        depositor = new Depositor{ salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4fac797fe40060000001b1ff2a }(
            honestWork, dishonestWork
        );

        // Create bad
        depositor = new Depositor{ salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4f62e4d73bf63900000001647c }(
            honestWork, dishonestWork
        );
    }
}
