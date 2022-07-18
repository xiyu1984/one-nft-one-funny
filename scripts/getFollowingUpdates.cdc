import PunstersNFT from 0x05ede3f803407aae

pub fun main(addr: Address): [PunstersNFT.DuanjiView] {
    if let punsterRef = PunstersNFT.getIPunsterFromAddress(addr: addr) {
        return punsterRef.getFollowingUpdates();
    }
    
    return [];
}
