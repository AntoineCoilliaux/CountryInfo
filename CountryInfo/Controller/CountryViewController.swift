//
//  ViewController.swift
//  CountryInfo
//
//  Created by Antoine Coilliaux on 25/06/2025.
//

import UIKit

class CountryViewController: UIViewController {

    var countryManager = CountryManager()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.17, green: 0.24, blue: 0.31, alpha: 1.00)
        setupUI()
        countryManager.delegate = self
        countryManager.performRequest()

    }
    
    @objc func nextButtonPressed() {
        countryManager.performRequest()
    }

//MARK: - UI
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Countries"
        label.font = UIFont.systemFont(ofSize: 38, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let capitalLabel: UILabel = {
        let label = UILabel()
        label.text = "Capital city:"
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let populationLabel: UILabel = {
        let label = UILabel()
        label.text = "Population:"
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Let's travel!", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .white
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    func setupUI() {
        // Ajouter tous les éléments à la vue
        view.addSubview(titleLabel)
        view.addSubview(flagImageView)
        view.addSubview(capitalLabel)
        view.addSubview(populationLabel)
        view.addSubview(nextButton)
        
        // Contraintes pour le titleLabel
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20),
            
            
            // Contraintes pour l'image du drapeau
            flagImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            flagImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            flagImageView.widthAnchor.constraint(equalToConstant: 200),
            flagImageView.heightAnchor.constraint(equalToConstant: 120),
            
            // Contraintes pour la capitale
            capitalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            capitalLabel.topAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: 50),
            capitalLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            capitalLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20),
            
            // Contraintes pour la population
            populationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            populationLabel.topAnchor.constraint(equalTo: capitalLabel.bottomAnchor, constant: 50),
            populationLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            populationLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20),
            
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            nextButton.widthAnchor.constraint(equalToConstant: 130),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        // Action du bouton
            nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
    }

}
//MARK: - Country Manager Delegate
extension CountryViewController: CountryManagerDelegate {
    func didUpdateCountry(country: CountryModel) {
        DispatchQueue.main.async {
            self.titleLabel.text = country.name
            self.capitalLabel.text = "Capital city: \(country.capital)"
                   let formatter = NumberFormatter()
                   formatter.numberStyle = .decimal
                    formatter.locale = Locale(identifier: "en_US")
                   let formattedPopulation = formatter.string(from: NSNumber(value: country.population)) ?? "\(country.population)"
                   
                   self.populationLabel.text = "Population: \(formattedPopulation) inhabitants"
            
            if let url = URL(string: country.flagURL) {
                        URLSession.shared.dataTask(with: url) { data, _, error in
                            if let data = data, error == nil {
                                DispatchQueue.main.async {
                                    self.flagImageView.image = UIImage(data: data)
                                }
                            }
                        }.resume()
                    }
                }
            }

    
    func didFailWithError(error: any Error) {
        print(error)
    }
}
