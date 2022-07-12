pub contract FunnyThings {
    pub let FunnyGuyStoragePath: StoragePath;
    pub let IFunnyGuyPublicPath: PublicPath;
    pub let IFunnyIndexPublicPath: PublicPath;
    // pub let DuanjiStoragePath: StoragePath;
    // pub let IDuanjiPublicPath: PublicPath;

    access(contract) var FunnyGuyTotal: UInt64;
    access(contract) var DuanjiTotal: UInt64;

    init() {
        self.FunnyGuyStoragePath = /storage/FunnyGuyStoragePath;
        self.IFunnyGuyPublicPath = /public/IFunnyGuyPublicPath;
        self.IFunnyIndexPublicPath = /public/IFunnyIndexPublicPath;
        // self.DuanjiStoragePath = /storage/DuanjiStoragePath;
        // self.IDuanjiPublicPath = /public/IDuanjiPublicPath;

        self.FunnyGuyTotal = 1;
        self.DuanjiTotal = 1;
    }

    pub resource interface IFunnyIndex {
        pub fun getDuanjiFunnyIndex(duanjiID: UInt64): UInt32;
        pub fun getFunnyGuyFunnyIndex(): UInt32;
    }

    // This `I` is not mean 'Interface' but 'Interaction'
    pub resource interface IFunnyGuy {
        // tell-fetch model. 
        // Notify followers to 
        pub fun notify(addr: Address);
        // return last update timestamp, that is `fun getCurrentBlock(): Block`
        pub fun getLatestUpdate(): UInt64;
        pub fun getUpdateInfo(timestamp: UInt64);

        // tell-fetch model.
        // Follow some funnyguy
        pub fun follow(addr: Address, link: String);
        pub fun isFollowing(addr: Address);

        // Get `Duanji` information
        // Return informations of `Duanji` the time after `timestamp`
        pub fun getDuanjiFrom(timestamp: UInt64);
        // Return informations of all `Duanji`
        pub fun getAllDuanji();

        // tell-fetch model
        // Receive `Duanji` commending from others
        pub fun ReceiveCommend(addr: Address, duanjiID: UInt64);
        pub fun ReceiveCancelCommend(addr: Address, duanjiID: UInt64);
        pub fun isCommended(duanjiID: UInt64);
    }

    // `Duanji` is a NFT
    pub resource Duanji {
        pub let id: UInt64;

        pub let name: String;
        pub let description: String;
        pub let thumbnail: String;

        priv let commends: [Address];
        // priv let funnyIndex: UInt32;

        init(
            id: UInt64,
            name: String,
            description: String,
            thumbnail: String,
        ) {
            self.id = id;
            self.name = name;
            self.description = description;
            self.thumbnail = thumbnail;
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
    }

    // `FunnyGuy` is a NFT and a NFT collection
    // This NFT will be locked for a time before being traded again
    pub resource FunnyGuy {
        pub let id: UInt64;

        pub let name: String;
        pub let description: String;
        pub let thumbnail: String;

        pub let publishedDuanji: @{UInt64: Duanji};
        pub let followings: {Address: [UInt64]};
        pub let followers: [Address];

        init(
            id: UInt64,
            name: String,
            description: String,
            thumbnail: String,
        ) {
            self.id = id;
            self.name = name;
            self.description = description;
            self.thumbnail = thumbnail;

            self.publishedDuanji <- {};

            self.followings = {};
            self.followers = [];
        }

        destroy () {
            destroy self.publishedDuanji;
        }

        // this is a NTF interface 
        // pub fun withdraw(withdrawID: UInt64): @Duanji {

        // }

        // `Duanji` transferring
        // A NFT interface
        // pub fun deposit(duanji: @Duanji) {

        // }
        
        pub fun publishDuanji(
                                name: String,
                                description: String,
                                thumbnail: String,
                            ){

            let oldToken <-self.publishedDuanji[FunnyThings.DuanjiTotal] <- create Duanji(id: FunnyThings.DuanjiTotal, 
                                                                                        name: name,
                                                                                        description: description,
                                                                                        thumbnail: thumbnail);

            FunnyThings.DuanjiTotal = FunnyThings.DuanjiTotal + 1;

            destroy oldToken;
        }

        pub fun commendToDuanji() {

        }

        pub fun cancelCommendToDuanji() {

        }

        pub fun followSomeone() {

        }

        pub fun beFollowed() {

        }

        pub fun getFollowing(){

        }

        pub fun getFollowers() {

        }

        pub fun isFollowing() {

        }

        pub fun isFollowed() {

        }
    }

    // one account, one `FunnyGuy` NFT
    pub fun registerFunnyGuy() {

    }
}
