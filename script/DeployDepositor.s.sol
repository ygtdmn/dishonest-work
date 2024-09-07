// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.25 <0.9.0;

import { Depositor } from "../src/Depositor.sol";
import { BaseScript } from "./Base.s.sol";
import { IERC721 } from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

/// @dev See the Solidity Scripting tutorial: https://book.getfoundry.sh/tutorials/solidity-scripting
contract DeployDepositor is BaseScript {
    function run() public broadcast {
        // sepolia contracts
        IERC721 honestWork = IERC721(0xCfED1cC741F68AF4778c2Eb8efDcFc0F9ab28466);
        address dishonestWork = 0x123EA2287adb6Cc4AFb55a6592C1702aC93409CE;

        // Create beef
        Depositor beefDepositor = new Depositor{
            salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4f9660afac20059ec573bb310b
        }(honestWork, dishonestWork);

        require(
            address(beefDepositor) == address(0x8873A37f142694320259fd1C19dEB72Ca1FaBeEF),
            "Deployed Beef address does not match expected address"
        );

        // Create babe
        Depositor babeDepositor = new Depositor{
            salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4f7b0849ed8630b86866e7c1bc
        }(honestWork, dishonestWork);

        require(
            address(babeDepositor) == address(0x45E8346cCaE1B07C4089e2Ec7126befe9bA0baBE),
            "Deployed Babe address does not match expected address"
        );

        // Create deaf
        Depositor deafDepositor = new Depositor{
            salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4fb1335e5e3cf3d06a463ef8ab
        }(honestWork, dishonestWork);

        require(
            address(deafDepositor) == address(0x2073b7F273dFC2d76457986aE53f91977CC3deaf),
            "Deployed Deaf address does not match expected address"
        );

        // Create dead
        Depositor deadDepositor = new Depositor{
            salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4f1d7551178af1421db2fa6a53
        }(honestWork, dishonestWork);

        require(
            address(deadDepositor) == address(0x941A5eBCba1d71c81582723146cA859C0E11DeAD),
            "Deployed Dead address does not match expected address"
        );

        // Create face
        Depositor faceDepositor = new Depositor{
            salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4fe18a364d39708930d79f5c57
        }(honestWork, dishonestWork);

        require(
            address(faceDepositor) == address(0x8c45E474937A89419eB7aadf38202E32e666facE),
            "Deployed Face address does not match expected address"
        );

        // Create feed
        Depositor feedDepositor = new Depositor{
            salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4f7740aa0305860754ff783828
        }(honestWork, dishonestWork);

        require(
            address(feedDepositor) == address(0xfb7F70cc9a3468573c2Daa7A0C98C15Bf0BafEeD),
            "Deployed Feed address does not match expected address"
        );

        // Create fed
        Depositor fedDepositor = new Depositor{
            salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4fe52f48e9ce4dcca945e41bd9
        }(honestWork, dishonestWork);

        require(
            address(fedDepositor) == address(0x5DfF4b9FC610a0fAAB68c03ed573f8AE4c201FEd),
            "Deployed Fed address does not match expected address"
        );

        // Create bad
        Depositor badDepositor = new Depositor{
            salt: 0x7d761d8828baf244eac723f82b2ece15ef8adc4fba7e7a23a760ea935e82f8d2
        }(honestWork, dishonestWork);

        require(
            address(badDepositor) == address(0x4962B3F71c88C4611662A682EDf57766cef01bAd),
            "Deployed Bad address does not match expected address"
        );
    }
}
