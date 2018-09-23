//
//  ViewController.swift
//  BabyTube
//
//  Created by Virtual Castle  on 9/19/18.
//  Copyright © 2018 Virtual Castle . All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    

    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var logoImage: UIImageView!
    var videoArray = [Video]()
    
    @IBOutlet weak var searchButton: UIButton!
    private var isShowingSearchBar: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        self.table.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        isShowingSearchBar = false
        setUpVideos()
        setUpSearchBar()
    }

    private func setUpVideos()
    {
        videoArray.append(Video(title: "Episode 1", videoImg: #imageLiteral(resourceName: "1"), channel: "The Office US", type: VideoType.episode, duration: "3:11", date: "Published on Sep 21, 2027"))
        videoArray.append(Video(title: "Best Prank", videoImg: #imageLiteral(resourceName: "2"), channel: "The Office Jokes", type: VideoType.movie, duration: "3:12", date: "Published on Sep 22, 2017"))
        videoArray.append(Video(title: "Best Shows Ep 2", videoImg: #imageLiteral(resourceName: "5"), channel: "Best of Netflix ", type: VideoType.episode, duration: "3:13", date: "Published on Sep 27, 2013"))
        videoArray.append(Video(title: "Episode 2", videoImg: #imageLiteral(resourceName: "4"), channel: "The Office US", type: VideoType.episode, duration: "3:14", date: "Published on Sep 17, 2017"))
        videoArray.append(Video(title: "Jim and Pam", videoImg: #imageLiteral(resourceName: "2"), channel: "Best of Netflix ", type: VideoType.movie, duration: "3:15", date: "Published on Sep 21, 2011"))
        
    }
    
    private func setUpSearchBar()
    {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("VideoTableCell", owner: self, options: nil)?.first as! VideoTableCell
        
        cell.title.text = videoArray[indexPath.row].title
        cell.channel.text = videoArray[indexPath.row].channel
        cell.date.text = videoArray[indexPath.row].date
        cell.duration.text = videoArray[indexPath.row].duration
        
        cell.videoImg.image = videoArray[indexPath.row].videoImg
        
        if(videoArray[indexPath.row].type.rawValue == "Episode")
        {
            cell.type.image = #imageLiteral(resourceName: "episode")
        }
        else
        {
           cell.type.image = #imageLiteral(resourceName: "movie")
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }
    
    
    @IBAction func ShowSearchBar(_ sender: Any) {
        if(!isShowingSearchBar)
        {
            logoImage.isHidden = true
            isShowingSearchBar = true
            
            searchButton.setImage(#imageLiteral(resourceName: "CancelImage"), for: UIControlState.normal)
        }
        else
        {
            logoImage.isHidden = false
            isShowingSearchBar = false
            searchButton.setImage(#imageLiteral(resourceName: "SearchImage"),for: UIControlState.normal)
        }
        
    }
    

}

class Video {
    let title: String
    let videoImg: UIImage
    let channel: String
    let duration: String
    let date: String
    let type: VideoType
    
    init(title: String, videoImg: UIImage, channel: String, type: VideoType, duration: String, date: String)
    {
        self.title = title
        self.videoImg = videoImg
        self.channel = channel
        self.type = type
        self.duration = duration
        self.date = date
    }
}

enum VideoType: String {
    case episode = "Episode"
    case movie = "SoloVideo"
}

