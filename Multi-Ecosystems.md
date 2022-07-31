# User Guide
## Deployment

Flow to Rinkeby

```
# Mint Duanji
flow transactions send ./transactions/createNFT/registerPunster.cdc "I'm punster" "https://raw.githubusercontent.com/wuyahuang/opensea/main/1"

flow transactions send ./transactions/createNFT/publishDuanji.cdc "I found the dog is so funny" "https://raw.githubusercontent.com/wuyahuang/opensea/main/1"

# Tranfer Duanji to locker
flow transactions send ./transactions/CrossChainNFT/sendDuanji2Opensea.cdc 0x70e730a085eb1437b29c36d615c78648ef8be1bc19688b437ecbc1cf89b8b217 0x71Fa7558e22Ba5265a1e9069dcd2be7c6735BE23 1  

# Claim Duanji on Rinkeby testnet
node client/crosschain/ethereumClaim.js 1 044cecaa8c944515dfc8bbab90c34a5973e75f60015bfa2af985176c33a91217
```

Rinkeby to Flow
```
# Lock Rinkeby NFT
node client/nft/lockOpenseaDuanji.mjs 1 0x70e730a085eb1437b29c36d615c78648ef8be1bc19688b437ecbc1cf89b8b217

# Claim NFT on Flow
node client/crosschain/flowClaim.js 1 044cecaa8c944515dfc8bbab90c34a5973e75f60015bfa2af985176c33a91217

# Burn NFT on Rinkeby
node client/crosschain/burnRinkebyNFT.js 1
```

#### Check NFT on Opensea browser

Wait for some time...You can see new NFT below:
```
https://testnets.opensea.io/assets?search[query]=0x2FeB2eCe306d6DeCc6a3f87CF23aDcE60D081Da2&search[resultModel]=ASSETS
```

Made with ❤️ in Singapore
