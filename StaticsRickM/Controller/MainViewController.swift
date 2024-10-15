import UIKit
import DGCharts
import RealmSwift
import Charts

class VisitorsViewController: UIViewController {

    private var statistics: Results<DataStorageStaticsRealm>?
    private let statisticsRepository: StatisticsRepositoryProtocol
    private let mainView: MainView
    
    init(statisticsRepository: StatisticsRepositoryProtocol) {
        self.statisticsRepository = statisticsRepository
        self.mainView = MainView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationTitle()
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }

//    // Функция для загрузки данных
//    private func loadData() {
//        statisticsRepository.getStatistics { [weak self] result in
//            switch result {
//            case .success(let statistics):
//                self?.statistics = statistics
//                DispatchQueue.main.async {
//                    self?.updateChartData()
//                }
//            case .failure(let error):
//                print("Ошибка: \(error)")
//            }
//        }
//    }
//
//    // Функция для обновления данных на графике
//    private func updateChartData() {
//        guard let statistics = statistics else { return }
//
//        var dataEntries: [ChartDataEntry] = []
//        
//        // Пример: создадим график для первого элемента из statistics (можно настроить выбор нужного графика)
//        if let firstStat = statistics.first {
//            for (index, date) in firstStat.dates.enumerated() {
//                let entry = ChartDataEntry(x: Double(index), y: Double(date.timeIntervalSince1970))
//                dataEntries.append(entry)
//            }
//        }
//
//        let dataSet = LineChartDataSet(entries: dataEntries, label: "Даты посещений")
//        dataSet.colors = [.blue]
//        dataSet.circleColors = [.red]
//
//        let data = LineChartData(dataSet: dataSet)
//        lineChartView.data = data
//    }
//
//    // Функция для принудительного обновления данных (Pull to Refresh)
//    @objc private func refreshData() {
//        statisticsRepository.forceUpdateStatistics { [weak self] success in
//            DispatchQueue.main.async {
//                if success {
//                    self?.loadData()
//                } else {
//                    print("Ошибка обновления данных с сервера")
//                }
//            }
//        }
//    }
}

private extension VisitorsViewController {
    private func setupNavigationTitle() {
        view.backgroundColor = UIColor(ciColor: CIColor(red: 246/255, green: 246/255, blue: 246/255))
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Статистика"
        let textAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 34)
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
    }
}
