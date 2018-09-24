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
    
    public var id: String
    public var title: String
    public var videoImg: String
    public var channel: String
    public var duration: String
    public var date: String
    public var type: VideoType
    
    init(id: String, title: String, videoImg: String, channel: String, type: VideoType, duration: String, date: String)
    {
        self.id = id
        self.title = title
        self.videoImg = videoImg
        self.channel = channel
        self.type = type
        self.duration = duration
        self.date = date
    }
    
    init() {
        self.id = ""
        self.title = ""
        self.videoImg = ""
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
    
    static var currentVideos: [Video] = []
    
    static let API_KEY: String = "AIzaSyDavu9Lv7W-EAWvYUju5iV2OmOZpOb0lkk"
    
    public static func retriveVideosFromStaticSource() ->[Video]
    {
        var videos = [Video]()
        videos.append(Video(id: "id", title: "Episode 1", videoImg: "1", channel: "The Office US", type: VideoType.episode, duration: "3:11", date: "Published on Sep 21, 2027"))
        videos.append(Video(id: "id",title: "Best Prank", videoImg: "2", channel: "The Office Jokes", type: VideoType.movie, duration: "3:12", date: "Published on Sep 22, 2017"))
        videos.append(Video(id: "id",title: "Best Shows Ep 2", videoImg: "3", channel: "Best of Netflix ", type: VideoType.episode, duration: "3:13", date: "Published on Sep 27, 2013"))
        videos.append(Video(id: "id",title: "Episode 2", videoImg: "4", channel: "The Office US", type: VideoType.episode, duration: "3:14", date: "Published on Sep 17, 2017"))
        videos.append(Video(id: "id",title: "Jim and Pam", videoImg: "5", channel: "Best of Netflix ", type: VideoType.movie, duration: "3:15", date: "Published on Sep 21, 2011"))
        
        return videos
    }
    
    public static func retriveVideosFromYoutube(query: String, completion: @escaping ((_ data: [Video]) -> Void))
    {
        var  videos = [Video]()
        
        var counter: Int = 0
        let parameters: Parameters = ["part": "snippet", "q":query, "maxResults":"15", "key":API_KEY]
        
        Alamofire.request("https://www.googleapis.com/youtube/v3/search", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON{ response in
            
            let json = JSON(response.result.value as Any)
            //print(response.result.value)
            for(key, subJson):(String, JSON) in json
            {
                
                if(key == "items")
                {
                    for (_, subJsonDos):(String, JSON) in subJson
                    {
                        if(subJsonDos["id"]["kind"] != "youtube#channel")
                        {
                            //let amountOfVideos = subJsonDos.array?.count
                            
                            let id = subJsonDos["id"]["videoId"].stringValue
                            let title = subJsonDos["snippet"]["title"].stringValue
                            let date  = subJsonDos["snippet"]["publishedAt"].stringValue
                            let channel = subJsonDos["snippet"]["channelTitle"].stringValue
                            let thumbnail = subJsonDos["snippet"]["thumbnails"]["medium"]["url"].stringValue
                            
                            let videoId = subJsonDos["id"]["videoId"].stringValue
                            
                            let videoParameters: Parameters = ["part":"contentDetails", "id":videoId, "key":API_KEY]
                            
                            Alamofire.request("https://www.googleapis.com/youtube/v3/videos", method: .get, parameters: videoParameters, encoding: URLEncoding.default, headers: nil).responseJSON{ videoResponse in
                                
                                let videoJson = JSON(videoResponse.result.value as Any)
                                //print(videoResponse.result.value)
                                for(videoKey, videoSubJson):(String, JSON) in videoJson
                                {
                                   
                                    if(videoKey == "items")
                                    {
                                        
                                        let duration = videoSubJson[0]["contentDetails"]["duration"].stringValue
                                        
                                        var videoToInsert : Video = Video()
                                        
                                        print("--------New Video-------\n" )
                                        videoToInsert.id = id
                                        videoToInsert.title = title
                                        videoToInsert.channel = channel
                                        videoToInsert.duration = parseDuration(duration: duration)
                                        videoToInsert.date = parseDate(date: date)
                                        videoToInsert.videoImg = thumbnail
                                        videoToInsert.type = VideoType.movie
                                        videos.append(videoToInsert)
                                        print(videoToInsert.id + "\n" + videoToInsert.title + "\n" +  videoToInsert.channel + "\n" +  videoToInsert.date + "\n" +  videoToInsert.duration + "\n")
                                        
                                        if(videos.count == 10)
                                        {
                                            completion(videos)
                                        }
                                    }
                                }

                            }
                            
                            
                        }
                        
                    }
                }
            }
        }
        
    }
    
    public static func parseDuration(duration: String) -> String
    {
        if(duration.count < 5) {return "LIVE"} // TO IMPROVE
        let index = duration.index(duration.startIndex, offsetBy: 2)
        
        let shortTime = String(duration[index...])
        let indexFin = shortTime.index(shortTime.endIndex, offsetBy: -2)
      
        let justM = String(shortTime[...indexFin])
        let indexM = justM.index(of: "M")
        
        //let mins = String(justM[...indexM])
        let minutes = String(justM[...justM.index(before: indexM!)])
        
        let seconds = String(justM[justM.index(after: indexM!)...])
        
        //let mIndex = duration.index(of: "M")
        //let minutes = shortTime.substring(to: shortTime.index(before: mIndex!))
        if(seconds.count<2)
        {
            return minutes+":0"+seconds
        }
        else
        {
            return minutes+":"+seconds
        }
    }
    
    public static func parseDate(date: String) -> String
    {
        let indexT = date.index(of: "T")
        let shortDate = String(date[...date.index(before:indexT!)])
        return "Uploaded on: " + shortDate
    }
    
}


