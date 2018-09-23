//
//  VideoModel.swift
//  BabyTube
//
//  Created by Virtual Castle  on 9/23/18.
//  Copyright © 2018 Virtual Castle . All rights reserved.
//

import Foundation
import Alamofire

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
        
        
        let parameters: Parameters = ["part": "snippet", "q":"Post Malone", "key":API_KEY]
        
        Alamofire.request("https://www.googleapis.com/youtube/v3/search", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON{ response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
        
        
        return videos
    }
    
}


