//
//  ContentView.swift
//  Dodoku
//
//  Created by localadmin on 27.03.20.
//  Copyright © 2020 Mark Lucking. All rights reserved.
//

import SwiftUI
import CoreServices

var imageURLs:[Int:String] = [1:"img3url",2:"img4url"]

struct ContentView: View {


  
//    let img2url = Bundle.main.url(forResource: "rdot", withExtension: "png")
    let img3url = URL(fileURLWithPath:(Bundle.main.resourcePath! + "/Images/bdot.png"))
    let img4url = URL(fileURLWithPath:(Bundle.main.resourcePath! + "/Images/rdot.png"))


  @State var img1url: URL?
  @State var img2url: URL?
  @State var show = false
    
    var body: some View {
        HStack {
            Text("fuck").onAppear {
              
              let fucker = Bundle.main.resourcePath! + "/Images/dot.png"
              self.img2url = URL(fileURLWithPath: fucker)
              if let resourcePath = Bundle.main.resourcePath {
                let imgName = "/ydot.png"
                let path = resourcePath + imgName
                print("path ",path)
                self.img1url = URL(fileURLWithPath: path)
                self.show = true
                print("img2url ",self.img2url,fucker)
                
              }
            }
            VStack {
              Text("fuck")
              if show {
                DragableImage(url: "rdot")
                DragableImage(url: "gdot")
              }
            }
            
            VStack {
              Text("fuck")
                DragableImage(url: "bdot")
                DragableImage(url: "ydot")
            }
            
            DroppableArea()
        }.padding(40)
    }
    
    struct DragableImage: View {
        let url: String
        var body: some View {
              Image(url)
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .padding(2)
                .overlay(Circle().strokeBorder(Color.black.opacity(0.1)))
                .shadow(radius: 3)
                .padding(4)
                .onDrag {
                  print("self.url ",self.url)
                  
                  return NSItemProvider(object: self.url as NSItemProviderWriting) }
                .onAppear {
                  print("Dragable ",self.url)
                }
                
        }
    }
    
    struct DroppableArea: View {
        @State private var imageUrls: [Int: String] = [:]
        @State private var active = 0
        
        var body: some View {
            let dropDelegate = MyDropDelegate(imageUrls: $imageUrls, active: $active)
            print("URL 0",self.imageUrls[self.active])
            return VStack {
                HStack {
                    GridCell(active: self.active == 1, url: imageUrls[1])
                    GridCell(active: self.active == 3, url: imageUrls[3])
                }
                HStack {
                    GridCell(active: self.active == 2, url: imageUrls[2])
                    GridCell(active: self.active == 4, url: imageUrls[4])
                }
                
            }
            .background(Rectangle().fill(Color.gray))
            .frame(width: 300, height: 300)
            .onDrop(of: [kUTTypeData as String], delegate: dropDelegate)
            
        }
    }
    
  
    
    struct GridCell: View {
        let active: Bool
        let url: String?
        
        var body: some View {
                if url == nil {
                  let img = Image(systemName: "photo")
                  .resizable()
                  .frame(width: 150, height: 150)
                  return Rectangle()
                  .fill(self.active ? Color.green : Color.clear)
                  .frame(width: 150, height: 150)
                  .overlay(img)
                } else {
                  let img = Image(url!)
                  .resizable()
                  .frame(width: 150, height: 150)
                  return Rectangle()
                .fill(self.active ? Color.green : Color.clear)
                .frame(width: 150, height: 150)
                .overlay(img)
                }
        }
    }
    
    struct MyDropDelegate: DropDelegate {
        @Binding var imageUrls: [Int: String]
        @Binding var active: Int
        
        func validateDrop(info: DropInfo) -> Bool {
//            return info.hasItemsConforming(to: ["public.file-url"])
//            print("validate Drop")
            return true
        }
        
        func dropEntered(info: DropInfo) {
//            print("drop entered",info.itemProviders(for: [kUTTypeData as String]))
        }
        
        func performDrop(info: DropInfo) -> Bool {
//            print("do drop")
            
            let gridPosition = getGridPosition(location: info.location)
            self.active = gridPosition
            
            if let item = info.itemProviders(for: [kUTTypeData as String]).first {
                item.loadItem(forTypeIdentifier: kUTTypeData as String, options: nil) { (urlData, error) in
//                    print("grid ",gridPosition,self.imageUrls[gridPosition]! )
                    DispatchQueue.main.async {
                        if let urlData = urlData as? Data {
                          
                          let str = String(decoding: urlData, as: UTF8.self)
                          print("urlData ",urlData,str)
//                            self.imageUrls[gridPosition] = NSURL(absoluteURLWithDataRepresentation: urlData, relativeTo: nil) as URL
                         self.imageUrls[gridPosition] = str
                        }
                    }
                }
                
                return true
                
            } else {
                return false
            }

        }
        
        func dropUpdated(info: DropInfo) -> DropProposal? {
            self.active = getGridPosition(location: info.location)
            return nil
        }
        
        func dropExited(info: DropInfo) {
            print("dropExited")
            self.active = 0
        }
        
        func getGridPosition(location: CGPoint) -> Int {
            
            let midXPoint:CGFloat = 640
            let midYPoint:CGFloat = 320
            if location.x > midXPoint && location.y > midYPoint {
                return 4
            } else if location.x > midXPoint && location.y < midYPoint {
                return 3
            } else if location.x < midXPoint && location.y > midYPoint {
                return 2
            } else if location.x < midXPoint && location.y < midYPoint {
                return 1
            } else {
                return 0
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
