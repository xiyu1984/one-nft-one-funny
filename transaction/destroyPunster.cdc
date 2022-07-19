import PunstersNFT from 0x05ede3f803407aae
import NonFungibleToken from 0x05ede3f803407aae

transaction (description: String, ipfsURL: String) {

  prepare(acct: AuthAccount) {

    if let resPunster <- acct.load<PunstersNFT.Collection>(from: PunstersNFT.PunsterStoragePath) {
        PunstersNFT.destroyPunsters(resPunster: resPunster);
    }
  }

  execute {
    
  }
}