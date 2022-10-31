//
//  PlayListView.swift
//  songify
//
//  Created by yury mid on 30.10.2022.
//

import SwiftUI

struct PlayListView: View {
    @StateObject var song: CurrentSongViewModel
    
    var body: some View {
        VStack{
            headerBlock
                .padding()
            playListBlock
            Spacer()
        }
        .background(Color.bg)
    }
}

struct PlayListView_Previews: PreviewProvider {
    static var previews: some View {
        PlayListView(song: CurrentSongViewModel())
    }
}

extension PlayListView {
    private var headerBlock: some View {
        HStack{
            Text("Playlist")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
        }
    }
    
    private func listItem(name:String, author:String, image: Int) -> some View {
        HStack{
            ZStack{
                if image == 0 {
                    Image(systemName: "music.note.list")
                        .resizable()
                        .scaledToFill()
                        .padding(13)
                        .frame(width: 50, height: 50)
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                }else{
                    Image("bgimage\(image)")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                }
            }
            .padding(6)
            VStack(alignment: .leading){
                Text(name)
                    .font(.headline)
                Text(author)
                    .font(.subheadline)
                    .foregroundColor(Color.readable)
            }
            
            Spacer()
        }
        .background(.ultraThinMaterial)
        .cornerRadius(13)
        .padding(.horizontal)
    }
    
    
    private var playListBlock: some View {
        ScrollView{
            ForEach(playList, id: \.self) { item in
                Button {
                    song.setSong(song: item)
                } label: {
                    listItem(name: item.name, author: item.author, image: item.image)
                }
            }
        }
    }
}
