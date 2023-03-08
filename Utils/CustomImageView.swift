//
//  CustomImageView.swift
//  Nativekit
//
//  Created by Joel Ramirez on 08/03/23.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageURLString: String?
    
    
    
    var cornerRadius:CGFloat = 0{
        didSet{
            layer.cornerRadius = cornerRadius < 0 ? bounds.height/2 : cornerRadius
        }
    }
    
 
    func downloaded(from url: URL?, contentMode mode: ContentMode = .scaleAspectFill,retries: Int = 3) {
        //image = #imageLiteral(resourceName: "placeholder")
        contentMode = .scaleToFill
        guard let url = url else {
            return
        }
        imageURLString = url.absoluteString
        if let cachedImage = imageCache.object(forKey: url as AnyObject) as? UIImage{
            self.contentMode = mode
            loadFade(cachedImage)
        }
        
        var urlRequest:URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        //Content-Type
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //urlRequest.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        //let bearer = bearerToken
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 10.0
        sessionConfig.timeoutIntervalForResource = 10.0
        let session = URLSession(configuration: sessionConfig)
        session.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                //let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                if retries > 0{
                    DispatchQueue.main.async {
                        print("URL request for image \(urlRequest)")
                        self?.downloaded(from: url,retries: retries - 1)
                    }
                    //print("Data: \(data)")
                }
                print("Fallo la carga de la imagen retries \(retries)")
                return
                
            }
            DispatchQueue.main.async() {
                if self?.imageURLString == url.absoluteString{
                    self?.contentMode = mode
                    self?.loadFade(image)
                }
                imageCache.setObject(image, forKey: url as AnyObject)
                self?.image = image
            }
        }.resume()
        
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
    func loadFade(_ image: UIImage) {
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.image = image
            
        }, completion: nil)
        
    }
    
    func imageGet() {
        // Create URL
           let url = URL(string: "https://cdn.cocoacasts.com/cc00ceb0c6bff0d536f25454d50223875d5c79f1/above-the-clouds.jpg")!

           // Fetch Image Data
           if let data = try? Data(contentsOf: url) {
               let image = UIImage(data: data)
               DispatchQueue.main.async() {
                   self.loadFade(image ?? UIImage(imageLiteralResourceName: "si"))
                   self.image = image
               }
           }
    }
    
}


