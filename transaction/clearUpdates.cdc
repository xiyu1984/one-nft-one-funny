import PunstersNFT from 0x05ede3f803407aae
import NonFungibleToken from 0x05ede3f803407aae

transaction () {
    prepare (acct: AuthAccount) {
        if let punsterRef = acct.borrow<&PunstersNFT.Collection>(from: PunstersNFT.PunsterStoragePath) {
            punsterRef.clearUpdate();
        }
    }

    execute {

    }
}