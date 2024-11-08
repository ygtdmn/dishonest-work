// SPDX-License-Identifier: MIT
pragma solidity >=0.8.27;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@balancer-labs/v2-interfaces/contracts/vault/IVault.sol";
import "@balancer-labs/v2-interfaces/contracts/vault/IFlashLoanRecipient.sol";
import "@balancer-labs/v2-interfaces/contracts/solidity-utils/misc/IWETH.sol";
import "./IHonestWork.sol";
/**
 * @title DishonestWork
 * @notice A helper smart contract to assist/cheat with Honest Work by @0xShiroi tasks.
 * @author Yigit Duman (@yigitduman)
 * @custom:version v5
 * @custom:changelog Added utility functions to aid off-chain tools, added events, updated documentation.
 */

contract DishonestWork is Ownable(msg.sender), IFlashLoanRecipient {
    IHonestWork public honestWork;
    IWETH public weth;

    /// @notice Addresses for various deposit locations
    address public beef;
    address public babe;
    address public deaf;
    address public dead;
    address public face;
    address public feed;
    address public fed;
    address public bad;

    /// @notice Address that can withdraw orphaned assets
    /// @dev Can only withdraw assets with no associated owner
    address public withdrawAddress;

    /// @notice Balancer vault interface for flashloans
    IVault private vault;

    /// @notice Mapping of token IDs to their original depositors
    /// @dev Used to track ownership for withdrawal permissions
    mapping(uint256 => address) public ownerMap;

    /**
     * @notice Modifier to restrict access to withdraw address
     * @dev Used for emergency withdrawal functions and withdraw address management
     */
    modifier onlyWithdrawAddress() {
        require(msg.sender == withdrawAddress, "Only withdraw address");
        _;
    }

    /*//////////////////////////////////////////////////////////////
                              EVENTS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Emitted when a deposit is made to any special address
     * @param tokenId The ID of the deposited token
     * @param depositor The address that deposited the token
     * @param destination The address where the token was deposited
     */
    event TokenDeposited(uint256 indexed tokenId, address indexed depositor, address indexed destination);

    /**
     * @notice Emitted when a withdrawal is made from any special address
     * @param tokenId The ID of the withdrawn token
     * @param withdrawer The address that withdrew the token
     * @param source The address from where the token was withdrawn
     */
    event TokenWithdrawn(uint256 indexed tokenId, address indexed withdrawer, address indexed source);

    /*//////////////////////////////////////////////////////////////
                           INITIALIZATION
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Initializes the contract with required addresses
     * @param _honestWork Address of the HonestWork contract
     * @param _withdrawAddress Address that can withdraw orphaned assets
     * @param _vault Address of the Balancer vault for flashloans
     */
    constructor(IHonestWork _honestWork, address _withdrawAddress, address _vault) {
        require(address(_honestWork) != address(0), "Invalid HonestWork address");
        require(_withdrawAddress != address(0), "Invalid withdraw address");
        require(_vault != address(0), "Invalid vault address");

        honestWork = _honestWork;
        withdrawAddress = _withdrawAddress;
        vault = IVault(_vault);
        weth = vault.WETH();
    }

    /*//////////////////////////////////////////////////////////////
                           INTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Internal function to deposit an Honest Work token to a specific address
     * @dev Only works after ownership is renounced to prevent unauthorized deposits
     * @param tokenId ID of the token to deposit
     * @param destination Target address for the deposit
     * @param msgSender Address of the sender
     * @custom:security Requires ownership renouncement
     */
    function deposit(uint256 tokenId, address destination, address msgSender) internal {
        if (owner() != address(0)) {
            revert("Deposit functions do not work before ownership is renounced");
        }

        honestWork.transferFrom(msgSender, destination, tokenId);
        ownerMap[tokenId] = msgSender;
        emit TokenDeposited(tokenId, msgSender, destination);
    }

    /**
     * @notice Internal function to withdraw Honest Work from a specific address
     * @dev Only original depositor can withdraw
     * @param tokenId ID of the token to withdraw
     * @param source Address to withdraw from
     * @param msgSender Address of the sender
     */
    function withdraw(uint256 tokenId, address source, address msgSender) internal {
        require(ownerMap[tokenId] == msgSender, "You are not the owner");
        honestWork.transferFrom(source, msgSender, tokenId);
        ownerMap[tokenId] = address(0);
        emit TokenWithdrawn(tokenId, msgSender, source);
    }

    /*//////////////////////////////////////////////////////////////
                           PUBLIC FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Deposits token to this contract
     * @param tokenId ID of the token to deposit
     */
    function takeAVacation(uint256 tokenId) external {
        deposit(tokenId, address(this), msg.sender);
    }

    /**
     * @notice Withdraws token previously deposited to this contract
     * @param tokenId ID of the token to withdraw
     */
    function backToWork(uint256 tokenId) external {
        withdraw(tokenId, address(this), msg.sender);
    }

    /**
     * @notice Deposits token to the beef address
     * @param tokenId ID of the token to deposit
     */
    function startABeef(uint256 tokenId) external {
        deposit(tokenId, beef, msg.sender);
    }

    /**
     * @notice Withdraws token from the beef address
     * @param tokenId ID of the token to withdraw
     */
    function endYourBeef(uint256 tokenId) external {
        withdraw(tokenId, beef, msg.sender);
    }

    /**
     * @notice Deposits token to the babe address
     * @param tokenId ID of the token to deposit
     */
    function callABabe(uint256 tokenId) external {
        deposit(tokenId, babe, msg.sender);
    }

    /**
     * @notice Withdraws token from the babe address
     * @param tokenId ID of the token to withdraw
     */
    function sayGoodbyeToBabe(uint256 tokenId) external {
        withdraw(tokenId, babe, msg.sender);
    }

    /**
     * @notice Deposits token to the deaf address
     * @param tokenId ID of the token to deposit
     */
    function goRaveTurnDeaf(uint256 tokenId) external {
        deposit(tokenId, deaf, msg.sender);
    }

    /**
     * @notice Withdraws token from the deaf address
     * @param tokenId ID of the token to withdraw
     */
    function goToDoctorHealDeaf(uint256 tokenId) external {
        withdraw(tokenId, deaf, msg.sender);
    }

    /**
     * @notice Deposits token to the dead address
     * @param tokenId ID of the token to deposit
     */
    function overdoseAndGoDead(uint256 tokenId) external {
        deposit(tokenId, dead, msg.sender);
    }

    /**
     * @notice Withdraws token from the dead address
     * @param tokenId ID of the token to withdraw
     */
    function shotAdrenalineNoMoreDead(uint256 tokenId) external {
        withdraw(tokenId, dead, msg.sender);
    }

    /**
     * @notice Deposits token to the face address
     * @param tokenId ID of the token to deposit
     */
    function faceYourFears(uint256 tokenId) external {
        deposit(tokenId, face, msg.sender);
    }

    /**
     * @notice Withdraws token from the face address
     * @param tokenId ID of the token to withdraw
     */
    function turnBackWithAHappyFace(uint256 tokenId) external {
        withdraw(tokenId, face, msg.sender);
    }

    /**
     * @notice Deposits token to the feed address
     * @param tokenId ID of the token to deposit
     */
    function goToAFancyRestaurantFeedYourself(uint256 tokenId) external {
        deposit(tokenId, feed, msg.sender);
    }

    /**
     * @notice Withdraws token from the feed address
     * @param tokenId ID of the token to withdraw
     */
    function returnHomeToFeedYourHead(uint256 tokenId) external {
        withdraw(tokenId, feed, msg.sender);
    }

    /**
     * @notice Deposits token to the fed address
     * @param tokenId ID of the token to deposit
     */
    function snitchToFeds(uint256 tokenId) external {
        deposit(tokenId, fed, msg.sender);
    }

    /**
     * @notice Withdraws token from the fed address
     * @param tokenId ID of the token to withdraw
     */
    function returnFromFedsWithWitnessProtection(uint256 tokenId) external {
        withdraw(tokenId, fed, msg.sender);
    }

    /**
     * @notice Deposits token to the bad address
     * @param tokenId ID of the token to deposit
     */
    function shillScamTokenToYourFriendsBeBad(uint256 tokenId) external {
        deposit(tokenId, bad, msg.sender);
    }

    /**
     * @notice Withdraws token from the bad address
     * @param tokenId ID of the token to withdraw
     */
    function putAMiladyPfpNoMoreBad(uint256 tokenId) external {
        withdraw(tokenId, bad, msg.sender);
    }

    /**
     * @notice Transfers token to a specific address with a random chance of success
     * @param probability Probability of success (0-100)
     * @param to Address to transfer the token to
     * @param tokenId ID of the token to transfer
     */
    function makeYourOwnLuck(uint256 probability, address to, uint256 tokenId) external {
        honestWork.transferFrom(msg.sender, to, tokenId);
        uint256 currentProbability = uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao))) % 100;
        if (currentProbability > probability) {
            revert("You are unlucky");
        }
    }

    /**
     * @notice Transfers token to a specific address
     * @param to Address to transfer the token to
     * @param tokenId ID of the token to transfer
     */
    function makeOriginNotSender(address to, uint256 tokenId) external {
        honestWork.transferFrom(msg.sender, to, tokenId);
    }

    /**
     * @notice Transfers token to this contract and then back to the sender
     * @param tokenId ID of the token to transfer
     */
    function sendToAnEmptyAddress(uint256 tokenId) external {
        honestWork.transferFrom(msg.sender, address(this), tokenId);
        honestWork.transferFrom(address(this), msg.sender, tokenId);
    }

    /**
     * @notice Transfers token a specific number of times
     * @dev You can also use this for TWICE_WITHIN_A_BLOCK and TO_CONTRACT tasks.
     * @param tokenId ID of the token to transfer
     * @param times Number of times to transfer the token
     */
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

    /**
     * @notice Transfers token to a specific address with a password
     * @param to Address to transfer the token to
     * @param tokenId ID of the token to transfer
     */
    function sendWithPassword(address to, uint256 tokenId) external {
        honestWork.safeTransferFrom(msg.sender, to, tokenId, abi.encodePacked("password"));
    }

    /*//////////////////////////////////////////////////////////////
                              FLASH LOANS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Performs a flashloan-assisted token transfer
     * @param tokenId ID of the token to transfer
     * @param ethAmount Amount of ETH to flashloan
     */
    function sendWithFakeRolex(uint256 tokenId, uint256 ethAmount) external {
        IERC20[] memory tokens = new IERC20[](1);
        tokens[0] = weth;
        uint256[] memory amounts = new uint256[](1);
        amounts[0] = ethAmount;
        bytes memory userData = abi.encode(msg.sender, tokenId);
        deposit(tokenId, address(this), msg.sender);
        vault.flashLoan(this, tokens, amounts, userData);
    }

    /**
     * @notice Callback function for Balancer flashloan
     * @dev Only callable by Balancer vault
     * @param amounts Array of amounts for each token
     * @param userData Encoded sender address and tokenId
     */
    function receiveFlashLoan(
        IERC20[] memory,
        uint256[] memory amounts,
        uint256[] memory,
        bytes memory userData
    )
        external
        override
    {
        require(msg.sender == address(vault));
        (address sender, uint256 tokenId) = abi.decode(userData, (address, uint256));
        weth.withdraw(amounts[0]);
        withdraw(tokenId, address(this), sender);
        weth.deposit{ value: amounts[0] }();
        weth.transfer(address(vault), amounts[0]);
    }

    /**
     * @dev Prevents direct ETH transfers except from vault or WETH
     */
    fallback() external {
        if (msg.sender != address(vault) && msg.sender != address(weth)) {
            revert("You can't send ETH to this contract!");
        }
    }

    /**
     * @dev Prevents direct ETH transfers except from vault or WETH
     */
    receive() external payable {
        if (msg.sender != address(vault) && msg.sender != address(weth)) {
            revert("You can't send ETH to this contract!");
        }
    }

    /*//////////////////////////////////////////////////////////////
                           OWNER FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Sets addresses for various deposit locations
     * @dev Only callable by contract owner
     * @param _beef Address for beef-related deposits
     * @param _babe Address for babe-related deposits
     * @param _deaf Address for deaf-related deposits
     * @param _dead Address for dead-related deposits
     * @param _face Address for face-related deposits
     * @param _feed Address for feed-related deposits
     * @param _fed Address for fed-related deposits
     * @param _bad Address for bad-related deposits
     */
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

    /**
     * @notice Updates the withdraw address
     * @dev Only callable by current withdraw address
     * @param _newAddress New address to set as withdraw address
     */
    function setWithdrawAddress(address _newAddress) external onlyWithdrawAddress {
        withdrawAddress = _newAddress;
    }

    /**
     * @notice Withdraws any ETH in the contract
     * @dev Only callable by withdraw address, emergency function
     */
    function withdrawEth() external onlyWithdrawAddress {
        payable(withdrawAddress).transfer(address(this).balance);
    }

    /**
     * @notice Withdraws any ERC20 tokens in the contract
     * @dev Only callable by withdraw address, emergency function
     * @param erc20 Address of the ERC20 token to withdraw
     */
    function withdrawErc20(IERC20 erc20) external onlyWithdrawAddress {
        erc20.transfer(withdrawAddress, erc20.balanceOf(address(this)));
    }

    /**
     * @notice Withdraws orphaned NFTs to the withdraw address
     * @dev Can only withdraw NFTs that have no associated owner
     * @param erc721 Address of the NFT contract
     * @param tokenId ID of the NFT to withdraw
     */
    function withdrawErc721(IERC721 erc721, uint256 tokenId) external onlyWithdrawAddress {
        if (erc721 == honestWork) {
            require(ownerMap[tokenId] == address(0), "Owner exists");
        }

        erc721.transferFrom(address(this), withdrawAddress, tokenId);
    }

    /*//////////////////////////////////////////////////////////////
                           UTILITY FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Returns all token IDs deposited to this contract and other special addresses
     * @dev This function is intended to be used off-chain and not optimized.
     * @return Array of all token IDs
     */
    function getAllDepositedTokens() public view returns (uint256[] memory) {
        uint256[] memory allTokensOfThis = honestWork.tokensOf(address(this));
        uint256[] memory allTokensOfBabe = honestWork.tokensOf(babe);
        uint256[] memory allTokensOfDeaf = honestWork.tokensOf(deaf);
        uint256[] memory allTokensOfDead = honestWork.tokensOf(dead);
        uint256[] memory allTokensOfFace = honestWork.tokensOf(face);
        uint256[] memory allTokensOfFeed = honestWork.tokensOf(feed);
        uint256[] memory allTokensOfFed = honestWork.tokensOf(fed);
        uint256[] memory allTokensOfBad = honestWork.tokensOf(bad);
        uint256[] memory allTokensOfBeef = honestWork.tokensOf(beef);

        uint256[] memory allTokens = new uint256[](
            allTokensOfThis.length + allTokensOfBabe.length + allTokensOfDeaf.length + allTokensOfDead.length
                + allTokensOfFace.length + allTokensOfFeed.length + allTokensOfFed.length + allTokensOfBad.length
                + allTokensOfBeef.length
        );
        uint256 index = 0;
        for (uint256 i = 0; i < allTokensOfThis.length; i++) {
            allTokens[index] = allTokensOfThis[i];
            index++;
        }
        for (uint256 i = 0; i < allTokensOfBabe.length; i++) {
            allTokens[index] = allTokensOfBabe[i];
            index++;
        }
        for (uint256 i = 0; i < allTokensOfDeaf.length; i++) {
            allTokens[index] = allTokensOfDeaf[i];
            index++;
        }
        for (uint256 i = 0; i < allTokensOfDead.length; i++) {
            allTokens[index] = allTokensOfDead[i];
            index++;
        }
        for (uint256 i = 0; i < allTokensOfFace.length; i++) {
            allTokens[index] = allTokensOfFace[i];
            index++;
        }
        for (uint256 i = 0; i < allTokensOfFeed.length; i++) {
            allTokens[index] = allTokensOfFeed[i];
            index++;
        }
        for (uint256 i = 0; i < allTokensOfFed.length; i++) {
            allTokens[index] = allTokensOfFed[i];
            index++;
        }
        for (uint256 i = 0; i < allTokensOfBad.length; i++) {
            allTokens[index] = allTokensOfBad[i];
            index++;
        }
        for (uint256 i = 0; i < allTokensOfBeef.length; i++) {
            allTokens[index] = allTokensOfBeef[i];
            index++;
        }
        return allTokens;
    }

    /**
     * @notice Returns all token IDs deposited to a specific address
     * @dev This function is intended to be used off-chain and not optimized.
     * @param user Address to check
     * @return Array of token IDs
     */
    function getDepositedTokens(address user) external view returns (uint256[] memory) {
        uint256[] memory allDepositedTokens = getAllDepositedTokens();

        // First count matching tokens
        uint256 count = 0;
        for (uint256 i = 0; i < allDepositedTokens.length; i++) {
            if (ownerMap[allDepositedTokens[i]] == user) {
                count++;
            }
        }

        // Create fixed-size array and populate it
        uint256[] memory depositedTokens = new uint256[](count);
        uint256 index = 0;
        for (uint256 i = 0; i < allDepositedTokens.length; i++) {
            if (ownerMap[allDepositedTokens[i]] == user) {
                depositedTokens[index] = allDepositedTokens[i];
                index++;
            }
        }
        return depositedTokens;
    }
}
