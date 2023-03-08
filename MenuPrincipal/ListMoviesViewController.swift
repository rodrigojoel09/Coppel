//
//  ListMoviesViewController.swift
//  Nativekit
//
//  Created by Joel Ramirez on 07/03/23.
//

import Foundation
import UIKit

struct TestCollection {
    let title: String
    let image: String
}

class ListMoviesViewController: UIViewController {
    
    let items = ["Popular", "Top Rated", "On TV", "Airing Today"]
    let testColl = [TestCollection(title: "Ejemplo 1", image: ""),
                    TestCollection(title: "Ejemplo 2", image: ""),
                    TestCollection(title: "Ejemplo 3", image: ""),
                    TestCollection(title: "Ejemplo 4", image: ""),
                    TestCollection(title: "Ejemplo 5", image: ""),
                    TestCollection(title: "Ejemplo 6", image: ""),
                    TestCollection(title: "Ejemplo 7", image: ""),
                    TestCollection(title: "Ejemplo 8", image: "")]
    
    private var pathToDetail = 1
    var finalPath = ""
    
    var viewModel = ListMoviesViewModel()
    
    var movies = PopularMoviesResponseEntity(results: []) {
        didSet{
            DispatchQueue.main.async {
                self.collectionMovies.reloadData()
            }
        }
    }
    
    private let collectionMovies: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //layout.itemSize = CGSize(width: (collection.frame.width - layout.minimumInteritemSpacing) / 2, height: 300)
        layout.itemSize = .init(width: 180, height: 540)
        //layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TV SHOWS"
        view.backgroundColor = .white
        
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        let profileButton = UIBarButtonItem(image: UIImage(named: "user"), style: .done, target: self, action: #selector(showProfile))
            navigationItem.rightBarButtonItems = [space, profileButton]
       
        
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.frame = CGRect(x: 20, y: 100, width: view.frame.width - 40, height: 30)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = .red
        segmentedControl.addTarget(self, action: #selector(didChangeSegmentedControl), for: .valueChanged)
        
        collectionMovies.backgroundColor = .white
        collectionMovies.dataSource = self
        collectionMovies.register(CustomCellMovie.self, forCellWithReuseIdentifier: "CustomCellMovie")
        
        [segmentedControl, collectionMovies].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([collectionMovies.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
                                     collectionMovies.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
                                     collectionMovies.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
                                     collectionMovies.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12)])
        
        bind()
        configureView()
        
    }
    
    @objc private func didChangeSegmentedControl(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            
        case 0:
            print("UISegmentedControl Value: \(sender.selectedSegmentIndex)")
            ListMoviesViewModel.url = Constants.popularPath
            pathToDetail = 1
            bind()
            configureView()
            movies.results = []
        case 1:
            print("UISegmentedControl Value: \(sender.selectedSegmentIndex)")
            ListMoviesViewModel.url = Constants.topRatedPath
            pathToDetail = 1
            configureView()
            bind()
            movies.results = []
            
        case 2:
            print("UISegmentedControl Value: \(sender.selectedSegmentIndex)")
            ListMoviesViewModel.url = Constants.onTV
            pathToDetail = 2
            configureView()
            bind()
            movies.results = []
        case 3:
            print("UISegmentedControl Value: \(sender.selectedSegmentIndex)")
            ListMoviesViewModel.url = Constants.airingToday
            pathToDetail = 2
            bind()
            configureView()
            movies.results = []
           
        default:
            print("Error en seleccion")
        }
    }
    
    @objc func showProfile() {
      
        
        let vc = ProfileViewController()
                navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private func configureView() {
        viewModel.getListofMovies { result in
            print("FROM VIEWCONTROLLER")
            print(result)
        }
    }
    
    private func bind() {
        viewModel.movies.bind { [weak self] movies in
            self?.movies.results.append(contentsOf: movies.results)
        }
    }

}

extension ListMoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.results.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCellMovie", for: indexPath) as! CustomCellMovie
        cell.backgroundColor = .white
        
        let model = movies.results[indexPath.row]
        
        cell.moviesList = model
        
        return cell
    }
    
    
}
