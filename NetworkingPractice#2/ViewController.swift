//
//  ViewController.swift
//  NetworkingPractice#2
//
//  Created by Виктор on 03.11.2026.
//


import UIKit
import SnapKit

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
    }()

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

    private let characterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .leading
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstreints()

        Task {
            await loadCharacter()
        }
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground

        characterStackView.addArrangedSubview(nameLabel)
        characterStackView.addArrangedSubview(heightLabel)
        characterStackView.addArrangedSubview(massLabel)
        characterStackView.addArrangedSubview(genderLabel)

        view.addSubview(characterStackView)
    }

    private func setupConstreints() {

    }

    private func loadCharacter() async {
        guard let url = URL(string: "https://swapi.info/api/people/1") else {
            print("Неверный URL")
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse else {
                print("Ошибка при создании HTTPURLResponse")
                return
            }

            guard (200..<300).contains(httpResponse.statusCode) else {
                print("Ошибка HTTP: \(httpResponse.statusCode)")
                return
            }

            let character = try JSONDecoder().decode(StarWarsCharacter.self, from: data)

            print("Имя персонажа: \(character.name)")
            print("рост: \(character.height)")
            print("вес: \(character.mass)")
            print("пол: \(character.gender)")

        } catch {
            print(error)
        }
    }
}

