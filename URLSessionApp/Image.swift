//
//  Image.swift
//  URLSessionApp
//
//  Created by Sosin Vladislav on 11.01.2023.
//

import Foundation

struct Image: Decodable {
    let id: String?
    let author: String?
    let width: Int?
    let height: Int?
    let url: String?
    let download_url: String?
}
