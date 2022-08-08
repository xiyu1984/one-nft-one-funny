# PunStar
# Introduction
PunStar is a social platform based on funny. punStar participants are called "Punsters" (an NFT) and they can share their funny things in the form of "Duanji" (an NFT). Each person can express their preference for a "Duanji", which can stimulate the construction of social relationships between participants and let it possible to estimate the "funny index" of each "Punster". The "Punsters" can make content promotions(e.g. publish ads) based on their relationship constructed in PunStar, which needs to satisfy some restrictions based on the "funny index" first. We use Flow's unique mechanism to coalesce social relationships, content promotion, and some other practical abilities into NFT, which is a great enhancement to the existing NFT, allowing NFT to be more realistic and of greater practical value.

## Official Website
Register to [PunStar](http://punster.stonelens.com/) and start your funny journey. Check the [tutorial](./Front%20UI%20Tutorial.md) if you are new to Flow.
 

## Highlights
* **Assetization of social relationships**  
As we know, in resource-oriented cadence things can be bound to each resource, so resources can actually **have** their own abilities, such as social relationships based on the `following` mechanism. This is very different from the smart-contract-based chains where everything is published on smart contracts. Resources can be exchanged, so the bound abilities such as relationships can be exchanged too. This improves the potential value of the `Punster` NFT, as relationships can be combined with the advertisement ability for example. `Punsters` with more followers might be more valuable. 

* **Assetization of funny things** 
As every participant can express their preference for a `Dunaji`, the funny index of a `Duanji` and `Punsters` can be evaluated, which may improve their market performance.

* **Enable and assetize execution abilities for NFT: Such as advertisement mechanism**   
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
![演示文稿4_02](https://user-images.githubusercontent.com/83746881/180390775-08bf330d-44a3-45a5-b951-808a6af7ea03.jpg)
* People publish `Duanji` to share funny things.
* If one person thinks some other `punsters` are interesting, he can `follow` them to get the newest information as soon as the followed `punsters` publish any updates.  
* If one person likes a `Duanji`, he can `commend` it, so that, the "Funny Index" of the `Duanji` will be increased, and the related `punster` who published the `Duanji`.
* `Punsters` can push advertisements to their followers based on the `funny index`.
* Both `Duanji` and `Punster` are NFTs that can be exchanged between different participants.
* Besides Flow, we are trying to provide advertising access interfaces to other chains, without losing the unique resource features provided by Flow.

### Technology Architecture
![image](https://user-images.githubusercontent.com/83746881/180392687-5d3400e2-61a8-4e1f-8f19-92945ee84199.png)
The key points of the technology are as follows:  
* `Following` mechanism can be implemented easily on Flow by resource interactions. 
* `Funny index` evaluation algorithm in the `Commend` mechanism can make out an estimation of how funny a `Duanji` or a `Punster` is, which depends on both commending counts and time passed.
* Advertisement mechanism based on `funny index` of `Punsters`.
* A cross-chain access system.

### Logo
![3333](https://user-images.githubusercontent.com/83746881/180390840-091e029d-2577-4c30-9c52-0ffb00dd1336.png)
### Marketing
* The funny `Duanji` is used as the initial entry point for the topic to start the market.
* Give NFT more dynamical and practical value based on Flow's unique mechanism to attract more user to create to build their social relationships.
* Assetization the practical value of both `Duanji` and `Punster` NFTs, and make everything tradable, so that to improve the activity of PunStar platform.
* Bring in more dynamical and practical ablities to `Punster` and `Duanji` NFT, such as E-commerce.
* Besides funny things, bring in more topics like dating to inspire users to enhance their social relationships.


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

## Deployment
* The deployed address on Testnet is: *0x1a478a7149935b63*, and the contracs are as below:
    * **PunStar contracts for this hackathon**: 
        * [Punsters](./contracts/Punsters.cdc): The smart contract defines NFTs(resource) of `Duanji`(standard NonFungibleToken), `Punster`(NonFungibleToken and standard Collection). Based on Flow's unique mechanism, they are endowed with social relationships and unique executable properties.
        * [StarRealm](./contracts/StarRealm.cdc): A special collection used for exchanging NFTs between personal accounts and cross ecosystem `Locker`(details are in the below item).
        * [Locker](./contracts/Locker.cdc): The smart contract manages the cross ecosystem transfering of NFTs based on Dante Network.
    * Standard NFT contracts from [official](https://github.com/onflow/flow-nft), including [FungibleToken](./contracts/utility/FungibleToken.cdc), [NonFungibleToken](./contracts/NonFungibleToken.cdc), [MetadataVeiws](./contracts/MetadataViews.cdc). 

## The operation by Flow CLI is as below:
[Try it mannually](./PunStarOperation.md)

## The details of cross-ecosystem operation are as below:
* We use an interoperation middleware to make NFTs defined as resource on Flow with flexibile action features be transfered to other chains without losing anything Flow supports. Currently, we use Dante Network as the infrastructure to help us make `Punster` and `Duanji` NFTs be multi-ecosystem resource.
* [See more details](./CrossEcosystem.md)
