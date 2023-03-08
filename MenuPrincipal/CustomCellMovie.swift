//
//  CustomCellMovie.swift
//  Nativekit
//
//  Created by Joel Ramirez on 08/03/23.
//

import UIKit


class CustomCellMovie: UICollectionViewCell {
    
    
    private let stackMovies: UIStackView = {
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
        labelM.translatesAutoresizingMaskIntoConstraints = false
        
        return labelM
    }()
    
    private let descriptioMovie: UILabel = {
       let labelM = UILabel()
        labelM.font = .systemFont(ofSize: 14)
        labelM.numberOfLines = 8
        labelM.translatesAutoresizingMaskIntoConstraints = false
        
        return labelM
    }()
    
    private let averageMovie: UILabel = {
       let labelM = UILabel()
        labelM.font = .systemFont(ofSize: 14)
        labelM.translatesAutoresizingMaskIntoConstraints = false
        
        return labelM
    }()
    
    private let dateMovie: UILabel = {
       let labelM = UILabel()
        labelM.font = .systemFont(ofSize: 14)
        labelM.translatesAutoresizingMaskIntoConstraints = false
        
        return labelM
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        addSubview(stackMovies)
        stackMovies.addArrangedSubview(imageMovie)
        stackMovies.addArrangedSubview(titleMovie)
        stackMovies.addArrangedSubview(stackChild)
        stackChild.addArrangedSubview(dateMovie)
        stackChild.addArrangedSubview(averageMovie)
        stackMovies.addArrangedSubview(descriptioMovie)
        
        configureConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([stackMovies.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     stackMovies.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     stackMovies.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor)
                                    ])
    }
    
    var moviesList: PopularMovieEntity? {
        didSet{
        
            titleMovie.text = moviesList?.title ?? moviesList?.name
            descriptioMovie.text = moviesList?.overview
            dateMovie.text = moviesList?.date ?? moviesList?.dateTV
            let votesStr: String = String(format: "%.1f", moviesList?.votes ?? "10")
            averageMovie.text = "⭐️\(votesStr)"
            print("---------ID---------")
            print("id: \(String(describing: moviesList?.id))")
            print("generes : \(String(describing: moviesList?.genres))")
            imageMovie.downloaded(from: Constants.pathImage(path:moviesList?.imageURL ?? "dum URL"))
            //movieImage.imageGet()
            
        }
    }
}
