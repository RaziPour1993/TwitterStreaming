//
//  Tweet.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import Foundation

// MARK: - Tweet
struct Tweet: Codable {
    let data: DataClass
    let includes: Includes
    
    enum CodingKeys: String, CodingKey {
        case data, includes
    }
    
    var profileImage: String {
        return includes.users?.first?.profileImageURL ?? ""
    }
    
    var name: String {
        self.includes.users?.first?.name ?? ""
    }
    
    var username: String {
        self.includes.users?.first?.username ?? ""
    }
    
    var tweetText: String {
        self.data.text ?? ""
    }
    
    var commentCount: String {
        return String((self.data.publicMetrics?.quoteCount ?? 0) + (self.data.publicMetrics?.replyCount ?? 0))
    }
    
    var retweetCount: String {
        return String(self.data.publicMetrics?.retweetCount ?? 0)
    }
    
    var likeCount: String {
        return String(self.data.publicMetrics?.likeCount ?? 0)
    }
    
    var source: String {
        return String(self.data.source ?? "")
    }
    
    var hashtags: String {
        var str = ""
        self.data.entities?.hashtags?.forEach({ item in
            str += "#\(item.tag) "
        })
        return str
    }
    
    var url: String {
        return self.data.entities?.urls?.last?.expandedURL ?? ""
    }
    
}

// MARK: - DataClass
struct DataClass: Codable {
    let entities: Entities?
    let publicMetrics: DataPublicMetrics?
    let source, text: String?
    
    enum CodingKeys: String, CodingKey {
        case entities
        case publicMetrics = "public_metrics"
        case source, text
    }
}

// MARK: - Entities
struct Entities: Codable {
    let hashtags: [Hashtag]?
    let urls: [URLElement]?
}

// MARK: - Hashtag
struct Hashtag: Codable {
    let tag: String
}

// MARK: - URLElement
struct URLElement: Codable {
    let url, expandedURL: String?
    let displayURL, mediaKey: String?
    
    enum CodingKeys: String, CodingKey {
        case url
        case expandedURL = "expanded_url"
        case displayURL = "display_url"
        case mediaKey = "media_key"
    }
}

// MARK: - DataPublicMetrics
struct DataPublicMetrics: Codable {
    let retweetCount, replyCount, likeCount, quoteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case retweetCount = "retweet_count"
        case replyCount = "reply_count"
        case likeCount = "like_count"
        case quoteCount = "quote_count"
    }
}

// MARK: - Includes
struct Includes: Codable {
    let users: [User]?
}

// MARK: - User
struct User: Codable {
    let name, profileImageURL: String?
    let url, username: String?
    
    enum CodingKeys: String, CodingKey {
        case profileImageURL = "profile_image_url"
        case url, username, name
    }
}
