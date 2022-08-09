# User Guide
## Deployment
* Contract defination address: `0x1a478a7149935b63`

## Usage
### Prepare(Can be ignored)
* Prepare your test account on Rinkeby
* Add a .secret file in ./client/crosschain and put your private key in it, just like [./multi-ecosystem/client/crosschain/.secret-example](./multi-ecosystem/client/crosschain/.secret-example) does   

```sh
# Register `Punster` and publish `Duanji`. This can be ignored if registering `Punster` and publishing `Duanji` have already happened through our website http://punster.stonelens.com/
flow transactions send ./transaction/registerPunster.cdc "I'm punster xxx" <Real IPFS URL>

flow transactions send ./transaction/publishDuanji.cdc "I found the dog is so funny" <Real IPFS URL>

# Query NFT on Flow
flow scripts execute ./scripts/queryDuanjiFrom.cdc <address on Flow> -n testnet
```

### Flow to Rinkeby
* Note that the `receiver address on Rinkeby` below is related to your private key in "`.secret`" added in [prepare](#preparecan-be-ignored)

```sh
# Go to work dictionary
cd multi-ecosystem

# Tranfer Duanji to locker. 
flow transactions send ./transactions/CrossChainNFT/sendDuanji2Opensea.cdc <hash lock question> <receiver address on Rinkeby> <Duanji id> --signer <Duanji Owner on Flow> -n testnet
# Example
flow transactions send ./transactions/CrossChainNFT/sendDuanji2Opensea.cdc 0x70e730a085eb1437b29c36d615c78648ef8be1bc19688b437ecbc1cf89b8b217 0x71Fa7558e22Ba5265a1e9069dcd2be7c6735BE23 21 --signer testnet-Frank -n testnet

# Claim Duanji on Rinkeby testnet
node client/crosschain/ethereumClaim.js <id> <hash lock answer>
# Example
node client/crosschain/ethereumClaim.js 21 044cecaa8c944515dfc8bbab90c34a5973e75f60015bfa2af985176c33a91217
```

### Rinkeby to Flow
```sh
# Lock Rinkeby NFT
node client/nft/lockOpenseaDuanji.mjs <id> <hash lock question> <receiver address on target Chain (here it is Flow)>
# Example
node client/nft/lockOpenseaDuanji.mjs 21 0x70e730a085eb1437b29c36d615c78648ef8be1bc19688b437ecbc1cf89b8b217 0x3c03aba355023006


# Claim NFT on Flow
node client/crosschain/flowClaim.js <id> <hash lock answer> --signer <any account on Flow> -n testnet
# Example
node client/crosschain/flowClaim.js 21 044cecaa8c944515dfc8bbab90c34a5973e75f60015bfa2af985176c33a91217 --signer testnet-Frank -n testnet

# Burn NFT on Rinkeby
node client/crosschain/burnRinkebyNFT.js <id>
# Example
node client/crosschain/burnRinkebyNFT.js 21
```


**Note that remember to burn NFT on Rinkeby mannually in this stage, or the NFT with the same id cannot be transferred to Rinkeby again.**  

### Check NFT on Opensea browser

Wait for some time...You can see new NFT below:
```
https://testnets.opensea.io/assets?search[query]=0x5818f70E7468e14a048B63E0211A1f4A5A4534e2&search[resultModel]=ASSETS
```

### Restart Flow emulator
* If use Flow emulator to make test and the emulator restarts, clear data queue on Rinkeby
```
node client/crosschain/clearDataQueue.mjs
```
* There will be some configtures to be setted, please contact us to get details.

## Contact
* [Link](https://linktr.ee/dantenetwork)
