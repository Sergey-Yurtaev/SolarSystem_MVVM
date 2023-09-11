//
//  DetailsViewController.swift
//  Planet(MVVM)+UnitTesting
//
//  Created by  Sergey Yurtaev on 12.08.2022.
//

import UIKit
import SnapKit
import SafariServices

final class DetailsViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: Public properties
    var viewModel: DetailsViewModelProtocol! {
        didSet {
            viewModel.fetchImage {
                guard let imageData = self.viewModel.imageData else { return }
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    
                    self.activityIndicator.stopAnimating()
                    self.imagePlanet.image = UIImage(data: imageData)
                }
            }
        }
    }
    
    //MARK: Private properties
    private var isFavorite = false
    
    // ScrollView
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .black
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        scrollView.contentOffset = CGPoint(x: 0, y: 200)
        scrollView.backgroundColor = .black
        return scrollView
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 350)
    }
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.frame.size = contentSize
        return contentView
    }()
    
    // Views
    private lazy var imagePlanet: UIImageView = {
        let imagePlanet = UIImageView()
        imagePlanet.contentMode = .scaleAspectFit
        return imagePlanet
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .yellow
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    // Button
    private lazy var favoriteButton: UIButton = {
        let favoriteButton = UIButton()
        favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        favoriteButton.tintColor = .gray
        favoriteButton.titleLabel?.font = .systemFont(ofSize: 30)
        favoriteButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        return favoriteButton
    }()
    
    private lazy var goToFullNewsButton: UIButton = {
        let goToFullNewsButton = UIButton()
        goToFullNewsButton.backgroundColor = UIColor(red: 21/255, green: 101/255, blue: 192/255, alpha: 1)
        goToFullNewsButton.setTitle("Get complete information", for: .normal)
        goToFullNewsButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        goToFullNewsButton.setTitleColor(.white, for: .normal)
        
        goToFullNewsButton.layer.cornerRadius = 10
        goToFullNewsButton.addTarget(self, action: #selector(goToFullInfoSolarSystem), for: .touchUpInside)
        
        return goToFullNewsButton
    }()
    
    // Labels
    private lazy var namePlanetLabel: UILabel = {
        let namePlanetLabel = UILabel()
        namePlanetLabel.textAlignment = .center
        namePlanetLabel.textColor = .white
        namePlanetLabel.sizeToFit()
        namePlanetLabel.font = .systemFont(ofSize: 30)
        return namePlanetLabel
    }()
    
    private lazy var velocityLabel: UILabel = {
        let velocityLabel = UILabel()
        velocityLabel.textColor = .white
        velocityLabel.adjustsFontSizeToFitWidth = true
        velocityLabel.font = .systemFont(ofSize: 20)
        return velocityLabel
    }()
    
    private lazy var distanceLabel: UILabel = {
        let distanceLabel = UILabel()
        distanceLabel.textColor = .white
        distanceLabel.adjustsFontSizeToFitWidth = true
        distanceLabel.font = .systemFont(ofSize: 20)
        return distanceLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.minimumScaleFactor = 0.5
        return descriptionLabel
    }()
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setConstrains()
        setupUI()
    }
    
    // MARK:  Actions @objc
    @objc func toggleFavorite(sender: UIButton!) {
        viewModel.changeFavoriteStatus()
        setImageForFavoriteButton()
    }
    
    @objc private func goToFullInfoSolarSystem() {
        let fullNews = SFSafariViewController(url: URL(string: viewModel.urlFullInfo)!)
        present(fullNews, animated: true)
    }
    
    // MARK: - Private methods
    private func setupUI() {
        viewModel.isFavorite.bind { [weak self] isFavorite in
            self?.isFavorite = isFavorite
        }
        
        viewModel.setFavoriteStatus()
        setImageForFavoriteButton()
        namePlanetLabel.text = viewModel.planetName
        velocityLabel.text = viewModel.velocity
        distanceLabel.text = viewModel.distance
        descriptionLabel.text = viewModel.description
    }
    
    private func setImageForFavoriteButton() {
        favoriteButton.tintColor = isFavorite ? .red : .gray
    }
    
    private func setupSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imagePlanet)
        contentView.addSubview(activityIndicator)
        contentView.addSubview(namePlanetLabel)
        contentView.addSubview(velocityLabel)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(goToFullNewsButton)
    }
    
    private func setConstrains() {
        imagePlanet.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(200)
            make.height.equalTo(300)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(imagePlanet)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.right.equalTo(namePlanetLabel).inset(-30)
            make.top.equalTo(namePlanetLabel).inset(2)
        }
        
        namePlanetLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imagePlanet).inset(280)
        }
        
        velocityLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(namePlanetLabel).inset(50)
        }
        
        distanceLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(velocityLabel).inset(30)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(distanceLabel).inset(30)
        }
        
        goToFullNewsButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(50)
            make.bottom.equalTo(descriptionLabel).inset(-50)
        }
    }
    
    deinit {
        print("DetailsViewController has been dealocated")
    }
}

