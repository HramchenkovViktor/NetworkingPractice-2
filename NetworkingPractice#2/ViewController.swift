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
    
    private var characters: [StarWarsCharacter] = []
    
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
        
        characterCollectionView.delegate = self
        characterCollectionView.dataSource = self
        
        characterCollectionView.register(
            CharacterCell.self,
            forCellWithReuseIdentifier: CharacterCell.reuseIdentifier
        )
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
            await MainActor.run {
                self.characters = characters
                self.characterCollectionView.reloadData()
            }
      

        } catch {
            print(error)


        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharacterCell.reuseIdentifier,
            for: indexPath
        ) as? CharacterCell else {
            return UICollectionViewCell()
        }

        let character = characters[indexPath.item]

        cell.configure(with: character)

        return cell
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

        let spacing: CGFloat = 12
        let width = (collectionView.bounds.width - spacing) / 2

        return CGSize(width: width, height: 290)
    }
    
}
