import PunstersNFT from 0x05ede3f803407aae

pub fun main(addr: Address): AnyStruct? {
    
    if let punsterRef = PunstersNFT.getIPunsterFromAddress(addr: addr) {
        return punsterRef.getPunsterView();
    }
    
    return nil;
}