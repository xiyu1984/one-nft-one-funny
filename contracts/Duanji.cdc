pub contract FunnyThings {
    
    // This `I` is not mean 'Interface' but 'Interaction'
    pub resource interface IFunnyGuy {
        // tell-fetch model. 
        // Notify followers to 
        pub fun notify(addr: Address, link: String);
        // return last update timestamp, that is `fun getCurrentBlock(): Block`
        pub fun getLatestUpdate(): UInt64;
        pub fn getUpdateInfo(timestamp: UInt64);

        // tell-fetch model.
        // Follow some funnyguy
        pub fun follow(addr: Address, link: String);
        pub fun isFollowing(addr: Address);

        // tell-fetch model.
        // Get `Duanji` information
        
    }

    pub resource interface IDuanji {

    }

    pub resource interface IFGVault {

    }


    // `Duanji` is a NFT
    pub resource Duanji {
        
        pub fun 
        
        pub fun commend() {

        }

        pub fun cancelCommend() {

        }
    }

    // `FunnyGuy` is a NFT
    // This NFT will be locked for a time before being traded again
    pub resource FunnyGuy {
        pub fun publishDuanji() {

        }

        pub fun commendDuanji() {

        }

        pub fun cancelCommendDuanji() {

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

    // Bind to an account. Help users to manage their `FunnyGuy` resource.
    pub resource FunnyVault {

    }
}
