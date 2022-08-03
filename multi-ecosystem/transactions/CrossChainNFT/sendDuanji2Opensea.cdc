import PunstersNFT from "../../../contracts/Punsters.cdc"
import Locker from "../../../contracts/Locker.cdc"

transaction(hashValue: String, owner: String, duanjiID: UInt64) {

    prepare(acct: AuthAccount) {
        let punsterRef = acct.borrow<&PunstersNFT.Collection>(from: PunstersNFT.PunsterStoragePath)!;

        let duanji <- punsterRef.withdraw(withdrawID: duanjiID);

        Locker.sendCrossChainNFT(transferToken: <- duanji, 
                                signerAddress: acct.address, 
                                id: duanjiID, 
                                owner: owner, 
                                hashValue: hashValue);
    }

    execute {
        
    }
}
