//
//  ContentView.swift
//  Shared
//
//  Created by Doug Diego on 2/17/21.
//

import SwiftUI
import FloatingActionButton

struct ContentView: View {
    var body: some View {
        VStack {
        Text("Hello, world!")
            .padding()
        }
        .fab(image: Image(systemName: "plus"), activeImage: Image(systemName: "plus"),  color: Color.blue.opacity(0.75), items: [
            FloatingItem(title: "Favorite", image: Image(systemName: "heart.fill"), action: oneAction),
            FloatingItem(title: "Thumbs Up", image: Image(systemName: "hand.thumbsup.fill"), action: twoAction),
            FloatingItem(title: "Thumbs Down", image: Image(systemName: "hand.thumbsdown.fill"), action: threeAction)
        ])
    }

    
    func oneAction() {
        print("one action")
    }
    
    func twoAction() {
        print("two action")
    }
    
    func threeAction() {
        print("three action")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
