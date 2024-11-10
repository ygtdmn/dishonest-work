// SPDX-License-Identifier: MIT
pragma solidity >=0.8.27 <0.9.0;

import { Test } from "forge-std/src/Test.sol";
import { console2 } from "forge-std/src/console2.sol";
import { Depositor } from "../src/Depositor.sol";
import { DishonestWork } from "../src/DishonestWork.sol";
import { ExampleERC721 } from "./ExampleERC721.sol";
import { ExampleERC20 } from "./ExampleERC20.sol";
import { IERC20 } from "@balancer-labs/v2-interfaces/contracts/solidity-utils/openzeppelin/IERC20.sol";
import { MockVault } from "./MockVault.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

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
        vm.prank(address(0xdead));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        vm.prank(address(0xbeef));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        vm.prank(address(0xbabe));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        vm.prank(address(0xfeed));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        vm.prank(address(0xfed));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        vm.prank(address(0xbad));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        vm.prank(address(0xface));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        vm.prank(address(0xdeaf));
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
        vm.expectRevert("Deposit functions do not work before ownership is renounced");
        dishonestWork.takeAVacation(0);
    }

    /*//////////////////////////////////////////////////////////////
                        UNOWNED WITHDRAW CHECKS
    //////////////////////////////////////////////////////////////*/

    function testBackToWorkUnowned() external {
        dishonestWork.renounceOwnership();
        honestWork.mint(address(0x113), 1);
        vm.startPrank(address(0x113));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        dishonestWork.takeAVacation(1);
        vm.stopPrank();
        vm.expectRevert("You are not the owner");
        dishonestWork.backToWork(1);
    }

    function testEndYourBeefUnowned() external {
        dishonestWork.renounceOwnership();
        honestWork.mint(address(0x113), 1);
        vm.startPrank(address(0x113));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        dishonestWork.startABeef(1);
        vm.stopPrank();
        vm.expectRevert("You are not the owner");
        dishonestWork.endYourBeef(1);
    }

    function testSayGoodbyeToBabeUnowned() external {
        dishonestWork.renounceOwnership();
        honestWork.mint(address(0x113), 1);
        vm.startPrank(address(0x113));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        dishonestWork.callABabe(1);
        vm.stopPrank();
        vm.expectRevert("You are not the owner");
        dishonestWork.sayGoodbyeToBabe(1);
    }

    function testGoToDoctorHealDeafUnowned() external {
        dishonestWork.renounceOwnership();
        honestWork.mint(address(0x113), 1);
        vm.startPrank(address(0x113));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        dishonestWork.goRaveTurnDeaf(1);
        vm.stopPrank();
        vm.expectRevert("You are not the owner");
        dishonestWork.goToDoctorHealDeaf(1);
    }

    function testShotAdrenalineNoMoreDeadUnowned() external {
        dishonestWork.renounceOwnership();
        honestWork.mint(address(0x113), 1);
        vm.startPrank(address(0x113));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        dishonestWork.overdoseAndGoDead(1);
        vm.stopPrank();
        vm.expectRevert("You are not the owner");
        dishonestWork.shotAdrenalineNoMoreDead(1);
    }

    function testTurnBackWithAHappyFaceUnowned() external {
        dishonestWork.renounceOwnership();
        honestWork.mint(address(0x113), 1);
        vm.startPrank(address(0x113));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        dishonestWork.faceYourFears(1);
        vm.stopPrank();
        vm.expectRevert("You are not the owner");
        dishonestWork.turnBackWithAHappyFace(1);
    }

    function testReturnHomeToFeedYourHeadUnowned() external {
        dishonestWork.renounceOwnership();
        honestWork.mint(address(0x113), 1);
        vm.startPrank(address(0x113));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        dishonestWork.goToAFancyRestaurantFeedYourself(1);
        vm.stopPrank();
        vm.expectRevert("You are not the owner");
        dishonestWork.returnHomeToFeedYourHead(1);
    }

    function testReturnFromFedsWithWitnessProtectionUnowned() external {
        dishonestWork.renounceOwnership();
        honestWork.mint(address(0x113), 1);
        vm.startPrank(address(0x113));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        dishonestWork.snitchToFeds(1);
        vm.stopPrank();
        vm.expectRevert("You are not the owner");
        dishonestWork.returnFromFedsWithWitnessProtection(1);
    }

    function testPutAMiladyPfpNoMoreBadUnowned() external {
        dishonestWork.renounceOwnership();
        honestWork.mint(address(0x113), 1);
        vm.startPrank(address(0x113));
        honestWork.setApprovalForAll(address(dishonestWork), true);
        dishonestWork.shillScamTokenToYourFriendsBeBad(1);
        vm.stopPrank();
        vm.expectRevert("You are not the owner");
        dishonestWork.putAMiladyPfpNoMoreBad(1);
    }

    /*//////////////////////////////////////////////////////////////
                         ADMIN WITHDRAW CHECKS
    //////////////////////////////////////////////////////////////*/

    function testWithdrawEthAdmin() external {
        vm.deal(address(dishonestWork), 1 ether);
        vm.deal(withdrawAddress, 1 ether);
        vm.prank(withdrawAddress);
        dishonestWork.withdrawEth();
        assertEq(withdrawAddress.balance, 2 ether);
    }

    function testWithdrawEthNonAdmin() external {
        vm.prank(address(0xdeadbeef));
        vm.expectRevert("Only withdraw address");
        dishonestWork.withdrawEth();
    }

    function testWithdrawErc20Admin() external {
        ExampleERC20 erc20 = new ExampleERC20();
        erc20.mint(address(dishonestWork), 100);
        vm.prank(withdrawAddress);
        dishonestWork.withdrawErc20(IERC20(address(erc20)));
        assertEq(erc20.balanceOf(address(dishonestWork)), 0);
        assertEq(erc20.balanceOf(withdrawAddress), 100);
    }

    function testWithdrawErc20NonAdmin() external {
        ExampleERC20 erc20 = new ExampleERC20();
        erc20.mint(address(dishonestWork), 100);
        vm.prank(address(0xdeadbeef));
        vm.expectRevert("Only withdraw address");
        dishonestWork.withdrawErc20(IERC20(address(erc20)));
    }

    function testWithdrawErc721Admin() external {
        ExampleERC721 erc721 = new ExampleERC721();
        erc721.mint(address(dishonestWork), 1);
        vm.prank(withdrawAddress);
        dishonestWork.withdrawErc721(erc721, 1);
        assertEq(erc721.ownerOf(1), withdrawAddress);
    }

    function testWithdrawErc721NonAdmin() external {
        ExampleERC721 erc721 = new ExampleERC721();
        erc721.mint(address(dishonestWork), 1);
        vm.prank(address(0xdeadbeef));
        vm.expectRevert("Only withdraw address");
        dishonestWork.withdrawErc721(erc721, 1);
    }

    function testWithdrawHonestWorkAdmin() external {
        dishonestWork.renounceOwnership();
        honestWork.mint(address(this), 1);
        dishonestWork.takeAVacation(1);
        vm.prank(withdrawAddress);
        vm.expectRevert("Owner exists");
        dishonestWork.withdrawErc721(honestWork, 1);
    }

    function testWithdrawHonestWorkOwnedNonAdmin() external {
        dishonestWork.renounceOwnership();
        honestWork.mint(address(this), 1);
        dishonestWork.takeAVacation(1);
        vm.expectRevert("Only withdraw address");
        vm.prank(address(this));
        dishonestWork.withdrawErc721(honestWork, 1);
    }

    /*//////////////////////////////////////////////////////////////
                         UTILITY FUNCTION TESTS
    //////////////////////////////////////////////////////////////*/

    function testGetAllDepositedTokens() external {
        dishonestWork.renounceOwnership();

        // Mint and deposit tokens to different addresses
        honestWork.mint(address(this), 1);
        honestWork.mint(address(this), 2);
        honestWork.mint(address(this), 3);

        dishonestWork.takeAVacation(1); // to contract
        dishonestWork.startABeef(2); // to beef
        dishonestWork.callABabe(3); // to babe

        uint256[] memory allTokens = dishonestWork.getAllDepositedTokens();

        // Should have 3 tokens
        assertEq(allTokens.length, 3);

        // Verify the tokens are in the returned array
        bool found1 = false;
        bool found2 = false;
        bool found3 = false;

        for (uint256 i = 0; i < allTokens.length; i++) {
            if (allTokens[i] == 1) found1 = true;
            if (allTokens[i] == 2) found2 = true;
            if (allTokens[i] == 3) found3 = true;
        }

        assertTrue(found1 && found2 && found3, "Not all deposited tokens were returned");
    }

    function testGetDepositedTokensForUser() external {
        dishonestWork.renounceOwnership();

        // Setup test with multiple users
        address user1 = address(this);
        address user2 = address(0x123);

        // Mint tokens to both users
        honestWork.mint(user1, 1);
        honestWork.mint(user1, 2);
        honestWork.mint(user2, 3);

        // User1 deposits their tokens
        dishonestWork.takeAVacation(1);
        dishonestWork.startABeef(2);

        // User2 deposits their token
        vm.startPrank(user2);
        honestWork.setApprovalForAll(address(dishonestWork), true);
        dishonestWork.callABabe(3);
        vm.stopPrank();

        // Check user1's deposited tokens
        uint256[] memory user1Tokens = dishonestWork.getDepositedTokens(user1);
        assertEq(user1Tokens.length, 2);

        bool found1 = false;
        bool found2 = false;

        for (uint256 i = 0; i < user1Tokens.length; i++) {
            if (user1Tokens[i] == 1) found1 = true;
            if (user1Tokens[i] == 2) found2 = true;
        }

        assertTrue(found1 && found2, "Not all user1 tokens were returned");

        // Check user2's deposited tokens
        uint256[] memory user2Tokens = dishonestWork.getDepositedTokens(user2);
        assertEq(user2Tokens.length, 1);
        assertEq(user2Tokens[0], 3);
    }

    function testGetDepositedTokensEmptyForNonUser() external {
        dishonestWork.renounceOwnership();

        // Check tokens for an address that hasn't deposited anything
        uint256[] memory tokens = dishonestWork.getDepositedTokens(address(0xdead));
        assertEq(tokens.length, 0);
    }

    function testGetAllDepositedTokensAfterWithdraw() external {
        dishonestWork.renounceOwnership();

        // Deposit and then withdraw tokens
        honestWork.mint(address(this), 1);
        dishonestWork.takeAVacation(1);
        dishonestWork.backToWork(1);

        uint256[] memory allTokens = dishonestWork.getAllDepositedTokens();
        assertEq(allTokens.length, 0, "Should have no tokens after withdrawal");
    }

    function testSetWithdrawAddressFromNonWithdrawAddress() external {
        vm.prank(address(0xdead));
        vm.expectRevert("Only withdraw address");
        dishonestWork.setWithdrawAddress(address(0x1337));
    }

    function testSetAddressesAfterRenounce() external {
        dishonestWork.renounceOwnership();
        vm.expectPartialRevert(Ownable.OwnableUnauthorizedAccount.selector);
        dishonestWork.setAddresses(
            address(0x1),
            address(0x2),
            address(0x3),
            address(0x4),
            address(0x5),
            address(0x6),
            address(0x7),
            address(0x8)
        );
    }

    function testTokenDepositedEventEmission() external {
        dishonestWork.renounceOwnership();
        vm.expectEmit(true, true, true, true);
        emit DishonestWork.TokenDeposited(0, address(this), address(dishonestWork));
        dishonestWork.takeAVacation(0);
    }

    function testTokenWithdrawnEventEmission() external {
        dishonestWork.renounceOwnership();
        dishonestWork.takeAVacation(0);
        vm.expectEmit(true, true, true, true);
        emit DishonestWork.TokenWithdrawn(0, address(this), address(dishonestWork));
        dishonestWork.backToWork(0);
    }

    function testDirectETHTransferFails() external {
        vm.expectRevert("You can't send ETH to this contract!");
        assembly {
            pop(call(gas(), dishonestWork.slot, 1000000000000000000, 0, 0, 0, 0))
        }
    }

    function testETHTransferFromVaultWorks() external {
        vm.deal(address(mockVault), 1 ether);
        vm.prank(address(mockVault));
        (bool success,) = address(dishonestWork).call{ value: 1 ether }("");
        assertTrue(success);
    }

    /*//////////////////////////////////////////////////////////////
                    UTILITY FUNCTION EDGE CASES
    //////////////////////////////////////////////////////////////*/

    function testGetDepositedTokensWithDuplicateDeposits() external {
        dishonestWork.renounceOwnership();

        // Mint tokens
        honestWork.mint(address(this), 1);

        // Try different deposit methods for the same token
        dishonestWork.takeAVacation(1);
        dishonestWork.backToWork(1);
        dishonestWork.startABeef(1);
        dishonestWork.endYourBeef(1);
        dishonestWork.callABabe(1);

        // Get deposited tokens
        uint256[] memory tokens = dishonestWork.getDepositedTokens(address(this));

        // Should only count the last deposit
        assertEq(tokens.length, 1);
        assertEq(tokens[0], 1);
        assertEq(honestWork.ownerOf(1), dishonestWork.babe());
    }

    function testGetAllDepositedTokensWithMaxTokens() external {
        dishonestWork.renounceOwnership();
        uint256 numTokens = 100; // Large enough to test array handling but not too gas intensive

        // Mint and deposit many tokens starting from ID 1
        for (uint256 i = 1; i <= numTokens; i++) {
            honestWork.mint(address(this), i);
            if (i % 8 == 0) dishonestWork.takeAVacation(i);
            else if (i % 8 == 1) dishonestWork.startABeef(i);
            else if (i % 8 == 2) dishonestWork.callABabe(i);
            else if (i % 8 == 3) dishonestWork.goRaveTurnDeaf(i);
            else if (i % 8 == 4) dishonestWork.overdoseAndGoDead(i);
            else if (i % 8 == 5) dishonestWork.faceYourFears(i);
            else if (i % 8 == 6) dishonestWork.goToAFancyRestaurantFeedYourself(i);
            else dishonestWork.snitchToFeds(i);
        }

        // Get all deposited tokens
        uint256[] memory allTokens = dishonestWork.getAllDepositedTokens();

        // Verify length
        assertEq(allTokens.length, numTokens);

        // Verify all tokens are present
        bool[] memory found = new bool[](numTokens + 1); // +1 to account for 1-based indexing
        for (uint256 i = 0; i < allTokens.length; i++) {
            uint256 tokenId = allTokens[i];
            require(!found[tokenId], "Duplicate token found");
            found[tokenId] = true;
        }

        // Verify all tokens were found
        for (uint256 i = 1; i <= numTokens; i++) {
            assertTrue(found[i], "Token not found in returned array");
        }
    }

    /*//////////////////////////////////////////////////////////////
                    CONCURRENT OPERATIONS TESTS
    //////////////////////////////////////////////////////////////*/

    function testConcurrentDepositsAndWithdraws() external {
        dishonestWork.renounceOwnership();

        // Setup multiple users
        address[] memory users = new address[](5);
        users[0] = address(0x1);
        users[1] = address(0x2);
        users[2] = address(0x3);
        users[3] = address(0x4);
        users[4] = address(0x5);

        // Mint tokens to users starting from ID 1
        for (uint256 i = 0; i < users.length; i++) {
            honestWork.mint(users[i], i + 1); // Changed to i + 1
            vm.startPrank(users[i]);
            honestWork.setApprovalForAll(address(dishonestWork), true);
            vm.stopPrank();
        }

        // Concurrent deposits (using token IDs 1-5)
        vm.startPrank(users[0]);
        dishonestWork.takeAVacation(1);
        vm.stopPrank();

        vm.startPrank(users[1]);
        dishonestWork.startABeef(2);
        vm.stopPrank();

        vm.startPrank(users[2]);
        dishonestWork.callABabe(3);
        vm.stopPrank();

        vm.startPrank(users[3]);
        dishonestWork.goRaveTurnDeaf(4);
        vm.stopPrank();

        vm.startPrank(users[4]);
        dishonestWork.overdoseAndGoDead(5);
        vm.stopPrank();

        // Verify all deposits
        assertEq(honestWork.ownerOf(1), address(dishonestWork));
        assertEq(honestWork.ownerOf(2), dishonestWork.beef());
        assertEq(honestWork.ownerOf(3), dishonestWork.babe());
        assertEq(honestWork.ownerOf(4), dishonestWork.deaf());
        assertEq(honestWork.ownerOf(5), dishonestWork.dead());

        // Concurrent withdrawals
        vm.startPrank(users[0]);
        dishonestWork.backToWork(1);
        vm.stopPrank();

        vm.startPrank(users[1]);
        dishonestWork.endYourBeef(2);
        vm.stopPrank();

        vm.startPrank(users[2]);
        dishonestWork.sayGoodbyeToBabe(3);
        vm.stopPrank();

        vm.startPrank(users[3]);
        dishonestWork.goToDoctorHealDeaf(4);
        vm.stopPrank();

        vm.startPrank(users[4]);
        dishonestWork.shotAdrenalineNoMoreDead(5);
        vm.stopPrank();

        // Verify all withdrawals
        assertEq(honestWork.ownerOf(1), users[0]);
        assertEq(honestWork.ownerOf(2), users[1]);
        assertEq(honestWork.ownerOf(3), users[2]);
        assertEq(honestWork.ownerOf(4), users[3]);
        assertEq(honestWork.ownerOf(5), users[4]);

        // Verify token mappings are cleared
        uint256[] memory allTokens = dishonestWork.getAllDepositedTokens();
        assertEq(allTokens.length, 0, "Not all tokens were withdrawn");

        // Check individual user deposits are cleared
        for (uint256 i = 0; i < users.length; i++) {
            uint256[] memory userTokens = dishonestWork.getDepositedTokens(users[i]);
            assertEq(userTokens.length, 0, "User still has deposited tokens");
        }
    }
}
