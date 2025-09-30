//
//  PageInfo.swift
//  RickAndMorty
//
//  Created by Will Saults on 9/29/25.
//

import Foundation

struct PageInfo: Decodable {
    let count: Int
    let pages: Int
    let next: URL?
    let prev: URL?
}
