# User Guide
## Deployment
* Contract defination address: `0x1a478a7149935b63`

## Usage
### Prepare(Can be ignored)
```sh
# Register `Punster` and publish `Duanji`. This can be ignored if registering `Punster` and publishing `Duanji` have already happened through our website http://punster.stonelens.com/
flow transactions send ./transaction/registerPunster.cdc "I'm punster xxx" <Real IPFS URL>

flow transactions send ./transaction/publishDuanji.cdc "I found the dog is so funny" <Real IPFS URL>

# Query NFT on Flow
flow scripts execute ./scripts/queryDuanjiFrom.cdc 0xf8d6e0586b0a20c7
```

### Flow to Rinkeby
```sh
# Go to work dictionary
cd multi-ecosystem

# Tranfer Duanji to locker
flow transactions send ./transactions/CrossChainNFT/sendDuanji2Opensea.cdc 0x70e730a085eb1437b29c36d615c78648ef8be1bc19688b437ecbc1cf89b8b217 0x71Fa7558e22Ba5265a1e9069dcd2be7c6735BE23 1

# Claim Duanji on Rinkeby testnet
node client/crosschain/ethereumClaim.js 1 044cecaa8c944515dfc8bbab90c34a5973e75f60015bfa2af985176c33a91217
```

### Rinkeby to Flow
```sh
# Lock Rinkeby NFT
node client/nft/lockOpenseaDuanji.mjs 1 0x70e730a085eb1437b29c36d615c78648ef8be1bc19688b437ecbc1cf89b8b217 0x01cf0e2f2f715450

# Claim NFT on Flow
node client/crosschain/flowClaim.js 1 044cecaa8c944515dfc8bbab90c34a5973e75f60015bfa2af985176c33a91217

# Burn NFT on Rinkeby
node client/crosschain/burnRinkebyNFT.js 1
```

### Check NFT on Opensea browser

Wait for some time...You can see new NFT below:
```
https://testnets.opensea.io/assets?search[query]=0x5818f70E7468e14a048B63E0211A1f4A5A4534e2&search[resultModel]=ASSETS
```
### Restart Flow emulator
If emulator on Flow restarts, clear data queue on Rinkeby
```
node client/crosschain/clearDataQueue.mjs
```
