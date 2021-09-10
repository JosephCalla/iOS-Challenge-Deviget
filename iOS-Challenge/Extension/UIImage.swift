//
//  UIImage.swift
//  iOS-Challenge
//
//  Created by Joseph Calla Moreyra on 10/09/21.
//

import Foundation
import UIKit
extension UIImageView {
    
    private func fetchFromServer(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        
        self.image = UIImage(named: "placeholder")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    
    func setImageFrom(link: String?, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let link = link, let url = URL(string: link) else { return }
        fetchFromServer(url: url, contentMode: mode)
    }
}
