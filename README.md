# PunStar
# Introduction
PunStar is a social platform for funny things. People participating in `PunStar` are called `Punsters`(a NFT), who can share their funny things in the form of `Duanji`(a NFT). Each person can express their preference of a `Duanji`, which can inspire the social relationships to be constructed between participants. 

## Highlights
* **Assetization of social relationships**  
As we know, in resource-oriented cadence every things can be bound to each resource, so the resource can actually **have** its own abilities, such as its social relationships based on `following` mechanism. This is very different from the smart contract based chains where everything is published on smart contracts. Resource can be exchanged, so the bound abilities such as relationships can be exchanged too. This improves the potential value of the `Punster` NFT, as we can bring in advertisement mechanism in the future for example. `Punsters` with more followers might be more valuable. 

* **Assetization of funny things** 
As every participants can express their preference of a `Dunaji`, the funny index of a `Duanji` and `Punsters` can be evaluated, which may improve their market performance.

* Advertisement mechanism based on `funny index` evaluation  
`Punsters` can push advertisement to their followers if some special conditions are satisfied.

* Assets in PunStar can be exchanged cross-chain  
Interesting things should be shared to others.

## Background
- Target audience
- Evidence for the need

## Solution
### Product  
(need a picture to explain)
* People publish `Duanji` to share funny things.
* If one person thinks someother `punsters` are interesting, he can `follow` them to get the newest information as soon as the followed `punsters` publishing any updates.  
* If one person likes a `Duanji`, he can `commend` it, so that, the "Funny Index" of the `Duanji` will be increased, and the related `punster` who punlished the `Duanji`.
* Both `Duanji` and `Punster` are NFTs which can be exchanged between different participants.
* `Punsters` can push advertisement to their followers based on the `funny index`.

### Technology Architecture
(need a technical picture to explain)  
The key points of the technology are as follows:  
* `Following` mechanism can be implemented easily on Flow by resource interactions. 
* `Funny index` evaluation algorithm in `Commend` mechanism can make out an estimation of how funny a `Duanji` or a `Punster` is.
* Advertisement mechanism based on `funny index` of `Punsters`.
* A cross-chain trading market system.

### Logo
### Marketing

# Programming in Web3 Jam
*Cadence Smart Contract*

- [x] NFT standard smart contract for `Duanji`
- [x] NFT smart contract for `Punster`
- [x] The following mechanism between `Punsters`
- [x] The commend mechanism for `Duanji` by `Punsters`
- [x] The funny index mechanism for `Duanji` and `Punsters`
- [x] A cross-chain marketing(between Flow and opensea on Rinkeby for instance)

*Client*

- [x] Personal page for each `Punster`: 
    - [x] The information of following `Punsters`, followers, `Duanji`, recommended `Duanji` with high funny index, etc.
    - [x] The operations such as publish `Duanji`, commend `Duanji`, follow other `Punster`, etc. 
    - [x] The interface of advertisement mechanism.

## Team

| Name | Role     | Bio | Contact     |
| ---- | ------------------- | --- | ----------------------- |
| Xiyu | Full-Stack Engineer | ... | [Github](https://github.com/xiyu1984)  |
| Zation | Full-Stack Engineer | ... | [Github](https://github.com/xiyu1984)  |
| Zack W | Full-Stack Engineer | ... | [Github](https://github.com/xiyu1984)  |
| Jason | All-round talent | ... | Weixin id: *HopeOfTown* <br> Weixin Name: *404NotFound*  |

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
