# PunStar
# Introduction

## Background

## Solution

# Programming in Web3 Jam

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
