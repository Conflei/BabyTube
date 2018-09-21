//
//  ViewController.swift
//  BabyTube
//
//  Created by Virtual Castle  on 9/19/18.
//  Copyright © 2018 Virtual Castle . All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var videoArray = [Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpVideos()
    }

    private func setUpVideos()
    {
        videoArray.append(Video(title: "Episode 1", videoImg: #imageLiteral(resourceName: "1"), channel: "The Office US", type: VideoType.episode))
        videoArray.append(Video(title: "Best Prank", videoImg: #imageLiteral(resourceName: "2"), channel: "The Office Jokes", type: VideoType.movie))
        videoArray.append(Video(title: "Best Shows Ep 2", videoImg: #imageLiteral(resourceName: "5"), channel: "Best of Netflix ", type: VideoType.episode))
        videoArray.append(Video(title: "Episode 2", videoImg: #imageLiteral(resourceName: "4"), channel: "The Office US", type: VideoType.episode))
        videoArray.append(Video(title: "Jim and Pam", videoImg: #imageLiteral(resourceName: "2"), channel: "Best of Netflix ", type: VideoType.movie))
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("VideoTableCell", owner: self, options: nil)?.first as! VideoTableCell
        
        cell.title.text = videoArray[indexPath.row].title
        cell.channel.text = videoArray[indexPath.row].channel
        cell.typeVideo.text = videoArray[indexPath.row].type.rawValue
        cell.videoImg.image = videoArray[indexPath.row].videoImg
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }
    
    

}

class Video {
    let title: String
    let videoImg: UIImage
    let channel: String
    let type: VideoType
    
    init(title: String, videoImg: UIImage, channel: String, type: VideoType)
    {
        self.title = title
        self.videoImg = videoImg
        self.channel = channel
        self.type = type
    }
}

enum VideoType: String {
    case episode = "Episode"
    case movie = "SoloVideo"
}

