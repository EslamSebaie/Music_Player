//
//  ViewController.swift
//  SebaieFM
//
//  Created by Eslam Sebaie on 11/5/19.
//  Copyright © 2019 Eslam Sebaie. All rights reserved.
//
/*
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

*/
import UIKit
import AVFoundation

var songs:[String] = []
var Audio_player = AVAudioPlayer()

var audiostuffed = false

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    var thisSong = 0
    
  
    @IBOutlet weak var laLable: UILabel!
    
    @IBOutlet weak var myTableview: UITableView!
   // @IBOutlet weak var collectview: UICollectionView!
    @IBOutlet weak var collectview: UICollectionView!
    @IBOutlet weak var pagecont: UIPageControl!
    
    //@IBOutlet weak var pagecont: UIPageControl!
    var color = UIColor.black
    var imageArr = [UIImage(named: "adele1" ),
                    UIImage(named: "adele2" ),
                    UIImage(named: "adele3" ),
                    UIImage(named: "adele4" ),
                    UIImage(named: "adele5" ),
                    UIImage(named: "adele6" ),
                    UIImage(named: "adele7" )
        
        
    ]
    
    
    var imgArr = [ "adele1" ,"adele2" ,
                    "adele3" ,
                     "adele4",
                    "adele5" ,
                    "adele6" ,
                    "adele7"
    ]
    
    
    var timer = Timer()
    var count = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gettingSongname()
        pagecont.numberOfPages = imageArr.count
        pagecont.currentPage = 0
        DispatchQueue.main.async {
            
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @objc func changeImage()  {
        
        if count < imageArr.count {
            let index = IndexPath.init(item: count, section: 0)
            self.collectview.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pagecont.currentPage = count
            count += 1
        } else {
            count = 0
            let index = IndexPath.init(item: count, section: 0)
            self.collectview.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pagecont.currentPage = count
            count = 1
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let cell = UITableViewCell(style: .default, reuseIdentifier: "cell") as! viewControllerTableViewCell
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! viewControllerTableViewCell
        
        cell.laLable.text = songs[indexPath.row]
        cell.laImage.image = UIImage(named: (imgArr[indexPath.row]))
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
            tableView.deselectRow(at: indexPath, animated: true)
        
           performSegue(withIdentifier: "secondpage", sender: self)
            
        
    }
    override  func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondcont = segue.destination as! SecondViewController
        secondcont.mysong = myTableview.indexPathForSelectedRow?.row ?? 1
         
        
        
    }
    
    
    func gettingSongname()  {
        let folderUrl = URL(fileURLWithPath: Bundle.main.resourcePath!)
        do
        {
            let songPath = try FileManager.default.contentsOfDirectory(at: folderUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            for song in songPath
            {
                var mySong = song.absoluteString
                if (mySong.contains(".mp3"))
                {
                    let findString = mySong.components(separatedBy: "/")
                    mySong = findString[findString.count-1]
                    mySong = mySong.replacingOccurrences(of: "%20", with: " ")
                    mySong = mySong.replacingOccurrences(of: ".mp3", with: "")
                
                    songs.append(mySong)
                    
                }
            }
            myTableview.reloadData()
        }
        catch
        {
            
        }
    }
}


extension ViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let vc = cell.viewWithTag(111) as? UIImageView {
            vc.image = imageArr[indexPath.row]
        }
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectview.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
