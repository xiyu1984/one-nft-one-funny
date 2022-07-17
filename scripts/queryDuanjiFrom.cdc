import PunstersNFT from 0x05ede3f803407aae

pub fun main(addr: Address): [PunstersNFT.DuanjiView]? {
    
    var duanjiView: [PunstersNFT.DuanjiView] = []

    var rst: UInt64 = 0;

    if let punsterRef = PunstersNFT.getIPunsterFromAddress(addr: addr) {
        duanjiView.concat(punsterRef.getAllDuanjiView());
        rst = punsterRef.getAllDuanji()[0];
        duanjiView = duanjiView.concat(punsterRef.getAllDuanjiView());
        return duanjiView;
    }

    // let pubAcct = getAccount(addr);
    // let oIPunster = pubAcct.getCapability<&{PunstersNFT.IPunsterPublic}>(PunstersNFT.IPunsterPublicPath);
    // duanjiView.concat(oIPunster.borrow()!.getAllDuanjiView());

    return nil;
}