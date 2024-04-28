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
        address dishonestWork = 0xAB120c9255281aC36b24a99fc64b5eb69D5aBe0c;

        // Create beef
        depositor = new Depositor{ salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4f27231fc208eb0000000007c8 }(
            honestWork, dishonestWork
        );

        // Create babe
        depositor = new Depositor{ salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4fa8751e65b21500000000c059 }(
            honestWork, dishonestWork
        );

        // Create deaf
        depositor = new Depositor{ salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4f20e6b10e366f0000000049f7 }(
            honestWork, dishonestWork
        );

        // Create dead
        depositor = new Depositor{ salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4f83ff5a5b7bd2000000003dfa }(
            honestWork, dishonestWork
        );

        // Create face
        depositor = new Depositor{ salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4fdc30928a129100000002ac90 }(
            honestWork, dishonestWork
        );

        // Create feed
        depositor = new Depositor{ salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4f453cb981b08d00000000be13 }(
            honestWork, dishonestWork
        );

        // Create fed
        depositor = new Depositor{ salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4f7c5d59c714b000000000f613 }(
            honestWork, dishonestWork
        );

        // Create bad
        depositor = new Depositor{ salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4f317770be236b000000037b4c }(
            honestWork, dishonestWork
        );
    }
}
