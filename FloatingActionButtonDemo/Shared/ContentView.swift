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
        .fab(title: "Choose", image: Image(systemName: "plus"), items: [
            FloatingItem(title: "One", image: Image(systemName: "1.circle"), action: oneAction),
            FloatingItem(title: "Two", image: Image(systemName: "2.circle"), action: twoAction)
        ])
    }

    
    func oneAction() {
        print("one action")
    }
    
    func twoAction() {
        print("two action")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}