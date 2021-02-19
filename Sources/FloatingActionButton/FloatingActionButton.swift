//
//  FloatingActionButton.swift
//  FloatingActionButton
//
//  Created by Doug Diego on 2/15/21.
//
import SwiftUI

public struct FloatingItem: Identifiable {
    public let id = UUID()
    let title: String
    let image: Image
    let action: () -> Void
    
    public init(title: String, image: Image, action: @escaping () -> Void) {
        self.title = title
        self.image = image
        self.action = action
    }
}

struct FloatingActionButton<Parent: View>: View {
    @State private var showingFloatingItems = false
    var parent: Parent
    let image: Image
    let activeImage: Image?
    let color: Color?
    let items: [FloatingItem]
    
    init(parent: Parent,
         image: Image,
         activeImage: Image,
         color:  Color,
         items: [FloatingItem]
    ) {
        self.parent = parent
        self.image = image
        self.activeImage = activeImage
        self.color = color
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
                        withAnimation {
                            self.showingFloatingItems.toggle()
                        }
                    }) {
                        if self.showingFloatingItems {
                            activeImage
                        } else {
                            image
                        }
                    }
                    .padding(12)
                    .background(color)
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
                
                
            }
            .padding(.bottom, 60)
            
            if showingFloatingItems {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        VStack {
                            ForEach(items, id: \.id) { item in
                                Label {
                                    Text(item.title).font(.title2)
                                } icon: {
                                    item.image.font(.title2)
                                }
                                .padding(.leading)
                                .padding(.vertical, 8)
                                //.background(Color.red)
                                .onTapGesture {
                                    item.action()
                                    withAnimation {
                                        self.showingFloatingItems.toggle()
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.trailing)
                .padding(.bottom, 140)
                .transition(.move(edge: .trailing))
            }
        }
    }
}

public struct FloatingActionSheetItem: Identifiable {
    public let id = UUID()
    let title: String
    let action: () -> Void
    
    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}

struct FloatingActionSheetButton<Parent: View>: View {
    @State private var showingFloatingItems = false
    var parent: Parent
    let title: String
    let cancelTitle: String
    let image: Image
    let items: [FloatingActionSheetItem]
    
    init(parent: Parent,
         title: String,
         cancelTitle: String,
         image: Image,
         items: [FloatingActionSheetItem]) {
        self.parent = parent
        self.title = title
        self.cancelTitle = cancelTitle
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
                        self.showingFloatingItems = true
                    }) {
                        image
                    }
                    .actionSheet(isPresented: self.$showingFloatingItems) {
                        ActionSheet(title: Text(title),
                                    message: nil,
                                    buttons: getActionSheetButtons()
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
    
    func getActionSheetButtons() -> [ActionSheet.Button]  {
        var buttons = [ActionSheet.Button]()
        for item in items {
            buttons.append(ActionSheet.Button.default(Text(item.title), action: item.action))
        }
        buttons.append(ActionSheet.Button.cancel(Text(cancelTitle)))
        return buttons
    }
    
}

extension View {
    public func fab(image: Image, items: [FloatingItem]) -> some View {
        FloatingActionButton(parent: self, image: image, activeImage: image, color:  Color.black.opacity(0.75), items: items)
    }
    
    public func fab(image: Image, activeImage: Image, color: Color, items: [FloatingItem]) -> some View {
        FloatingActionButton(parent: self, image: image, activeImage: activeImage, color: color, items: items)
    }
    
    public func fasb(title: String, cancelTitle: String, image: Image, items: [FloatingActionSheetItem]) -> some View {
        FloatingActionSheetButton(parent: self, title: title, cancelTitle: cancelTitle, image: image, items: items)
    }
}
