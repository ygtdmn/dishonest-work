// SPDX-License-Identifier: MIT
pragma solidity >=0.8.27 <0.9.0;

import { Depositor } from "../src/Depositor.sol";
import { BaseScript } from "./Base.s.sol";
import { IERC721 } from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import { DishonestWork } from "../src/DishonestWork.sol";
import { stdJson } from "forge-std/src/StdJson.sol";

contract DeployDepositor is BaseScript {
    using stdJson for string;

    function getMainnetContracts() internal pure returns (IERC721, DishonestWork) {
        IERC721 honestWork = IERC721(0xCfED1cC741F68AF4778c2Eb8efDcFc0F9ab28466);
        DishonestWork dishonestWork = DishonestWork(payable(address(0x943B541B49274Eb8845DC9BE200151289E5b820D)));
        return (honestWork, dishonestWork);
    }

    function getSepoliaContracts() internal pure returns (IERC721, DishonestWork) {
        IERC721 honestWork = IERC721(0x47f62429558cFfB91dbD1edF4f1e94F151091fb9);
        DishonestWork dishonestWork = DishonestWork(payable(address(0x3259577885133126E9576Dc9a8ddD5E244c7367C)));
        return (honestWork, dishonestWork);
    }

    function run() public broadcast {
        // Get mainnet contracts
        (IERC721 honestWork, DishonestWork dishonestWork) = getMainnetContracts();

        string[] memory command = new string[](2);
        command[0] = "python3";
        command[1] = "script/generate_salts.py";
        vm.ffi(command);

        // Read salts from JSON
        string memory root = vm.projectRoot();
        string memory path = string.concat(root, "/script/salts.json");
        string memory json = vm.readFile(path);

        // Create all depositors
        address[] memory addresses = new address[](8);
        uint256 i = 0;

        string[] memory suffixes = new string[](8);
        suffixes[0] = "beef";
        suffixes[1] = "babe";
        suffixes[2] = "deaf";
        suffixes[3] = "dead";
        suffixes[4] = "face";
        suffixes[5] = "feed";
        suffixes[6] = "fed";
        suffixes[7] = "bad";

        for (i = 0; i < suffixes.length; i++) {
            // Read directly using the suffix as the key
            bytes32 salt = abi.decode(json.parseRaw(string.concat(".", suffixes[i], ".salt")), (bytes32));

            Depositor depositor = new Depositor{ salt: salt }(honestWork, address(dishonestWork));

            addresses[i] = address(depositor);

            // Verify address matches expected
            address expectedAddr = abi.decode(json.parseRaw(string.concat(".", suffixes[i], ".address")), (address));

            require(
                address(depositor) == expectedAddr,
                string.concat("Deployed ", suffixes[i], " address does not match expected address")
            );
        }

        // Set addresses in dishonestWork
        dishonestWork.setAddresses(
            addresses[0], // beef
            addresses[1], // babe
            addresses[2], // deaf
            addresses[3], // dead
            addresses[4], // face
            addresses[5], // feed
            addresses[6], // fed
            addresses[7] // bad
        );

        dishonestWork.renounceOwnership();
    }
}
