//
//  DetailMovieViewController.swift
//  Nativekit
//
//  Created by Joel Ramirez on 08/03/23.
//

import UIKit

class DetailMovieViewController: UIViewController {
    
    
    var urlFinal = ""
    
    var viewModel = DetailViewModel()
    
    var movie: DetailResponse? {
        didSet{
            DispatchQueue.main.async {
                self.titleMovie.text = self.movie?.title ?? self.movie?.title
                self.descriptioMovie.text = self.movie?.overview
                self.dateMovie.text = self.movie?.release_date ?? self.movie?.release_date
                let votesStr: String = String(format: "%.1f", self.movie?.vote_average ?? "10")
                self.averageMovie.text = "⭐️\(votesStr)"
                print("---------ID---------")
                print("id: \(String(describing: self.movie?.id))")
                self.imageMovie.downloaded(from: Constants.pathImage(path:self.movie?.poster_path ?? "dum URL"))
                //movieImage.imageGet()
            }
        }
    }
    
    private let stackMovie: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layer.borderColor = UIColor.black.cgColor
        stack.spacing = 10
        
        return stack
    }()
    
    private let stackChild: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layer.borderColor = UIColor.black.cgColor
        stack.spacing = 10
        
        return stack
    }()
    
    private let imageMovie: CustomImageView = {
        let image = CustomImageView()
        image.image = UIImage(named: "imagedum")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.cornerRadius = 20
        
        return image
    }()
    
    private let titleMovie: UILabel = {
       let labelM = UILabel()
        labelM.font = .systemFont(ofSize: 16)
        labelM.textAlignment = .center
        labelM.numberOfLines = 2
        labelM.text = "."
        labelM.translatesAutoresizingMaskIntoConstraints = false
        
        return labelM
    }()
    
    private let descriptioMovie: UILabel = {
       let labelM = UILabel()
        labelM.font = .systemFont(ofSize: 14)
        labelM.numberOfLines = 8
        labelM.text = "."
        labelM.translatesAutoresizingMaskIntoConstraints = false
        
        return labelM
    }()
    
    private let averageMovie: UILabel = {
       let labelM = UILabel()
        labelM.font = .systemFont(ofSize: 14)
        labelM.text = "."
        labelM.translatesAutoresizingMaskIntoConstraints = false
        
        return labelM
    }()
    
    private let dateMovie: UILabel = {
       let labelM = UILabel()
        labelM.font = .systemFont(ofSize: 14)
        labelM.text = "."
        labelM.translatesAutoresizingMaskIntoConstraints = false
        
        return labelM
    }()
    
    private let imageError: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "error")
        image.isHidden = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let favoritesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Agregar a Favoritos", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.layer.cornerRadius = 10
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(addfavorites), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "DETAIL"
        view.backgroundColor = .white
        view.addSubview(stackMovie)
        view.addSubview(imageError)
        stackMovie.addArrangedSubview(imageMovie)
        stackMovie.addArrangedSubview(titleMovie)
        stackMovie.addArrangedSubview(stackChild)
        stackChild.addArrangedSubview(dateMovie)
        stackChild.addArrangedSubview(averageMovie)
        stackMovie.addArrangedSubview(descriptioMovie)
        stackMovie.addArrangedSubview(favoritesButton)
        
        configureConstraints()
        
        print("url detail path: \(urlFinal)")
        viewModel.statusCode.bind { [weak self] code in
            if code == .error_server {
                print("ERROR code detail desde VC")
                DispatchQueue.main.async {
                    self?.stackMovie.isHidden = true
                    self?.imageError.isHidden = false
                }
                
            }
        }
        
        bind()
        config()
        
    }
    
    private func config() {
        viewModel.getMovieDetail(url: urlFinal) { result in
            print("DETAIL OF MOVIE")
            print(result)
            
        }
    }
    
    private func bind(){
        viewModel.movie.bind { [weak self] movie in
            self?.movie = movie
        }
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([stackMovie.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
                                     stackMovie.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
                                     stackMovie.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),imageError.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     imageError.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                                    ])
    }
    
    @objc func addfavorites() {
        print("Añadir a Core Data y consumir servicio account")
    }
 
}
