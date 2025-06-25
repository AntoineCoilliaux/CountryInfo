//
//  CountryManager.swift
//  CountryInfo
//
//  Created by Antoine Coilliaux on 25/06/2025.
//

import Foundation
protocol CountryManagerDelegate {
    func didUpdateCountry(country: CountryModel)
    func didFailWithError(error: Error)
    
}

struct CountryManager {
    
    var delegate: CountryManagerDelegate?
    
    let URLString = "https://restcountries.com/v3.1/independent?status=true&fields=name,flags,capital,population"
    
    func performRequest() {
        let url = URL(string: URLString)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                delegate?.didFailWithError(error: error!)
                print(error!)
                return
            }
            
            if let safeData = data {
                if let country = self.parseJSON(safeData) {
                    delegate?.didUpdateCountry(country: country)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(_ data: Data) -> CountryModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([CountryData].self, from: data)
            guard let country = decodedData.randomElement() else { return nil }

            let name = country.name.common
            let capital = country.capital.first ?? "No capital"
            let population = country.population
            let flagURL = country.flags.png

            return CountryModel(name: name, capital: capital, population: population, flagURL: flagURL)
        } catch {
            print(error)
            return nil
        }
    }

}
