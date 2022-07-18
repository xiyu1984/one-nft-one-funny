# PunStar
# Introduction
PunStar is a social platform for funny things. People participating in `PunStar` are called `Punster`, who can share their funny things in the form of `Duanji`. `Punsters` can construct social relationships by...
## Highlights
* Assetization of social relationships  
We have built a following mechanism to ... So the social relationship is constructed by ...
* Assetization of funny things  
We have built a funny index mechanism to ...
* Assets in PunStar can be Omnichain swaped



## Background
- Target audience
- Evidence for the need

## Solution
### Product  
If one person thinks someother `punsters` are interesting, he can `follow` them to get the newest information as soon as the followed `punsters` publishing any updates.  
If one person likes a `Duanji`, he can `commend` it, so that, the "Funny Index" of the `Duanji` will be increased, and the related `punster` who punlished the `Duanji`.
### Technology Architecture
### Logo
### Marketing

# Programming in Web3 Jam
*Cadence Smart Contract*

- [x] NFT standard smart contract for `Duanji`
- [x] NFT smart contract for `Punster`
- [x] The following mechanism between `Punsters`
- [x] The commend mechanism for `Duanji` by `Punsters`
- [x] The funny index mechanism for `Duanji` and `Punsters`
- [x] The multi-chain swap and trading system(Flow and opensea on Rinkeby)

*Client*

- [x] Personal show page with related account(following `punsters`, `duanji`, recommended `duanji` with high funny index, etc.)
- [x] Social relationship based on following mechanism 
- [x] NFT cross-chain bridge betweed Flow and opensea(Rinkeby)

## 团队成员

| 姓名 Name | 角色 Role     | 个人经历 Bio | 联系方式 Contact     |
| ---- | ------------------- | --- | ----------------------- |
| Alex | Full-Stack Engineer | ... | Github账号 / 微信 / 邮件  |

# API for Developers
The transactions and scripts to invoke resource operations and query resource statements are as follows:

## Transactions
The deployed address on Testnet is: *0x05ede3f803407aae* 

### [Register `Punster`](./transaction/RegisterPunster.cdc)
The related `Flow CLI` is as follow: 
```sh
flow transactions send ./transaction/RegisterPunster.cdc "I'm a funny punster!" "Punster Alice's ipfs url" --signer <signer-account-info> -n testnet
```
* The first parameter `"I'm a funny punster!"` is `description`
* The second parameter `"Punster Alice's ipfs url"` is `ipfsURL`
* Every account can only invoke `register` once

### [Publish `Duanji`](./transaction/PublishDuanji.cdc)
The related `Flow CLI` is as follow:
```sh
flow transactions send ./transaction/PublishDuanji.cdc "I found the dog is so funny!" "ipfs uri 2 is defined" --signer <signer-account-info> -n testnet
```
* The first parameter `"I found the dog is so funny!"` is `discription`
* The second parameter `"ipfs uri 2 is defined"` is `ipfsURL`

### [Commend to `Duanji`](./transaction/CommendTo.cdc)
The related `Flow CLI` is as follow:
```sh
flow transactions send ./transaction/CommendTo.cdc 0x05ede3f803407aae 3 --signer <signer-account-info> -n testnet
```
* The first parameter`0x05ede3f803407aae` is the owner address
* The second parameter `3` is the id of duanji 

### [Cancel commend to `Duanji`](./transaction/CancelCommendTo.cdc)
The related `Flow CLI` is as follow:
```sh
flow transactions send ./transaction/CancelCommendTo.cdc 0x05ede3f803407aae 3 --signer <signer-account-info> -n testnet
```
* The first parameter`0x05ede3f803407aae` is the owner address
* The second parameter `3` is the id of duanji 

### [Follow to someone](./transaction/followTo.cdc)
The related `Flow CLI` is as follow:
```sh
flow transactions send ./transaction/followTo.cdc 0x05ede3f803407aae --signer <signer-account-info> -n testnet
```
* The first parameter `0x05ede3f803407aae` is the account to follow

### [Unfollow to someone](./transaction/unfollowTo.cdc)
The related `Flow CLI` is as follow:
```sh
flow transactions send ./transaction/unfollowTo.cdc 0x05ede3f803407aae --signer <signer-account-info> -n testnet
```
* * The first parameter `0x05ede3f803407aae` is the account to unfollow

### [Clear following updates](./transaction/clearUpdates.cdc)
The related `Flow CLI` is as follow:
```sh
flow transactions send ./transaction/clearUpdates.cdc --signer <signer-account-info> -n testnet
```
* Every following's update(publish new `duanji`) will be temporarily stored by his followers. But punsters can chose to clear this cache with this transaction.

## Scripts
### [query all 'duanji' from a Address](./scripts/queryDuanjiFrom.cdc)
The related `Flow CLI` is as follow:
```sh
flow scripts execute ./scripts/queryDuanjiFrom.cdc 0x33a8abe2196c9e15 -n testnet
```
* The first parameter `0x33a8abe2196c9e15` is the address of a punster

### [query Punster funny index](./scripts/getPunsterFI.cdc)
The related `Flow CLI` is as follow:
```sh
flow scripts execute ./scripts/getPunsterFI.cdc 0x05ede3f803407aae -n testnet
```
* The first parameter `0x33a8abe2196c9e15` is the address of a punster

### [query duanji funny index](./scripts/getDuanjiFI.cdc)
The related `Flow CLI` is as follow:
```sh
flow scripts execute ./scripts/getDuanjiFI.cdc 0x05ede3f803407aae 3 -n testnet
```
* The first parameter `0x33a8abe2196c9e15` is the address of a punster
* The second parameter `3` is the id of a duanji

### [query followers](./scripts/getFollowers.cdc)
The related `Flow CLI` is as follow:
```sh
flow scripts execute ./scripts/getFollowers.cdc 0x05ede3f803407aae -n testnet
```
* The first parameter `0x33a8abe2196c9e15` is the address of a punster

### [query followings](./scripts/getFollowings.cdc)
The related `Flow CLI` is as follow:
```sh
flow scripts execute ./scripts/getFollowings.cdc 0x33a8abe2196c9e15 -n testnet
```
* The first parameter `0x33a8abe2196c9e15` is the address of a punster

### [query following duanji updates](./scripts/getFollowingUpdates.cdc)
The related `Flow CLI` is as follow:
```sh
flow scripts execute ./scripts/getFollowingUpdates.cdc 0x33a8abe2196c9e15 -n testnet
```
* The first parameter `0x33a8abe2196c9e15` is the address of a punster
* You can get the duanji information in one punster's following update cache, which is mentioned in [Clear following updates](#clear-following-updates)
