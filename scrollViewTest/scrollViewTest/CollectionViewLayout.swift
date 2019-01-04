//
//  CollectionViewLayout.swift
//  scrollViewTest
//
//  Created by Cara Brennan on 9/17/18.
//  Copyright © 2018 Cara Brennan. All rights reserved.
//

import UIKit

protocol CollectionViewLayoutDelegate: class {
    func collectionView(_ collectionView:UICollectionView, widthForCellAtIndexPath indexPath:IndexPath) -> CGFloat
}

class CollectionViewLayout: UICollectionViewLayout {

    var delegate: CollectionViewLayoutDelegate!

    //want this to be populated with the number of channels

    private var numberOfRows =  6

    private var cellPadding:CGFloat = 6

    private var cache = [UICollectionViewLayoutAttributes]()

    private var contentWidth:CGFloat = 0

    private var contentHeight: CGFloat = 0

    var rowHeight: CGFloat = 200

    override var collectionViewContentSize: CGSize {
        return CGSize(width:contentWidth, height:contentHeight)
    }



    override func prepare() {

        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }
        
        var yOffset:CGFloat = 0
        contentHeight = CGFloat(collectionView.numberOfSections) * rowHeight

        for section in 0 ..< collectionView.numberOfSections {
            var xOffset: CGFloat =  0

            for item in 0 ..< collectionView.numberOfItems(inSection: section) {

                let indexPath = IndexPath( item:item, section: section)

                let emojiCellWidth = delegate.collectionView(collectionView, widthForCellAtIndexPath: indexPath)
                //            let emojiCellWidth = CGFloat(500)
                let width = cellPadding * 2 + emojiCellWidth

                let frame = CGRect(x: xOffset, y: yOffset, width: width, height: rowHeight)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                cache.append(attributes)

                contentWidth = max(contentWidth, frame.maxX)
                xOffset = xOffset + width

            }
            yOffset += rowHeight
        }

    }



    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()

        for attributes in cache {
            if attributes.frame.intersects(rect){
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }

}




