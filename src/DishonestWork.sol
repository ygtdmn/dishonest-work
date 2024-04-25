// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.25;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract DishonestWork {
    IERC721 public honestWork = IERC721(0xCfED1cC741F68AF4778c2Eb8efDcFc0F9ab28466);

    // Use this function with Flashbots to avoid getting reverted
    function makeYourOwnLuck(uint256 probability, address to, uint256 tokenId) external {
        honestWork.safeTransferFrom(msg.sender, to, tokenId);
        uint256 currentProbability = uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao))) % 100;
        if (currentProbability > probability) {
            revert("You are unlucky");
        }
    }

    function makeOriginNotSender(address to, uint256 tokenId) external {
        honestWork.safeTransferFrom(msg.sender, to, tokenId);
    }

    // You can also use this for TWICE_WITHIN_A_BLOCK and TO_CONTRACT
    function sendToAnEmptyAddress(uint256 tokenId) external {
        honestWork.transferFrom(msg.sender, address(this), tokenId);
        honestWork.transferFrom(address(this), msg.sender, tokenId);
    }

    function transferXTimes(uint256 tokenId, uint256 times) external {
        for (uint256 i = 0; i < times; i++) {
            if (i % 2 == 0) {
                honestWork.safeTransferFrom(msg.sender, address(this), tokenId);
            } else {
                honestWork.safeTransferFrom(address(this), msg.sender, tokenId);
            }
        }

        if (honestWork.ownerOf(tokenId) == address(this)) {
            honestWork.safeTransferFrom(address(this), msg.sender, tokenId);
        }
    }

    function sendWithPassword(address to, uint256 tokenId) external {
        honestWork.safeTransferFrom(msg.sender, to, tokenId, abi.encodePacked("password"));
    }
}
