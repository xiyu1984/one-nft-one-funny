import PunstersNFT from 0x05ede3f803407aae
import NonFungibleToken from 0x05ede3f803407aae

transaction {

  prepare(acct: AuthAccount) {
      let punster <- PunstersNFT.registerPunster(addr: acct.address, description: "Punster: ".concat(acct.address.toString()), ipfsURL: "my ipfs url");

      punster.publishDuanji(description: "Duanji from ".concat(acct.address.toString()), ipfsURL: "my ipfs url");

      let id = punster.getAllDuanji();

      let nft = punster.getAllDuanjiView();

      log(nft);

      acct.save(<-punster, to: PunstersNFT.PunsterStoragePath);
      acct.link<&{PunstersNFT.IPunsterPublic}>(PunstersNFT.IPunsterPublicPath, target: PunstersNFT.PunsterStoragePath);
  }

  execute {
    
  }
}
