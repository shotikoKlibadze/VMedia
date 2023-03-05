//
//  TvGuideLayout.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 03.03.23.
//

import UIKit

protocol SpreadsheetLayoutDelegate: AnyObject {
    func spreadsheet(layout: SpreadsheetLayout, heightForRowsInSection section: Int) -> CGFloat
    func widthsOfSideRowsInSpreadsheet(layout: SpreadsheetLayout) -> (left: CGFloat?, right: CGFloat?)
    func spreadsheet(layout: SpreadsheetLayout, widthForColumnAtIndex index: Int) -> CGFloat
    func heightsOfHeaderAndFooterColumnsInSpreadsheet(layout: SpreadsheetLayout) -> (headerHeight: CGFloat?, footerHeight: CGFloat?)
}

final class SpreadsheetLayout: UICollectionViewLayout {
    
    public weak var delegate: SpreadsheetLayoutDelegate?
    var stickyChannelsHeader = true
    var stickyTopHeader = true
    
    enum ViewKindType: String {
        case channelInformation = "ChannelInformationView"
        case timeInformation = "TimeInformation"
        
        //case dateInformation = "DateInformation"
    }
    
    lazy var channelRowCache = [UICollectionViewLayoutAttributes]()
    lazy var cellCache = [[UICollectionViewLayoutAttributes]]()
    lazy var topColumnCache = [UICollectionViewLayoutAttributes]()
    
    
    private var topLeftGapSpaceLayoutAttributes: UICollectionViewLayoutAttributes?
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat = 0
    
    private var decorationViewSet = (topLeft: false, topRight: false, bottomLeft: false, bottomRight: false)
    
    convenience init(delegate: SpreadsheetLayoutDelegate,
                     topLeftDecorationView: UINib? = nil) {
        self.init()
        if let topLeftDecorationView {
            self.register(topLeftDecorationView, forDecorationViewOfKind: "DateInformation")
        }
        self.delegate = delegate
    }
    
    override func prepare() {
        guard let collectionView = self.collectionView, let delegate = self.delegate else { return }
        
        var maxItems = 0
        
        let widthTuple = delegate.widthsOfSideRowsInSpreadsheet(layout: self)
        let headerFooterTuple = delegate.heightsOfHeaderAndFooterColumnsInSpreadsheet(layout: self)
        
        let maxTopColumnHeight = headerFooterTuple.headerHeight ?? 0
        
        //Calculate channels Row heights for sections
        var rowHeights = [CGFloat]()
        var currentRowYoffset = maxTopColumnHeight
        
        for section in 0 ..< collectionView.numberOfSections {
            let rowHeight = delegate.spreadsheet(layout: self, heightForRowsInSection: section)
            rowHeights.append(rowHeight)
            
            let items = collectionView.numberOfItems(inSection: section)
            maxItems = max(maxItems, items)
            
            if let maxLeftRowWidth = widthTuple.left {
                let channelRowAttributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: ViewKindType.channelInformation.rawValue, with: IndexPath(item: 0, section: section))
                channelRowAttributes.frame = CGRect(x: 0, y: currentRowYoffset, width: maxLeftRowWidth, height: rowHeight)
                self.channelRowCache.append(channelRowAttributes)
            }
            currentRowYoffset += rowHeight
        }
        
        //Calculate programs Row width and time information view
        var columnWidths = [CGFloat]()
        var currentColumnHeadlineXoffset = widthTuple.left ?? 0
        for item in 0 ..< maxItems {
            let topColumnWidth = delegate.spreadsheet(layout: self, widthForColumnAtIndex: item)
            columnWidths.append(topColumnWidth)
            if maxTopColumnHeight > 0 {
                let topColumnAttributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: ViewKindType.timeInformation.rawValue, with: IndexPath(item: item, section: 0))
                topColumnAttributes.frame = CGRect(x: currentColumnHeadlineXoffset, y: 0, width: topColumnWidth, height: maxTopColumnHeight)
                self.topColumnCache.append(topColumnAttributes)
                currentColumnHeadlineXoffset += topColumnWidth
            }
        }
        
        //Cell Data Setup
        var currentCellXoffset = widthTuple.left ?? 0
        var currentCellYoffset = maxTopColumnHeight
        for currentSection in 0 ..< rowHeights.count {
            let sectionHeight = rowHeights[currentSection]
            var sectionAttributes = [UICollectionViewLayoutAttributes]()
            currentCellXoffset = widthTuple.left ?? 0
            for currentItem in 0 ..< columnWidths.count {
                let rowWidth = columnWidths[currentItem]
                let cellAttributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: currentItem, section: currentSection))
                cellAttributes.frame = CGRect(x: currentCellXoffset, y: currentCellYoffset, width: rowWidth, height: sectionHeight)
                currentCellXoffset += rowWidth
                sectionAttributes.append(cellAttributes)
            }
            self.cellCache.append(sectionAttributes)
            currentCellYoffset += sectionHeight
        }
        
        
        
        //Top Left Decoration View
        let numberOfSections = collectionView.numberOfSections
        if numberOfSections > 0 {
            if let leftRowWidth = widthTuple.left {
                if maxTopColumnHeight > 0 {
                    let topLeftAttributes = UICollectionViewLayoutAttributes(forDecorationViewOfKind: "DateInformation", with: IndexPath(item: 0, section: 0))
                    topLeftAttributes.frame = CGRect(x: 0, y: 0, width: leftRowWidth, height: maxTopColumnHeight)
                    self.topLeftGapSpaceLayoutAttributes = topLeftAttributes
                }
            }
        }
        
        if self.contentWidth != currentCellXoffset {
            collectionView.setContentOffset(CGPoint.zero, animated: false)
        }
        
        self.contentWidth = currentCellXoffset
        self.contentHeight = currentCellYoffset
    }
    override public var collectionViewContentSize : CGSize {
        return CGSize(width: self.contentWidth, height: self.contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let cv = self.collectionView else { return nil }
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        //Cells
        for cellCacheArray in self.cellCache {
            for cellAttributes in cellCacheArray where cellAttributes.frame.intersects(rect) {
                cellAttributes.zIndex = 0
                layoutAttributes.append(cellAttributes)
            }
        }
        
        //Channels Header
        if self.stickyChannelsHeader && cv.contentOffset.x >= 0 {
            let contentOffsetX = cv.contentOffset.x
            
            if contentOffsetX >= 0 {
                for rowAttributes in self.channelRowCache {
                    rowAttributes.frame.origin.x = contentOffsetX
                    rowAttributes.zIndex = 1000
                    layoutAttributes.append(rowAttributes)
                }
            }
        }
        else {
            for rowAttributes in self.channelRowCache where rowAttributes.frame.intersects(rect) {
                rowAttributes.frame.origin.x = 0
                rowAttributes.zIndex = 1000
                layoutAttributes.append(rowAttributes)
            }
        }
        
        //TOP COLUMN
        if self.stickyTopHeader && cv.contentOffset.y >= 0 {
            for columnAttributes in self.topColumnCache {
                columnAttributes.frame.origin.y = cv.contentOffset.y
                columnAttributes.zIndex = 2000
                layoutAttributes.append(columnAttributes)
            }
        }
        else {
            for columnAttributes in self.topColumnCache where columnAttributes.frame.intersects(rect) {
                columnAttributes.frame.origin.y = 0
                columnAttributes.zIndex = 2000
                layoutAttributes.append(columnAttributes)
            }
        }
        
        //Top Left Gap Space
        if let topLeftGapSpaceAttributes = self.topLeftGapSpaceLayoutAttributes {
            if self.stickyChannelsHeader && cv.contentOffset.x >= 0 {
                topLeftGapSpaceAttributes.frame.origin.x = cv.contentOffset.x
            }
            else if topLeftGapSpaceAttributes.frame.intersects(rect) {
                topLeftGapSpaceAttributes.frame.origin.x = 0
            }
            
            if self.stickyChannelsHeader && cv.contentOffset.y >= 0 {
                topLeftGapSpaceAttributes.frame.origin.y = cv.contentOffset.y
            }
            else if topLeftGapSpaceAttributes.frame.intersects(rect) {
                topLeftGapSpaceAttributes.frame.origin.y = 0
            }
            
            topLeftGapSpaceAttributes.zIndex = 3000
            layoutAttributes.append(topLeftGapSpaceAttributes)
        }

        return layoutAttributes
    }
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.cellCache[indexPath.section][indexPath.row]
    }
    
    override public func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let viewKind = ViewKindType(rawValue: elementKind) else { fatalError("Invalid View Kind for string: \(elementKind)") }
        switch viewKind {
        case .channelInformation:
            return self.channelRowCache[indexPath.section]
        case .timeInformation:
            return self.topColumnCache[indexPath.section]
        }
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        channelRowCache.removeAll()
        cellCache.removeAll()
        topColumnCache.removeAll()
    }
    
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return self.stickyChannelsHeader
    }
}
