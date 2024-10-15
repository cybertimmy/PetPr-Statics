import UIKit
import DGCharts

final class ChartManager {

    static func settingFirstChart(with data: [Double], in chartView: LineChartView) {
    
        for (index, value) in data.enumerated() {
            let entry = ChartDataEntry(x: Double(index), y: value)
            DataStoragaCharts.dataEntries.append(entry)
        }
        
        let dataSet = LineChartDataSet(entries: DataStoragaCharts.dataEntries, label: "") // Удаляем заголовок
        dataSet.lineWidth = 3.0 // Устанавливаем толщину линии
        dataSet.mode = .cubicBezier
        dataSet.setColor(UIColor(red: 66/255, green: 176/255, blue: 119/255, alpha: 1.0)) // Цвет линии
        dataSet.drawValuesEnabled = false // Отключаем отображение значений
        dataSet.drawCirclesEnabled = false // Включаем отображение кругов на точках
        
        guard let lastEntry = DataStoragaCharts.dataEntries.last else { return }
        let lastDataSet = LineChartDataSet(entries: [lastEntry], label: "")
        lastDataSet.circleRadius = 5.0 // Радиус точки на конце линии
        lastDataSet.circleColors = [UIColor.red] // Цвет точки
        lastDataSet.drawValuesEnabled = false // Отключаем отображение значений
        lastDataSet.drawCirclesEnabled = true // Включаем отображение круга только для последней точки
        lastDataSet.setColor(.clear) // Прозрачная линия, чтобы не отображалась
        
        // Объединяем оба набора данных
        chartView.data = LineChartData(dataSets: [dataSet, lastDataSet])
        
        let chartData = LineChartData(dataSet: dataSet)
        chartView.data = chartData
        
        // Отключаем отображение осей и сетки
        chartView.xAxis.drawLabelsEnabled = false // Отключаем метки по оси X
        chartView.leftAxis.drawLabelsEnabled = false // Отключаем метки по оси Y
        chartView.rightAxis.drawLabelsEnabled = false // Отключаем метки по оси Y (если есть)
        chartView.xAxis.drawGridLinesEnabled = false // Отключаем сетку по оси X
        chartView.leftAxis.drawGridLinesEnabled = false // Отключаем сетку по оси Y
        chartView.rightAxis.drawGridLinesEnabled = false // Отключаем сетку по оси Y (если есть)
        chartView.legend.enabled = false // Отключаем легенду
        chartView.highlightPerTapEnabled = true // Отключаем подсветку при нажатии
        chartView.drawGridBackgroundEnabled = false
        chartView.isUserInteractionEnabled = false
        chartView.xAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        chartView.drawBordersEnabled = false
        chartView.minOffset = 0
        chartView.setExtraOffsets(left: 10, top: 10, right: 10, bottom: 10)
        chartView.layer.shadowColor = UIColor.black.cgColor
        chartView.layer.shadowOffset = CGSize(width: 0, height: 7)
        chartView.layer.shadowOpacity = 0.3
        chartView.layer.shadowRadius = 3
    }
}
