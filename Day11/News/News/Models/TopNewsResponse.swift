//
//  TopNewsResponse.swift
//  News
//
//  Created by Bayu Yasaputro on 16/10/21.
//

import Foundation

struct TopNewsResponse: Decodable {
    let results: [News]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decodeIfPresent([News].self, forKey: .results) ?? []
    }
}
