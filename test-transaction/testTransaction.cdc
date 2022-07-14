import TestNFTWithViews from 0x05
import NonFungibleToken from 0x03

transaction {

  prepare(acct: AuthAccount) {}

  execute {
    let res <- TestNFTWithViews.mint(nftID: 1);

    let resRef = &res as auth &NonFungibleToken.NFT;

    log((resRef as! &TestNFTWithViews.NFT).getValue());

    destroy res;
  }
}
