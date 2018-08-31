//
//  MainNetworkService.swift
//  Translator
//
//  Created by Sergey on 28.08.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Foundation

class MainNetworkService {
    
    private init() {}
    
    static func getContent(stringURL: String, completion: @escaping (String) -> ()) {
        
        let downloadUrl = URL(string: stringURL)
        guard let url = downloadUrl else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, responce, error) in
            guard let data = data,
                      responce != nil,
                      error == nil else {
                                            print("Something is wrong")
                                            return
            }
            
            do {
                let decoderData = try JSONDecoder().decode(Translate.self, from: data)
                guard decoderData.text?.isEmpty == false else { return }
                
                let allText = decoderData.text![0]
                
                DispatchQueue.main.async {
                    completion(allText)
                }
            } catch let err {
                print("error getContent is \(err)")
            }
            }.resume()
    }
    
}
