//
//  CurrentSongViewModel.swift
//  songify
//
//  Created by yury mid on 31.10.2022.
//

import SwiftUI
import Foundation
import AVFAudio

class CurrentSongViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    @Published var playlistSheet: Bool = false
    @Published var backgroundImage = 1
    var currentSongIndex: Int = 0
    @Published var currentSong: Song = playList[0]
    
    private var sound = playList[0].fileName
    private var audioPlayer: AVAudioPlayer?
    
    @Published public var isPlaying = false
    @Published var repeatSound: Bool = false
    @Published public var progress: CGFloat = 0.0
    @Published public var duration: Double = 0.0
    @Published public var formattedDuration: String = ""
    @Published public var formattedProgress: String = "00:00"
    
    public var volume: Double {
        didSet {
            audioPlayer?.volume = Float(volume)
        }
    }
    
    private func initSound(bundle: Bundle = .main, volume: Double = 1.0, repeatSound: Bool = false){
        guard let url = bundle.url(forResource: sound, withExtension: nil) else {
            print("Failed to find \(sound) in bundle.")
            return
        }
        
        guard let player = try? AVAudioPlayer(contentsOf: url) else {
            print("Failed to load \(sound) from bundle.")
            return
        }
        self.audioPlayer = player
        self.audioPlayer?.prepareToPlay()
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = [ .pad ]
        
        formattedDuration = formatter.string(from: TimeInterval(self.audioPlayer?.duration ?? 0.0))!
        duration = self.audioPlayer?.duration ?? 0.0
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if let player = self.audioPlayer {
                if !player.isPlaying {
                    self.isPlaying = false
                }
                self.progress = CGFloat(player.currentTime / player.duration)
                self.formattedProgress = formatter.string(from: TimeInterval(player.currentTime))!
            }
        }
        audioPlayer?.delegate = self
    }
    
    public init(bundle: Bundle = .main, volume: Double = 1.0, repeatSound: Bool = false) {
        self.currentSong = playList[self.currentSongIndex]
        
        self.volume = volume
        self.repeatSound = repeatSound
        
        super.init()
        
        initSound(bundle: bundle, volume: volume, repeatSound: repeatSound)
        
    }
    
    deinit {
        audioPlayer?.stop()
    }
    
    public func play() {
        isPlaying = true
        audioPlayer?.play()
    }
    
    public func stop() {
        isPlaying = false
        audioPlayer?.stop()
    }
    
    public func forward() {
        if let player = self.audioPlayer {
            let increase = player.currentTime + 15
            if increase < self.duration {
                player.currentTime = increase
            } else {
                player.currentTime = duration
            }
        }
    }
    
    public func next() {
        if let player = self.audioPlayer {
            currentSongIndex+=1
            switchSong()
            player.currentTime = duration
        }
    }
    
    public func rewind() {
        if let player = self.audioPlayer {
            let decrease = player.currentTime - 15.0
            if decrease < 0.0 {
                player.currentTime = 0
            } else {
                player.currentTime -= 15
            }
        }
    }
    
    public func prev() {
        if let player = self.audioPlayer {
            let decrease = player.currentTime
            if decrease > 0.9 {
                player.currentTime = 0
            } else {
                if currentSongIndex <= 0 {
                    currentSongIndex = playList.count-1
                }else{
                    currentSongIndex-=1
                }
                
                switchSong()
            }
        }
    }
    
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if repeatSound  {
            play()
        } else {
            next()
        }
    }
    
    public func refreshBGImage(image: Int = 0){
        withAnimation(.easeInOut){
            if image != 0{
                backgroundImage = image
            }else{
                backgroundImage = Int.random(in: 1..<15)
            }
        }
    }
    
    private func switchSong(){
        if currentSongIndex >= playList.count {
            currentSongIndex = 0
        }
        currentSong = playList[currentSongIndex]
        sound = currentSong.fileName
        initSound()
        refreshBGImage(image: currentSong.image)
        self.play()
    }
    
    public func setSong(song: Song){
        playlistSheet = false
        currentSong = song
        sound = currentSong.fileName
        initSound()
        refreshBGImage(image: currentSong.image)
        self.play()
    }
    
}
