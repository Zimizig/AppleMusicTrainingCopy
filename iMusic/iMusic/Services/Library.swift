//
//  Library.swift
//  iMusic
//
//  Created by Роман on 18.08.2023.
//

import SwiftUI

struct Library: View {
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geometry in
                    HStack (spacing: 20) {
                        Button(action: {
                        }, label: {
                            Image(systemName: "play.fill")
                                .frame(width: geometry.size.width / 2 - 10, height: 50)
                                .accentColor(Color.init(UIColor.systemPink))
                                .background(Color.init(UIColor.systemGray2))
                                .cornerRadius(8)
                        })
                        
                        Button(action: {
                            print("123")
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
                    LibraryCell()
                    Text("Keke meme lele")
                    Text("Keke meme lele")
                    Text("Keke meme lele")
                    Text("Keke meme lele")
                    Text("Keke meme lele")
                }
            }
            .navigationBarTitle("Медиатека")
        }
    }
}

struct LibraryCell: View {
    var body: some View {
        HStack {
            Image("pop3").resizable().frame(width: 55,height: 55).cornerRadius(7)
            VStack {
                Text("Track name")
                Text("Artist name")
            }
        }
    }
}


struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}
