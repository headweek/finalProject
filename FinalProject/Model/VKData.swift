//
//  VKData.swift
//  FinalProject
//
//  Created by apple on 08.04.2024.
//

import Foundation

struct Welcome: Decodable {
    let response: VKData
}

struct VKData: Decodable {
    let count: Int
    let items: [VKItem]
}

struct VKItem: Decodable {
    let inner_type: String
    let donut: Donut
    let is_pinned: Int
    let comments: Comments
    let marked_as_ads: Int
    let short_text_rate: Float
    let hash: String
    let has_translation: Bool
    let type: String
    let carousel_offset: Int
    let donut_miniapp_url: String
    let attachments: [VKAttachments]
    let date: Int
    let edited: Int
    let from_id: Int
    let id: Int
    let is_favorite: Bool
    let likes: VKLikes
    let reaction_set_id: String
    let owner_id: Int
    let text: String
    
}

struct Donut: Decodable {
    let is_donut: Bool
}

struct Comments: Decodable {
    let can_post: Int
    let can_view: Int
    let count: Int
    let groups_can_post: Bool
}

struct VKAttachments: Decodable {
    let type: String
    let video: VKVideo?
    let link: VKLink?
}

struct VKVideo: Decodable {
    let response_type: String
    let access_key: String
    let can_comment: Int
    let can_like: Int
    let can_repost: Int
    let can_subscribe: Int
    let can_add_to_faves: Int
    let can_add: Int
    let comments: Int
    let date: Int
    let description: String
    let duration: Int
    let image: [VKImage]
    let id: Int
    let owner_id: Int
    let title: String
    let is_favorite: Bool
    let track_code: String
    let type: String
    let views: Int
    let platform: String
    let can_dislike: Int
}

struct VKLink: Decodable {
    let url: String
    let description: String
    let is_favorite: Bool
    let photo: VKPhoto
    let title: String
    let target: String
}

struct VKImage: Decodable {
    let url: String
    let width: Int
    let height: Int
    let with_padding: Int
}

struct VKPhoto: Decodable {
    let album_id: Int
    let date: Int
    let id: Int
    let owner_id: Int
    let sizes: [Sizes]
    let text: String
    let user_id: Int
    let web_view_token: String
    let has_tags: Bool
}

struct Sizes: Decodable {
    let height: Int
    let type: String
    let width: Int
    let url: String
}

struct VKLikes: Decodable {
    let can_like: Int
    let count: Int
    let user_likes: Int
    let can_publish: Int
    let repost_disabled: Bool
}

//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)
//
//import Foundation
//
//// MARK: - Welcome
//struct Welcome: Codable {
//    let response: Response
//}
//
//// MARK: - Response
//struct Response: Codable {
//    let count: Int
//    let items: [ResponseItem]
//    let reactionSets: [ReactionSet]
//
//    enum CodingKeys: String, CodingKey {
//        case count, items
//        case reactionSets = "reaction_sets"
//    }
//}
//
//// MARK: - ResponseItem
//struct ResponseItem: Codable {
//    let innerType: String
//    let canDelete, canPin: Int
//    let donut: Donut
//    let comments: Comments
//    let markedAsAds: Int
//    let shortTextRate: Double
//    let hash: String
//    let hasTranslation: Bool
//    let type: String
//    let attachments: [ItemAttachment]
//    let canArchive: Bool
//    let date, fromID, id: Int
//    let isArchived, isFavorite: Bool
//    let likes: Likes
//    let reactionSetID: String
//    let reactions: Reactions?
//    let ownerID: Int
//    let postSource: ItemPostSource
//    let postType: String
//    let reposts: Reposts
//    let text: String
//    let views: Views
//    let copyHistory: [CopyHistory]?
//
//    enum CodingKeys: String, CodingKey {
//        case innerType = "inner_type"
//        case canDelete = "can_delete"
//        case canPin = "can_pin"
//        case donut, comments
//        case markedAsAds = "marked_as_ads"
//        case shortTextRate = "short_text_rate"
//        case hash
//        case hasTranslation = "has_translation"
//        case type, attachments
//        case canArchive = "can_archive"
//        case date
//        case fromID = "from_id"
//        case id
//        case isArchived = "is_archived"
//        case isFavorite = "is_favorite"
//        case likes
//        case reactionSetID = "reaction_set_id"
//        case reactions
//        case ownerID = "owner_id"
//        case postSource = "post_source"
//        case postType = "post_type"
//        case reposts, text, views
//        case copyHistory = "copy_history"
//    }
//}
//
//// MARK: - ItemAttachment
//struct ItemAttachment: Codable {
//    let type: String
//    let photo: Photo?
//    let video: Video?
//}
//
//// MARK: - Photo
//struct Photo: Codable {
//    let albumID, date, id, ownerID: Int
//    let postID: Int
//    let sizes: [Size]
//    let squareCrop: String?
//    let text, webViewToken: String
//    let hasTags: Bool
//    let accessKey: String?
//    let lat, long: Double?
//
//    enum CodingKeys: String, CodingKey {
//        case albumID = "album_id"
//        case date, id
//        case ownerID = "owner_id"
//        case postID = "post_id"
//        case sizes
//        case squareCrop = "square_crop"
//        case text
//        case webViewToken = "web_view_token"
//        case hasTags = "has_tags"
//        case accessKey = "access_key"
//        case lat, long
//    }
//}
//
//// MARK: - Size
//struct Size: Codable {
//    let height: Int
//    let type: String?
//    let width: Int
//    let url: String
//    let withPadding: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case height, type, width, url
//        case withPadding = "with_padding"
//    }
//}
//
//// MARK: - Video
//struct Video: Codable {
//    let responseType, accessKey: String
//    let canComment: Int
//    let canEdit, canDelete: Int?
//    let canLike, canRepost, canAddToFaves, canAdd: Int
//    let canAttachLink, canEditPrivacy: Int?
//    let comments, date: Int
//    let description: String
//    let duration: Int
//    let image, firstFrame: [Size]
//    let width, height, id, ownerID: Int
//    let isAuthor: Bool?
//    let title: String
//    let isFavorite: Bool
//    let trackCode, type: String
//    let views, localViews, canDislike: Int
//    let canSubscribe: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case responseType = "response_type"
//        case accessKey = "access_key"
//        case canComment = "can_comment"
//        case canEdit = "can_edit"
//        case canDelete = "can_delete"
//        case canLike = "can_like"
//        case canRepost = "can_repost"
//        case canAddToFaves = "can_add_to_faves"
//        case canAdd = "can_add"
//        case canAttachLink = "can_attach_link"
//        case canEditPrivacy = "can_edit_privacy"
//        case comments, date, description, duration, image
//        case firstFrame = "first_frame"
//        case width, height, id
//        case ownerID = "owner_id"
//        case isAuthor = "is_author"
//        case title
//        case isFavorite = "is_favorite"
//        case trackCode = "track_code"
//        case type, views
//        case localViews = "local_views"
//        case canDislike = "can_dislike"
//        case canSubscribe = "can_subscribe"
//    }
//}
//
//// MARK: - Comments
//struct Comments: Codable {
//    let canPost, canClose, canView, count: Int
//    let groupsCanPost: Bool
//
//    enum CodingKeys: String, CodingKey {
//        case canPost = "can_post"
//        case canClose = "can_close"
//        case canView = "can_view"
//        case count
//        case groupsCanPost = "groups_can_post"
//    }
//}
//
//// MARK: - CopyHistory
//struct CopyHistory: Codable {
//    let innerType, type: String
//    let attachments: [CopyHistoryAttachment]
//    let date, fromID, id, ownerID: Int
//    let postSource: CopyHistoryPostSource
//    let postType, text: String
//
//    enum CodingKeys: String, CodingKey {
//        case innerType = "inner_type"
//        case type, attachments, date
//        case fromID = "from_id"
//        case id
//        case ownerID = "owner_id"
//        case postSource = "post_source"
//        case postType = "post_type"
//        case text
//    }
//}
//
//// MARK: - CopyHistoryAttachment
//struct CopyHistoryAttachment: Codable {
//    let type: String
//    let video: Video
//}
//
//// MARK: - CopyHistoryPostSource
//struct CopyHistoryPostSource: Codable {
//    let type: String
//}
//
//// MARK: - Donut
//struct Donut: Codable {
//    let isDonut: Bool
//
//    enum CodingKeys: String, CodingKey {
//        case isDonut = "is_donut"
//    }
//}
//
//// MARK: - Likes
//struct Likes: Codable {
//    let canLike, count, userLikes, canPublish: Int
//    let repostDisabled: Bool
//
//    enum CodingKeys: String, CodingKey {
//        case canLike = "can_like"
//        case count
//        case userLikes = "user_likes"
//        case canPublish = "can_publish"
//        case repostDisabled = "repost_disabled"
//    }
//}
//
//// MARK: - ItemPostSource
//struct ItemPostSource: Codable {
//    let data, platform: String?
//    let type: String
//}
//
//// MARK: - Reactions
//struct Reactions: Codable {
//    let count: Int
//    let items: [ReactionsItem]
//}
//
//// MARK: - ReactionsItem
//struct ReactionsItem: Codable {
//    let id, count: Int
//}
//
//// MARK: - Reposts
//struct Reposts: Codable {
//    let count, wallCount, mailCount, userReposted: Int
//
//    enum CodingKeys: String, CodingKey {
//        case count
//        case wallCount = "wall_count"
//        case mailCount = "mail_count"
//        case userReposted = "user_reposted"
//    }
//}
//
//// MARK: - Views
//struct Views: Codable {
//    let count: Int
//}
//
//// MARK: - ReactionSet
//struct ReactionSet: Codable {
//    let id: String
//    let items: [ReactionSetItem]
//}
//
//// MARK: - ReactionSetItem
//struct ReactionSetItem: Codable {
//    let id: Int
//    let title: String
//    let asset: Asset
//}
//
//// MARK: - Asset
//struct Asset: Codable {
//    let animationURL: String
//    let images: [Size]
//    let title: Title
//    let titleColor: TitleColor
//
//    enum CodingKeys: String, CodingKey {
//        case animationURL = "animation_url"
//        case images, title
//        case titleColor = "title_color"
//    }
//}
//
//// MARK: - Title
//struct Title: Codable {
//    let color: Color
//}
//
//// MARK: - Color
//struct Color: Codable {
//    let foreground, background: TitleColor
//}
//
//// MARK: - TitleColor
//struct TitleColor: Codable {
//    let light, dark: String
//}
