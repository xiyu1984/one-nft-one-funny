import PunstersNFT from 0x05ede3f803407aae
import NonFungibleToken from 0x05ede3f803407aae

transaction (description: String, ipfsURL: String) {

  prepare(acct: AuthAccount) {

      let punster <- PunstersNFT.registerPunster(addr: acct.address, 
                                                description: "Punster: ".concat(acct.address.toString()).concat(". ").concat(description), 
                                                ipfsURL: ipfsURL);

      acct.save(<-punster, to: PunstersNFT.PunsterStoragePath);
      acct.link<&{PunstersNFT.IPunsterPublic}>(PunstersNFT.IPunsterPublicPath, target: PunstersNFT.PunsterStoragePath);
  }

  execute {
    
  }
}
