//
//  PlanetsViewController.swift
//  Planet(MVVM)+UnitTesting
//
//  Created by  Sergey Yurtaev on 11.08.2022.
//
import SnapKit
import UIKit

class PlanetsViewController: UIViewController {
    
    //MARK: Private properties
    private let cellID = "cellPlanet"
    private let planetsTableView = UITableView()
    
    private var viewModel: PlanetsViewModalProtocol! {
        didSet {
            viewModel.fetchPlanets {
                self.planetsTableView.reloadData()
            }
        }
    }
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PlanetsViewModel()
        setupNavigationBar()
        setTableView()
    }
        
    // MARK: - Private methods
    private func setupNavigationBar() {
        title = "Solar System"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarApperance = UINavigationBarAppearance()
        navBarApperance.configureWithOpaqueBackground()
        
        navBarApperance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarApperance.titleTextAttributes =  [.foregroundColor: UIColor.white]
        navBarApperance.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        navigationController?.navigationBar.standardAppearance = navBarApperance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarApperance
    }
    
    private func setTableView() {
        planetsTableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        planetsTableView.register(CellPlanet.self, forCellReuseIdentifier: cellID)
        planetsTableView.delegate = self
        planetsTableView.dataSource = self
        planetsTableView.backgroundView = UIImageView(image: UIImage(named: "space"))
        self.view.addSubview(planetsTableView)
    }
    
    deinit {
        print("PlanetsViewController has been dealocated")
    }
    
}

// MARK: - UITableViewDelegate
extension PlanetsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let platenDetailsVM = viewModel.viewModelForSelectedRow(at: indexPath)
        let detailsVC = DetailsViewController()
        navigationController?.pushViewController(detailsVC, animated: true)
        detailsVC.viewModel = platenDetailsVM
    }
}

// MARK: - UITableViewDataSource
extension PlanetsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = planetsTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CellPlanet
        let cellViewModel = viewModel.cellViewModel(at: indexPath)
        cell.viewModel = cellViewModel
        cell.backgroundColor = UIColor.clear
        return cell
    }
}
