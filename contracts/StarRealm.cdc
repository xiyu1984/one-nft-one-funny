import NonFungibleToken from "./NonFungibleToken.cdc"

pub contract StarRealm {
    pub resource interface StarDocker {
        pub fun docking(punster: @NonFungibleToken.Collection);
    }

    pub resource StarPort: StarDocker {
        priv var punster: @NonFungibleToken.Collection?;

        init() {
            self.punster <- nil;
        }

        pub fun sailing(): @NonFungibleToken.Collection? {
            if let punsterRes <- self.punster <- nil {
                return <- punsterRes;
            } else {
                return nil
            }
        }

        pub fun docking(punster: @NonFungibleToken.Collection) {
            // if let oldpunster <- self.punster <- punster {
            //     destroy oldpunster
            // } else {
            //     self.punster <-! punster;
            // }
            let oldpunster <- self.punster <- punster;
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