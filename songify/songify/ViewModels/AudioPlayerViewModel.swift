//
//  AudioPlayerViewModel.swift
//  songify
//
//  Created by yury mid on 30.10.2022.
//

import Foundation
import AVFAudio

//public class AudioPlayerViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
 /// A Boolean representing whether this sound is currently playing.
//    @Published public var isPlaying = false

//    @Published var repeatSound: Bool = false
/// These are used in our view
//    @Published public var progress: CGFloat = 0.0
//    @Published public var duration: Double = 0.0
//    @Published public var formattedDuration: String = ""
//    @Published public var formattedProgress: String = "00:00"

  /// The internal audio player being managed by this object.
//    @Published public var audioPlayer: AVAudioPlayer?

    /// How loud to play this sound relative to other sounds in your app,
    /// specified in the range 0 (no volume) to 1 (maximum volume).
//    public var volume: Double {
//        didSet {
//            audioPlayer?.volume = Float(volume)
//        }
//    }

    /// If the sound is played on a loop. Specifying false here
    /// (the default) will play the sound only once.
//    public var repeatSound: Bool

    /// Creates a new instance by looking for a particular sound filename in a bundle of your choosing.of `.reset`.
       /// - Parameters:
       ///   - sound: The name of the sound file you want to load.
       ///   - bundle: The bundle containing the sound file. Defaults to the main bundle.
       ///   - volume: How loud to play this sound relative to other sounds in your app,
       ///     specified in the range 0 (no volume) to 1 (maximum volume).
       ///   - repeatSound: if false  (the default) will play the sound only once.
//       public init(sound: String, bundle: Bundle = .main, volume: Double = 1.0, repeatSound: Bool = false) {
//           self.volume = volume
//           self.repeatSound = repeatSound
//
//           super.init()
//
//           guard let url = bundle.url(forResource: sound, withExtension: nil) else {
//               print("Failed to find \(sound) in bundle.")
//               return
//           }
//
//           guard let player = try? AVAudioPlayer(contentsOf: url) else {
//               print("Failed to load \(sound) from bundle.")
//               return
//           }
//           self.audioPlayer = player
//           self.audioPlayer?.prepareToPlay()
//
//           /// a formatter to get the duration and progress to the view
//           let formatter = DateComponentsFormatter()
//           formatter.allowedUnits = [.minute, .second]
//           formatter.unitsStyle = .positional
//           formatter.zeroFormattingBehavior = [ .pad ]
//
//           //I need both! The formattedDuration is the string to display and duration is used when forwarding
//           formattedDuration = formatter.string(from: TimeInterval(self.audioPlayer?.duration ?? 0.0))!
//           duration = self.audioPlayer?.duration ?? 0.0
//
//           Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
//               if let player = self.audioPlayer {
//                   if !player.isPlaying {
//                       self.isPlaying = false
//                   }
//                   self.progress = CGFloat(player.currentTime / player.duration)
//                   self.formattedProgress = formatter.string(from: TimeInterval(player.currentTime))!
//               }
//           }
//           audioPlayer?.delegate = self
//       }
//
//    deinit {
//         audioPlayer?.stop()
//     }
//    
    


//}
