import PunstersNFT from 0x04
import NonFungibleToken from 0x03

transaction {

  prepare(acct: AuthAccount) {}

  execute {
    let punster <- PunstersNFT.registerPunster(addr: 0x01, description: "First Punster", ipfsURL: "my ipfs url");

    punster.publishDuanji(description: "First Duanji", ipfsURL: "my ipfs url");

    let id = punster.getAllDuanji();

    let nft = punster.getAllDuanjiView();

    log(nft);

    destroy punster;
  }
}
