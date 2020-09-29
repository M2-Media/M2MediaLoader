//
//  ExampleTableViewController.swift
//  MediaLoader_Example
//
//  Created by Matias Fernandez on 4/14/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import M2MediaLoader

class ExampleTableViewController: UITableViewController {

    var options = [[M2MediaType]]()
    var selected: M2MediaType?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Image
        var images = [M2MediaType]()
        images.append(.ALL_PHOTOS)
        images.append(.PANORAMA)
        images.append(.HDR_PHOTO)
        images.append(.SCREENSHOT)
        images.append(.LIVE_IMAGE)
        images.append(.DEPTH_IMAGE)
        options.append(images)
        
        //Video
        var video = [M2MediaType]()
        video.append(.ALL_VIDEOS)
        video.append(.VIDEO_STREAMED)
        video.append(.VIDEO_HFR)
        video.append(.VIDEO_TIMELAPSE)
        options.append(video)
        
        //Audio
        var audio = [M2MediaType]()
        audio.append(.ALL_AUDIOS)
        audio.append(.AUDIO)
        options.append(audio)
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Photos"
        case 1:
            return "Videos"
        case 2:
            return "Audio"
        default:
            return "Unknown"
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return options.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return options[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath)

        let option = options[indexPath.section][indexPath.row]
        cell.textLabel?.text = option.name

        return cell
    }

    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        selected = options[indexPath.section][indexPath.row]
        NSLog("Clicked \(String(describing: selected))")
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selected = options[indexPath.section][indexPath.row]
//        NSLog("Clicked \(selected)")
//    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "push") {
            let destination = segue.destination
            if(destination .isKind(of: ExampleCollectionViewController.classForCoder())) {
                
                if (selected != nil) {
                    (destination as! ExampleCollectionViewController).load(selected!)
                }
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

