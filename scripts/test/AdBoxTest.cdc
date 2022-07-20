import PunstersNFT from "../../contracts/Punsters.cdc"

pub fun main(): Fix64{
    let adBox = PunstersNFT.AdBox();

    let dv = PunstersNFT.DuanjiView(id: 0, 
                                    owner: 0x01, 
                                    description: "heihei", 
                                    ipfsUrl: "ipfs", 
                                    fidx: 0, 
                                    true);

    if (adBox.publishAD(dv: dv, fi: 100000000)) {
        return adBox.getRemainingTime()
    }

    return -1.0;
}