//
//  CityWeatherVC.swift
//  WeatherApp
//
//  Created by Sachin on 03/03/21.
//

import UIKit

class CityWeatherVC: UIViewController {

    //MARK: Properties
    
    var weather: Weather?
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: view.bounds, style: .grouped)
        tv.dataSource = self
        tv.delegate = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        return tv
    }()
}

extension CityWeatherVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = weather?.cityName
        view.addSubview(tableView)
    }

}

extension CityWeatherVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "CELL_ID")
        cell.selectionStyle = .none
        cell.detailTextLabel?.font = UIFont.title3
        cell.detailTextLabel?.textColor = UIColor().AppTheme
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Temperature"
            let temp = weather?.temp ?? 0
            cell.detailTextLabel?.text = "\(temp) °C"
        case 1:
            cell.textLabel?.text = "Feels Like"
            let feels_like = weather?.feels_like ?? 0
            cell.detailTextLabel?.text = "\(feels_like) °C"
        case 2:
            cell.textLabel?.text = "Minimum Temperature"
            let temp_min = weather?.temp_min ?? 0
            cell.detailTextLabel?.text = "\(temp_min) °C"
        case 3:
            cell.textLabel?.text = "Maximum Temperature"
            let temp_max = weather?.temp_max ?? 0
            cell.detailTextLabel?.text = "\(temp_max) °C"
        case 4:
            cell.textLabel?.text = "Humidity"
            let humidity = weather?.humidity ?? 0
            cell.detailTextLabel?.text = "\(humidity) %"
        case 5:
            cell.textLabel?.text = "Pressure"
            let pressure = weather?.pressure ?? 0
            cell.detailTextLabel?.text = "\(pressure) hPa"
        default:
            break
        }
        
        return cell
    }
    
    
}

extension CityWeatherVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
}
