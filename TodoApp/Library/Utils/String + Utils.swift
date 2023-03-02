//
//  String + Utils.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 28.02.2023.
//

import Foundation

extension String {
    
    static func randomStringWithLength(_ len: Int) -> String {
        
        let letters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString: NSMutableString = NSMutableString(capacity: len)
        
        for _ in 0 ..< len {
            let length = UInt32(letters.length)
            let rand = UInt32.random(in: 0..<length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        return randomString as String
    }
}
