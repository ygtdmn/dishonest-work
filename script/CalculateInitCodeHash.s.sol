// SPDX-License-Identifier: MIT
pragma solidity >=0.8.27 <0.9.0;

import { Depositor } from "../src/Depositor.sol";
import { Script } from "forge-std/src/Script.sol";
import { IERC721 } from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract CalculateInitCodeHash is Script {
    function run() public pure returns (bytes32 initCodeHash) {
        (address honestWork, address dishonestWork) = getMainnetContracts();

        bytes memory creationCode = type(Depositor).creationCode;
        bytes memory constructorArgs = abi.encode(IERC721(honestWork), address(dishonestWork));
        bytes memory initCode = bytes.concat(creationCode, constructorArgs);
        initCodeHash = keccak256(initCode);
    }

    function getMainnetContracts() internal pure returns (address honestWork, address dishonestWork) {
        honestWork = address(0xCfED1cC741F68AF4778c2Eb8efDcFc0F9ab28466);
        dishonestWork = address(0x943B541B49274Eb8845DC9BE200151289E5b820D);
    }

    function getSepoliaContracts() internal pure returns (address honestWork, address dishonestWork) {
        honestWork = address(0x47f62429558cFfB91dbD1edF4f1e94F151091fb9);
        dishonestWork = address(0x3259577885133126E9576Dc9a8ddD5E244c7367C);
    }
}
