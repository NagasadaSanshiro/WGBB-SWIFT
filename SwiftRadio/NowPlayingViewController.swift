//
//  NowPlayingViewController.swift
//  WGBB
//
//  Created by Zhongyi Yan on 5/21/16.
//  Copyright © 2016 Zhongyi Yan. All rights reserved.
//

import UIKit
import MediaPlayer

//*****************************************************************
// Protocol
// Updates the StationsViewController when the track changes
//*****************************************************************

protocol NowPlayingViewControllerDelegate: class {
    func songMetaDataDidUpdate(_ track: Track)
    func artworkDidUpdate(_ track: Track)
    func trackPlayingToggled(_ track: Track)
}

//*****************************************************************

//*****************************************************************

class NowPlayingViewController: UIViewController {

    //@IBOutlet weak var albumHeightConstraint: NSLayoutConstraint!
    //@IBOutlet weak var albumImageView: SpringImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    //@IBOutlet weak var songLabel: SpringLabel!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var stationDescLabel: UILabel!
    @IBOutlet weak var volumeParentView: UIView!
    @IBOutlet weak var slider = UISlider()
    @IBOutlet weak var menuButtom: UIButton!
    
    
    var currentStation: RadioStation!
    var downloadTask: URLSessionDownloadTask?
    var iPhone4 = false
    var justBecameActive = false
    var newStation = true
    var nowPlayingImageView: UIImageView!
    let radioPlayer = Player.radio
    var track: Track!
    var trackR: Track!
    var mpVolumeSlider = UISlider()
    let WGBB_URL = "live stream"
    weak var delegate: NowPlayingViewControllerDelegate?
    
    var imageView: UIImageView!
    let maskLayer = CALayer()
    let btLayer = CALayer()
    
    //*****************************************************************
    // MARK: - ViewDidLoad
    //*****************************************************************
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        /*self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true*/
        
        /*navigationController?.navigationBar.barTintColor = UIColor.purpleColor()*/
        self.navigationController?.navigationBar.topItem?.title = "紐約中國廣播網"
        self.navigationItem.title = "AM WGBB 1240"
        
        
        trackR = Track()
        trackR.title = "紐約中國廣播網"
        /*"streamURL": "http://209.17.186.202:8275/1240",*/
        trackR.artworkURL = "http://live.chineseradionetwork.com"
       //--------------------
        
        let image = UIImage(named: "background2")!
        
        // initialize the value of imageView with a CGRectZero, resize it later
        self.imageView = UIImageView(frame: CGRect.zero)
        
        self.imageView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7)

        // set the appropriate contentMode and add the image to your imageView property
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.image = image
        
        // add the imageView to your view hierarchy
        
        
        
        
        maskLayer.frame = CGRect(x: 0, y: 0, width: imageView.frame.size.width/2, height:imageView.frame.size.height)//Double((imageView.image?.size.height)!)
        maskLayer.backgroundColor = UIColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 0.5).cgColor
        maskLayer.masksToBounds = true
        
        
        /*self.view.layer.mask = maskLayer*/
        //self.view.layer.insertSublayer(maskLayer, above: <#T##CALayer?#>)
        //self.view.layer.insertSublayer(maskLayer, atIndex: 5)
        //self.view.addSubview(imageView)
        
        //--------------------
        
        //--------------------
        /*let X_Co = (self.view.frame.size.width - 50)/2
        menuButtom.frame = CGRectMake( 0.0 , 20.0, 50.0, 50.0)*/
        //--------------------
        // Setup handoff functionality - GH
        //setupUserActivity()
        
        // Set AlbumArtwork Constraints
        optimizeForDeviceSize()

        // Set View Title
        self.title = trackR.title
        //self.title = currentStation.stationName
        
        // Create Now Playing BarItem
        //createNowPlayingAnimation()
        pauseButton.isHidden = true
        // Setup MPMoviePlayerController
        // If you're building an app for a client, you may want to
        // replace the MediaPlayer player with a more robust 
        // streaming library/SDK. Preferably one that supports interruptions, etc.
        // Most of the good streaming libaries are in Obj-C, however they
        // will work nicely with this Swift code. There is a branch using RadioKit if 
        // you need an example of how nicely this code integrates with libraries.
        setupPlayer()
        
        // Notification for when app becomes active
        NotificationCenter.default.addObserver(self,
            selector: #selector(NowPlayingViewController.didBecomeActiveNotificationReceived),
            name:NSNotification.Name(rawValue: "UIApplicationDidBecomeActiveNotification"),
            object: nil)
        
        // Notification for MediaPlayer metadata updated
        NotificationCenter.default.addObserver(self,
            selector: #selector(NowPlayingViewController.metadataUpdated(_:)),
            name:NSNotification.Name.MPMoviePlayerTimedMetadataUpdated,
            object: nil);
        
        // Check for station change
        if newStation {
            track = Track()
            stationDidChange()
        } else {
            updateLabels()
            /*albumImageView.image = track.artworkImage*/
            
            if !track.isPlaying {
                pausePressed()
            } else {
                //nowPlayingImageView.startAnimating()
            }
        }
        //assignbackground()
        // Setup slider
        //setupVolumeSlider()
    }// NowPlayingViewController
    
    
    @IBAction func ToTab(_ sender: AnyObject) {
           }
    
    func didBecomeActiveNotificationReceived() {
        // View became active
        updateLabels()
        justBecameActive = true
        resetAlbumArtwork()
    }
    
    deinit {
        // Be a good citizen
        NotificationCenter.default.removeObserver(self,
            name:NSNotification.Name(rawValue: "UIApplicationDidBecomeActiveNotification"),
            object: nil)
        NotificationCenter.default.removeObserver(self,
            name: NSNotification.Name.MPMoviePlayerTimedMetadataUpdated,
            object: nil)
    }
    
    func assignbackground(){
        //let background = UIImage(named: "background")
        
        
        //backGroundImage = UIImageView(frame: view.bounds)
        
        
        //backGroundImage.contentMode = .ScaleAspectFill
        //backGroundImage.clipsToBounds = true
        //backGroundImage.center = view.center
        
    	
        //view.addSubview(backGroundImage)
        //self.view.sendSubviewToBack(backGroundImage)
        //backGroundImage.frame = view.bounds
        
        
        let image = UIImage(named: "background2")!
        
        // initialize the value of imageView with a CGRectZero, resize it later
        self.imageView = UIImageView(frame: CGRect.zero)
        
        // set the appropriate contentMode and add the image to your imageView property
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.image = image
        
        // add the imageView to your view hierarchy
        self.view.addSubview(imageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //set the frame of your imageView here to automatically adopt screen size changes (e.g. by rotation or splitscreen)
        self.imageView.frame = self.view.bounds
        self.view.sendSubview(toBack: imageView)
    }
    
    //*****************************************************************
    // MARK: - Setup
    //*****************************************************************
    
    func setupPlayer() {
        radioPlayer.view.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        radioPlayer.view.sizeToFit()
        radioPlayer.movieSourceType = MPMovieSourceType.streaming
        radioPlayer.isFullscreen = false
        radioPlayer.shouldAutoplay = true
        radioPlayer.prepareToPlay()
        radioPlayer.controlStyle = MPMovieControlStyle.none
    }
  
    func setupVolumeSlider() {
        // Note: This slider implementation uses a MPVolumeView
        // The volume slider only works in devices, not the simulator.
        volumeParentView.backgroundColor = UIColor.clear
        let volumeView = MPVolumeView(frame: volumeParentView.bounds)
        for view in volumeView.subviews {
            let uiview: UIView = view as UIView
             if (uiview.description as NSString).range(of: "MPVolumeSlider").location != NSNotFound {
                mpVolumeSlider = (uiview as! UISlider)
            }
        }
        
        let thumbImageNormal = UIImage(named: "slider-ball")
        slider?.setThumbImage(thumbImageNormal, for: UIControlState())
        
    }
    
    func stationDidChange() {
        radioPlayer.stop()
        
        //radioPlayer.contentURL = NSURL(string: currentStation.stationStreamURL)
        radioPlayer.contentURL = URL(string: self.trackR.artworkURL)
        radioPlayer.prepareToPlay()
        radioPlayer.play()
        updateLabels("Loading Station...")
        
        // songLabel animate
        /*songLabel.animation = "flash"
        songLabel.repeatCount = 3
        songLabel.animate()*/
        
        resetAlbumArtwork()
        //playButton.hidden = false   // July 15 By Yan
        //pauseButton.hidden = true   // July 15 By Yan
        //track.isPlaying = false     // July 15 By Yan
        playButtonEnable(false)
        
        
    }
    
    //*****************************************************************
    // MARK: - Player Controls (Play/Pause/Volume)
    //*****************************************************************
    
    @IBAction func playPressed() {
        playButtonEnable(false)
        radioPlayer.play()
        updateLabels()
        
        // songLabel Animation
        /*songLabel.animation = "flash"
        songLabel.animate()*/
        
        // Start NowPlaying Animation
        //nowPlayingImageView.startAnimating()
        
        // Update StationsVC
        self.delegate?.trackPlayingToggled(self.track)
    }
    
    @IBAction func pausePressed() {
        playButtonEnable()
        
        radioPlayer.pause()
        updateLabels("Station Paused...")
        //nowPlayingImageView.stopAnimating()
        
        // Update StationsVC
        self.delegate?.trackPlayingToggled(self.track)
    }
    
    @IBAction func volumeChanged(_ sender:UISlider) {
        mpVolumeSlider.value = sender.value
    }
    
    //*****************************************************************
    // MARK: - UI Helper Methods
    //*****************************************************************
    
    func playButtonEnable(_ enabled: Bool = true) {
        if enabled {
            playButton.isEnabled = true
            playButton.isHidden = false
            pauseButton.isEnabled = false
            pauseButton.isHidden = true
            track.isPlaying = false
        } else {
            playButton.isEnabled = false
            playButton.isHidden = true
            pauseButton.isEnabled = true
            pauseButton.isHidden = false
            track.isPlaying = true
        }
    }
    
    
    func optimizeForDeviceSize() {
        
        // Adjust album size to fit iPhone 4s, 6s & 6s+
        let deviceHeight = self.view.bounds.height
        
        if deviceHeight == 480 {
            iPhone4 = true
            //albumHeightConstraint.constant = 106
            //view.updateConstraints()
        } else if deviceHeight == 667 {
            //albumHeightConstraint.constant = 230
            //view.updateConstraints()
        } else if deviceHeight > 667 {
            //albumHeightConstraint.constant = 260
            //view.updateConstraints()
        }
    }
    
    func updateLabels(_ statusMessage: String = "") {
        
        if statusMessage != "" {
            // There's a an interruption or pause in the audio queue
            songLabel.text = WGBB_URL
            //songLabel.text = ""
            //songLabel.text = statusMessage
            //artistLabel.text = trackR.title
            //artistLabel.text = currentStation.stationName
            
        } else {
            // Radio is (hopefully) streaming properly
            if track != nil {
                songLabel.text = WGBB_URL
                //songLabel.text = ""
                //songLabel.text = track.title
                //artistLabel.text = track.artist
            }
        }
        
        // Hide station description when album art is displayed or on iPhone 4
        if track.artworkLoaded || iPhone4 {
            stationDescLabel.isHidden = true
        } else {
            stationDescLabel.isHidden = false
            stationDescLabel.text = ""
            //stationDescLabel.text = currentStation.stationDesc
        }
    }
    
    
    func createNowPlayingAnimation() {
        
        // Setup ImageView
        nowPlayingImageView = UIImageView(image: UIImage(named: "NowPlayingBars-3"))
        nowPlayingImageView.autoresizingMask = UIViewAutoresizing()
        //nowPlayingImageView.contentMode = UIViewContentMode.Center
        
        // Create Animation
        nowPlayingImageView.animationImages = AnimationFrames.createFrames()
        nowPlayingImageView.animationDuration = 0.7
        
        // Create Top BarButton
        let barButton = UIButton(type: UIButtonType.custom)
        barButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40);
        barButton.addSubview(nowPlayingImageView)
        nowPlayingImageView.center = barButton.center
        
        let barItem = UIBarButtonItem(customView: barButton)
        self.navigationItem.rightBarButtonItem = barItem
        
    }
    
    func startNowPlayingAnimation() {
        //nowPlayingImageView.startAnimating()
    }
    
    //*****************************************************************
    // MARK: - Album Art
    //*****************************************************************
    
    func resetAlbumArtwork() {
        track.artworkLoaded = false
        track.artworkURL = "" //currentStation.stationImageURL
        //resetAlbumArtwork()
        stationDescLabel.isHidden = false
    }
    
   /* func updateAlbumArtwork() {
        track.artworkLoaded = false
        if track.artworkURL.range(of: "http") != nil {
            
            // Hide station description
            DispatchQueue.main.async {
                //self.albumImageView.image = nil
                self.stationDescLabel.isHidden = false
            }
            
            // Attempt to download album art from an API
            if let url = URL(string: track.artworkURL) {
                
                self.downloadTask = self.albumImageView.loadImageWithURL(url) { (image) in
                    
                    // Update track struct
                    self.track.artworkImage = image
                    self.track.artworkLoaded = true
                    
                    // Turn off network activity indicator
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        
                    // Animate artwork
                    self.albumImageView.animation = "wobble"
                    self.albumImageView.duration = 2
                    self.albumImageView.animate()
                    self.stationDescLabel.isHidden = true

                    // Update lockscreen
                    self.updateLockScreen()
                    
                    // Call delegate function that artwork updated
                    self.delegate?.artworkDidUpdate(self.track)
                }
            }
            
            // Hide the station description to make room for album art
            if track.artworkLoaded && !self.justBecameActive {
                self.stationDescLabel.isHidden = true
                self.justBecameActive = false
            }
            
        } else if track.artworkURL != "" {
            // Local artwork
            self.albumImageView.image = UIImage(named: track.artworkURL)
            track.artworkImage = albumImageView.image
            track.artworkLoaded = true
            
            // Call delegate function that artwork updated
            self.delegate?.artworkDidUpdate(self.track)
            
        } else {
            // No Station or API art found, use default art
            //self.albumImageView.image = UIImage(named: "albumArt")
            //track.artworkImage = albumImageView.image
        }
        
        // Force app to update display
        self.view.setNeedsDisplay()
    }*/

    // Call LastFM or iTunes API to get album art url
    
    func queryAlbumArt() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // Construct either LastFM or iTunes API call URL
        let queryURL: String
        if useLastFM {
            queryURL = String(format: "http://ws.audioscrobbler.com/2.0/?method=track.getInfo&api_key=%@&artist=%@&track=%@&format=json", apiKey, track.artist, track.title)
        } else {
            queryURL = String(format: "https://itunes.apple.com/search?term=%@+%@&entity=song", track.artist, track.title)
        }
        
        let escapedURL = queryURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        // Query API
        DataManager.getTrackDataWithSuccess(escapedURL!) { (data) in
            
            if DEBUG_LOG {
                print("API SUCCESSFUL RETURN")
                print("url: \(escapedURL!)")
            }
            
            let json = JSON(data: data!)
            
            if useLastFM {
                // Get Largest Sized LastFM Image
                if let imageArray = json["track"]["album"]["image"].array {
                    
                    let arrayCount = imageArray.count
                    let lastImage = imageArray[arrayCount - 1]
                    
                    if let artURL = lastImage["#text"].string {
                        
                        // Check for Default Last FM Image
                        if artURL.range(of: "/noimage/") != nil {
                            self.resetAlbumArtwork()
                            
                        } else {
                            // LastFM image found!
                            self.track.artworkURL = artURL
                            self.track.artworkLoaded = true
                            self.resetAlbumArtwork()
                        }
                        
                    } else {
                        self.resetAlbumArtwork()
                    }
                } else {
                    self.resetAlbumArtwork()
                }
            
            } else {
                // Use iTunes API. Images are 100px by 100px
                if let artURL = json["results"][0]["artworkUrl100"].string {
                    
                    if DEBUG_LOG { print("iTunes artURL: \(artURL)") }
                    
                    self.track.artworkURL = artURL
                    self.track.artworkLoaded = true
                    self.resetAlbumArtwork()
                } else {
                    self.resetAlbumArtwork()
                }
            }
            
        }
    }
    
    //*****************************************************************
    // MARK: - Segue
    //*****************************************************************
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "InfoDetail" {
            let infoController = segue.destination as! InfoDetailViewController
            infoController.currentStation = currentStation
        }
    }
    
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "InfoDetail", sender: self)
    }
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        let songToShare = "I'm listening to \(track.title) on \(currentStation.stationName) via Swift Radio Pro"
        let activityViewController = UIActivityViewController(activityItems: [songToShare, track.artworkImage!], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    //*****************************************************************
    // MARK: - MPNowPlayingInfoCenter (Lock screen)
    //*****************************************************************
    
    func updateLockScreen() {
        
        // Update notification/lock screen
        let albumArtwork = MPMediaItemArtwork(image: track.artworkImage!)
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            MPMediaItemPropertyArtist: track.artist,
            MPMediaItemPropertyTitle: track.title,
            MPMediaItemPropertyArtwork: albumArtwork
        ]
    }
    
    override func remoteControlReceived(with receivedEvent: UIEvent?) {
        super.remoteControlReceived(with: receivedEvent)
        
        if receivedEvent!.type == UIEventType.remoteControl {
            
            switch receivedEvent!.subtype {
            case .remoteControlPlay:
                playPressed()
            case .remoteControlPause:
                pausePressed()
            default:
                break
            }
        }
    }
    
    //*****************************************************************
    // MARK: - MetaData Updated Notification
    //*****************************************************************
    
    func metadataUpdated(_ n: Notification)
    {
        if(radioPlayer.timedMetadata != nil && radioPlayer.timedMetadata.count > 0)
        {
            startNowPlayingAnimation()
            
            let firstMeta: MPTimedMetadata = radioPlayer.timedMetadata.first as! MPTimedMetadata
            let metaData = firstMeta.value as! String
            
            var stringParts = [String]()
            if metaData.range(of: " - ") != nil {
                stringParts = metaData.components(separatedBy: " - ")
            } else {
                stringParts = metaData.components(separatedBy: "-")
            }
            
            // Set artist & songvariables
            let currentSongName = track.title
            track.artist = stringParts[0]
            track.title = stringParts[0]
            
            if stringParts.count > 1 {
                track.title = stringParts[1]
            }
            
            if track.artist == "" && track.title == "" {
                track.artist = currentStation.stationDesc
                track.title = currentStation.stationName
            }
            
            DispatchQueue.main.async {
                
                if currentSongName != self.track.title {
                    
                    if DEBUG_LOG {
                        print("METADATA artist: \(self.track.artist) | title: \(self.track.title)")
                    }
                    
                    // Update Labels
                    //self.artistLabel.text = self.track.artist
                    self.songLabel.text = self.WGBB_URL
                    //self.songLabel.text = self.track.title
                    self.updateUserActivityState(self.userActivity!)
                    
                    // songLabel animation
                    /*self.songLabel.animation = "zoomIn"
                    self.songLabel.duration = 1.5
                    self.songLabel.damping = 1
                    self.songLabel.animate()*/
                    
                    // Update Stations Screen
                    self.delegate?.songMetaDataDidUpdate(self.track)
                    
                    // Query API for album art
                    self.resetAlbumArtwork()
                    self.queryAlbumArt()
                    self.updateLockScreen()
                    
                }
            }
        }
    }
    
    //*****************************************************************
    // MARK: - Handoff Functionality - GH
    //*****************************************************************
    
    func setupUserActivity() {
        let activity = NSUserActivity(activityType: NSUserActivityTypeBrowsingWeb ) //"com.graemeharrison.handoff.googlesearch" //NSUserActivityTypeBrowsingWeb
        userActivity = activity
        let url = "https://www.google.com" /*"https://www.google.com/search?q=\(self.artistLabel.text!)+\(self.songLabel.text!)"*/
        let urlStr = "" /*url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())*/
        let searchURL : URL = URL(string: urlStr)! //NSURL(string: urlStr!)!
        activity.webpageURL = searchURL
        userActivity?.becomeCurrent()
    }
    
    override func updateUserActivityState(_ activity: NSUserActivity) {
        let url = "https://www.google.com/search?q=\(self.artistLabel.text!)+\(self.songLabel.text!)"
        let urlStr = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let searchURL : URL = URL(string: urlStr!)!
        activity.webpageURL = searchURL
        super.updateUserActivityState(activity)
    }
}
