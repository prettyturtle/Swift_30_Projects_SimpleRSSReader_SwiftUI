//
//  XMLParserManager.swift
//  Swift_30_Projects_SimpleRSSReader
//
//  Created by yc on 2023/05/09.
//

import Foundation
import Combine

final class XMLParserManager: NSObject, XMLParserDelegate {
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    private var result = [[String: String]]()
    private var current: [String: String]?
    private var currentKey: String?
    
    func startParse<T: Decodable>(type: T.Type) -> Publishers.Decode<Publishers.TryMap<URLSession.DataTaskPublisher, JSONDecoder.Input>, T, JSONDecoder> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, _ in
                let xmlParser = XMLParser(data: data)
                
                xmlParser.delegate = self
                
                xmlParser.parse()
                
                let resultData = try JSONSerialization.data(withJSONObject: self.result)
                
                return resultData
            }
            .decode(type: type.self, decoder: JSONDecoder())
    }
    
    func startParse<T: Decodable>(type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                let xmlParser = XMLParser(data: data)
                
                xmlParser.delegate = self
                
                xmlParser.parse()
                
                let resultData = try! JSONSerialization.data(withJSONObject: self.result)
                
                let decoded = try! JSONDecoder().decode(type.self, from: resultData)
                
                completion(.success(decoded))
            }
        }
        .resume()
    }
    
    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String] = [:]
    ) {
        if elementName == "item" {
            current = [:]
            return
        }
        
        if current != nil {
            currentKey = elementName
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if let currentKey = currentKey {
            if let currentValue = current?[currentKey] {
                current?[currentKey] = currentValue + string
            } else {
                current?[currentKey] = string
            }
        }
    }
    
    func parser(
        _ parser: XMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?
    ) {
        if elementName == "item" {
            if let current = current {
                result.append(current)
            }
            
            current = nil
            
            return
        }
        
        if currentKey == elementName {
            currentKey = nil
        }
    }
}
