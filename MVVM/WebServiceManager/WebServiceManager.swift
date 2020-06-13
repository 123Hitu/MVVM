//
//  WebServiceManager.swift
//  MVVM
//
//  Created by Hitendra on 04/06/20.
//

import UIKit

class WebServiceManager: NSObject {

    static let sharedInstance = WebServiceManager()
    
    func getServiceCall<T:Codable>(url: String, complition : @escaping([T]?, Error?) -> ()){
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            if error == nil{
                if let responseData = data{
                    var userResponse = [T]()
                    userResponse = self.decode(responseData)
                    DispatchQueue.main.async {
                        complition(userResponse,nil)
                    }
                }
            }
        }.resume()
    }
    
    func decode<T : Codable>(_ data : Data) -> T{
        let decoder = JSONDecoder()
        guard (try? decoder.decode(T.self, from: data)) != nil else {
            fatalError("Failed to Decoded")
        }
        return (try! decoder.decode(T.self, from: data))
    }

    func downlodImage(_ imgUrl : String , complition : @escaping(NSData?,Error?) -> ()){
        var responseData : Data? = nil
        URLSession.shared.dataTask(with: URL(string: imgUrl)!) { (data, response, error) in
            if error == nil{
                DispatchQueue.main.async {
                    responseData = data
                    complition(responseData as NSData?,nil)
                }
            }
        }.resume()
    }
}

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    var imageUrlString: String?
    
    func downloadImageFrom(withUrl urlString : String) {
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        else{
            self.image = UIImage(named: "NoImage")
        }
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error == nil {
                DispatchQueue.main.async {
                    if let image = UIImage(data: data!) {
                        imageCache.setObject(image, forKey: NSString(string: urlString))
                        if self.imageUrlString == urlString {
                            self.image = image
                        }
                    }
                }
            }
        }).resume()
    }
}
