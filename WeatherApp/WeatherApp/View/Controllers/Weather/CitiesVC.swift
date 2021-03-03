//
//  CitiesVC.swift
//  WeatherApp
//
//  Created by Sachin on 03/03/21.
//

import UIKit

let cellId = "CELL_ID"

class CitiesVC: UIViewController {

    var cityViewModel: CitiesViewModel?
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: view.bounds, style: .grouped)
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Cities"
        view.addSubview(tableView)
        fetchWeather()
      
    }
    
    func fetchWeather() {
        APIManager.shared.fetchWeather { (response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let response = response else { return }
            print(response)
            self.cityViewModel = CitiesViewModel(weatherData: response)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension CitiesVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cityViewModel?.cities.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = self.cityViewModel?.cities[indexPath.row].cityName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}

extension CitiesVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weather = self.cityViewModel?.cities[indexPath.row]
        let vc = CityWeatherVC()
        vc.weather = weather
        navigationController?.pushViewController(vc, animated: true)
    }
}
