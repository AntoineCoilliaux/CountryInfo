# CountryInfo 🌍

**CountryInfo** is a simple iOS app built with Swift and UIKit that displays random information about independent countries using the REST Countries API. The app shows the country’s name, flag, capital city, and population.

---

## Features

- Fetches random independent countries from the [REST Countries API](https://restcountries.com).
- Displays:
  - Country name  
  - Flag image  
  - Capital city  
  - Population (formatted with commas)
- UI fully built programmatically in Swift (no Storyboard).
- Tap the **Next** button to load a new random country.

---

## Technologies Used

- Swift 5
- UIKit (programmatic UI)
- `URLSession` for network requests
- `JSONDecoder` for parsing JSON
- Auto Layout with `NSLayoutConstraint`
- Delegate pattern for communication between classes

---

## Getting started

To run the project locally:

- Clone this repository
- Open CountryInfo.xcodeproj in Xcode
- Build and run on a simulator (or real device)

## Project Structure
- CountryManager.swift – Handles API calls and data processing.
- CountryModel.swift – Defines the model used to represent a country.
- CountryData.swift – Structures used for decoding API responses.
- CountryViewController.swift – Sets up and manages the UI.
