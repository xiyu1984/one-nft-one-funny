import PunstersNFT from 0x05ede3f803407aae

pub fun main(): {UInt64: Address} {
    return PunstersNFT.getRegisteredPunsters();
}