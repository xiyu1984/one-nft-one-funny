# Try with `Flow CLI`
The transactions and scripts to invoke resource operations and query resource statements are as follows:

## Deployment
* The deployed address on Testnet is: *0x1a478a7149935b63*, and the contracs are as below:
    * 
    * Standard NFT contracts from [official](https://github.com/onflow/flow-nft), including [FungibleToken](./contracts/utility/FungibleToken.cdc), [NonFungibleToken](./contracts/NonFungibleToken.cdc), [MetadataVeiws](./contracts/MetadataViews.cdc). 
    

## Transactions

### [Register `Punster`](./transaction/registerPunster.cdc)
The related `Flow CLI` is as follow: 
```sh
flow transactions send ./transaction/registerPunster.cdc "I'm a funny punster!" "Punster Alice's ipfs url" --signer <signer-account-info> -n testnet
```
* The first parameter `"I'm a funny punster!"` is `description`
* The second parameter `"Punster Alice's ipfs url"` is `ipfsURL`
* Every account can only invoke `register` once

### [Publish `Duanji`](./transaction/publishDuanji.cdc)
The related `Flow CLI` is as follow:
```sh
flow transactions send ./transaction/publishDuanji.cdc "I found the dog is so funny!" "ipfs uri 2 is defined" --signer <signer-account-info> -n testnet
```
* The first parameter `"I found the dog is so funny!"` is `discription`
* The second parameter `"ipfs uri 2 is defined"` is `ipfsURL`

### [Commend to `Duanji`](./transaction/commendTo.cdc)
The related `Flow CLI` is as follow:
```sh
flow transactions send ./transaction/commendTo.cdc 0x05ede3f803407aae 3 --signer <signer-account-info> -n testnet
```
* The first parameter`0x05ede3f803407aae` is the owner address
* The second parameter `3` is the id of duanji 

### [Cancel commend to `Duanji`](./transaction/cancelCommendTo.cdc)
The related `Flow CLI` is as follow:
```sh
flow transactions send ./transaction/cancelCommendTo.cdc 0x05ede3f803407aae 3 --signer <signer-account-info> -n testnet
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
* The first parameter `0x05ede3f803407aae` is the account to unfollow

### Post ads.
The related `Flow CLI` is as follow:
```sh
flow transactions send ./transaction/postADs.cdc "This is an Alice's ad." "Alice's ipfs URL." --sginer testnet-Alice -n testnet
```
* The first parameter `This is an Alice's ad.` is the description of the ad.
* The second parameter `Alice's ipfs URL.` is the IPFS url, the same as normal `Duanji`.

### [Clear following updates](./transaction/clearUpdates.cdc)
The related `Flow CLI` is as follow:
```sh
flow transactions send ./transaction/clearUpdates.cdc --signer <signer-account-info> -n testnet
```
* Every following's update(publish new `duanji`) will be temporarily stored by his followers. But punsters can chose to clear this cache with this transaction.

### [Destroy Punster](./transaction/destroyPunster.cdc)
The related `Flow CLI` is as follow:
```sh
flow transactions send ./transaction/destroyPunster.cdc --signer testnet-account -n testnet
```
* Destroy owned Punster. All of the owned `Duanji` and relationships will be cleared. But the commends to `Duanji`s will not be liquidated. 

### transfer `Duanji` to others
The related `Flow CLI` is as follow:
```sh
flow transaction send ./transaction/transferPunStar/transferDuanji.cdc 0x05ede3f803407aae 1 --signer testnet-Alice -n testnet
```
* The first parameter `0x05ede3f803407aae` is the account to receive the `Duanji`
* The second parameter `1` is the id of the `Duanji`

### create StarRealm
```sh
flow transactions send ./transaction/transferPunStar/createStarPort.cdc --signer emulator-Alice
```
* `StarPort` is used for transfering `Punster` from one account to another

### get punster from self ported
```sh
flow transactions send ./transaction/transferPunStar/getPunsterFromPorted.cdc --signer emulator-Alice
```
* `Punster` needs to be saved in your account storage path(`PunstersNFT.PunsterStoragePath`) before used
* `Punster`'s owner ship will be updated throungh `PunstersNFT.updateRegisteredPunster`

### transfer punster to
```sh
flow transactions send ./transaction/transferPunStar/transferPunster.cdc 0x01cf0e2f2f715450
```
* The first parameter `0x01cf0e2f2f715450` is the target address
* Make sure there's no `Punster` in the target address, or the transfer will fail
* Make sure the `StarPort` has been created in the target address, or the transfer will fail

## Scripts
### query all following duanji
```sh
flow scripts execute ./scripts/getAllDuanjiFollowing.cdc 0x33a8abe2196c9e15 -n testnet
```
* Returns all the `Duanji` the punster with the address `0x33a8abe2196c9e15` following. 

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

### [query all punsters](./scripts/queryAllPunsters.cdc)
The related `Flow CLI` is as follow:
```sh
flow scripts execute ./scripts/queryAllPunsters.cdc -n testnet
```

### [query punster view](./scripts/getPunsterView.cdc)
The related `Flow CLI` is as follow:
```sh
flow scripts execute ./scripts/getPunsterView.cdc 0x05ede3f803407aae -n testnet
```
* The first parameter `0x05ede3f803407aae` is the address of a punster
