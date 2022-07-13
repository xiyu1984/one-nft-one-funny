import MetadataViews from "./MetadataViews.cdc"

pub contract FunnyThings {
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
    }

    pub resource interface IFunnyIndex {
        pub fun getDuanjiFunnyIndex(duanjiID: UInt64): UInt32;
        pub fun getFunnyGuyFunnyIndex(): UInt32;
    }

    // This `I` is not mean 'Interface' but 'Interaction'
    pub resource interface IPunster {
        // tell-fetch model. 
        // Notify followers to 
        pub fun notify(addr: Address);
        // return last update timestamp, that is `fun getCurrentBlock(): Block`
        pub fun getLatestUpdate(): UFix64;

        // tell-fetch model.
        // Follow some funnyguy
        pub fun follow(addr: Address, link: String);
        pub fun isFollowing(addr: Address);

        // Get `Duanji` information
        // Return informations of `Duanji` the time after `timestamp`
        pub fun getDuanjiFrom(timestamp: UFix64);
        // Return informations of all `Duanji`
        pub fun getAllDuanji();

        // tell-fetch model
        // Receive `Duanji` commending from others
        pub fun ReceiveCommend(addr: Address, duanjiID: UInt64);
        pub fun ReceiveCancelCommend(addr: Address, duanjiID: UInt64);
        pub fun isCommended(duanjiID: UInt64);
    }

    // `Duanji` is a NFT
    pub resource Duanji: MetadataViews.Resolver {
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
    }

    // `Punster` is a NFT and a NFT collection for `Duanji`
    // This NFT will be locked for a time before being traded again
    pub resource Punster {
        pub let id: UInt64;
        pub let timestamp: UFix64;
        pub let acct: Address;

        pub let metadata: { String: String };

        pub let publishedDuanji: @{UInt64: Duanji};
        pub let followings: [Address];
        pub let followers: [Address];

        pub let followUpdates: {Address: UFix64};
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

            self.publishedDuanji <- {};

            self.followings = [];
            self.followers = [];

            self.followUpdates = {};
            self.latestUpdate = self.timestamp;
        }

        destroy () {
            destroy self.publishedDuanji;
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
                        name: self.getMetadata()["name"] ?? "Punster ".concat(self.id.toString()),
                        description: self.getMetadata()["description"] ?? "No description set",
                        thumbnail: ipfsImage
                    )
            }

            return nil
        }

        pub fun getMetadata(): {String: String} {
            return self.metadata;
        }

        // this is a NTF interface 
        // pub fun withdraw(withdrawID: UInt64): @Duanji {

        // }

        // `Duanji` transferring
        // A NFT interface
        // pub fun deposit(duanji: @Duanji) {

        // }
        
        pub fun publishDuanji(metadata: {String: String}) {

            let oldToken <-self.publishedDuanji[FunnyThings.DuanjiTotal] <- create Duanji(id: FunnyThings.DuanjiTotal, 
                                                                                        metadata: metadata);

            FunnyThings.DuanjiTotal = FunnyThings.DuanjiTotal + 1;

            self.latestUpdate = getCurrentBlock().timestamp;

            for ele in self.followers {
                let pubAcct = getAccount(ele);
                let oIPunster = pubAcct.getCapability<&{IPunster}>(FunnyThings.IPunsterPublicPath);
                if let punsterRef = oIPunster.borrow() {
                    punsterRef.notify(addr: self.acct);
                }
            }

            destroy oldToken;
        }

        // tell-fetch model. 
        // Notify followers to 
        pub fun notify(addr: Address) {
            if (self.followings.contains(addr)) {
                let pubAcct = getAccount(addr);
                let oIPunster = pubAcct.getCapability<&{IPunster}>(FunnyThings.IPunsterPublicPath);
                if let punsterRef = oIPunster.borrow() {
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
        pub fun getDuanjiFrom(timestamp: UFix64){

        }
        // Return informations of all `Duanji`
        pub fun getAllDuanji(){
            
        }

        pub fun commendToDuanji() {

        }

        pub fun cancelCommendToDuanji() {

        }

        
    }

    // one account, one `Punster` NFT
    pub fun registerPunster() {

    }
}
