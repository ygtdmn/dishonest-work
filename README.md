# Dishonest Work

A helper smart contract for [Honest Work by @0xShiroi](https://honestwork.0xfff.love/) made by
[Yigit Duman](https://twitter.com/YigitDuman).

## Deployed Addresses:

**Ethereum Mainnet:**
[0x123EA2287adb6Cc4AFb55a6592C1702aC93409CE](https://etherscan.io/address/0x123EA2287adb6Cc4AFb55a6592C1702aC93409CE)

## Depositor Addresses

**Beef:** 0x8873A37f142694320259fd1C19dEB72Ca1FaBeEF

**Babe:** 0x45E8346cCaE1B07C4089e2Ec7126befe9bA0baBE

**Deaf:** 0x2073b7F273dFC2d76457986aE53f91977CC3deaf

**Dead:** 0x941A5eBCba1d71c81582723146cA859C0E11DeAD

**Face:** 0x8c45E474937A89419eB7aadf38202E32e666facE

**Feed:** 0xfb7F70cc9a3468573c2Daa7A0C98C15Bf0BafEeD

**Fed:** 0x5DfF4b9FC610a0fAAB68c03ed573f8AE4c201FEd

**Bad:** 0x4962B3F71c88C4611662A682EDf57766cef01bAd

## Deployment

`forge script script/Deploy.s.sol --rpc-url sepolia --broadcast --verify`
`forge script script/DeployDepositor.s.sol --rpc-url sepolia --broadcast --verify`

## How to Mine Vanity Addresses?

`forge script script/CalculateInitCodeHash.s.sol | grep "initCodeHash: " | awk '{print $3}' | xargs -I {} cast create2 --caller 0x28996f7DECe7E058EBfC56dFa9371825fBfa515A --init-code-hash {} --ends-with beef`
