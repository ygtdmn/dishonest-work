// SPDX-License-Identifier: MIT
pragma solidity >=0.8.25;

import "@balancer-labs/v2-interfaces/contracts/vault/IVault.sol";

contract MockVault is IVault {
    constructor() { }

    function getDomainSeparator() external view override returns (bytes32) { }

    function getNextNonce(address user) external view override returns (uint256) { }

    function getPausedState()
        external
        view
        override
        returns (bool paused, uint256 pauseWindowEndTime, uint256 bufferPeriodEndTime)
    { }

    function getActionId(bytes4 selector) external view override returns (bytes32) { }

    function getAuthorizer() external view override returns (IAuthorizer) { }

    function setAuthorizer(IAuthorizer newAuthorizer) external override { }

    function hasApprovedRelayer(address user, address relayer) external view override returns (bool) { }

    function setRelayerApproval(address sender, address relayer, bool approved) external override { }

    function getInternalBalance(
        address user,
        IERC20[] memory tokens
    )
        external
        view
        override
        returns (uint256[] memory)
    { }

    function manageUserBalance(UserBalanceOp[] memory ops) external payable override { }

    function registerPool(PoolSpecialization specialization) external override returns (bytes32) { }

    function getPool(bytes32 poolId) external view override returns (address, PoolSpecialization) { }

    function registerTokens(bytes32 poolId, IERC20[] memory tokens, address[] memory assetManagers) external override { }

    function deregisterTokens(bytes32 poolId, IERC20[] memory tokens) external override { }

    function getPoolTokenInfo(
        bytes32 poolId,
        IERC20 token
    )
        external
        view
        override
        returns (uint256 cash, uint256 managed, uint256 lastChangeBlock, address assetManager)
    { }

    function getPoolTokens(bytes32 poolId)
        external
        view
        override
        returns (IERC20[] memory tokens, uint256[] memory balances, uint256 lastChangeBlock)
    { }

    function joinPool(
        bytes32 poolId,
        address sender,
        address recipient,
        JoinPoolRequest memory request
    )
        external
        payable
        override
    { }

    function exitPool(
        bytes32 poolId,
        address sender,
        address payable recipient,
        ExitPoolRequest memory request
    )
        external
        override
    { }

    function swap(
        SingleSwap memory singleSwap,
        FundManagement memory funds,
        uint256 limit,
        uint256 deadline
    )
        external
        payable
        override
        returns (uint256)
    { }

    function batchSwap(
        SwapKind kind,
        BatchSwapStep[] memory swaps,
        IAsset[] memory assets,
        FundManagement memory funds,
        int256[] memory limits,
        uint256 deadline
    )
        external
        payable
        override
        returns (int256[] memory)
    { }

    function queryBatchSwap(
        SwapKind kind,
        BatchSwapStep[] memory swaps,
        IAsset[] memory assets,
        FundManagement memory funds
    )
        external
        override
        returns (int256[] memory assetDeltas)
    { }

    function flashLoan(
        IFlashLoanRecipient recipient,
        IERC20[] memory tokens,
        uint256[] memory amounts,
        bytes memory userData
    )
        external
        override
    { }

    function managePoolBalance(PoolBalanceOp[] memory ops) external override { }

    function getProtocolFeesCollector() external view override returns (IProtocolFeesCollector) { }

    function setPaused(bool paused) external override { }

    function WETH() external pure override returns (IWETH) {
        return IWETH(0x1234567890123456789012345678901234567890);
    }
}
