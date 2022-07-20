import StarRealm from "../../contracts/StarRealm.cdc"
import PunstersNFT from "../../contracts/Punsters.cdc"
import NonFungibleToken from "../../contracts/NonFungibleToken.cdc"

pub fun main(): { String: AnyStruct } {
    let punster <- PunstersNFT.registerPunster(addr: 0x01, description: "test punster", ipfsURL: "test url");

    let starportOne <- StarRealm.createStarPort();

    starportOne.docking(punster: <- punster);

    let starportTwo <- StarRealm.createStarPort();

    let sailingPunster <- starportOne.sailing();

    // `as`: the result type is just the type of the right one
    // `as?`: the result type is the type of right one + ?, which is used for left type is different from the right one
    // `as!`: the result type is the forced casting of `as?`, which is also used for left type is different from the right one 
    
    // let testType: auth &NonFungibleToken.Collection = (&sailingPunster as auth &NonFungibleToken.Collection?)!
    let psRef: &PunstersNFT.Collection = (&sailingPunster as auth &NonFungibleToken.Collection?)! as! &PunstersNFT.Collection;

    let psView = psRef.metadata;

    starportTwo.docking(punster: <- sailingPunster!);

    // destroy punster;
    // destroy sailingPunster;
    destroy starportOne;
    destroy starportTwo;

    return psView;
}
