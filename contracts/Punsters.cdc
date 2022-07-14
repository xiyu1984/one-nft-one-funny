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

    init() {
        self.PunsterStoragePath = /storage/PunsterStoragePath;
        self.IPunsterPublicPath = /public/IPunsterPublicPath;
        self.IFunnyIndexPublicPath = /public/IFunnyIndexPublicPath;
        // self.DuanjiStoragePath = /storage/DuanjiStoragePath;
        // self.IDuanjiPublicPath = /public/IDuanjiPublicPath;

        self.PunsterTotal = 1;
        self.DuanjiTotal = 1;

        self.totalSupply = 0;
    }

    // -----------------------------------------------------------------------
    // NonFungibleToken Standard Functions
    // -----------------------------------------------------------------------
    // This interface is useless 
    pub fun createEmptyCollection(): @NonFungibleToken.Collection {
        let punsterRes <- create Collection(id: self.PunsterTotal, acct: 0x00, metadata: {});
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

        pub let metadata: { String: String };

        priv let commends: [Address];
        // priv let funnyIndex: UInt32;

        init(
            id: UInt64,
            metadata: {String: String}
        ) {
            self.id = id;
            self.timestamp = getCurrentBlock().timestamp;
            self.metadata = metadata;
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
                Type<MetadataViews.Display>()
            ]
        }

        pub fun resolveView(_ view: Type): AnyStruct? {
            switch view {
                case Type<MetadataViews.Display>():
                    var ipfsImage = MetadataViews.IPFSFile(cid: "No thumbnail cid set", path: "No thumbnail path set")
                    if (self.getMetadata().containsKey("thumbnailCID")) {
                        ipfsImage = MetadataViews.IPFSFile(cid: self.getMetadata()["thumbnailCID"]!, path: self.getMetadata()["thumbnailPath"])
                    }
                    return MetadataViews.Display(
                        name: self.getMetadata()["name"] ?? "Duanji ".concat(self.id.toString()),
                        description: self.getMetadata()["description"] ?? "No description set",
                        thumbnail: ipfsImage
                    )
            }

            return nil
        }

        pub fun getMetadata(): {String: String} {
            return self.metadata;
        }

        pub fun getURL(): String? {
            return self.metadata["thumbnailCID"];
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

        pub let metadata: { String: String };
        pub var ownedNFTs: @{UInt64: NonFungibleToken.NFT};

        pub let followings: [Address];
        pub let followers: [Address];

        priv var followUpdates: {Address: UFix64};
        priv var latestUpdate: UFix64;

        init(
            id: UInt64,
            acct: Address,
            metadata: {String: String}
        ) {
            self.id = id;
            self.timestamp = getCurrentBlock().timestamp;
            self.acct = acct;
            self.metadata = metadata;
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
                    if (self.getMetadata().containsKey("thumbnailCID")) {
                        ipfsImage = MetadataViews.IPFSFile(cid: self.getMetadata()["thumbnailCID"]!, path: self.getMetadata()["thumbnailPath"])
                    }
                    return MetadataViews.Display(
                        name: self.getMetadata()["name"] ?? "Duanji ".concat(self.id.toString()),
                        description: self.getMetadata()["description"] ?? "No description set",
                        thumbnail: ipfsImage
                    )
            }

            return nil
        }

        pub fun getMetadata(): {String: String} {
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
        pub fun publishDuanji(metadata: {String: String}) {

            let oldToken <-self.ownedNFTs[PunstersNFT.DuanjiTotal] <- create NFT(id: PunstersNFT.DuanjiTotal, 
                                                                                        metadata: metadata);

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
    pub fun registerPunster(addr: Address, metadata: {String: String}): @Collection{
        let punsterRes <- create Collection(id: self.PunsterTotal, acct: addr, metadata: metadata);
        self.PunsterTotal = self.PunsterTotal + 1; 
        return <-punsterRes
    }
}
