//
//  PlayerView.swift
//  songify
//
//  Created by yury mid on 30.10.2022.
//

import SwiftUI
import AVFAudio

struct PlayerView: View {

    @StateObject var song: CurrentSongViewModel = CurrentSongViewModel()
    
//    @State private var playlistSheet: Bool = false
    
    @State var isRepeatColor = Color.readable
    
    var body: some View {
        VStack{
            Image("bgimage\(song.backgroundImage)")
                .resizable()
                .scaledToFill()
                .onTapGesture {
                    song.refreshBGImage(image: song.currentSong.image)
                }
        }
        .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        .sheet(isPresented: $song.playlistSheet) {
            PlayListView(song: song)
        }
        .overlay(alignment: .bottom, content: {
            playerToolsBlock()
                .padding(.bottom)
        })
        .overlay(alignment: .topLeading, content: {
            Button {
                if (isRepeatColor == Color.readable){
                    isRepeatColor = Color.accentColor
                    song.repeatSound = true
                }else{
                    isRepeatColor = Color.readable
                    song.repeatSound = false
                }
            } label: {
                ZStack{
                    Image(systemName: "arrow.2.circlepath")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(isRepeatColor)
                        .padding()
                }
                .background(.ultraThinMaterial.opacity(0.8))
                .cornerRadius(15)
                .padding()
                .offset(y: 40)
            }
        })
        .overlay(alignment: .topTrailing, content: {
            Button {
                song.playlistSheet = true
            } label: {
                ZStack{
                    Image(systemName: "text.line.first.and.arrowtriangle.forward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.accentColor)
                        .padding()
                }
                .background(.ultraThinMaterial.opacity(0.8))
                .cornerRadius(15)
                .padding()
                .offset(y: 40)
            }
        })
        .ignoresSafeArea()
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}

extension PlayerView {
    
    private func playerToolsBlock() -> some View {
        VStack{
            songHeaderBlock(nameString: song.currentSong.name, authorString: song.currentSong.author)
                .padding(.bottom)
            songControlToolsBlock
            Spacer()
        }
        .padding(25)
        .frame(height: 200)
        .frame(width: UIScreen.main.bounds.size.width - 20)
        .background(.ultraThinMaterial.opacity(0.8))
        .cornerRadius(35)
        .padding()
    }
    
    private func songHeaderBlock(nameString: String, authorString: String) -> some View {
        VStack{
            HStack{
                Text(nameString)
                    .font(.title2)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .foregroundColor(.white)
                Spacer()
            }
            HStack{
                Text(authorString)
                    .font(.subheadline)
                    .lineLimit(1)
                    .foregroundColor(.white)
                Spacer()
            }
        }
    }
    
    private var songControlToolsBlock: some View {
        VStack{
            GeometryReader { gr in
                Capsule()
                    .stroke(Color.accentColor, lineWidth: 1)
                    .background(
                        Capsule()
                            .foregroundColor(Color.accentColor)
                            .frame(width: gr.size.width * song.progress, height: 5), alignment: .leading)
            }
            .frame( height: 5)
            HStack{
                Text(song.formattedProgress)
                    .font(.caption.monospacedDigit())
                Spacer()
                Text(song.formattedDuration)
                    .font(.caption.monospacedDigit())
            }.foregroundColor(.white)
                .accessibilityElement(children: .ignore)
                .accessibility(identifier: "audio player")
                .accessibilityLabel(song.isPlaying ? Text("Playing at ") : Text("Duration"))
                .accessibilityValue(Text("\(song.formattedProgress)"))
            
            HStack(alignment: .center, spacing: 20) {
                Spacer()
                Button(action: {
                    song.rewind()
                }) {
                    Image(systemName: "gobackward.15")
                        .font(.title3)
                        .imageScale(.medium)
                        .foregroundColor(.white)
                }
                Button(action: {
                    song.prev()
                }) {
                    HStack{
                        Image(systemName: "arrowtriangle.left.fill")
                            .font(.title)
                            .imageScale(.medium)
                            .offset(x:10)
                        Image(systemName: "arrowtriangle.left.fill")
                            .font(.title)
                            .imageScale(.medium)
                            .offset(x:-5)
                    }
                }
                Button(action: {
                    if song.isPlaying {
                        song.stop()
                        song.isPlaying = false
                    } else if !song.isPlaying {
                        song.play()
                    }
                }) {
                    Image(systemName: song.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.largeTitle)
                        .imageScale(.large)
                        .scaleEffect(1.2)
                }

                Button(action: {
                    song.next()
                }) {
                    HStack{
                        Image(systemName: "arrowtriangle.right.fill")
                            .font(.title)
                            .imageScale(.medium)
                            .offset(x:10)
                        Image(systemName: "arrowtriangle.right.fill")
                            .font(.title)
                            .imageScale(.medium)
                            .offset(x:-5)
                    }
                    
                }
                Button(action: {
                    song.forward()
                }) {
                    Image(systemName: "goforward.15")
                        .font(.title3)
                        .imageScale(.medium)
                        .foregroundColor(.white)
                }
                Spacer()
            }
        }
    }
}
