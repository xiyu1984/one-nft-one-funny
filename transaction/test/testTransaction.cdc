import PunstersNFT from "../../contracts/Punsters.cdc"
import NonFungibleToken from "../../contracts/NonFungibleToken.cdc"

transaction {

  prepare(acct: AuthAccount) {}

  execute {
    let res <- TestNFTWithViews.mint(nftID: 1);

    let resRef = &res as auth &NonFungibleToken.NFT;

    log((resRef as! &TestNFTWithViews.NFT).getValue());

    destroy res;
  }
}
