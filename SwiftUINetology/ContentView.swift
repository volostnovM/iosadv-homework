//
//  ContentView.swift
//  SwiftUINetology
//
//  Created by TIS Developer on 17.05.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .tag(0)
            
            FeedView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Feed")
                }.tag(1)
            
            MusicView()
                .tabItem {
                    Image(systemName: "music.note")
                    Text("Player")
                }.tag(2)
            
            MoviesView()
                .tabItem {
                    Image(systemName: "video")
                    Text("Video")
                }.tag(3)
            
            RecordView()
                .tabItem {
                    Image(systemName: "mic.fill")
                    Text("Record")
                }.tag(4)
        }
    }
}

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .background(.gray)
    }
}

struct MainModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size: 13, weight: .regular, design: .default))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
