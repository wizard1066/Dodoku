//
//  ContentView.swift
//  Dodoku
//
//  Created by localadmin on 27.03.20.
//  Copyright © 2020 Mark Lucking. All rights reserved.
//

import SwiftUI
import CoreServices

struct ContentView: View {
    var body: some View {
        HStack {
            VStack {
                DragableImage(name: "rdot")
                DragableImage(name: "gdot")
            }
            VStack {
                DragableImage(name: "bdot")
                DragableImage(name: "ydot")
                DragableImage(name: "pdot")
            }
            DroppableArea()
        }.padding(40)
    }
    
    struct DragableImage: View {
        let name: String
        var body: some View {
              Image(name)
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .padding(2)
                .overlay(Circle().strokeBorder(Color.black.opacity(0.1)))
                .shadow(radius: 3)
                .padding(4)
                .onDrag {
                  return NSItemProvider(object: self.name as NSItemProviderWriting) }
        }
    }
    
    struct DroppableArea: View {
        @State private var imageUrls: [Int: String] = [:]
        @State private var active = 0
        
        var body: some View {
            let dropDelegate = MyDropDelegate(imageUrls: $imageUrls, active: $active)
            return VStack(alignment: .center, spacing: 5) {
                HStack(alignment: .center, spacing: 5) {
                    GridCell(active: self.active == 1, url: imageUrls[1]).onTapGesture {
//                      withAnimation(.linear(duration: 0.25)){
//                        Image(systemName: "star")
//                      }
                    }
                    GridCell(active: self.active == 2, url: imageUrls[2]).border(Color.blue)
                    GridCell(active: self.active == 3, url: imageUrls[3]).border(Color.blue)
                    GridCell(active: self.active == 4, url: imageUrls[4]).border(Color.blue)
                    GridCell(active: self.active == 5, url: imageUrls[5]).border(Color.blue)
                }
                HStack(alignment: .center, spacing: 5) {
                    GridCell(active: self.active == 6, url: imageUrls[6]).border(Color.blue)
                    GridCell(active: self.active == 7, url: imageUrls[7]).border(Color.blue)
                    GridCell(active: self.active == 8, url: imageUrls[8]).border(Color.blue)
                    GridCell(active: self.active == 9, url: imageUrls[9]).border(Color.blue)
                    GridCell(active: self.active == 10, url: imageUrls[10]).border(Color.blue)
                }
                HStack(alignment: .center, spacing: 5) {
                    GridCell(active: self.active == 11, url: imageUrls[11]).border(Color.blue)
                    GridCell(active: self.active == 12, url: imageUrls[12]).border(Color.blue)
                    GridCell(active: self.active == 13, url: imageUrls[13]).border(Color.blue)
                    GridCell(active: self.active == 14, url: imageUrls[14]).border(Color.blue)
                    GridCell(active: self.active == 15, url: imageUrls[15]).border(Color.blue)
                }
                HStack(alignment: .center, spacing: 5) {
                    GridCell(active: self.active == 16, url: imageUrls[16]).border(Color.blue)
                    GridCell(active: self.active == 17, url: imageUrls[17]).border(Color.blue)
                    GridCell(active: self.active == 18, url: imageUrls[18]).border(Color.blue)
                    GridCell(active: self.active == 19, url: imageUrls[19]).border(Color.blue)
                    GridCell(active: self.active == 20, url: imageUrls[20]).border(Color.blue)
                }
                HStack(alignment: .center, spacing: 5) {
                    GridCell(active: self.active == 21, url: imageUrls[21]).border(Color.blue)
                    GridCell(active: self.active == 22, url: imageUrls[22]).border(Color.blue)
                    GridCell(active: self.active == 23, url: imageUrls[23]).border(Color.blue)
                    GridCell(active: self.active == 24, url: imageUrls[24]).border(Color.blue)
                    GridCell(active: self.active == 25, url: imageUrls[25]).border(Color.blue)
                }
                
            }
            .background(Rectangle().fill(Color.gray))
            .frame(width: 400, height: 400)
            .position(x: 256, y: 256)
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
                  .frame(width: 80, height: 80)
                  return Rectangle()
                  .fill(self.active ? Color.green : Color.clear)
                  .frame(width: 80, height: 80)
                  .overlay(img)
                } else {
                  let img = Image(url!)
                  .resizable()
                  .frame(width: 80, height: 80)
                  return Rectangle()
                .fill(self.active ? Color.green : Color.clear)
                .frame(width: 80, height: 80)
                .overlay(img)
                }
        }
    }
    
    struct MyDropDelegate: DropDelegate {
        @Binding var imageUrls: [Int: String]
        @Binding var active: Int
        
        func validateDrop(info: DropInfo) -> Bool {
          return info.hasItemsConforming(to: ["kUTTypeData as String"])
        }
        
        func dropEntered(info: DropInfo) {
//            print("drop entered",info.itemProviders(for: [kUTTypeData as String]))
        }
        
        func performDrop(info: DropInfo) -> Bool {
            let gridPosition = getGridPosition(location: info.location)
            print("location ",info.location)
            self.active = gridPosition
            if let item = info.itemProviders(for: [kUTTypeData as String]).first {
                item.loadItem(forTypeIdentifier: kUTTypeData as String, options: nil) { (urlData, error) in
                    DispatchQueue.main.async {
                        if let urlData = urlData as? Data {
                         let str = String(decoding: urlData, as: UTF8.self)
                         print("urlData ",urlData,str)
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
            
            let calcX = round((location.x - 358) / 95) + 1
            let calcY = round((location.y - 148) / 95)
            
            print("calcX ",calcX, "calcY ",calcY)
            
            return Int(round(calcX + (calcY * 5)))
        
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//            Text("fuck").onAppear {
//
//              let fucker = Bundle.main.resourcePath! + "/Images/dot.png"
//              self.img2url = URL(fileURLWithPath: fucker)
//              if let resourcePath = Bundle.main.resourcePath {
//                let imgName = "/ydot.png"
//                let path = resourcePath + imgName
//                print("path ",path)
//                self.img1url = URL(fileURLWithPath: path)
//                self.show = true
//                print("img2url ",self.img2url,fucker)
//
//              }
//            }
