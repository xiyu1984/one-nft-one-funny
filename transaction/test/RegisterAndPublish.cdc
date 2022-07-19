import PunstersNFT from "../../contracts/Punsters.cdc"
import NonFungibleToken from "../../contracts/NonFungibleToken.cdc"

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
