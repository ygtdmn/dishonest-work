// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.25 <0.9.0;

import { Test } from "forge-std/src/Test.sol";
import { console2 } from "forge-std/src/console2.sol";
import { Depositor } from "../src/Depositor.sol";
import { DishonestWork } from "../src/DishonestWork.sol";
import { ExampleERC721 } from "./ExampleERC721.sol";
import { ExampleERC20 } from "./ExampleERC20.sol";
import { IERC20 } from "@balancer-labs/v2-interfaces/contracts/solidity-utils/openzeppelin/IERC20.sol";
import { MockVault } from "./MockVault.sol";

contract DishonestTest is Test {
    ExampleERC721 private honestWork;
    DishonestWork private dishonestWork;
    address private withdrawAddress = 0x8C9A4427e991c6485e559E3c4F79a88128d8be3E;
    MockVault private mockVault;

    function setUp() public virtual {
        honestWork = new ExampleERC721();
        mockVault = new MockVault();
        dishonestWork = new DishonestWork(honestWork, withdrawAddress, address(mockVault));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        dishonestWork.setAddresses(
            address(0xdead),
            address(0xbeef),
            address(0xbabe),
            address(0xfeed),
            address(0xfed),
            address(0xbad),
            address(0xface),
            address(0xdeaf)
        );
        vm.broadcast(address(0xdead));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        vm.broadcast(address(0xbeef));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        vm.broadcast(address(0xbabe));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        vm.broadcast(address(0xfeed));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        vm.broadcast(address(0xfed));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        vm.broadcast(address(0xbad));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        vm.broadcast(address(0xface));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        vm.broadcast(address(0xdeaf));
        honestWork.setApprovalForAll(address(dishonestWork), true);
    }

    function testGetCreationBytecode() external pure {
        bytes memory bytecode = abi.encodePacked(
            type(Depositor).creationCode,
            abi.encode(ExampleERC721(0xCfED1cC741F68AF4778c2Eb8efDcFc0F9ab28466)),
            abi.encode(address(0x123EA2287adb6Cc4AFb55a6592C1702aC93409CE))
        );
        console2.logBytes(bytecode);
        console2.logBytes32(keccak256(bytecode));
    }

    /*//////////////////////////////////////////////////////////////
                        FROM, TO ADDRESS CHECKS
    //////////////////////////////////////////////////////////////*/

    function testMakeYourOwnLuckToAddressWorks() external {
        uint256 currentProbability = uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao))) % 100;
        dishonestWork.makeYourOwnLuck(currentProbability + 1, address(0x1337), 0);
        assertEq(honestWork.ownerOf(0), address(0x1337));
    }

    function testMakeOriginNotSenderToAddressWorks() external {
        dishonestWork.makeOriginNotSender(address(0x1337), 0);
        assertEq(honestWork.ownerOf(0), address(0x1337));
    }

    function testSendToAnEmptyAddressReturnsBack() external {
        dishonestWork.sendToAnEmptyAddress(0);
        assertEq(honestWork.ownerOf(0), address(this));
    }

    function testTransferXTimesReturnsBack() external {
        dishonestWork.transferXTimes(0, 10);
        assertEq(honestWork.ownerOf(0), address(this));
    }

    function testSendWithPasswordToAddressWorks() external {
        dishonestWork.sendWithPassword(address(0x1337), 0);
        assertEq(honestWork.ownerOf(0), address(0x1337));
    }

    function testTakeAVacationDepositWorks() external {
        dishonestWork.renounceOwnership();
        dishonestWork.takeAVacation(0);
        assertEq(honestWork.ownerOf(0), address(dishonestWork));
    }

    function testStartABeefDepositWorks() external {
        dishonestWork.renounceOwnership();
        dishonestWork.startABeef(0);
        assertEq(honestWork.ownerOf(0), dishonestWork.beef());
    }

    function testCallABabeDepositWorks() external {
        dishonestWork.renounceOwnership();
        dishonestWork.callABabe(0);
        assertEq(honestWork.ownerOf(0), dishonestWork.babe());
    }

    function testGoRaveTurnDeafDepositWorks() external {
        dishonestWork.renounceOwnership();
        dishonestWork.goRaveTurnDeaf(0);
        assertEq(honestWork.ownerOf(0), dishonestWork.deaf());
    }

    function testOverdoseAndGoDeadDepositWorks() external {
        dishonestWork.renounceOwnership();
        dishonestWork.overdoseAndGoDead(0);
        assertEq(honestWork.ownerOf(0), dishonestWork.dead());
    }

    function testFaceYourFearsDepositWorks() external {
        dishonestWork.renounceOwnership();
        dishonestWork.faceYourFears(0);
        assertEq(honestWork.ownerOf(0), dishonestWork.face());
    }

    function testGoToAFancyRestaurantFeedYourselfDepositWorks() external {
        dishonestWork.renounceOwnership();
        dishonestWork.goToAFancyRestaurantFeedYourself(0);
        assertEq(honestWork.ownerOf(0), dishonestWork.feed());
    }

    function testSnitchToFedsDepositWorks() external {
        dishonestWork.renounceOwnership();
        dishonestWork.snitchToFeds(0);
        assertEq(honestWork.ownerOf(0), dishonestWork.fed());
    }

    function testShillScamTokenToYourFriendsBeBadDepositWorks() external {
        dishonestWork.renounceOwnership();
        dishonestWork.shillScamTokenToYourFriendsBeBad(0);
        assertEq(honestWork.ownerOf(0), dishonestWork.bad());
    }

    function testBackToWorkWithdraws() external {
        dishonestWork.renounceOwnership();
        dishonestWork.takeAVacation(0);
        assertEq(honestWork.ownerOf(0), address(dishonestWork));
        dishonestWork.backToWork(0);
        assertEq(honestWork.ownerOf(0), address(this));
    }

    function testEndYourBeefWithdraws() external {
        dishonestWork.renounceOwnership();
        dishonestWork.startABeef(0);
        assertEq(honestWork.ownerOf(0), dishonestWork.beef());
        dishonestWork.endYourBeef(0);
        assertEq(honestWork.ownerOf(0), address(this));
    }

    function testSayGoodbyeToBabeWithdraws() external {
        dishonestWork.renounceOwnership();
        dishonestWork.callABabe(0);
        assertEq(honestWork.ownerOf(0), dishonestWork.babe());
        dishonestWork.sayGoodbyeToBabe(0);
        assertEq(honestWork.ownerOf(0), address(this));
    }

    function testGoToDoctorHealDeafWithdraws() external {
        dishonestWork.renounceOwnership();
        dishonestWork.goRaveTurnDeaf(0);
        assertEq(honestWork.ownerOf(0), dishonestWork.deaf());
        dishonestWork.goToDoctorHealDeaf(0);
        assertEq(honestWork.ownerOf(0), address(this));
    }

    function testShotAdrenalineNoMoreDeadWithdraws() external {
        dishonestWork.renounceOwnership();
        dishonestWork.overdoseAndGoDead(0);
        assertEq(honestWork.ownerOf(0), dishonestWork.dead());
        dishonestWork.shotAdrenalineNoMoreDead(0);
        assertEq(honestWork.ownerOf(0), address(this));
    }

    function testTurnBackWithAHappyFaceWithdraws() external {
        dishonestWork.renounceOwnership();
        dishonestWork.faceYourFears(0);
        assertEq(honestWork.ownerOf(0), dishonestWork.face());
        dishonestWork.turnBackWithAHappyFace(0);
        assertEq(honestWork.ownerOf(0), address(this));
    }

    function testReturnHomeToFeedYourHeadWithdraws() external {
        dishonestWork.renounceOwnership();
        dishonestWork.goToAFancyRestaurantFeedYourself(0);
        assertEq(honestWork.ownerOf(0), dishonestWork.feed());
        dishonestWork.returnHomeToFeedYourHead(0);
        assertEq(honestWork.ownerOf(0), address(this));
    }

    function testReturnFromFedsWithWitnessProtectionWithdraws() external {
        dishonestWork.renounceOwnership();
        dishonestWork.snitchToFeds(0);
        assertEq(honestWork.ownerOf(0), dishonestWork.fed());
        dishonestWork.returnFromFedsWithWitnessProtection(0);
        assertEq(honestWork.ownerOf(0), address(this));
    }

    function testPutAMiladyPfpNoMoreBadWithdraws() external {
        dishonestWork.renounceOwnership();
        dishonestWork.shillScamTokenToYourFriendsBeBad(0);
        assertEq(honestWork.ownerOf(0), dishonestWork.bad());
        dishonestWork.putAMiladyPfpNoMoreBad(0);
        assertEq(honestWork.ownerOf(0), address(this));
    }

    /*//////////////////////////////////////////////////////////////
                          FUNCTIONALITY CHECKS
    //////////////////////////////////////////////////////////////*/

    function testMakeYourOwnLuckProbabilityWorks() external {
        vm.warp(13_371_337);
        uint256 currentProbability = uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao))) % 100;
        dishonestWork.makeYourOwnLuck(currentProbability, address(0x1337), 0);
        assertEq(honestWork.ownerOf(0), address(0x1337));
    }

    function testMakeYourOwnLuckProbabilityFails() external {
        vm.warp(13_371_337);
        vm.expectRevert("You are unlucky");
        dishonestWork.makeYourOwnLuck(0, address(0x1337), 0);
    }

    function testTransferXTimesWorks() external {
        dishonestWork.transferXTimes(0, 10);
        assertEq(honestWork.getTransferCount(0), 10);
    }

    function testDepositBeforeRenounceOwnershipFails() external {
        vm.expectRevert(DishonestWork.DepositWithdrawFunctionsDoNotWorkBeforeOwnershipRenounce.selector);
        dishonestWork.takeAVacation(0);
    }

    /*//////////////////////////////////////////////////////////////
                        UNOWNED WITHDRAW CHECKS
    //////////////////////////////////////////////////////////////*/

    function testBackToWorkUnowned() external {
        dishonestWork.renounceOwnership();
        honestWork.mint(address(0x113), 1);
        vm.startBroadcast(address(0x113));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        dishonestWork.takeAVacation(1);
        vm.stopBroadcast();
        vm.expectRevert("You are not the owner");
        dishonestWork.backToWork(1);
    }

    function testEndYourBeefUnowned() external {
        dishonestWork.renounceOwnership();
        honestWork.mint(address(0x113), 1);
        vm.startBroadcast(address(0x113));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        dishonestWork.startABeef(1);
        vm.stopBroadcast();
        vm.expectRevert("You are not the owner");
        dishonestWork.endYourBeef(1);
    }

    function testSayGoodbyeToBabeUnowned() external {
        dishonestWork.renounceOwnership();
        honestWork.mint(address(0x113), 1);
        vm.startBroadcast(address(0x113));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        dishonestWork.callABabe(1);
        vm.stopBroadcast();
        vm.expectRevert("You are not the owner");
        dishonestWork.sayGoodbyeToBabe(1);
    }

    function testGoToDoctorHealDeafUnowned() external {
        dishonestWork.renounceOwnership();
        honestWork.mint(address(0x113), 1);
        vm.startBroadcast(address(0x113));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        dishonestWork.goRaveTurnDeaf(1);
        vm.stopBroadcast();
        vm.expectRevert("You are not the owner");
        dishonestWork.goToDoctorHealDeaf(1);
    }

    function testShotAdrenalineNoMoreDeadUnowned() external {
        dishonestWork.renounceOwnership();
        honestWork.mint(address(0x113), 1);
        vm.startBroadcast(address(0x113));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        dishonestWork.overdoseAndGoDead(1);
        vm.stopBroadcast();
        vm.expectRevert("You are not the owner");
        dishonestWork.shotAdrenalineNoMoreDead(1);
    }

    function testTurnBackWithAHappyFaceUnowned() external {
        dishonestWork.renounceOwnership();
        honestWork.mint(address(0x113), 1);
        vm.startBroadcast(address(0x113));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        dishonestWork.faceYourFears(1);
        vm.stopBroadcast();
        vm.expectRevert("You are not the owner");
        dishonestWork.turnBackWithAHappyFace(1);
    }

    function testReturnHomeToFeedYourHeadUnowned() external {
        dishonestWork.renounceOwnership();
        honestWork.mint(address(0x113), 1);
        vm.startBroadcast(address(0x113));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        dishonestWork.goToAFancyRestaurantFeedYourself(1);
        vm.stopBroadcast();
        vm.expectRevert("You are not the owner");
        dishonestWork.returnHomeToFeedYourHead(1);
    }

    function testReturnFromFedsWithWitnessProtectionUnowned() external {
        dishonestWork.renounceOwnership();
        honestWork.mint(address(0x113), 1);
        vm.startBroadcast(address(0x113));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        dishonestWork.snitchToFeds(1);
        vm.stopBroadcast();
        vm.expectRevert("You are not the owner");
        dishonestWork.returnFromFedsWithWitnessProtection(1);
    }

    function testPutAMiladyPfpNoMoreBadUnowned() external {
        dishonestWork.renounceOwnership();
        honestWork.mint(address(0x113), 1);
        vm.startBroadcast(address(0x113));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        dishonestWork.shillScamTokenToYourFriendsBeBad(1);
        vm.stopBroadcast();
        vm.expectRevert("You are not the owner");
        dishonestWork.putAMiladyPfpNoMoreBad(1);
    }

    /*//////////////////////////////////////////////////////////////
                         ADMIN WITHDRAW CHECKS
    //////////////////////////////////////////////////////////////*/

    function testWithdrawEthAdmin() external {
        vm.deal(address(dishonestWork), 1 ether);
        vm.deal(withdrawAddress, 1 ether);
        vm.broadcast(withdrawAddress);
        dishonestWork.withdrawEth();
        assertEq(withdrawAddress.balance, 2 ether);
    }

    function testWithdrawEthNonAdmin() external {
        vm.broadcast(address(0xdeadbeef));
        vm.expectRevert("Only withdraw address");
        dishonestWork.withdrawEth();
    }

    function testWithdrawErc20Admin() external {
        ExampleERC20 erc20 = new ExampleERC20();
        erc20.mint(address(dishonestWork), 100);
        vm.broadcast(withdrawAddress);
        dishonestWork.withdrawErc20(IERC20(address(erc20)));
        assertEq(erc20.balanceOf(address(dishonestWork)), 0);
        assertEq(erc20.balanceOf(withdrawAddress), 100);
    }

    function testWithdrawErc20NonAdmin() external {
        ExampleERC20 erc20 = new ExampleERC20();
        erc20.mint(address(dishonestWork), 100);
        vm.broadcast(address(0xdeadbeef));
        vm.expectRevert("Only withdraw address");
        dishonestWork.withdrawErc20(IERC20(address(erc20)));
    }

    function testWithdrawErc721Admin() external {
        ExampleERC721 erc721 = new ExampleERC721();
        erc721.mint(address(dishonestWork), 1);
        vm.broadcast(withdrawAddress);
        dishonestWork.withdrawErc721(erc721, 1);
        assertEq(erc721.ownerOf(1), withdrawAddress);
    }

    function testWithdrawErc721NonAdmin() external {
        ExampleERC721 erc721 = new ExampleERC721();
        erc721.mint(address(dishonestWork), 1);
        vm.broadcast(address(0xdeadbeef));
        vm.expectRevert("Only withdraw address");
        dishonestWork.withdrawErc721(erc721, 1);
    }

    function testWithdrawHonestWorkAdmin() external {
        dishonestWork.renounceOwnership();
        honestWork.mint(address(this), 1);
        dishonestWork.takeAVacation(1);
        vm.broadcast(withdrawAddress);
        vm.expectRevert("Owner exists");
        dishonestWork.withdrawErc721(honestWork, 1);
    }

    function testWithdrawHonestWorkOwnedNonAdmin() external {
        dishonestWork.renounceOwnership();
        honestWork.mint(address(this), 1);
        dishonestWork.takeAVacation(1);
        vm.expectRevert("Only withdraw address");
        vm.broadcast(address(this));
        dishonestWork.withdrawErc721(honestWork, 1);
    }
}
