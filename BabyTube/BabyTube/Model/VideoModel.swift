//
//  VideoModel.swift
//  BabyTube
//
//  Created by Virtual Castle  on 9/23/18.
//  Copyright © 2018 Virtual Castle . All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Video {
    public var title: String
    public var videoImg: UIImage
    public var channel: String
    public var duration: String
    public var date: String
    public var type: VideoType
    
    init(title: String, videoImg: UIImage, channel: String, type: VideoType, duration: String, date: String)
    {
        self.title = title
        self.videoImg = videoImg
        self.channel = channel
        self.type = type
        self.duration = duration
        self.date = date
    }
    
    init() {
        self.title = ""
        self.videoImg = #imageLiteral(resourceName: "4")
        self.channel = ""
        self.type = VideoType.movie
        self.duration = ""
        self.date = ""
    }
    
}

enum VideoType: String {
    case episode = "Episode"
    case movie = "SoloVideo"
}

class VideoModel
{
    
    static let API_KEY: String = "AIzaSyDavu9Lv7W-EAWvYUju5iV2OmOZpOb0lkk"
    
    public static func retriveVideosFromStaticSource() ->[Video]
    {
        var videos = [Video]()
        videos.append(Video(title: "Episode 1", videoImg: #imageLiteral(resourceName: "1"), channel: "The Office US", type: VideoType.episode, duration: "3:11", date: "Published on Sep 21, 2027"))
        videos.append(Video(title: "Best Prank", videoImg: #imageLiteral(resourceName: "2"), channel: "The Office Jokes", type: VideoType.movie, duration: "3:12", date: "Published on Sep 22, 2017"))
        videos.append(Video(title: "Best Shows Ep 2", videoImg: #imageLiteral(resourceName: "5"), channel: "Best of Netflix ", type: VideoType.episode, duration: "3:13", date: "Published on Sep 27, 2013"))
        videos.append(Video(title: "Episode 2", videoImg: #imageLiteral(resourceName: "4"), channel: "The Office US", type: VideoType.episode, duration: "3:14", date: "Published on Sep 17, 2017"))
        videos.append(Video(title: "Jim and Pam", videoImg: #imageLiteral(resourceName: "2"), channel: "Best of Netflix ", type: VideoType.movie, duration: "3:15", date: "Published on Sep 21, 2011"))
        
        return videos
    }
    
    public static func retriveVideosFromYoutube(query: String) -> [Video]
    {
        let videos = [Video]()
        
        
        let parameters: Parameters = ["part": "snippet", "q":"Boku no hero", "maxResults":"10", "key":API_KEY]
        
        Alamofire.request("https://www.googleapis.com/youtube/v3/search", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON{ response in
            
            let json = JSON(response.result.value as Any)
            
            for(key, subJson):(String, JSON) in json
            {
                
                if(key == "items")
                {
                    for (_, subJsonDos):(String, JSON) in subJson
                    {
                        if(subJsonDos["id"]["kind"] != "youtube#channel")
                        {
                            let title = subJsonDos["snippet"]["title"].stringValue
                            let date  = subJsonDos["snippet"]["publishedAt"].stringValue
                            let channel = subJsonDos["snippet"]["channelTitle"].stringValue
                            let thumbnail = subJsonDos["snippet"]["thumbnails"]["medium"]["url"].stringValue
                            
                            let videoId = subJsonDos["id"]["videoId"].stringValue
                            
                            let videoParameters: Parameters = ["part":"contentDetails", "id":videoId, "key":API_KEY]
                            
                            Alamofire.request("https://www.googleapis.com/youtube/v3/videos", method: .get, parameters: videoParameters, encoding: URLEncoding.default, headers: nil).responseJSON{ videoResponse in
                                
                                let videoJson = JSON(videoResponse.result.value as Any)
                                
                                for(videoKey, videoSubJson):(String, JSON) in videoJson
                                {
                                   
                                    if(videoKey == "items")
                                    {
                                        
                                        let duration = videoSubJson[0]["contentDetails"]["duration"].stringValue
                                        
                                        var videoToInsert : Video = Video()
                                        
                                        videoToInsert.title = title
                                        videoToInsert.channel = channel
                                        videoToInsert.duration = duration
                                        videoToInsert.date = date
                                        videoToInsert.videoImg = #imageLiteral(resourceName: "CancelImage")
                                        videoToInsert.type = VideoType.movie

                                        print("--------New Video-------\n" +  videoToInsert.title + "\n" +  videoToInsert.channel + "\n" +  videoToInsert.date + "\n" +  videoToInsert.duration + "\n")
                                    }
                                }

                            }
                            
                            
                        }
                        
                    }
                }
            }
        }
        
        
        return videos
    }
    
}


