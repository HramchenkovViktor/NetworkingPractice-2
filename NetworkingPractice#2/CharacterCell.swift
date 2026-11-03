//
//  CharacterCell.swift
//  NetworkingPractice#2
//
//  Created by Виктор on 03.11.2026.
//

import UIKit
import SnapKit

final class CharacterCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CharacterCell"
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .label
        label.numberOfLines = 2
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
        contentView.addSubview(characterImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(infoLabel)
        
        setupConstraints()
        
    }
    
    private func setupConstraints() {

        characterImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(190)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(characterImageView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.bottom.lessThanOrEqualToSuperview().inset(12)
        }
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.bottom.lessThanOrEqualToSuperview().inset(12)
        }
    }
    func configure(with character: StarWarsCharacter) {
        nameLabel.text = character.name

        infoLabel.text = """
        Рост: \(character.height) см
        Вес: \(character.mass) кг
        """
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
