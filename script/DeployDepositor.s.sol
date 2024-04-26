// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.25 <0.9.0;

import { Depositor } from "../src/Depositor.sol";
import { BaseScript } from "./Base.s.sol";
import { IERC721 } from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

/// @dev See the Solidity Scripting tutorial: https://book.getfoundry.sh/tutorials/solidity-scripting
contract DeployDepositor is BaseScript {
    function run() public broadcast returns (Depositor depositor) {
        // sepolia contracts
        IERC721 honestWork = IERC721(0x47f62429558cFfB91dbD1edF4f1e94F151091fb9);
        address dishonestWork = 0x9ca3817F2af1D53a221fCEE3e8C7473d4537A911;

        // Create beef
        depositor = new Depositor{ salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4f9c0e3ee15c8a0000000007b4 }(
            honestWork, dishonestWork
        );

        // Create babe
        depositor = new Depositor{ salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4f68c91c63a4dd00000000ea75 }(
            honestWork, dishonestWork
        );

        // Create deaf
        depositor = new Depositor{ salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4fb50938e7817f00000000a779 }(
            honestWork, dishonestWork
        );

        // Create dead
        depositor = new Depositor{ salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4fba9ff4b682ee000000020c35 }(
            honestWork, dishonestWork
        );

        // Create face
        depositor = new Depositor{ salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4f639c8d25e93500000000072d }(
            honestWork, dishonestWork
        );

        // Create feed
        depositor = new Depositor{ salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4fb3cb1b0592ad00000000294d }(
            honestWork, dishonestWork
        );

        // Create fed
        depositor = new Depositor{ salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4fc8a5c073dc1500000000b08c }(
            honestWork, dishonestWork
        );

        // Create bad
        depositor = new Depositor{ salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4fa374a815e62e00000000fa6a }(
            honestWork, dishonestWork
        );
    }
}
