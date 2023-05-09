//
//  XMLParserManager.swift
//  Swift_30_Projects_SimpleRSSReader
//
//  Created by yc on 2023/05/09.
//

import Foundation

final class XMLParserManager: NSObject, XMLParserDelegate {
    private var parser: XMLParser?
    
    init(url: URL) {
        self.parser = XMLParser(contentsOf: url) // TODO: contentOf 수정
        
        super.init()
        
        parser?.delegate = self
    }
    
    private var result = [[String: String]]()
    private var current: [String: String]?
    private var currentKey: String?
    
    func startParse<T: Decodable>(type: T.Type) -> T {
        parser?.parse()
        
        let resultData = try! JSONSerialization.data(withJSONObject: result)
        
        let decoded = try! JSONDecoder().decode(type.self, from: resultData)
        
        return decoded
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
