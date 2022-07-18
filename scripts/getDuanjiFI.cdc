import PunstersNFT from 0x05ede3f803407aae

pub fun main(addr: Address, id: UInt64): UInt32? {
    return PunstersNFT.getDuanjiFunnyIndex(ownerAddr: addr, duanjiID: id);
}