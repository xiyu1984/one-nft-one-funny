# Project Name
**PunStar**
![3333](https://user-images.githubusercontent.com/83746881/180390840-091e029d-2577-4c30-9c52-0ffb00dd1336.png)

* Register to http://punster.stonelens.com/ and start your funny journey. Check the [Front UI Tutorial](./Front%20UI%20Tutorial.md) if you are new to Flow.
* More details are in our [Pitch Deck](https://github.com/xiyu1984/web3jam-2022-summer/blob/main/submissions/issue-5/docs/PunStar(v0.0.1).ppt.pdf)

# Description
## Problem statement
We are exploring a decentralized digital social network. By building a next-generation NFT architecture based on resource-oriented chains to express various social relationships and interactions in the Web3 world, and asset all this, so that the value of social capabilities of every participant could be confirmed and clarified.  

**PunStar** is an initial form of this social network. Firstly, we will build this platform on Flow due to its unique resource-oriented features and next this will be extended to more resource-oriented chains like Aptos and Sui. Besides static content features and combinability of normal NFT, we take advantage of resource mechanism to coalesce some innovative properties into NFT and asset them. The innovative properties include dynamical social relationships between participants established by resource interactions, executable abilities based on methods bound to resources (some of which have realistic meanings, e.g. advertising), and upgradeable features like `Funny index` which may actually increase NFT's value.  

In this stage, PunStar chooses `Funny things` as the entry point of the social network, which could be easily extended in the future. The participants of PunStar are called "Punsters" (an NFT) and they can share their funny things in the form of "Duanji" (an NFT). Each person can express their preference for a "Duanji", which can stimulate the construction of social relationships between participants and let it possible to estimate the "funny index" of each "Punster". The "Punsters" can make content promotions(e.g. publish ads) based on their relationship constructed in PunStar, which needs to satisfy some restrictions based on the "funny index" first. We use resource mechanism to coalesce social relationships, content promotion, and some other practical abilities into NFT, which is a great enhancement to the existing NFT, allowing NFT to be more realistic and of greater practical value.

### Highlights
* **Brings associativity abilities to NFT with related assetization**  
As we know, in resource-oriented cadence things can be bound to each resource, so resources can actually **have** their own abilities, such as social relationships based on the `following` mechanism. This is very different from the smart-contract-based chains where everything is published on smart contracts. Resources can be exchanged, so the bound abilities such as relationships can be exchanged too. This improves the potential value of the `Punster` NFT, as relationships can be combined with the advertising ability for instance. `Punsters` with more followers might be more valuable. 

* **Brings execution abilities to NFT: Such as advertisement mechanism**   
`Punsters` can push advertisements to their followers with limitations of some conditions based on the `funny index` mechanism. This is a demonstration of a specific feature of resource-oriented NFT, which is the implementation of executable abilities bound to NFTs. 

* **Brings dynamical growth abilities for NFT**   
Some dynamical abilities of `Punsters` could grow as they make contributions. For example, the funny index will increase if someone's `Duanji` is commended by others. And the funny index will influence the cooling time of Punster's advertising ability.

* Assetization of all the social capabilities in PunStar

* Assets in PunStar can be accessed Omnichain  
Interesting things should be shared with others. Users can enjoy some special abilities of PunStar deployed on resource-oriented chains from other chains without losing the specific features of resources.

### Background
- Target audience:  
Everyone can share funny things with each other, and enjoy funny stories from other punsters. So this is a product for every socialized humanity.    
- Evidence for the need:  
We can find some similar successful products in the Web2 world, such as Facebook, Twitter, WeChat Friend Circle, etc. But there're some uncomfortable things in the Web2 world that the ownership, control, and disposal of assets do not belong to individuals. PunStar starts building its social platforms with funny topics, at the same time, social relations and advertising mechanisms were created based on the full use of resource features.  

## Proposed solution
### Product  
![演示文稿4_02](https://user-images.githubusercontent.com/83746881/180390775-08bf330d-44a3-45a5-b951-808a6af7ea03.jpg)
* People publish `Duanji` to share funny things.
* If one person thinks some other `punsters` are interesting, he can `follow` them to get the newest information as soon as the followed `punsters` publish any updates.  
* If one person likes a `Duanji`, he can `commend` it, so that, the "Funny Index" of the `Duanji` will be increased, and the related `punster` who published the `Duanji`.
* `Punsters` can push advertisements to their followers based on the `funny index`.
* Both `Duanji` and `Punster` are NFTs that can be exchanged between different participants.
* Besides reousrce-oriented chains like Flow, Aptos, and Sui, we are trying to provide advertising access interfaces to other chains, without losing the unique resource features.

### Technology Architecture
![image](https://user-images.githubusercontent.com/83746881/183852679-d1d23c57-f84f-43c8-afc4-9d31343780f6.png)
The key points of the technology are as follows:  
* `Duanji` is our new architecture NFT compatible with ERC series standard. Besides static content properties, `Duanji` has its dynamical feature `funny index`.
* `Punster` is our new architecture NFT compatible with ERC series standard, and it is also a NFT container. A `Punster` NFT can contain lots of `Duanji` NFTs. The dynamical properties of `Punster` include  
* `Following` mechanism can be implemented easily based on resource interactions. 
* `Funny index` evaluation algorithm in the `Commend` mechanism can make out an estimation of how funny a `Duanji` or a `Punster` is, which depends on both commending counts and time passed.
* Advertisement mechanism based on `funny index` of `Punsters`.
* `StarRealm` and `Cross-Chain Locker` provide a Star Port for NFTs to travel to other chains.

### Marketing
* The funny `Duanji` is used as the initial entry point for the topic to start the market.
* Give NFT more dynamical and practical value based on resource-oriented mechanism to attract more user to create to build their social relationships.
* Assetization the practical value of both `Duanji` and `Punster` NFTs, and make everything tradable, so that to improve the activity of PunStar platform.
* Bring in more dynamical and practical ablities to `Punster` and `Duanji` NFT, such as E-commerce.
* Besides funny things, bring in more topics like dating to inspire users to enhance their social relationships.

# Prototypes
* [Demo Video](https://punstar.oss-cn-hangzhou.aliyuncs.com/PunStar%20Demo.mp4)
* [Website](http://punster.stonelens.com/)


## Team

| Name | Role     | Bio | Contact     |
| ---- | ------------------- | --- | ----------------------- |
| Xiyu | Full-Stack Engineer | ... | [Github](https://github.com/xiyu1984)  |
| Zation | Full-Stack Engineer | ... | [Github](https://github.com/zation)  |
