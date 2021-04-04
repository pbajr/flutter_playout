//
//  VideoPlayer.swift
//  flutter_playout
//
//  Created by Khuram Khalid on 08/10/2019.
//

import Foundation
import AVFoundation
import Flutter
import MediaPlayer
import AVKit


import ObjectiveC
import CoreMedia

// private struct AssociatedKeys {
//     static var FontKey = "FontKey"
//     static var ColorKey = "FontKey"
//     static var SubtitleKey = "SubtitleKey"
//     static var SubtitleHeightKey = "SubtitleHeightKey"
//     static var PayloadKey = "PayloadKey"
// }

// @objc public class Subtitles : NSObject {

//     // MARK: - Properties
//     fileprivate var parsedPayload: NSDictionary?
    
//     // MARK: - Public methods
//     public init(file filePath: URL, encoding: String.Encoding = String.Encoding.utf8) {
        
//         // Get string
//         let string = try! String(contentsOf: filePath, encoding: encoding)
        
//         // Parse string
//         parsedPayload = Subtitles.parseSubRip(string)
        
//     }
    
//  @objc public init(subtitles string: String) {
        
//         // Parse string
//         parsedPayload = Subtitles.parseSubRip(string)
        
//     }
    
//     /// Search subtitles at time
//     ///
//     /// - Parameter time: Time
//     /// - Returns: String if exists
//  @objc public func searchSubtitles(at time: TimeInterval) -> String? {
        
//         return Subtitles.searchSubtitles(parsedPayload, time)
        
//     }
    
//     // MARK: - Private methods
    
//     /// Subtitle parser
//     ///
//     /// - Parameter payload: Input string
//     /// - Returns: NSDictionary
//     fileprivate static func parseSubRip(_ payload: String) -> NSDictionary? {
        
//         do {
            
//             // Prepare payload
//             var payload = payload.replacingOccurrences(of: "\n\r\n", with: "\n\n")
//             payload = payload.replacingOccurrences(of: "\n\n\n", with: "\n\n")
//             payload = payload.replacingOccurrences(of: "\r\n", with: "\n")
            
//             // Parsed dict
//             let parsed = NSMutableDictionary()
            
//             // Get groups
//             let regexStr = "(\\d+)\\n([\\d:,.]+)\\s+-{2}\\>\\s+([\\d:,.]+)\\n([\\s\\S]*?(?=\\n{2,}|$))"
//             let regex = try NSRegularExpression(pattern: regexStr, options: .caseInsensitive)
//             let matches = regex.matches(in: payload, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, payload.count))
//             for m in matches {
                
//                 let group = (payload as NSString).substring(with: m.range)
                
//                 // Get index
//                 var regex = try NSRegularExpression(pattern: "^[0-9]+", options: .caseInsensitive)
//                 var match = regex.matches(in: group, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, group.count))
//                 guard let i = match.first else {
//                     continue
//                 }
//                 let index = (group as NSString).substring(with: i.range)
                
//                 // Get "from" & "to" time
//                 regex = try NSRegularExpression(pattern: "\\d{1,2}:\\d{1,2}:\\d{1,2}[,.]\\d{1,3}", options: .caseInsensitive)
//                 match = regex.matches(in: group, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, group.count))
//                 guard match.count == 2 else {
//                     continue
//                 }
//                 guard let from = match.first, let to = match.last else {
//                     continue
//                 }
                
//                 var h: TimeInterval = 0.0, m: TimeInterval = 0.0, s: TimeInterval = 0.0, c: TimeInterval = 0.0
                
//                 let fromStr = (group as NSString).substring(with: from.range)
//                 var scanner = Scanner(string: fromStr)
//                 scanner.scanDouble(&h)
//                 scanner.scanString(":", into: nil)
//                 scanner.scanDouble(&m)
//                 scanner.scanString(":", into: nil)
//                 scanner.scanDouble(&s)
//                 scanner.scanString(",", into: nil)
//                 scanner.scanDouble(&c)
//                 let fromTime = (h * 3600.0) + (m * 60.0) + s + (c / 1000.0)
                
//                 let toStr = (group as NSString).substring(with: to.range)
//                 scanner = Scanner(string: toStr)
//                 scanner.scanDouble(&h)
//                 scanner.scanString(":", into: nil)
//                 scanner.scanDouble(&m)
//                 scanner.scanString(":", into: nil)
//                 scanner.scanDouble(&s)
//                 scanner.scanString(",", into: nil)
//                 scanner.scanDouble(&c)
//                 let toTime = (h * 3600.0) + (m * 60.0) + s + (c / 1000.0)
                
//                 // Get text & check if empty
//                 let range = NSMakeRange(0, to.range.location + to.range.length + 1)
//                 guard (group as NSString).length - range.length > 0 else {
//                     continue
//                 }
//                 let text = (group as NSString).replacingCharacters(in: range, with: "")
                
//                 // Create final object
//                 let final = NSMutableDictionary()
//                 final["from"] = fromTime
//                 final["to"] = toTime
//                 final["text"] = text
//                 parsed[index] = final
                
//             }
            
//             return parsed
            
//         } catch {
            
//             return nil
            
//         }
        
//     }
    
//     /// Search subtitle on time
//     ///
//     /// - Parameters:
//     ///   - payload: Inout payload
//     ///   - time: Time
//     /// - Returns: String
//     fileprivate static func searchSubtitles(_ payload: NSDictionary?, _ time: TimeInterval) -> String? {
        
//         let predicate = NSPredicate(format: "(%f >= %K) AND (%f <= %K)", time, "from", time, "to")
        
//         guard let values = payload?.allValues, let result = (values as NSArray).filtered(using: predicate).first as? NSDictionary else {
//             return nil
//         }
        
//         guard let text = result.value(forKey: "text") as? String else {
//             return nil
//         }
        
//         return text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
//     }
    
// }

// public extension AVPlayerViewController {
    
//     // MARK: - Public properties
//     var subtitleLabel: UILabel? {
//         get { return objc_getAssociatedObject(self, &AssociatedKeys.SubtitleKey) as? UILabel }
//         set (value) { objc_setAssociatedObject(self, &AssociatedKeys.SubtitleKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
//     }
    
//     // MARK: - Private properties
//     fileprivate var subtitleLabelHeightConstraint: NSLayoutConstraint? {
//         get { return objc_getAssociatedObject(self, &AssociatedKeys.SubtitleHeightKey) as? NSLayoutConstraint }
//         set (value) { objc_setAssociatedObject(self, &AssociatedKeys.SubtitleHeightKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
//     }
//     fileprivate var parsedPayload: NSDictionary? {
//         get { return objc_getAssociatedObject(self, &AssociatedKeys.PayloadKey) as? NSDictionary }
//         set (value) { objc_setAssociatedObject(self, &AssociatedKeys.PayloadKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
//     }
    
//     // MARK: - Public methods
//     func addSubtitles() -> Self {
        
//         // Create label
//         addSubtitleLabel()
        
//         return self
        
//     }
    
//     func open(fileFromLocal filePath: URL, encoding: String.Encoding = String.Encoding.utf8) {
        
//         let contents = try! String(contentsOf: filePath, encoding: encoding)
//         show(subtitles: contents)
//     }
    
//     func open(fileFromRemote filePath: URL, encoding: String.Encoding = String.Encoding.utf8) {
        
        
//         subtitleLabel?.text = "..."
//         URLSession.shared.dataTask(with: filePath, completionHandler: { (data, response, error) -> Void in
            
//             if let httpResponse = response as? HTTPURLResponse {
//                 let statusCode = httpResponse.statusCode
                
//                 //Check status code
//                 if statusCode != 200 {
//                     NSLog("Subtitle Error: \(httpResponse.statusCode) - \(error?.localizedDescription ?? "")")
//                     return
//                 }
//             }
//             // Update UI elements on main thread
//             DispatchQueue.main.async(execute: {
//                 self.subtitleLabel?.text = ""
                
//                 if let checkData = data as Data? {
//                     if let contents = String(data: checkData, encoding: encoding) {
//                         self.show(subtitles: contents)
//                     }
//                 }
                
//             })
//         }).resume()
//     }
    
    
    
//     func show(subtitles string: String) {
        
//         // Parse
//         parsedPayload = Subtitles.parseSubRip(string)
//         addPeriodicNotification(parsedPayload: parsedPayload!)
        
//     }
    
//     func showByDictionary(dictionaryContent: NSMutableDictionary) {
        
//         // Add Dictionary content direct to Payload
//         parsedPayload = dictionaryContent
//         addPeriodicNotification(parsedPayload: parsedPayload!)
        
//     }
    
//     func addPeriodicNotification(parsedPayload: NSDictionary) {
//         // Add periodic notifications
//         self.player?.addPeriodicTimeObserver(
//             forInterval: CMTimeMake(value: 1, timescale: 60),
//             queue: DispatchQueue.main,
//             using: { [weak self] (time) -> Void in
                
//                 guard let strongSelf = self else { return }
//                 guard let label = strongSelf.subtitleLabel else { return }
                
//                 // Search && show subtitles
//                 label.text = Subtitles.searchSubtitles(strongSelf.parsedPayload, time.seconds)
                
//                 // Adjust size
//                 let baseSize = CGSize(width: label.bounds.width, height: CGFloat.greatestFiniteMagnitude)
//                 let rect = label.sizeThatFits(baseSize)
//                 if label.text != nil {
//                     strongSelf.subtitleLabelHeightConstraint?.constant = rect.height + 5.0
//                 } else {
//                     strongSelf.subtitleLabelHeightConstraint?.constant = rect.height
//                 }
                
//         })
        
//     }

    
//     fileprivate func addSubtitleLabel() {
        
//         guard let _ = subtitleLabel else {
            
//             // Label
//             subtitleLabel = UILabel()
//             subtitleLabel?.translatesAutoresizingMaskIntoConstraints = false
//             subtitleLabel?.backgroundColor = UIColor.clear
//             subtitleLabel?.textAlignment = .center
//             subtitleLabel?.numberOfLines = 0
//             // subtitleLabel?.font = UIFont.boldSystemFont(ofSize: UI_USER_INTERFACE_IDIOM() == .pad ? 40.0 : 22.0)
//             subtitleLabel?.font = UIFont.boldSystemFont(ofSize: UI_USER_INTERFACE_IDIOM() == .pad ? 40.0 : 15.0)
//             subtitleLabel?.textColor = UIColor.white
//             subtitleLabel?.numberOfLines = 0;
//             subtitleLabel?.layer.shadowColor = UIColor.black.cgColor
//             subtitleLabel?.layer.shadowOffset = CGSize(width: 1.0, height: 1.0);
//             subtitleLabel?.layer.shadowOpacity = 0.9;
//             subtitleLabel?.layer.shadowRadius = 1.0;
//             subtitleLabel?.layer.shouldRasterize = true;
//             subtitleLabel?.layer.rasterizationScale = UIScreen.main.scale
//             subtitleLabel?.lineBreakMode = .byWordWrapping
//             contentOverlayView?.addSubview(subtitleLabel!)
            
//             // Position
//             var constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(20)-[l]-(20)-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["l" : subtitleLabel!])
//             contentOverlayView?.addConstraints(constraints)
//             constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[l]-(30)-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["l" : subtitleLabel!])
//             contentOverlayView?.addConstraints(constraints)
//             subtitleLabelHeightConstraint = NSLayoutConstraint(item: subtitleLabel!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 30.0)
//             contentOverlayView?.addConstraint(subtitleLabelHeightConstraint!)
            
//             return
            
//         }
        
//     }
    
// }

class VideoPlayerFactory: NSObject, FlutterPlatformViewFactory {
    
    var videoPlayer:VideoPlayer?
    
    var registrar:FlutterPluginRegistrar?
    
    private var messenger:FlutterBinaryMessenger
    
    /* register video player */
    static func register(with registrar: FlutterPluginRegistrar) {
        
        let plugin = VideoPlayerFactory(messenger: registrar.messenger())
        
        plugin.registrar = registrar
            
        registrar.register(plugin, withId: "tv.mta/NativeVideoPlayer")
    }
    
    init(messenger:FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
    
    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        
        self.videoPlayer = VideoPlayer(frame: frame, viewId: viewId, messenger: messenger, args: args)
        
        self.registrar?.addApplicationDelegate(self.videoPlayer!)
        
        return self.videoPlayer!
    }
    
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterJSONMessageCodec()
    }
    
    public func applicationDidEnterBackground() {}
    
    public func applicationWillEnterForeground() {}
}

class VideoPlayer: NSObject, FlutterPlugin, FlutterStreamHandler, FlutterPlatformView {
    
    static func register(with registrar: FlutterPluginRegistrar) { }
    
    /* view specific properties */
    var frame:CGRect
    var viewId:Int64
    
    /* player properties */
    var player: FluterAVPlayer?
    var playerViewController:AVPlayerViewController?
    
    /* player metadata */
    var url:String = ""
    var srtUrl:String = ""
    var autoPlay:Bool = true
    var loop:Bool = false
    var title:String = ""
    var subtitle:String = ""
    var isLiveStream:Bool = false
    var showControls:Bool = false
    var position:Double = 0.0

    private var mediaDuration = 0.0

    private var isPlaying = false
    private var timeObserverToken:Any?

    let requiredAssetKeys = [
        "playable",
    ]

    /* Flutter event streamer properties */
    private var eventChannel:FlutterEventChannel?
    private var flutterEventSink:FlutterEventSink?

    private var nowPlayingInfo = [String : Any]()

    deinit {
        print("[dealloc] tv.mta/NativeVideoPlayer")
    }

    init(frame:CGRect, viewId: Int64, messenger: FlutterBinaryMessenger, args: Any?) {

        /* set view properties */
        self.frame = frame
        self.viewId = viewId

        super.init()

        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback)
        } catch _ { }

        setupEventChannel(viewId: viewId, messenger: messenger, instance: self)

        setupMethodChannel(viewId: viewId, messenger: messenger)

        /* data as JSON */
        let parsedData = args as! [String: Any]

        /* set incoming player properties */
        self.url = parsedData["url"] as! String
        self.srtUrl = parsedData["srtUrl"] as! String
        self.autoPlay = parsedData["autoPlay"] as! Bool
        self.loop = parsedData["loop"] as! Bool
        self.title = parsedData["title"] as! String
        self.subtitle = parsedData["subtitle"] as! String
        self.isLiveStream = parsedData["isLiveStream"] as! Bool
        self.showControls = parsedData["showControls"] as! Bool
        self.position = parsedData["position"] as! Double

        setupPlayer()
    }

    /* set Flutter event channel */
    private func setupEventChannel(viewId: Int64, messenger:FlutterBinaryMessenger, instance:VideoPlayer) {

        /* register for Flutter event channel */
        instance.eventChannel = FlutterEventChannel(name: "tv.mta/NativeVideoPlayerEventChannel_" + String(viewId), binaryMessenger: messenger, codec: FlutterJSONMethodCodec.sharedInstance())

        instance.eventChannel!.setStreamHandler(instance)
    }

    /* set Flutter method channel */
    private func setupMethodChannel(viewId: Int64, messenger:FlutterBinaryMessenger) {

        let nativeMethodsChannel = FlutterMethodChannel(name: "tv.mta/NativeVideoPlayerMethodChannel_" + String(viewId), binaryMessenger: messenger);

        nativeMethodsChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in

            if ("onMediaChanged" == call.method) {

                /* data as JSON */
                let parsedData = call.arguments as! [String: Any]

                /* set incoming player properties */
                self.url = parsedData["url"] as! String
                self.srtUrl = parsedData["srtUrl"] as! String
                self.autoPlay = parsedData["autoPlay"] as! Bool
                self.loop = parsedData["loop"] as! Bool
                self.title = parsedData["title"] as! String
                self.subtitle = parsedData["subtitle"] as! String
                self.isLiveStream = parsedData["isLiveStream"] as! Bool
                self.showControls = parsedData["showControls"] as! Bool
                self.position = parsedData["position"] as! Double

                self.onMediaChanged()

                result(true)
            }

            if ("seekTo" == call.method) {
                /* data as JSON */
                let parsedData = call.arguments as! [String: Any]

                self.position = parsedData["position"] as! Double

                self.player?.seek(to: CMTime(seconds: self.position, preferredTimescale: CMTimeScale(NSEC_PER_SEC)))

                result(true)
            }

            if ("onShowControlsFlagChanged" == call.method) {

                /* data as JSON */
                let parsedData = call.arguments as! [String: Any]

                /* set incoming player controls flag */
                self.showControls = parsedData["showControls"] as! Bool

                self.onShowControlsFlagChanged()

                result(true)
            }

            else if ("resume" == call.method) {
                self.play()
            }

            else if ("pause" == call.method) {
                self.pause()
            }

            /* dispose */
            else if ("dispose" == call.method) {

                self.dispose()

                result(true)
            }

            /* not implemented yet */
            else { result(FlutterMethodNotImplemented) }
        })
    }

    func setupPlayer(){
       
        if let videoURL = URL(string: self.url.trimmingCharacters(in: .whitespacesAndNewlines)) {

            do {
                let audioSession = AVAudioSession.sharedInstance()
                try audioSession.setCategory(AVAudioSession.Category.playback, options: AVAudioSession.CategoryOptions.allowBluetooth)
                try audioSession.setActive(true)
            } catch _ { }

            /* Create the asset to play */
            let asset = AVAsset(url: videoURL)

            if (asset.isPlayable) {
                /* Create a new AVPlayerItem with the asset and
                 an array of asset keys to be automatically loaded */
                let playerItem = AVPlayerItem(asset: asset, automaticallyLoadedAssetKeys: requiredAssetKeys)

                /* setup player */
                self.player = FluterAVPlayer(playerItem: playerItem)
            }
            else {
                /* not a valid playback asset */
                /* setup empty player */
                self.player = FluterAVPlayer()
            }

            let center = NotificationCenter.default

            center.addObserver(self, selector: #selector(onComplete(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
            center.addObserver(self, selector:#selector(onAVPlayerNewErrorLogEntry(_:)), name: .AVPlayerItemNewErrorLogEntry, object: player?.currentItem)
            center.addObserver(self, selector:#selector(onAVPlayerFailedToPlayToEndTime(_:)), name: .AVPlayerItemFailedToPlayToEndTime, object: player?.currentItem)

            if #available(iOS 12.0, *) {
                self.player?.preventsDisplaySleepDuringVideoPlayback = true
            }

            /* Add observer for AVPlayer status and AVPlayerItem status */
            self.player?.addObserver(self, forKeyPath: #keyPath(AVPlayer.status), options: [.new, .initial], context: nil)
            self.player?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options:[.old, .new, .initial], context: nil)
            self.player?.addObserver(self, forKeyPath: #keyPath(AVPlayer.timeControlStatus), options:[.old, .new, .initial], context: nil)

            /* setup callback for onTime */
            let interval = CMTime(seconds: 1.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
            timeObserverToken = player?.addPeriodicTimeObserver(forInterval: interval, queue: .main) {
                time in self.onTimeInterval(time: time)
            }
            
            /* setup player view controller */
            self.playerViewController = AVPlayerViewController()
            if #available(iOS 10.0, *) {
                self.playerViewController?.updatesNowPlayingInfoCenter = false
            }

            self.playerViewController?.player = self.player
            self.playerViewController?.view.frame = self.frame
            self.playerViewController?.showsPlaybackControls = self.showControls

            if self.srtUrl != "" {
                let srtUrl = URL(string: self.srtUrl)
                self.playerViewController?.addSubtitles().open(fileFromRemote: srtUrl!)
                self.playerViewController?.subtitleLabel?.font = UIFont.boldSystemFont(ofSize: UI_USER_INTERFACE_IDIOM() == .pad ? 40.0 : 13.0)
            }

            /* setup lock screen controls */
            setupRemoteTransportControls()

            setupNowPlayingInfoPanel()

            /* start playback if svet to auto play */
            if (self.autoPlay) {
                play()
            }

            /* setup loop */
            if (self.loop) {
                NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { [self] notification in
                    self.player?.seek(to: CMTime.zero)
                    player?.play()
                }
            }
            
            /* add player view controller to root view controller */
            let viewController = (UIApplication.shared.delegate?.window??.rootViewController)!
            viewController.addChild(self.playerViewController!)
            
        }
    }
    
    /* create player view */
    func view() -> UIView {
        /* return player view controller's view */
        return self.playerViewController!.view
    }
    
    private func onMediaChanged() {
        if let p = self.player {
            
            if let videoURL = URL(string: self.url) {
                
                /* create the new asset to play */
                let asset = AVAsset(url: videoURL)
                
                let playerItem = AVPlayerItem(asset: asset, automaticallyLoadedAssetKeys: requiredAssetKeys)
                
                p.replaceCurrentItem(with: playerItem)
                
                /* setup lock screen controls */
                setupRemoteTransportControls()
                setupNowPlayingInfoPanel()
            }
        }
    }
    
    private func onShowControlsFlagChanged() {
        self.playerViewController?.showsPlaybackControls = self.showControls
    }
    
    @objc func onComplete(_ notification: Notification) {
        
        pause()
        
        isPlaying = false
        
        self.flutterEventSink?(["name":"onComplete"])
        
        self.player?.seek(to: CMTime(seconds: 0, preferredTimescale: CMTimeScale(NSEC_PER_SEC)))
        
        updateInfoPanelOnComplete()
    }
    
    /* observe AVPlayer.status, AVPlayerItem.status & AVPlayer.timeControlStatus */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == #keyPath(AVPlayer.status) {
            /* player status notification */
        } else if keyPath == #keyPath(AVPlayerItem.status) {
            
            let newStatus: AVPlayerItem.Status
            
            if let newStatusAsNumber = change?[NSKeyValueChangeKey.newKey] as? NSNumber {
                newStatus = AVPlayerItem.Status(rawValue: newStatusAsNumber.intValue)!
            } else {
                newStatus = .unknown
            }
            
            if newStatus == .failed {
                
                isPlaying = false
                
                self.flutterEventSink?(["name":"onError", "error":(String(describing: self.player?.currentItem?.error))])
            
            }
        }
        
        else if keyPath == #keyPath(AVPlayer.timeControlStatus) {
            
            guard let p = object as! AVPlayer? else {
                return
            }
            
            if #available(iOS 10.0, *) {
                
                switch (p.timeControlStatus) {
                
                case AVPlayerTimeControlStatus.paused:
                    isPlaying = false
                    self.flutterEventSink?(["name":"onPause"])
                    break
                
                case AVPlayerTimeControlStatus.playing:
                    isPlaying = true
                    self.flutterEventSink?(["name":"onPlay"])
                    break
                
                case .waitingToPlayAtSpecifiedRate: break
                @unknown default:
                    break
                }
            }
            
        } else {
            super.observeValue(forKeyPath: keyPath,
                               of: object,
                               change: change,
                               context: context)
            return
        }
    }
    
    @objc func onAVPlayerNewErrorLogEntry(_ notification: Notification) {
        guard let object = notification.object, let playerItem = object as? AVPlayerItem else {
            return
        }
        guard let error: AVPlayerItemErrorLog = playerItem.errorLog() else {
            return
        }
        guard var errorMessage = error.extendedLogData() else {
            return
        }
        
        errorMessage.removeLast()
        
        isPlaying = false
        
        self.flutterEventSink?(["name":"onError", "error":String(data: errorMessage, encoding: .utf8)])
    }

    @objc func onAVPlayerFailedToPlayToEndTime(_ notification: Notification) {
        guard let error = notification.userInfo!["AVPlayerItemFailedToPlayToEndTimeErrorKey"] else {
            return
        }
        isPlaying = false
        self.flutterEventSink?(["name":"onError", "error":error])
    }
    
    private func setupRemoteTransportControls() {
        
        let commandCenter = MPRemoteCommandCenter.shared()

        // Add handler for Play Command
        commandCenter.playCommand.addTarget { event in
            if self.player?.rate == 0.0 {
                self.play()
                return .success
            }
            return .commandFailed
        }

        // Add handler for Pause Command
        commandCenter.pauseCommand.addTarget { event in
            if self.player?.rate == 1.0 {
                self.pause()
                return .success
            }
            return .commandFailed
        }
    }
    
    private func setupNowPlayingInfoPanel() {
        
        nowPlayingInfo[MPMediaItemPropertyTitle] = self.title
        
        nowPlayingInfo[MPMediaItemPropertyArtist] = self.subtitle
        
        if #available(iOS 10.0, *) {
            nowPlayingInfo[MPNowPlayingInfoPropertyIsLiveStream] = self.isLiveStream
        }

        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player?.currentTime().seconds

        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = player?.currentItem?.asset.duration.seconds

        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 0 // will be set to 1 by onTime callback

        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    private func updateInfoPanelOnPause() {
        
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = CMTimeGetSeconds((self.player?.currentTime())!)
        
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 0
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    private func updateInfoPanelOnPlay() {
        
        self.nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = CMTimeGetSeconds(((self.player?.currentTime())!))
        
        self.nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = self.nowPlayingInfo
    }
    
    private func updateInfoPanelOnComplete() {
        
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = 0

        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 0

        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    private func updateInfoPanelOnTime() {
        
        self.nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = CMTimeGetSeconds((self.player?.currentTime())!)
        
        self.nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = self.nowPlayingInfo
    }
    
    @objc private func play() {
        
        player?.play()
        
        updateInfoPanelOnPlay()
        
        onDurationChange()
    }
    
    private func pause() {
        
        player?.pause()
        
        updateInfoPanelOnPause()
        
        onDurationChange()
    }
    
    private func onTimeInterval(time:CMTime) {
        
        if (isPlaying) {
            
            self.flutterEventSink?(["name":"onTime", "time":time.seconds])
            
            updateInfoPanelOnTime()
        }
        
        onDurationChange()
    }
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        flutterEventSink = events
        self.player?.flutterEventSink = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        flutterEventSink = nil
        self.player?.flutterEventSink = nil
        return nil
    }
    
    private func onDurationChange() {
        
        guard let player = self.player else { return }
        
        guard let item = player.currentItem else { return }
        
        let newDuration = item.asset.duration.seconds * 1000
        
        if (newDuration.isNaN) {
            
            self.mediaDuration = newDuration
            
            self.flutterEventSink?(["name":"onDuration", "duration":-1])
            
        } else if (newDuration != mediaDuration) {
            
            self.mediaDuration = newDuration
            
            self.flutterEventSink?(["name":"onDuration", "duration":self.mediaDuration])
        }
    }
    
    public func dispose() {
        
        self.player?.pause()
        
        /* clear lock screen metadata */
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nil
        
        /* remove observers */
        if let timeObserver = timeObserverToken {
            player?.removeTimeObserver(timeObserver)
            timeObserverToken = nil
        }
        
        /* stop audio session */
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setActive(false)
        } catch _ { }
        
        NotificationCenter.default.removeObserver(self)
        
        self.player?.flutterEventSink = nil
        
        self.flutterEventSink = nil
        self.eventChannel?.setStreamHandler(nil)
        
        self.player = nil
    }
    
    /**
     detach player UI to keep audio playing in background
     */
    func applicationDidEnterBackground(_ application: UIApplication) {
        self.playerViewController?.player = nil
    }
    
    /**
     reattach player UI as app is in foreground now
     */
    func applicationWillEnterForeground(_ application: UIApplication) {
        self.playerViewController?.player = self.player
    }
}
