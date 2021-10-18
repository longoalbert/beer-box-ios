//
//  ListViewController.swift
//  BeerBox
//
//  Created by Alberto Longo on 14/10/21.
//

import UIKit
import Alamofire
import Kingfisher


class ListViewController: UIViewController {

    @IBOutlet weak var weekendOffersContainer: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var currentPage = 1
    private var beers = Array<Beer>()
    private lazy var filteredBeers: Array<Beer> = []
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navTitle = NSMutableAttributedString(string: "Beer ",
                                                 attributes: [
                                                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24.0, weight: .light),
                                                    NSAttributedString.Key.foregroundColor: UIColor.white
                                                 ])

        navTitle.append(NSMutableAttributedString(string: "Box",
                                                  attributes: [
                                                    NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24.0),
                                                    NSAttributedString.Key.foregroundColor: UIColor.white
                                                  ]))

        let navLabel = UILabel()
        navLabel.attributedText = navTitle
        
        weekendOffersContainer.layer.cornerRadius = weekendOffersContainer.bounds.size.height / 6
        weekendOffersContainer.clipsToBounds = true
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchTextField.textColor = .white
        navigationItem.searchController = searchController
        navigationItem.titleView = navLabel
        definesPresentationContext = true
        
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.prefetchDataSource = self
        fetchBeers()
    }

    private func fetchBeers() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let params = [
            "page": currentPage
        ]
        
        AF.request("https://api.punkapi.com/v2/beers", parameters: params, encoding: URLEncoding.queryString).responseDecodable(of: [BeerDTO].self, decoder: decoder) { [weak self] response in
            debugPrint(response)
            guard let beers = response.value else { return }
            
            self?.currentPage += 1
            
            self?.beers.append(contentsOf: beers.map { $0.toDomainModel() })
        
            self?.tableView.reloadData()
        }
    }
    
    private func filterContentFor(searchText: String) {
        filteredBeers = beers.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        tableView.reloadData()
    }

}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        !isFiltering ? beers.count : filteredBeers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerTableViewCell.identifier, for: indexPath) as? BeerTableViewCell else {
            fatalError("Wrong cell type dequeued")
        }
        
        let beer: Beer
        
        if !isFiltering {
            beer = beers[indexPath.row]
        }
        else {
            beer = filteredBeers[indexPath.row]
        }
        
        if let imageUrl = beer.imageUrl {
            cell.beerImageView.kf.setImage(with: URL(string: imageUrl))
        }
        cell.beerNameLabel.text = beer.name
        cell.beerTypeLabel.text = beer.tagline
        cell.beerDescriptionLabel.text = beer.description
        
        return cell
    }
    
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == beers.count - 1 {
            fetchBeers()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let beer: Beer
        if !isFiltering {
            beer = beers[indexPath.row]
        }
        else {
            beer = filteredBeers[indexPath.row]
        }
        
        viewController.beer = beer
        
        if #available(iOS 15.0, *) {
            if let presentationController = viewController.presentationController as? UISheetPresentationController {
                presentationController.detents = [.medium()]
            }
        }
        else {
            viewController.modalPresentationStyle = .custom
            viewController.transitioningDelegate = self
        }
        
        present(viewController, animated: true)
    }
    
}

extension ListViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print(indexPaths.last?.row)
    }
    
}

extension ListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentFor(searchText: searchBar.text!)
    }

}

extension ListViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presentingViewController)
    }
    
}

class HalfSizePresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let bounds = containerView?.bounds else { return .zero }
        return CGRect(x: 0, y: bounds.height / 2, width: bounds.width, height: bounds.height / 2)
    }
}
