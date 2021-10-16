//
//  Media.swift
//  News
//
//  Created by Bayu Yasaputro on 16/10/21.
//

import Foundation

struct Media: Decodable {
    let type: String
    let mediaMetadata: [MediaMetadata]
    
    enum CodingKeys: String, CodingKey {
        case type
        case mediaMetadata = "media-metadata"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type) ?? ""
        mediaMetadata = try values.decodeIfPresent([MediaMetadata].self, forKey: .mediaMetadata) ?? []
    }
}


struct MediaMetadata: Decodable {
    let url: String
    let format: String
    let height: Double
    let width: Double
    
    enum CodingKeys: String, CodingKey {
        case url
        case format
        case height
        case width
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url) ?? ""
        format = try values.decodeIfPresent(String.self, forKey: .format) ?? ""
        height = try values.decodeIfPresent(Double.self, forKey: .height) ?? 0
        width = try values.decodeIfPresent(Double.self, forKey: .width) ?? 0
    }
}
