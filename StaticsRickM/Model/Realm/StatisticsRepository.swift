import UIKit
import RealmSwift


final class StatisticsRepository: StatisticsRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    private let realmService: RealmServiceProtocol

    init(networkService: NetworkServiceProtocol, realmService: RealmServiceProtocol) {
        self.networkService = networkService
        self.realmService = realmService
    }
    
    func getStatistics(completion: @escaping (Result<Results<DataStorageStaticsRealm>, Error>) -> Void) {
        let localData = realmService.fetchStatistics()
        
        if localData.isEmpty {
            networkService.fetchData { result in
                switch result {
                case .success(let statisticsArray):
                    self.realmService.saveStatistics(statisticsArray: statisticsArray)
                    let updatedData = self.realmService.fetchStatistics()
                    completion(.success(updatedData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            completion(.success(localData))
        }
    }

    func forceUpdateStatistics(completion: @escaping (Bool) -> Void) {
        networkService.fetchData { result in
            switch result {
            case .success(let statisticsArray):
                self.realmService.saveStatistics(statisticsArray: statisticsArray)
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
}
