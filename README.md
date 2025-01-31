# Dishonest Work

A helper smart contract for [Honest Work by @0xShiroi](https://honestwork.0xfff.love/) made by
[Yigit Duman](https://twitter.com/YigitDuman).

## Deployed Addresses:

**Ethereum Mainnet:**
[0x943B541B49274Eb8845DC9BE200151289E5b820D](https://etherscan.io/address/0x943B541B49274Eb8845DC9BE200151289E5b820D)

**Sepolia Testnet:**
[0x3259577885133126E9576Dc9a8ddD5E244c7367C](https://sepolia.etherscan.io/address/0x3259577885133126E9576Dc9a8ddD5E244c7367C)

## Depositor Addresses
### Mainnet

**Beef:** 0x9CC6A8c2EaAF02CCa1658292A1d61bEA7cd8beeF

**Babe:** 0xC9bf4C27d176c20CF764f941958C7efAF620baBe

**Deaf:** 0xCbC21f36a54259181F96006dF40Ac058449FDeaF

**Dead:** 0x9E9a0B924781A60bd390FbfBfBB8f9F1224cDeAD

**Face:** 0xBc5B7da70BBA7110CEf353d26C333fd40A3dfaCE

**Feed:** 0xB2f73E133E3980B824b35e4b074b33983057FeeD

**Fed:** 0xc845BD631dE4d609Bba39B32dA2549a997243fED

**Bad:** 0x390F47Deb85b789B1297137C2DA41b8556ddEbAD

### Sepolia

**Beef:** 0x65fBfA0F880F1BF53933174EEFDCDE92567eBEeF

**Babe:** 0xD545b4b86115F3245cBc4bF8cfBaB99B6ecdbAbE

**Deaf:** 0x93A688E3dd60121b6Cbc941008858Bf39b33DeaF

**Dead:** 0xCA2d8A26ed0D2Caca892fD1B63B5dfE8d34DdEAD

**Face:** 0xA793C633ECAc90Dc9F0b10eA6279AA90B25FFaCe

**Feed:** 0x3534da01447E0be8E847C71B87baff590Ee5fEed

**Fed:** 0x7d0e5333684872A4412650891474ad5185309feD

**Bad:** 0xF193531511609E7E4Ae47a3fa71bdB029c146bad

## Deployment

1. First, update the addresses on script/Deploy.s.sol, script/DeployDepositor.s.sol and script/CalculateInitCodeHash.s.sol files.
2. Update the caller address in script/generate_salts.py from 0x28996f7DECe7E058EBfC56dFa9371825fBfa515A to your
   deployer address.
3. `forge script script/Deploy.s.sol --rpc-url sepolia --broadcast --verify`
4. `forge script script/DeployDepositor.s.sol --rpc-url sepolia --broadcast --verify`

## How to Mine Vanity Addresses?

`forge script script/CalculateInitCodeHash.s.sol | grep "initCodeHash: " | awk '{print $3}' | xargs -I {} cast create2 --caller 0x28996f7DECe7E058EBfC56dFa9371825fBfa515A --init-code-hash {} --ends-with beef`
