import UIKit
import RealmSwift


final class Constants {
    static let staticsKey = "https://cars.cprogroup.ru/api/episode/statistics/"
    static let usersStaticsKey = "https://cars.cprogroup.ru/api/episode/users/"
}

final class NetworkService: NetworkServiceProtocol {
    func fetchData(completion: @escaping (Result<[[String: Any]], Error>) -> Void) {
        guard let url = URL(string: Constants.staticsKey) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let statisticsArray = json["statistics"] as? [[String: Any]] {
                    completion(.success(statisticsArray))
                } else {
                    completion(.failure(NetworkError.invalidJSON))
                }
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case invalidJSON
}
