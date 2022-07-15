import MetadataViews from "./MetadataViews.cdc"
import NonFungibleToken from "./NonFungibleToken.cdc"

pub contract PunstersNFT: NonFungibleToken {
    // -----------------------------------------------------------------------
    // NonFungibleToken Standard Events
    // -----------------------------------------------------------------------
    pub event ContractInitialized()
    pub event Withdraw(id: UInt64, from: Address?)
    pub event Deposit(id: UInt64, to: Address?)
    
    pub var totalSupply: UInt64
    
    // -----------------------------------------------------------------------
    // Punsters
    // -----------------------------------------------------------------------
    pub let PunsterStoragePath: StoragePath;
    pub let IPunsterPublicPath: PublicPath;
    pub let IFunnyIndexPublicPath: PublicPath;
    // pub let DuanjiStoragePath: StoragePath;
    // pub let IDuanjiPublicPath: PublicPath;

    access(contract) var PunsterTotal: UInt64;
    access(contract) var DuanjiTotal: UInt64;

    pub let cidKey: String;
    pub let pathKey: String;
    pub let descriptionKey: String;

    init() {
        self.PunsterStoragePath = /storage/PunsterStoragePath;
        self.IPunsterPublicPath = /public/IPunsterPublicPath;
        self.IFunnyIndexPublicPath = /public/IFunnyIndexPublicPath;
        // self.DuanjiStoragePath = /storage/DuanjiStoragePath;
        // self.IDuanjiPublicPath = /public/IDuanjiPublicPath;

        self.PunsterTotal = 1;
        self.DuanjiTotal = 1;

        self.totalSupply = 0;
        
        self.cidKey = "thumbnailCID";
        self.pathKey = "thumbnailPath";
        self.descriptionKey = "description";
    }

    // -----------------------------------------------------------------------
    // NonFungibleToken Standard Functions
    // -----------------------------------------------------------------------
    // This interface is useless 
    pub fun createEmptyCollection(): @NonFungibleToken.Collection {
        let punsterRes <- create Collection(id: self.PunsterTotal, acct: 0x00, description: "", ipfsURL: "");
        self.PunsterTotal = self.PunsterTotal + 1; 
        return <-punsterRes
    }

    pub resource interface IFunnyIndex {
        pub fun getDuanjiFunnyIndex(duanjiID: UInt64): UInt32;
        pub fun getPunsterFunnyIndex(): UInt32;
    }

    // This `I` is not mean 'Interface' but 'Interaction'
    pub resource interface IPunsterPublic {
        // tell-fetch model. 
        // Notify followers to 
        pub fun notify(addr: Address);
        // return last update timestamp, that is `fun getCurrentBlock(): Block`
        pub fun getLatestUpdate(): UFix64;

        // Get `Duanji` information
        // Return informations of `Duanji` the time after `timestamp`
        pub fun getDuanjiFrom(timestamp: UFix64): [UInt64];
        // Return informations of all `Duanji`
        pub fun getAllDuanji(): [UInt64];
        // Return DuanjiView
        pub fun getDuanjiViewFrom(timestamp: UFix64): [DuanjiView];
        pub fun getAllDuanjiView(): [DuanjiView];

        // tell-fetch model.
        // Follow some funnyguy
        pub fun follow(addr: Address, link: String);
        pub fun isFollowing(addr: Address);


        // tell-fetch model
        // Receive `Duanji` commending from others
        pub fun ReceiveCommend(addr: Address, duanjiID: UInt64);
        pub fun ReceiveCancelCommend(addr: Address, duanjiID: UInt64);
        pub fun isCommended(duanjiID: UInt64);

        // -----------------------------------------------------------------------
        // NFT operations
        // -----------------------------------------------------------------------
        pub fun deposit(token: @NonFungibleToken.NFT)
        pub fun getIDs(): [UInt64]
        pub fun borrowNFT(id: UInt64): &NonFungibleToken.NFT
        pub fun borrowDuanji(id: UInt64): &PunstersNFT.NFT? {
            post {
                (result == nil) || (result?.id == id): 
                    "Cannot borrow TestNFTWithViews reference: The ID of the returned reference is incorrect"
            }
        }
    }

    // `Duanji` NFT
    pub resource NFT: NonFungibleToken.INFT, MetadataViews.Resolver {
        pub let id: UInt64;
        pub let timestamp: UFix64;

        pub let metadata: { String: AnyStruct};

        priv let commends: [Address];
        // priv let funnyIndex: UInt32;

        init(
            id: UInt64,
            description: String,
            ipfsURL: String
        ) {
            self.id = id;
            self.timestamp = getCurrentBlock().timestamp;
            self.metadata = {};
            self.metadata[PunstersNFT.cidKey] = ipfsURL;
            self.metadata[PunstersNFT.descriptionKey] = description;
            self.commends = [];
            // self.funnyIndex = 0;
        }
        
        access(contract) fun commend(addr: Address): Bool{
            if (!self.commends.contains(addr)) {
                self.commends.append(addr);
                // TODO: increase funny index
                
                return true;
            } else {
                return false;
            }
        }

        access(contract) fun cancelCommend(addr: Address): Bool {            
            let idxOr = self.commends.firstIndex(of: addr);
            if let idx = idxOr {
                self.commends.remove(at: idx);
                // TODO: decrease funny index

                return true;
            } else {
                return false;
            }
        }

        access(contract) fun getFunnyIndex(): UInt32 {
            return self.commends.length as! UInt32;
        }

       pub fun getViews(): [Type] {
            return [
                Type<MetadataViews.Display>(),
                Type<MetadataViews.Royalties>(),
                Type<MetadataViews.Editions>(),
                Type<MetadataViews.ExternalURL>(),
                Type<MetadataViews.NFTCollectionData>(),
                Type<MetadataViews.NFTCollectionDisplay>(),
                Type<MetadataViews.Serial>(),
                Type<MetadataViews.Traits>()
            ]
        }

        pub fun resolveView(_ view: Type): AnyStruct? {
            switch view {
                case Type<MetadataViews.Display>():
                    return MetadataViews.Display(
                        name: "DuanjiNFT".concat(self.id.toString()),
                        description: self.metadata[PunstersNFT.descriptionKey]! as! String,
                        thumbnail: MetadataViews.IPFSFile(
                            url: self.metadata[PunstersNFT.cidKey]! as! String, path: nil
                        )
                    )
                case Type<MetadataViews.Editions>():
                    // There is no max number of NFTs that can be minted from this contract
                    // so the max edition field value is set to nil
                    let editionInfo = MetadataViews.Edition(name: "PunStar Hackathon Edition", number: self.id, max: nil)
                    let editionList: [MetadataViews.Edition] = [editionInfo]
                    return MetadataViews.Editions(
                        editionList
                    )
                case Type<MetadataViews.Serial>():
                    return MetadataViews.Serial(
                        self.id
                    )
                case Type<MetadataViews.Royalties>():
                    return MetadataViews.Royalties(
                        []
                    )
                case Type<MetadataViews.ExternalURL>():
                    return MetadataViews.ExternalURL(self.metadata[PunstersNFT.cidKey]! as! String)
                case Type<MetadataViews.NFTCollectionData>():
                    return MetadataViews.NFTCollectionData(
                        storagePath: PunstersNFT.PunsterStoragePath,
                        publicPath: PunstersNFT.IPunsterPublicPath,
                        providerPath: /private/PunsterNFTCollection,
                        publicCollection: Type<&PunstersNFT.Collection{PunstersNFT.IPunsterPublic}>(),
                        publicLinkedType: Type<&PunstersNFT.Collection{PunstersNFT.IPunsterPublic,NonFungibleToken.CollectionPublic,NonFungibleToken.Receiver,MetadataViews.ResolverCollection}>(),
                        providerLinkedType: Type<&PunstersNFT.Collection{PunstersNFT.IPunsterPublic,NonFungibleToken.CollectionPublic,NonFungibleToken.Provider,MetadataViews.ResolverCollection}>(),
                        createEmptyCollectionFunction: (fun (): @NonFungibleToken.Collection {
                            return <-PunstersNFT.createEmptyCollection()
                        })
                    )
                case Type<MetadataViews.NFTCollectionDisplay>():
                    let media = MetadataViews.Media(
                        file: MetadataViews.IPFSFile(
                            url: self.metadata[PunstersNFT.cidKey]! as! String, path: nil
                        ),
                        mediaType: "image/svg+xml"
                    )
                    return MetadataViews.NFTCollectionDisplay(
                        name: "The Example Collection",
                        description: "This collection is used as an example to help you develop your next Flow NFT.",
                        externalURL: MetadataViews.ExternalURL(self.metadata[PunstersNFT.cidKey]! as! String),
                        squareImage: media,
                        bannerImage: media,
                        socials: {
                            "twitter": MetadataViews.ExternalURL("https://twitter.com/flow_blockchain")
                        }
                    )
                case Type<MetadataViews.Traits>():
                    // exclude mintedTime and foo to show other uses of Traits
                    let excludedTraits = ["mintedTime", "foo"]
                    let traitsView = MetadataViews.dictToTraits(dict: self.metadata, excludedNames: excludedTraits)

                    // mintedTime is a unix timestamp, we should mark it with a displayType so platforms know how to show it.
                    let mintedTimeTrait = MetadataViews.Trait(name: "mintedTime", value: self.timestamp, displayType: "Date", rarity: nil)
                    traitsView.addTrait(mintedTimeTrait)

                    // foo is a trait with its own rarity
                    let fooTraitRarity = MetadataViews.Rarity(score: 10.0, max: 100.0, description: "Common")
                    let fooTrait = MetadataViews.Trait(name: "foo", value: self.metadata["foo"], displayType: nil, rarity: fooTraitRarity)
                    traitsView.addTrait(fooTrait)
                    
                    return traitsView

            }
            return nil
        }

        pub fun getMetadata(): {String: AnyStruct} {
            return self.metadata;
        }

        pub fun getURL(): String? {
            return self.metadata[PunstersNFT.cidKey] as! String?;
        }
    }

    // Simplified information of `duanji`
    pub struct DuanjiView {
        pub let id: UInt64;
        pub let owner: Address;
        pub let ipfsUrl: String;

        init(id: UInt64, owner: Address, ipfsUrl: String) {
            self.id = id;
            self.owner = owner;
            self.ipfsUrl = ipfsUrl;
        }
    }

    // `Punster` is a NFT and a NFT collection for `Duanji` NFT
    // This NFT will be locked for a time before being traded again
    pub resource Collection: NonFungibleToken.INFT, MetadataViews.Resolver, NonFungibleToken.Provider, NonFungibleToken.Receiver, NonFungibleToken.CollectionPublic, MetadataViews.ResolverCollection {
        pub let id: UInt64;
        pub let timestamp: UFix64;
        pub let acct: Address;

        pub let metadata: { String: AnyStruct };
        pub var ownedNFTs: @{UInt64: NonFungibleToken.NFT};

        pub let followings: [Address];
        pub let followers: [Address];

        priv var followUpdates: {Address: UFix64};
        priv var latestUpdate: UFix64;

        init(
            id: UInt64,
            acct: Address,
            description: String,
            ipfsURL: String
        ) {
            self.id = id;
            self.timestamp = getCurrentBlock().timestamp;
            self.acct = acct;
            self.metadata = {};
            self.metadata[PunstersNFT.cidKey] = ipfsURL;
            self.metadata[PunstersNFT.descriptionKey] = description;
            self.ownedNFTs <- {};

            self.followings = [];
            self.followers = [];

            self.followUpdates = {};
            self.latestUpdate = self.timestamp;
        }

        destroy () {
            destroy self.ownedNFTs;
        }

        // -----------------------------------------------------------------------
        // NonFungibleToken Standard Functions---Collection
        // -----------------------------------------------------------------------
        pub fun withdraw(withdrawID: UInt64): @NonFungibleToken.NFT {
            let token <- self.ownedNFTs.remove(key: withdrawID) ?? panic("missing NFT")
            emit Withdraw(id: token.id, from: self.owner?.address)
            return <-(token as! @NonFungibleToken.NFT)
        }

        pub fun deposit(token: @NonFungibleToken.NFT) {
            let token <- token as! @NFT
            let id: UInt64 = token.id
            let oldToken <- self.ownedNFTs[id] <- token
            emit Deposit(id: id, to: self.owner?.address)
            destroy oldToken
        }

        pub fun getIDs(): [UInt64] {
            return self.ownedNFTs.keys
        }

        pub fun borrowNFT(id: UInt64): &NonFungibleToken.NFT {
            return (&self.ownedNFTs[id] as &NonFungibleToken.NFT?)!
        }

        pub fun borrowViewResolver(id: UInt64): &AnyResource{MetadataViews.Resolver} {
            let nft = &self.ownedNFTs[id] as auth &NonFungibleToken.NFT?
            let test = nft as! &PunstersNFT.NFT
            return test as &AnyResource{MetadataViews.Resolver}
        }

        // -----------------------------------------------------------------------
        // NonFungibleToken Standard Functions---NFT
        // -----------------------------------------------------------------------
        pub fun getViews(): [Type] { 
            return [
                Type<MetadataViews.Display>()
            ]
        }

        pub fun resolveView(_ view: Type): AnyStruct? {
            switch view {
                case Type<MetadataViews.Display>():
                    var ipfsImage = MetadataViews.IPFSFile(cid: "No thumbnail cid set", path: "No thumbnail path set")
                    if (self.getMetadata().containsKey(PunstersNFT.cidKey)) {
                        ipfsImage = MetadataViews.IPFSFile(cid: self.getMetadata()[PunstersNFT.cidKey]! as! String, path: self.getMetadata()[PunstersNFT.pathKey] as! String?)
                    }
                    return MetadataViews.Display(
                        name: self.getMetadata()["name"] as! String? ?? "PunStar".concat(self.id.toString()),
                        description: self.getMetadata()["description"] as! String? ?? "No description set",
                        thumbnail: ipfsImage
                    )
            }

            return nil
        }

        pub fun getMetadata(): {String: AnyStruct} {
            return self.metadata;
        }

        // -----------------------------------------------------------------------
        // For collections
        // -----------------------------------------------------------------------
        pub fun getOwnedNFTsRef(): &{UInt64: NonFungibleToken.NFT} {
            return &self.ownedNFTs as &{UInt64: NonFungibleToken.NFT};
        }

        pub fun borrowDuanji(id: UInt64): &PunstersNFT.NFT? {
            if self.ownedNFTs[id] != nil {
                let ref = &self.ownedNFTs[id] as auth &NonFungibleToken.NFT?
                return ref as! &PunstersNFT.NFT
            } else {
                return nil
            }
        }
        
        // -----------------------------------------------------------------------
        // Interface IPunsterPublic API
        // -----------------------------------------------------------------------
        // tell-fetch model. 
        // Notify followers to 
        pub fun notify(addr: Address) {
            if (self.followings.contains(addr)) {
                if let punsterRef = PunstersNFT.getIPunsterFromAddress(addr: addr) {
                    if (!self.followUpdates.containsKey(addr)) {
                        self.followUpdates[addr] = punsterRef.getLatestUpdate();
                    }
                }
            }
        }
        // return last update timestamp, that is `fun getCurrentBlock(): Block`
        pub fun getLatestUpdate(): UFix64{
            return self.latestUpdate;
        }

        // Get `Duanji` information
        // Return informations of `Duanji` the time after `timestamp`
        pub fun getDuanjiFrom(timestamp: UFix64): [UInt64]{
            let duanjiKeys = self.ownedNFTs.keys;
            var validKeys: [UInt64] = [];
            for ele in duanjiKeys {
                let nft = &self.ownedNFTs[ele] as auth &NonFungibleToken.NFT?
                let temp = nft as! &PunstersNFT.NFT
                if (temp.timestamp >= timestamp){
                    validKeys.append(ele);
                }
            }

            return validKeys;
        }

        // Return informations of all `Duanji`
        pub fun getAllDuanji(): [UInt64]{
            return self.ownedNFTs.keys
        }

        pub fun getDuanjiViewFrom(timestamp: UFix64): [DuanjiView]{
            var outputViews: [DuanjiView] = [];
            for ele in self.ownedNFTs.keys {
                let nft = &self.ownedNFTs[ele] as auth &NonFungibleToken.NFT?;
                let temp = nft as! &PunstersNFT.NFT;
                if (temp.timestamp > timestamp) {
                    if let url = temp.getURL() {
                        outputViews.append(DuanjiView(id: ele, owner: self.acct, ipfsUrl: url));
                    }
                }
            }

            return outputViews;
        }

        // Return all DuanjiView
        // pub fun getAllDuanjiView(): MetadataViews.NFTView {
        //     let nft = &self.ownedNFTs[0] as auth &NonFungibleToken.NFT?;
        //     let temp = nft as! &PunstersNFT.NFT;
        //     return MetadataViews.getNFTView(id: 0, viewResolver: temp as &AnyResource{MetadataViews.Resolver});
        // }
        pub fun getAllDuanjiView(): [DuanjiView] {
            var outputViews: [DuanjiView] = [];
            for ele in self.ownedNFTs.keys {
                let nft = &self.ownedNFTs[ele] as auth &NonFungibleToken.NFT?;
                let temp = nft as! &PunstersNFT.NFT;
                if let url = temp.getURL() {
                    outputViews.append(DuanjiView(id: ele, owner: self.acct, ipfsUrl: url));
                }
            }

            return outputViews;
        }


        // -----------------------------------------------------------------------
        // Resouce API
        // -----------------------------------------------------------------------
        pub fun publishDuanji(description: String, ipfsURL: String) {

            let oldToken <-self.ownedNFTs[PunstersNFT.DuanjiTotal] <- create NFT(id: PunstersNFT.DuanjiTotal, 
                                                                                        description: description,
                                                                                        ipfsURL: ipfsURL);

            PunstersNFT.DuanjiTotal = PunstersNFT.DuanjiTotal + 1;
            PunstersNFT.totalSupply = PunstersNFT.DuanjiTotal;

            self.latestUpdate = getCurrentBlock().timestamp;

            for ele in self.followers {
                if let punsterRef = PunstersNFT.getIPunsterFromAddress(addr: ele) {
                    punsterRef.notify(addr: self.acct);
                }
            }

            destroy oldToken;
        }

        // returns all 
        pub fun getAllUpdates(): [DuanjiView] {
            let outputViews: [DuanjiView] = [];
            for ele in self.followUpdates.keys {
                if let punsterRef = PunstersNFT.getIPunsterFromAddress(addr: ele) {
                    outputViews.concat(punsterRef.getDuanjiViewFrom(timestamp: self.followUpdates[ele]!));
                }
            }

            self.followUpdates = {};

            return outputViews;
        }

        pub fun commendToDuanji() {

        }

        pub fun cancelCommendToDuanji() {

        }
    }

    pub fun getIPunsterFromAddress(addr: Address): &{IPunsterPublic}? {
        let pubAcct = getAccount(addr);
        let oIPunster = pubAcct.getCapability<&{IPunsterPublic}>(PunstersNFT.IPunsterPublicPath);
        return oIPunster.borrow();
    }

    pub fun getIFunnyIndexFromAddress(addr: Address): &{IFunnyIndex}? {
        let pubAcct = getAccount(addr);
        let oIFI = pubAcct.getCapability<&{IFunnyIndex}>(PunstersNFT.IFunnyIndexPublicPath);
        return oIFI.borrow();
    }

    // one account, one `Punster` NFT
    // This function is used for everyone to create 
    pub fun registerPunster(addr: Address, description: String, ipfsURL: String): @Collection{
        let punsterRes <- create Collection(id: self.PunsterTotal, acct: addr, description: description, ipfsURL: ipfsURL);
        self.PunsterTotal = self.PunsterTotal + 1; 
        return <-punsterRes
    }
}
