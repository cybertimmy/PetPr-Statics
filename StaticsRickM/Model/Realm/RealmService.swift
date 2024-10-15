import UIKit
import RealmSwift

final class RealmService: RealmServiceProtocol {
    private let realm = try! Realm()

    func saveStatistics(statisticsArray: [[String: Any]]) {
        try! realm.write {
            for statDict in statisticsArray {
                let userID = statDict["user_id"] as? Int ?? 0
                let type = statDict["type"] as? String ?? ""

                if let existingStat = realm.objects(DataStorageStaticsRealm.self)
                                          .filter("userID == %@ AND type == %@", userID, type).first {
                    existingStat.dates.append(objectsIn: statDict["dates"] as? [Date] ?? [])
                } else {
                    let realmStat = DataStorageStaticsRealm()
                    realmStat.userID = userID
                    realmStat.type = type

                    if let dateNumbers = statDict["dates"] as? [Int] {
                        let dates = dateNumbers.map { Date(timeIntervalSince1970: TimeInterval($0)) }
                        realmStat.dates.append(objectsIn: dates)
                    }

                    realm.add(realmStat)
                }
            }
        }
    }

    func fetchStatistics() -> Results<DataStorageStaticsRealm> {
        return realm.objects(DataStorageStaticsRealm.self)
    }
}
