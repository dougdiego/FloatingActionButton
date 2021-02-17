//
//  FloatingActionButton.swift
//  FloatingActionButton
//
//  Created by Doug Diego on 2/15/21.
//
import SwiftUI

public struct FloatingItem {
    let title: String
    let image: Image
    let action: () -> Void
    
    public init(title: String, image: Image, action: @escaping () -> Void) {
        self.title = title
        self.image = image
        self.action = action
    }
}

public struct FloatingActionButton<Parent: View>: View {
    @State private var showingPrefillSheet = false
    var parent: Parent
    let title: String
    let image: Image
    let items: [FloatingItem]
    
    init(parent: Parent, title: String, image: Image, items: [FloatingItem]) {
        self.parent = parent
        self.title = title
        self.image = image
        self.items = items
    }
    
    public var body: some View {
        ZStack {
            parent
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        self.showingPrefillSheet = true
                    }) {
                        image
                    }
                    .actionSheet(isPresented: self.$showingPrefillSheet) {
                        ActionSheet(title: Text(title),
                                    message: nil,
                                    buttons: getButtons()
                        )
                    }
                    .padding(12)
                    .background(Color.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
                
            }.padding(.bottom, 60)
        }
    }
    
    func getButtons() -> [ActionSheet.Button]  {
        var buttons = [ActionSheet.Button]()
        for item in items {
            print("item: \(item)")
            buttons.append(ActionSheet.Button.default(Text(item.title), action: item.action))
        }
        buttons.append(ActionSheet.Button.cancel(Text("Cancel")))
        return buttons
    }
}

extension View {
    func fab(title: String, image: Image, items: [FloatingItem]) -> some View {
        FloatingActionButton(parent: self, title: title, image: image, items: items)
    }
}
