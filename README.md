# Dishonest Work

A helper smart contract for [Honest Work by @0xShiroi](https://honestwork.0xfff.love/) made by
[Yigit Duman](https://twitter.com/YigitDuman).

## Deployed Addresses:

**Ethereum Mainnet:**
[0x123EA2287adb6Cc4AFb55a6592C1702aC93409CE](https://etherscan.io/address/0x123EA2287adb6Cc4AFb55a6592C1702aC93409CE)

**Sepolia Testnet:**
[0xCE409eBe4dC1933cf36b8025d23B4f5D698EB0A3](https://sepolia.etherscan.io/address/0xCE409eBe4dC1933cf36b8025d23B4f5D698EB0A3)

## Depositor Addresses

**Beef:** 0x0E33182AA44e67ADE0b7229a3BB8Da968BcDbEeF

**Babe:** 0x5AdC0a42e27D2d7F2E4282964cf80a49097bbaBe

**Deaf:** 0x69b8133cd92BbB35FD5866dDcC6F368007e6deAf

**Dead:** 0x905A443cF242B7E5d665c6Fe9f2d64dCd187dEaD

**Face:** 0x44178951eAd525DF1F7351a8100F393666A7FACE

**Feed:** 0x631E76CE66Ab8A670A96c8885330AE56038EfEed

**Fed:** 0x093F151550B79cf996205E413344642588D89FED

**Bad:** 0xCB87c79cAF66973E495A63Fa52806AAcE2237Bad

## Deployment

1. First, update the addresses on script/Deploy.s.sol and script/DeployDepositor.s.sol files.
2. Update the caller address in script/generate_salts.py from 0x28996f7DECe7E058EBfC56dFa9371825fBfa515A to your
   deployer address.
3. `forge script script/Deploy.s.sol --rpc-url sepolia --broadcast --verify`
4. `forge script script/DeployDepositor.s.sol --rpc-url sepolia --broadcast --verify`

## How to Mine Vanity Addresses?

`forge script script/CalculateInitCodeHash.s.sol | grep "initCodeHash: " | awk '{print $3}' | xargs -I {} cast create2 --caller 0x28996f7DECe7E058EBfC56dFa9371825fBfa515A --init-code-hash {} --ends-with beef`
