import PunstersNFT from "../../../contracts/Punsters.cdc"
import Locker from "../../../contracts/Locker.cdc"
import StarRealm from "../../../contracts/StarRealm.cdc"

transaction(id: UInt64, answer: String) {

    prepare(acct: AuthAccount) {
        Locker.claimNFT(id: id, answer: answer);

        let starPortRef = acct.borrow<&StarRealm.StarPort>(from: StarRealm.PortStoragePath)!;

        let punster <- starPortRef.sailing()! as! @PunstersNFT.Collection;

        acct.unlink(StarRealm.DockerPublicPath);
        acct.save(<-punster, to: PunstersNFT.PunsterStoragePath);

        acct.link<&{PunstersNFT.IPunsterPublic}>(PunstersNFT.IPunsterPublicPath, target: PunstersNFT.PunsterStoragePath);
        acct.link<&{StarRealm.StarDocker}>(StarRealm.DockerPublicPath, target: PunstersNFT.PunsterStoragePath);
    }

    execute {
        
    }
}
