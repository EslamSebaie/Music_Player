//
//  SecondViewController.swift
//  SebaieFM
//
//  Created by Eslam Sebaie on 11/5/19.
//  Copyright © 2019 Eslam Sebaie. All rights reserved.
//

import UIKit
import AVFoundation
class SecondViewController: UIViewController {
    
    
  
    
    
    
    
    
    @IBOutlet weak var laLable: UILabel!
   
    @IBOutlet weak var laImage: UIImageView!
   
    @IBOutlet weak var favouriteButton: UIButton!
    
    var favourited:Bool = false
    
    var player = AVAudioPlayer()
   
   
    
    
    @IBOutlet weak var slider: UISlider!
   
    var timer: Timer?
    
  
    
    
    @IBOutlet weak var timeElapsedLable: UILabel!
    @IBOutlet weak var timeRemainingLable: UILabel!
    
    @IBOutlet weak var playPauseButton: UIButton!
    var mysong = Int()
    
   // @IBOutlet weak var playPauseButton: UIButton!
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        do
        {
            
           let audiopath = Bundle.main.path(forResource: songs[mysong], ofType: ".mp3")
         try Audio_player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audiopath!) as URL)
        
        }catch{
            
            print("error")
        }
            Audio_player.play()
        
        audiostuffed = true
        laLable.text = songs[mysong]
        
        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func favouriteTapped(_ sender: Any) {
        
        favourited = !favourited
        if favourited == true {
            favouriteButton.setImage(UIImage(named: "white.png"), for: .normal)
        } else {
            favouriteButton.setImage(UIImage(named: "icons8-red-heart-96.png"), for: .normal)
        }
    }
    
    
   
    
    @IBAction func sliderValuechange(_ sender: Any) {
        player.currentTime = Float64(slider.value)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        player = Audio_player
        slider.value = 0.0
        slider.maximumValue = Float(player.duration)
        player.play()
        timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
    }
    @objc func updateSlider() {
        player = Audio_player
        slider.value = Float(player.currentTime)
        let remainingTimeInSeconds = player.duration - player.currentTime
        timeElapsedLable.text = getFormattedTime(timeInterval: remainingTimeInSeconds)
        timeRemainingLable.text = getFormattedTime(timeInterval: player.currentTime)
    }
    
    
    
    func getFormattedTime(timeInterval: TimeInterval) -> String {
        let mins = timeInterval / 60
        let secs = timeInterval.truncatingRemainder(dividingBy: 60)
        let timeformatter = NumberFormatter()
        timeformatter.minimumIntegerDigits = 2
        timeformatter.minimumFractionDigits = 0
        timeformatter.roundingMode = .down
        guard let minsStr = timeformatter.string(from: NSNumber(value: mins)), let secsStr = timeformatter.string(from: NSNumber(value: secs)) else {
            return ""
        }
        return "\(minsStr):\(secsStr)"
    }
    
    
    
     @IBAction func next(_ sender: Any) {
        if(mysong < songs.count-1 &&  audiostuffed == true){
            playthis(thisone: songs[mysong+1])
            mysong += 1
            laLable.text = songs[mysong]
            
            
            playPauseButton.setImage(UIImage(named: "icons8-pause-96.png"), for: .normal)
            
    
            
            
            
            
        }
    
    }
     
   
    @IBAction func prev(_ sender: Any) {
        if(mysong != 0){
            if audiostuffed == true{
                playthis(thisone: songs[mysong - 1])
                mysong -= 1
                laLable.text = songs[mysong]
                
                
                playPauseButton.setImage(UIImage(named: "icons8-pause-96.png"), for: .normal)
            }
        }
        
        
    }
    @IBAction func playPausedPressed(_ sender: Any) {
        if Audio_player.isPlaying {
            Audio_player.pause()
            playPauseButton.setImage(UIImage(named: "icons8-play-96.png"), for: .normal)
        } else {
            Audio_player.play()
            playPauseButton.setImage(UIImage(named: "icons8-pause-96.png"), for: .normal)
        }
    }
    
    
    
    func playthis(thisone:String)
    {
        do
        {
            let audiopath = Bundle.main.path(forResource: thisone, ofType: ".mp3")
            try Audio_player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audiopath!) as URL)
            
            Audio_player.play()
            
        }
        catch{
            print("error")
        }
    }
    
    
    
    
}

