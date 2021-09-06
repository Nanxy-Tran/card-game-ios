//
//  AspectVGrid.swift
//  CardGame
//
//  Created by Thinh Tran on 05/09/2021.
//

import SwiftUI


struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable{
    var  items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    var size: CGSize
    
    init(items: [Item], aspectRatio: CGFloat, size: CGSize, content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
        self.size = size
    }
    
    var body: some View {
        let minimumWidth: CGFloat = bestWidthLayout(itemCount: items.count, in: size, aspectRatio: 2/3)
        LazyVGrid(columns: [GridItem(.adaptive(minimum: minimumWidth))], content: {
            ForEach(items){
                item in
                content(item).aspectRatio(aspectRatio, contentMode: .fit)
            }
        })
    }
    
    private func bestWidthLayout(itemCount: Int, in size: CGSize,aspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / aspectRatio
            if itemHeight * CGFloat(rowCount) < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + columnCount) / columnCount
        } while columnCount < itemCount
        if(columnCount > itemCount ) {
            columnCount = itemCount
        }
        return floor(size.width / CGFloat(columnCount))
    }
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
