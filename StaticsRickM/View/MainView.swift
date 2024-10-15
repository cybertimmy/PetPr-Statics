import UIKit
import DGCharts

final class MainView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Посетители"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        guard let image = UIImage.imageArrowUP else {
            imageView.image = nil
            return imageView
        }
        imageView.image = image
        return imageView
    }()
    
    private let graphView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Количество посетителей в этом месяце выросло"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    private let staticsLabel: UILabel = {
        let label = UILabel()
        label.text = "1356"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.noDataText = "Нет данных"
        return chartView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        // Данные для графика (пример)
        let data1: [Double] = [100, 50, 500, 500, 300, 350, 800]
        ChartManager.settingFirstChart(with: data1, in: lineChartView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAppearance() {
        self.backgroundColor = .systemBackground
        self.addSubviews(titleLabel,
                         graphView)
        self.graphView.addSubviews(lineChartView,
                                   infoLabel,
                                   imageView,
                                   staticsLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            graphView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            graphView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            graphView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            graphView.heightAnchor.constraint(equalToConstant: 100),
            
            lineChartView.trailingAnchor.constraint(equalTo: graphView.trailingAnchor, constant: -220),
            lineChartView.leadingAnchor.constraint(equalTo: graphView.leadingAnchor, constant: 10), //
            lineChartView.topAnchor.constraint(equalTo: graphView.topAnchor, constant: 23),
            lineChartView.heightAnchor.constraint(equalToConstant: 50),
            
            staticsLabel.topAnchor.constraint(equalTo: graphView.topAnchor, constant: 20),
            staticsLabel.trailingAnchor.constraint(equalTo: graphView.trailingAnchor, constant: -155),
            
            imageView.topAnchor.constraint(equalTo: graphView.topAnchor, constant: 25),
            imageView.leadingAnchor.constraint(equalTo: staticsLabel.leadingAnchor, constant: 50),
            
            infoLabel.trailingAnchor.constraint(equalTo: graphView.trailingAnchor, constant: -15),
            infoLabel.bottomAnchor.constraint(equalTo: graphView.bottomAnchor, constant: -15),
            infoLabel.widthAnchor.constraint(equalToConstant: 189),
        ])
    }
}
