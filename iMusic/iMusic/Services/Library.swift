//
//  Library.swift
//  iMusic
//
//  Created by Роман on 18.08.2023.
//

import SwiftUI
import URLImage

struct Library: View {
    @State var tracks = UserDefaults.standard.savedTracks()
    @State private var showingAlert = false
    @State private var track: SearchViewModel.Cell!
    
    var tabBarDelegate: MainTabBarControllerDelegate?
    
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geometry in
                    HStack (spacing: 20) {
                        Button(action: {
                            self.track = self.tracks[0]
                            self.tabBarDelegate?.maximizeTrackDetailController(viewModel: self.track)
                        }, label: {
                            Image(systemName: "play.fill")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .accentColor(Color.init(UIColor.systemPink))
                                .background(Color.init(UIColor.systemGray2))
                                .cornerRadius(8)
                        })
                        
                        Button(action: {
                            self.tracks = UserDefaults.standard.savedTracks()
                        }, label: {
                            Image(systemName: "arrow.2.circlepath")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .accentColor(Color.init(UIColor.systemPink))
                                .background(Color.init(UIColor.systemGray2))
                                .cornerRadius(8)
                        })
                    }
                }.padding().frame(height: 50)
                Divider().padding(.leading).padding(.trailing)
                
                List {
                    ForEach(tracks) { track in
                        
                        LibraryCell(cell: track).gesture(
                            LongPressGesture()
                                .onEnded { _ in
                                    print("Pressed!")
                                    self.track = track
                                    self.showingAlert = true
                                }
                                .simultaneously(with: TapGesture()
                                    .onEnded { _ in
                                        
                                        let keyWindow = UIApplication.shared.connectedScenes
                                        .filter {$0.activationState == .foregroundActive}
                                        .map {$0 as? UIWindowScene}
                                        .compactMap {$0}
                                        .first?.windows
                                        .filter{$0.isKeyWindow}.first
                                        
                                        let tabBarVC = keyWindow?.rootViewController as? MainTabBarController
                                        tabBarVC?.trackDetailView.delegate = self
                                        
                                        self.track = track
                                        self.tabBarDelegate?.maximizeTrackDetailController(viewModel: self.track)
                                    }))
                    }.onDelete(perform: delete)
                }
                .navigationBarTitle("Медиатека")
            }.actionSheet(isPresented: $showingAlert, content: {
                ActionSheet(
                    title: Text("Text"),
                    buttons: [.destructive(Text("Delete"), action: {
                        print("Deleting: \(self.track.trackName)")
                        self.delete(track: self.track)
                    }), .cancel()
                             ])
            })
        }
    }
    
    func delete(at offsets: IndexSet) {
        tracks.remove(atOffsets: offsets)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
    
    func delete(track: SearchViewModel.Cell) {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return }
        tracks.remove(at: myIndex)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: UserDefaults.favouriteTrackKey)
        }
    }
    
    struct LibraryCell: View {
        var cell: SearchViewModel.Cell
        var body: some View {
            HStack {
                URLImage(URL(string: cell.iconUrlString ?? "")!) { image in
                    image
                        .resizable()
                        .frame(width: 60, height: 60)
                        .cornerRadius(2)
                }
                VStack(alignment: .leading){
                    Text("\(cell.trackName)")
                    Text("\(cell.artistName)")
                }
            }
        }
    }
    
    
    struct Library_Previews: PreviewProvider {
        static var previews: some View {
            Library()
        }
    }
}

extension Library: TrackMovingDelegate {
    func moveBackForPreviousTrack() -> SearchViewModel.Cell? {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return nil }
        var nextTrack: SearchViewModel.Cell
        
        if myIndex - 1 == -1 {
            nextTrack = tracks[tracks.count - 1]
        } else {
            nextTrack = tracks[myIndex - 1]
        }
        
        self.track = nextTrack
        return nextTrack
    }
    
    func moveForwardForPreviousTrack() -> SearchViewModel.Cell? {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return nil }
        var nextTrack: SearchViewModel.Cell
        
        if myIndex + 1 == tracks.count {
            nextTrack = tracks[0]
        } else {
            nextTrack = tracks[myIndex + 1]
        }
        
        self.track = nextTrack
        return nextTrack
    }
}
