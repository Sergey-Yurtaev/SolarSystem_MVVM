//
//  CellPlanet.swift
//  Planets(MVVM)+UnitTesting
//
//  Created by  Sergey Yurtaev on 15.08.2022.
//

import UIKit
import SnapKit

class CellPlanet: UITableViewCell {
    
    var viewModel: CellPlanetViewModalProtocol! {
        didSet {
            self.namePalneLabel.text = viewModel.namePlanet
        }
    }
    
    private lazy var planetCell: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var namePalneLabel: UILabel = {
        let namePalneLabel = UILabel()
        namePalneLabel.font = .systemFont(ofSize: 25)
        namePalneLabel.textColor = .white
        namePalneLabel.translatesAutoresizingMaskIntoConstraints = false
        return namePalneLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(planetCell)
        self.planetCell.addSubview(namePalneLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        planetCell.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            
        }
        namePalneLabel.snp.makeConstraints { make in
            make.centerY.equalTo(planetCell)
            make.left.equalToSuperview()
        }
    }
}

