import RealmSwift
import Foundation

class StaticsRealm: Object {
    @Persisted var statistics = List<DataStorageStaticsRealm>()
}

class DataStorageStaticsRealm: Object {
    @Persisted var userID: Int = 0
    @Persisted var type: String = ""
    @Persisted var dates = List<Date>()
}
