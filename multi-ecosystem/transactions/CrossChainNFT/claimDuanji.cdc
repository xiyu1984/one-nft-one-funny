import PunstersNFT from "../../../contracts/Punsters.cdc"
import Locker from "../../../contracts/Locker.cdc"

transaction(id: UInt64, answer: String) {

    prepare(acct: AuthAccount) {
        Locker.claimNFT(id: id, answer: answer);
    }

    execute {
        
    }
}