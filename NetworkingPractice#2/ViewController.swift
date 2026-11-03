//
//  ViewController.swift
//  NetworkingPractice#2
//
//  Created by Виктор on 03.11.2026.
//


import UIKit
import SnapKit

class ViewController: UIViewController {
    

    
    private let characterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 16

        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )

        collectionView.backgroundColor = .clear

        return collectionView
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

        
  //      view.addSubview(characterStackView)
        view.addSubview(characterCollectionView)
    }
    
    private func setupConstreints() {
        characterCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func loadCharacter() async {
        guard let url = URL(string: "https://swapi.info/api/people") else {
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
            
            let characters = try JSONDecoder().decode([StarWarsCharacter].self, from: data)
            
            for character in characters {
                print(character.name)
            }
      

        } catch {
            print(error)


        }
    }
}
