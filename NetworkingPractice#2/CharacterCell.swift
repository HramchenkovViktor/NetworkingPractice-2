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

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
