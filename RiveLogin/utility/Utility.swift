//
//  Utility.swift
//  RiveLogin
//
//  Created by richa.e.srivastava on 21/11/2021.
//

import Foundation
import RiveRuntime

func getBytes(resourceName: String, resourceExt: String=".riv") -> [UInt8] {
    guard let url = Bundle.main.url(forResource: resourceName, withExtension: resourceExt) else {
        fatalError("Failed to locate \(resourceName) in bundle.")
    }
    guard let data = try? Data(contentsOf: url) else {
        fatalError("Failed to load \(url) from bundle.")
    }
    
    // Import the data into a RiveFile
    return [UInt8](data)
}


func getRiveFile(resourceName: String, resourceExt: String=".riv") throws -> RiveFile{
    let byteArray = getBytes(resourceName: resourceName, resourceExt: resourceExt)
    return try RiveFile(byteArray: byteArray)
}
