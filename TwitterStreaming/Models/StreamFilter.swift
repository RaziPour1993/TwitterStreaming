//
//  Stream.swift
//  TwitterStreaming
//
//  Created by Mohammad on 6/3/22.
//

import Foundation

struct StreamFilter: Codable {
    
    let expansions = "author_id,referenced_tweets.id,in_reply_to_user_id,geo.place_id,attachments.media_keys,attachments.poll_ids,entities.mentions.username,referenced_tweets.id.author_id"
    let tweetFields = "id,created_at,text,author_id,in_reply_to_user_id,referenced_tweets,attachments,withheld,geo,entities,public_metrics,possibly_sensitive,source,lang,context_annotations,conversation_id,reply_settings"
    let userFields = "id,created_at,name,username,protected,verified,withheld,profile_image_url,location,url,description,entities,pinned_tweet_id,public_metrics"
    let mediaFields = "media_key,duration_ms,height,preview_image_url,type,url,width,public_metrics,alt_text,variants"
    let placeFields = "id,name,country_code,place_type,full_name,country,contained_within,geo"
    let pollFields = "id,options,voting_status,end_datetime,duration_minutes"
    
    enum CodingKeys: String, CodingKey {
        case expansions = "expansions"
        case tweetFields = "tweet.fields"
        case userFields = "user.fields"
        case mediaFields = "media.fields"
        case placeFields = "place.fields"
        case pollFields = "poll.fields"
    }
}
