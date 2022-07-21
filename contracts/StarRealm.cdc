import NonFungibleToken from "./NonFungibleToken.cdc"

pub contract StarRealm {
    // -----------------------------------------------------------------------
    // StarDocker API, used for locker
    // -----------------------------------------------------------------------
    pub resource interface StarDocker {
        pub fun docking(nft: @AnyResource{NonFungibleToken.INFT});
    }

    pub resource StarPort: StarDocker {
        priv var punster: @AnyResource{NonFungibleToken.INFT}?;

        init() {
            self.punster <- nil;
        }

        pub fun sailing(): @AnyResource{NonFungibleToken.INFT}? {
            if let punsterRes <- self.punster <- nil {
                return <- punsterRes;
            } else {
                return nil
            }
        }

        // -----------------------------------------------------------------------
        // StarDocker API, used for locker
        // -----------------------------------------------------------------------
        pub fun docking(nft: @AnyResource{NonFungibleToken.INFT}) {
            // if let oldpunster <- self.punster <- punster {
            //     destroy oldpunster
            // } else {
            //     self.punster <-! punster;
            // }
            let oldpunster <- self.punster <- nft;
            destroy oldpunster;
        }

        destroy() {
            destroy self.punster;
        }
    }

    pub fun createStarPort(): @StarPort {
        return <- create StarPort();
    }
}