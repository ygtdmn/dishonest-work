// SPDX-License-Identifier: MIT
pragma solidity >=0.8.25;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/*
    * @title DishonestWork
    * @dev https://twitter.com/YigitDuman/status/1783450725588111550
    * @author Yigit Duman (@yigitduman)
*/
contract DishonestWork is Ownable(msg.sender) {
    IERC721 public honestWork;

    address public beef;
    address public babe;
    address public deaf;
    address public dead;
    address public face;
    address public feed;
    address public fed;
    address public bad;

    constructor(IERC721 _honestWork) {
        honestWork = _honestWork;
    }

    error DepositWithdrawFunctionsDoNotWorkBeforeOwnershipRenounce();

    mapping(uint256 => address) public ownerMap;

    // Use this function with Flashbots to avoid getting reverted
    function makeYourOwnLuck(uint256 probability, address to, uint256 tokenId) external {
        honestWork.transferFrom(msg.sender, to, tokenId);
        uint256 currentProbability = uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao))) % 100;
        if (currentProbability > probability) {
            revert("You are unlucky");
        }
    }

    function makeOriginNotSender(address to, uint256 tokenId) external {
        honestWork.transferFrom(msg.sender, to, tokenId);
    }

    // You can also use this for TWICE_WITHIN_A_BLOCK and TO_CONTRACT
    function sendToAnEmptyAddress(uint256 tokenId) external {
        honestWork.transferFrom(msg.sender, address(this), tokenId);
        honestWork.transferFrom(address(this), msg.sender, tokenId);
    }

    function transferXTimes(uint256 tokenId, uint256 times) external {
        for (uint256 i = 0; i < times; i++) {
            if (i % 2 == 0) {
                honestWork.transferFrom(msg.sender, address(this), tokenId);
            } else {
                honestWork.transferFrom(address(this), msg.sender, tokenId);
            }
        }

        if (honestWork.ownerOf(tokenId) == address(this)) {
            honestWork.transferFrom(address(this), msg.sender, tokenId);
        }
    }

    function sendWithPassword(address to, uint256 tokenId) external {
        honestWork.safeTransferFrom(msg.sender, to, tokenId, abi.encodePacked("password"));
    }

    function deposit(uint256 tokenId, address addy) internal {
        if (owner() != address(0)) {
            revert DepositWithdrawFunctionsDoNotWorkBeforeOwnershipRenounce();
        }

        honestWork.transferFrom(msg.sender, addy, tokenId);
        ownerMap[tokenId] = msg.sender;
    }

    function withdraw(uint256 tokenId, address addy) internal {
        require(ownerMap[tokenId] == msg.sender, "You are not the owner");
        honestWork.transferFrom(addy, msg.sender, tokenId);
        ownerMap[tokenId] = address(0);
    }

    function takeAVacation(uint256 tokenId) external {
        deposit(tokenId, address(this));
    }

    function backToWork(uint256 tokenId) external {
        withdraw(tokenId, address(this));
    }

    function startABeef(uint256 tokenId) external {
        deposit(tokenId, beef);
    }

    function endYourBeef(uint256 tokenId) external {
        withdraw(tokenId, beef);
    }

    function callABabe(uint256 tokenId) external {
        deposit(tokenId, babe);
    }

    function sayGoodbyeToBabe(uint256 tokenId) external {
        withdraw(tokenId, babe);
    }

    function goRaveTurnDeaf(uint256 tokenId) external {
        deposit(tokenId, deaf);
    }

    function goToDoctorHealDeaf(uint256 tokenId) external {
        withdraw(tokenId, deaf);
    }

    function overdoseAndGoDead(uint256 tokenId) external {
        deposit(tokenId, dead);
    }

    function shotAdrenalineNoMoreDead(uint256 tokenId) external {
        withdraw(tokenId, dead);
    }

    function faceYourFears(uint256 tokenId) external {
        deposit(tokenId, face);
    }

    function turnBackWithAHappyFace(uint256 tokenId) external {
        withdraw(tokenId, face);
    }

    function goToAFancyRestaurantFeedYourself(uint256 tokenId) external {
        deposit(tokenId, feed);
    }

    function returnHomeToFeedYourHead(uint256 tokenId) external {
        withdraw(tokenId, feed);
    }

    function snitchToFeds(uint256 tokenId) external {
        deposit(tokenId, fed);
    }

    function returnFromFedsWithWitnessProtection(uint256 tokenId) external {
        withdraw(tokenId, fed);
    }

    function shillScamTokenToYourFriendsBeBad(uint256 tokenId) external {
        deposit(tokenId, bad);
    }

    function putAMiladyPfpNoMoreBad(uint256 tokenId) external {
        withdraw(tokenId, bad);
    }

    function setAddresses(
        address _beef,
        address _babe,
        address _deaf,
        address _dead,
        address _face,
        address _feed,
        address _fed,
        address _bad
    )
        external
        onlyOwner
    {
        beef = _beef;
        babe = _babe;
        deaf = _deaf;
        dead = _dead;
        face = _face;
        feed = _feed;
        fed = _fed;
        bad = _bad;
    }
}
