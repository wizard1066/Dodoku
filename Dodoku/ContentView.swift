//
//  ContentView.swift
//  Dodoku
//
//  Created by localadmin on 27.03.20.
//  Copyright © 2020 Mark Lucking. All rights reserved.
//

import SwiftUI
import CoreServices

let dots = ["rdot","bdot","gdot","odot","ydot","pdot","fdot","tdot"]

struct ContentView: View {
    var body: some View {
    HStack {
      GridStack(rows: 8, columns: 1) { row, col in
  //    Image(systemName: "\(row * 4 + col).circle")
  //    Text("R\(row) C\(col)")
        DragableImage(name: dots[row])
      }.padding(60)
      DroppableAreaV()
    }
}
    
    
//        HStack {
//            VStack {
//                DragableImage(name: "rdot")
//                DragableImage(name: "gdot")
//                DragableImage(name: "bdot")
//                DragableImage(name: "odot")
//                }.padding(5)
//            VStack {
//                DragableImage(name: "ydot")
//                DragableImage(name: "pdot")
//                DragableImage(name: "fdot")
//                DragableImage(name: "tdot")
//            }.padding(5)
//            DroppableArea()
//        }.padding(0)
//    }
    


    
    struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0 ..< rows, id: \.self) { row in
                HStack {
                    ForEach(0 ..< self.columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }

    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}
    
    struct DragableImage: View {
        let name: String
        var body: some View {
              Image(name)
                .resizable()
                .frame(width: 60, height: 60)
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
    
    struct Grid: View {
      @State var zipX = 0
      @State var zipY = 0
      @State var color: Color!
      var body: some View {
        return Circle()
          .fill(color)
          .frame(width: 20, height: 20)
          .position(x: CGFloat(zipX * 75), y: CGFloat(zipY * 88))
      }
    }
    
    struct DroppableAreaV: View {
        @State private var imageUrls: [Int: String] = [:]
        @State private var active = 0
        @State private var index = 4
        
        var body: some View {
            print("index ",index)
            let dropDelegate = MyDropDelegate(imageUrls: $imageUrls, active: $active)
            return GridStack(rows: 4, columns: 4) { row, col in
              GridCell(active: self.active == self.index - row + (col * 4), url: self.imageUrls[self.index - row + (col * 4)])
                    .onTapGesture {
                      self.imageUrls[self.index - row + (col * 4)] = nil
                    }
//              Text("R\(row + self.index) C\(col) X\(row+col)")
          }.onDrop(of: [kUTTypeData as String], delegate: dropDelegate)
        }
    }
    
    struct DroppableArea: View {
        @State private var imageUrls: [Int: String] = [:]
        @State private var active = 0
        
        var body: some View {
            let dropDelegate = MyDropDelegate(imageUrls: $imageUrls, active: $active)
            return VStack(alignment: .center, spacing: 5) {
//                Grid(zipX: 1, zipY: 0, color: Color.yellow)
//                Grid(zipX: 1, zipY: 5, color: Color.yellow)
                HStack(alignment: .center, spacing: 5) {
                    GridCell(active: self.active == 1, url: imageUrls[1])
                    .onTapGesture {
                      self.imageUrls[1] = nil
                    }
                    GridCell(active: self.active == 2, url: imageUrls[2])
                    .onTapGesture {
                      self.imageUrls[2] = nil
                    }
                    GridCell(active: self.active == 3, url: imageUrls[3])
                    .onTapGesture {
                      self.imageUrls[3] = nil
                    }
                    GridCell(active: self.active == 4, url: imageUrls[4])
                    .onTapGesture {
                      self.imageUrls[4] = nil
                    }
                    GridCell(active: self.active == 5, url: imageUrls[5])
                    .onTapGesture {
                      self.imageUrls[5] = nil
                    }
                    GridCell(active: self.active == 6, url: imageUrls[6])
                    .onTapGesture {
                      self.imageUrls[6] = nil
                    }
                    GridCell(active: self.active == 7, url: imageUrls[7])
                    .onTapGesture {
                      self.imageUrls[7] = nil
                    }
                    GridCell(active: self.active == 8, url: imageUrls[8])
                    .onTapGesture {
                      self.imageUrls[8] = nil
                    }
                }
                HStack(alignment: .center, spacing: 5) {
                    GridCell(active: self.active == 9, url: imageUrls[9])
                    .onTapGesture {
                      self.imageUrls[9] = nil
                    }
                    GridCell(active: self.active == 10, url: imageUrls[10])
                    .onTapGesture {
                      self.imageUrls[10] = nil
                    }
                    GridCell(active: self.active == 11, url: imageUrls[11])
                    .onTapGesture {
                      self.imageUrls[11] = nil
                    }
                    GridCell(active: self.active == 12, url: imageUrls[12])
                    .onTapGesture {
                      self.imageUrls[12] = nil
                    }
                    GridCell(active: self.active == 13, url: imageUrls[13])
                    .onTapGesture {
                      self.imageUrls[13] = nil
                    }
                    GridCell(active: self.active == 14, url: imageUrls[14])
                    .onTapGesture {
                      self.imageUrls[14] = nil
                    }
                    GridCell(active: self.active == 15, url: imageUrls[15])
                    .onTapGesture {
                      self.imageUrls[15] = nil
                    }
                    GridCell(active: self.active == 16, url: imageUrls[16])
                    .onTapGesture {
                      self.imageUrls[16] = nil
                    }
                }
                HStack(alignment: .center, spacing: 5) {
                    GridCell(active: self.active == 17, url: imageUrls[17])
                    .onTapGesture {
                      self.imageUrls[17] = nil
                    }
                    GridCell(active: self.active == 18, url: imageUrls[18])
                    .onTapGesture {
                      self.imageUrls[18] = nil
                    }
                    GridCell(active: self.active == 19, url: imageUrls[19])
                    .onTapGesture {
                      self.imageUrls[19] = nil
                    }
                    GridCell(active: self.active == 20, url: imageUrls[20])
                    .onTapGesture {
                      self.imageUrls[20] = nil
                    }
                    GridCell(active: self.active == 21, url: imageUrls[21])
                    .onTapGesture {
                      self.imageUrls[21] = nil
                    }
                    GridCell(active: self.active == 22, url: imageUrls[22])
                    .onTapGesture {
                      self.imageUrls[22] = nil
                    }
                    GridCell(active: self.active == 23, url: imageUrls[23])
                    .onTapGesture {
                      self.imageUrls[23] = nil
                    }
                    GridCell(active: self.active == 24, url: imageUrls[24])
                    .onTapGesture {
                      self.imageUrls[24] = nil
                    }
                }
                HStack(alignment: .center, spacing: 5) {
                    GridCell(active: self.active == 25, url: imageUrls[25])
                    .onTapGesture {
                      self.imageUrls[25] = nil
                    }
                    GridCell(active: self.active == 26, url: imageUrls[26])
                    .onTapGesture {
                      self.imageUrls[26] = nil
                    }
                    GridCell(active: self.active == 27, url: imageUrls[27])
                    .onTapGesture {
                      self.imageUrls[27] = nil
                    }
                    GridCell(active: self.active == 28, url: imageUrls[28])
                    .onTapGesture {
                      self.imageUrls[28] = nil
                    }
                    GridCell(active: self.active == 29, url: imageUrls[29])
                    .onTapGesture {
                      self.imageUrls[29] = nil
                    }
                    GridCell(active: self.active == 30, url: imageUrls[30])
                    .onTapGesture {
                      self.imageUrls[30] = nil
                    }
                    GridCell(active: self.active == 31, url: imageUrls[31])
                    .onTapGesture {
                      self.imageUrls[31] = nil
                    }
                    GridCell(active: self.active == 32, url: imageUrls[32])
                    .onTapGesture {
                      self.imageUrls[32] = nil
                    }
              }
              HStack(alignment: .center, spacing: 5) {
                    GridCell(active: self.active == 33, url: imageUrls[33])
                    .onTapGesture {
                      self.imageUrls[33] = nil
                    }
                    GridCell(active: self.active == 34, url: imageUrls[34])
                    .onTapGesture {
                      self.imageUrls[34] = nil
                    }
                    GridCell(active: self.active == 35, url: imageUrls[35])
                    .onTapGesture {
                      self.imageUrls[35] = nil
                    }
                    GridCell(active: self.active == 36, url: imageUrls[36])
                    .onTapGesture {
                      self.imageUrls[36] = nil
                    }
                    GridCell(active: self.active == 33, url: imageUrls[33])
                    .onTapGesture {
                      self.imageUrls[33] = nil
                    }
                    GridCell(active: self.active == 34, url: imageUrls[34])
                    .onTapGesture {
                      self.imageUrls[34] = nil
                    }
                    GridCell(active: self.active == 35, url: imageUrls[35])
                    .onTapGesture {
                      self.imageUrls[35] = nil
                    }
                    GridCell(active: self.active == 36, url: imageUrls[36])
                    .onTapGesture {
                      self.imageUrls[36] = nil
                    }
                }
                HStack(alignment: .center, spacing: 5) {
                    GridCell(active: self.active == 37, url: imageUrls[37])
                    .onTapGesture {
                      self.imageUrls[37] = nil
                    }
                    GridCell(active: self.active == 38, url: imageUrls[38])
                    .onTapGesture {
                      self.imageUrls[38] = nil
                    }
                    GridCell(active: self.active == 39, url: imageUrls[39])
                    .onTapGesture {
                      self.imageUrls[39] = nil
                    }
                    GridCell(active: self.active == 40, url: imageUrls[40])
                    .onTapGesture {
                      self.imageUrls[40] = nil
                    }
                    GridCell(active: self.active == 41, url: imageUrls[41])
                    .onTapGesture {
                      self.imageUrls[41] = nil
                    }
                    GridCell(active: self.active == 42, url: imageUrls[42])
                    .onTapGesture {
                      self.imageUrls[42] = nil
                    }
                    GridCell(active: self.active == 43, url: imageUrls[43])
                    .onTapGesture {
                      self.imageUrls[43] = nil
                    }
                    GridCell(active: self.active == 44, url: imageUrls[44])
                    .onTapGesture {
                      self.imageUrls[44] = nil
                    }
                }
                HStack(alignment: .center, spacing: 5) {
                    GridCell(active: self.active == 45, url: imageUrls[45])
                    .onTapGesture {
                      self.imageUrls[45] = nil
                    }
                    GridCell(active: self.active == 46, url: imageUrls[46])
                    .onTapGesture {
                      self.imageUrls[46] = nil
                    }
                    GridCell(active: self.active == 47, url: imageUrls[47])
                    .onTapGesture {
                      self.imageUrls[47] = nil
                    }
                    GridCell(active: self.active == 48, url: imageUrls[48])
                    .onTapGesture {
                      self.imageUrls[48] = nil
                    }
                    GridCell(active: self.active == 49, url: imageUrls[49])
                    .onTapGesture {
                      self.imageUrls[49] = nil
                    }
                    GridCell(active: self.active == 50, url: imageUrls[50])
                    .onTapGesture {
                      self.imageUrls[50] = nil
                    }
                    GridCell(active: self.active == 51, url: imageUrls[51])
                    .onTapGesture {
                      self.imageUrls[51] = nil
                    }
                    GridCell(active: self.active == 52, url: imageUrls[52])
                    .onTapGesture {
                      self.imageUrls[52] = nil
                    }
                }
                HStack(alignment: .center, spacing: 5) {
                    GridCell(active: self.active == 53, url: imageUrls[53])
                    .onTapGesture {
                      self.imageUrls[53] = nil
                    }
                    GridCell(active: self.active == 54, url: imageUrls[54])
                    .onTapGesture {
                      self.imageUrls[54] = nil
                    }
                    GridCell(active: self.active == 55, url: imageUrls[55])
                    .onTapGesture {
                      self.imageUrls[55] = nil
                    }
                    GridCell(active: self.active == 56, url: imageUrls[56])
                    .onTapGesture {
                      self.imageUrls[56] = nil
                    }
                    GridCell(active: self.active == 57, url: imageUrls[57])
                    .onTapGesture {
                      self.imageUrls[57] = nil
                    }
                    GridCell(active: self.active == 58, url: imageUrls[58])
                    .onTapGesture {
                      self.imageUrls[58] = nil
                    }
                    GridCell(active: self.active == 59, url: imageUrls[59])
                    .onTapGesture {
                      self.imageUrls[59] = nil
                    }
                    GridCell(active: self.active == 60, url: imageUrls[60])
                    .onTapGesture {
                      self.imageUrls[60] = nil
                    }
                }
                
            }
            .background(Rectangle().fill(Color.gray))
            .frame(width: 400, height: 400)
            .onDrop(of: [kUTTypeData as String], delegate: dropDelegate)
        }
    }
    
//    struct GridCellV: View {
//      let active: Bool
//      @State var url: String?
//
//      var body: some View {
//        GridCell(active: self.active == active, url: url)
//          .onTapGesture {
//            self.url = nil
//        }
//      }
//    }
    
  
    
    struct GridCell: View {
    
        let active: Bool
        let url: String?
        
        var body: some View {
                if url == nil {
                  let img = Image(systemName: "photo")
                  .resizable()
                  .frame(width: 60, height: 60)
                  return Rectangle()
                  .fill(self.active ? Color.green : Color.clear)
                  .frame(width: 60, height: 60)
                  .overlay(img)
                } else {
                  let img = Image(url!)
                  .resizable()
                  .frame(width: 60, height: 60)
                  return Rectangle()
                .fill(self.active ? Color.green : Color.clear)
                .frame(width: 60, height: 60)
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
            print("drop entered")
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
          // Used Grid method to figure good values here
            let calcX = round((location.x - 480) / 88)
            let calcY = round((location.y - 526) / 60) * -1
            print("location ",Int(round(calcX )),location.x)
            return Int(round(calcY + (calcX * 4)))
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
