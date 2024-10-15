import UIKit
import RealmSwift

//отвечает за загрузку данных с сервера. Принцип SRP.
protocol NetworkServiceProtocol {
    func fetchData(completion: @escaping(Result<[[String: Any]], Error>) -> Void)
}

//отвечает за взаимодействие с базой данных Realm. Принцип SRP.
protocol RealmServiceProtocol {
    func saveStatistics(statisticsArray: [[String: Any]])
    func fetchStatistics() -> Results<DataStorageStaticsRealm>
}
//StatisticsRepository — отвечает за логику объединения данных из сети и базы. Он "закрыт" для изменений, но "открыт" для расширений (например, если поменять источник данных). Принцип OCP.
protocol StatisticsRepositoryProtocol {
    func getStatistics(completion: @escaping (Result<Results<DataStorageStaticsRealm>, Error>) -> Void)
    func forceUpdateStatistics(completion: @escaping (Bool) -> Void)
}
