//
//  ViewController.swift
//  BabyTube
//
//  Created by Virtual Castle  on 9/19/18.
//  Copyright © 2018 Virtual Castle . All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import WebKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    
    
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var searchBar: UITextField!
    
    @IBOutlet weak var logoImage: UIImageView!
    var videoArray = [Video]()
    
    @IBOutlet weak var searchButton: UIButton!
    private var isShowingSearchBar: Bool = false
    
    
   
    
    @IBOutlet var modalButton: UIButton!
    
    @IBOutlet var modalBG: UIImageView!
    
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        self.table.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        isShowingSearchBar = false
        //setUpVideos(videoArray: VideoModel.retriveVideosFromStaticSource())
        //setUpVideos(videoArray: VideoModel.retriveVideosFromYoutube(query: "Post Malone"))
        VideoModel.retriveVideosFromYoutube(query: "funny babies"){ [weak self] (data: [Video]) in self?.refreshTableData(newVids: data)}
    }

    private func setUpVideos(videoArray: [Video])
    {
        self.videoArray = videoArray
        
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
        
        cell.videoImg.sd_setImage(with: URL(string: videoArray[indexPath.row].videoImg), placeholderImage: #imageLiteral(resourceName: "4"))
        
        if(videoArray[indexPath.row].type.rawValue == "Episode")
        {
            cell.type.image = #imageLiteral(resourceName: "episode") //Meaning Episodes
        }
        else
        {
           cell.type.image = #imageLiteral(resourceName: "movie") //Meaning Solo Video or Movie
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var index = indexPath.row
        //print("User Selected: "+videoArray[index].title)
        webView.isHidden = false
        let videoCode = videoArray[index].id
        let murl = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        
        webView.load(URLRequest(url: murl!))
        modalButton.isHidden = false
        modalBG.isHidden = false
        webView.isHidden = false
    }
    
    
    @IBAction func showSearchBar(_ sender: Any) {
        if(!isShowingSearchBar)
        {
            logoImage.isHidden = true
            isShowingSearchBar = true
            searchBar.isHidden = false
            
            searchButton.setImage(#imageLiteral(resourceName: "CancelImage"), for: UIControlState.normal)
        }
        else
        {
            logoImage.isHidden = false
            isShowingSearchBar = false
            searchBar.isHidden = true
            searchButton.setImage(#imageLiteral(resourceName: "SearchImage"),for: UIControlState.normal)
        }
        
    }
    @IBAction func closeModal(_ sender: Any) {
        modalButton.isHidden = true
        modalBG.isHidden = true
        webView.isHidden = true
    }
    
    @IBAction func searchAction(_ sender: Any) {
        print("Search Now: "+searchBar.text!)
        searchBar.resignFirstResponder()
        
        VideoModel.retriveVideosFromYoutube(query: searchBar.text!){ [weak self] (data: [Video]) in self?.refreshTableData(newVids: data)}
    }
    
    public func refreshTableData(newVids: [Video])
    {
        self.videoArray = newVids
        print("Updating Videos, First title: ")
        print(self.videoArray.count)
        table.reloadData()
    }
    
    

}

