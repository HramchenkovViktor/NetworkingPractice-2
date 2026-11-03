//
//  ViewController.swift
//  NetworkingPractice#2
//
//  Created by Виктор on 03.11.2026.
//

import UIKit

class ViewController: UIViewController {

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Загрузка..."
        return label
    }()
    private let heightLabel: UILabel = {
        let label = UILabel()
        label.text = "Загрузка..."
        return label
    } ()
    private let massLabel: UILabel = {
        let label = UILabel()
        label.text = "Загрузка..."
        return label
    }()
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Загрузка..."
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            await loadCharacter()
        }
    }

    private func loadCharacter() async {
        guard let url = URL(string: "https://swapi.info/api/people/1") else { print("Неверный URL")
        return }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print ("Ошибка при создании HTTPURLResponse")
                return
                
                
            }
            
          
            
             guard (200..<300).contains(httpResponse.statusCode) else {
                 print ("Ошибка HTTP: \(httpResponse.statusCode)")
                 return
            }
            
            let character = try JSONDecoder().decode(StarWarsCharacter.self, from: data)
                  print("Имя персонажа: \( character.name)")
                  print("рост: \( character.height)")
                  print("вес: \( character.mass)")
                  print("пол: \( character.gender)")

        } catch {
            print(error)
        }
    }
}
