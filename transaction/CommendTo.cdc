import PunstersNFT from 0x05ede3f803407aae
import NonFungibleToken from 0x05ede3f803407aae

transaction (ownerAddr: Address, duanjiID: UInt64) {
    prepare (acct: AuthAccount) {
        if let punsterRef = acct.borrow<&PunstersNFT.Collection>(from: PunstersNFT.PunsterStoragePath) {
            punsterRef.commendToDuanji(addr: ownerAddr, duanjiID: duanjiID);
        }
    }

    execute {

    }
}
