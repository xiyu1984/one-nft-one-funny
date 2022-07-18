import PunstersNFT from 0x05ede3f803407aae

pub fun main(addr: Address): UInt32? {
    return PunstersNFT.getPunsterFunnyIndex(ownerAddr: addr);
}
