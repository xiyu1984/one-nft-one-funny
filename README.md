# PunStar
# Introduction
PunStar is a social platform based on funny. punStar participants are called "Punsters" (an NFT) and they can share their funny things in the form of "segments" (an NFT). Each person can express their preference for a "segment", which can stimulate the construction of social relationships between participants. In addition, we have created advertising mechanisms to demonstrate the interesting executable capabilities based on Flow's unique resource mechanism, which will be a great improvement for NFTs.

## Highlights
* **Assetization of social relationships**  
As we know, in resource-oriented cadence things can be bound to each resource, so resources can actually **have** their own abilities, such as social relationships based on the `following` mechanism. This is very different from the smart-contract-based chains where everything is published on smart contracts. Resources can be exchanged, so the bound abilities such as relationships can be exchanged too. This improves the potential value of the `Punster` NFT, as relationships can be combined with the advertisement ability for example. `Punsters` with more followers might be more valuable. 

* **Assetization of funny things** 
As every participant can express their preference for a `Dunaji`, the funny index of a `Duanji` and `Punsters` can be evaluated, which may improve their market performance.

* **Advertisement mechanism: one of the special executable abilities of NFT on Flow**   
`Punsters` can push advertisements to their followers with limitations of some conditions based on the `funny index` mechanism. This is a demonstration of a specific feature of Flow's NFT, which is the implementation of executable abilities bound to NFTs. 

* Assets in PunStar can be accessed cross-chain  
Interesting things should be shared with others. Users can enjoy some special abilities of PunStar deployed on Flow from other chains without losing the specific features of resources.

## Background
- Target audience:  
Everyone can share funny things with each other, and enjoy funny stories from other punsters. So this is a product for every socialized humanity.    
- Evidence for the need:  
We can find some similar successful products in the Web2 world, such as Facebook, Twitter, WeChat Friend Circle, etc. But there're some uncomfortable things in the Web2 world that the ownership, control, and disposal of assets do not belong to individuals. PunStar starts building its social platforms with funny topics, at the same time, social relations and advertising mechanisms were created based on the full use of Flow's resource features.

## Solution
### Product  
(need a picture to explain)
* People publish `Duanji` to share funny things.
* If one person thinks some other `punsters` are interesting, he can `follow` them to get the newest information as soon as the followed `punsters` publish any updates.  
* If one person likes a `Duanji`, he can `commend` it, so that, the "Funny Index" of the `Duanji` will be increased, and the related `punster` who published the `Duanji`.
* `Punsters` can push advertisements to their followers based on the `funny index`.
* Both `Duanji` and `Punster` are NFTs that can be exchanged between different participants.
* Besides Flow, we are trying to provide advertising access interfaces to other chains, without losing the unique resource features provided by Flow.

### Technology Architecture
(need a technical picture to explain)  
The key points of the technology are as follows:  
* `Following` mechanism can be implemented easily on Flow by resource interactions. 
* `Funny index` evaluation algorithm in the `Commend` mechanism can make out an estimation of how funny a `Duanji` or a `Punster` is, which depends both on commend counts and time passed.
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
