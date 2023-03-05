//
//  TvGuideViewController2.swift
//  VMedia
//
//  Created by Shotiko Klibadze on 03.03.23.
//

import UIKit
import ProgressHUD

final class TvGuideViewController2: UIViewController,StoryboardLoadable, TvGuidView {

    @IBOutlet weak var colectionView: UICollectionView!
    weak var output: TvGuideViewOutput?
    
    private let channelsViewNibName = "ChannelInfoView"
    private let channelViewIdentifier = "ChannelInfoViewIdentifier"
    private let timeInfoViewNibName = "TimeInfoView"
    private let imeInfoViewIdentifier = "GuideDateInformationViewIdentifier"
    private let defaultCellIdentifier = "DefaultCellIdentifier"
       
    private var dataSource: UICollectionViewDiffableDataSource<Int,TvProgram>!
    
    private var schedule = [TvSchedule]() {
        didSet {
            updateSnapshot()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD.show()
        output?.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        
        let layout = SpreadsheetLayout(delegate: self, topLeftDecorationView: UINib(nibName: "DateInfoView", bundle: nil))
        layout.stickyChannelsHeader = true
        self.colectionView.collectionViewLayout = layout
        
        //Register Supplementary-View
        self.colectionView.register(UINib(nibName: channelsViewNibName, bundle: nil), forSupplementaryViewOfKind: SpreadsheetLayout.ViewKindType.channelInformation.rawValue, withReuseIdentifier: self.channelViewIdentifier)
    
        self.colectionView.register(UINib(nibName: timeInfoViewNibName, bundle: nil), forSupplementaryViewOfKind: SpreadsheetLayout.ViewKindType.timeInformation.rawValue, withReuseIdentifier: self.imeInfoViewIdentifier)
        
        //DataSource
        dataSource = UICollectionViewDiffableDataSource(collectionView: colectionView, cellProvider: { collectionView, indexPath, model in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.defaultCellIdentifier, for: indexPath) as? ProgramCollectionViewCell else { fatalError() }
            cell.configure(with: model)
            return cell
        })
        
        //Supplementary views
        dataSource.supplementaryViewProvider = { [weak self] collectionView , kind , indexPath in
            guard let self, let viewKind = SpreadsheetLayout.ViewKindType(rawValue: kind) else {
                return nil
            }
            switch viewKind {
            case .channelInformation:
                let channelInfoView = collectionView.dequeueReusableSupplementaryView(ofKind: viewKind.rawValue, withReuseIdentifier: self.channelViewIdentifier, for: indexPath) as!
                ChannelInfoView
                channelInfoView.configure(with: self.schedule[indexPath.section].tvChannel)
                return channelInfoView
            case .timeInformation:
                let decorationView = collectionView.dequeueReusableSupplementaryView(ofKind: viewKind.rawValue, withReuseIdentifier: self.imeInfoViewIdentifier, for: indexPath) as!
                TimeInfoView
                return decorationView
            }
        }
    }
    
    func tvProgramSchedule(schedule: [TvSchedule]) {
        self.schedule = schedule
    }
    
    func updateSnapshot() {
        var snapShot = NSDiffableDataSourceSnapshot<Int,TvProgram>()
        snapShot.appendSections(schedule.map { $0.tvChannel.id })
        schedule.forEach { snapShot.appendItems($0.programs, toSection: $0.tvChannel.id) }
        dataSource.apply(snapShot)
        ProgressHUD.dismiss()
    }
}

extension TvGuideViewController2: SpreadsheetLayoutDelegate {
    
    func spreadsheet(layout: SpreadsheetLayout, heightForRowsInSection section: Int) -> CGFloat {
        return 50
    }
    
    func widthsOfSideRowsInSpreadsheet(layout: SpreadsheetLayout) -> (left: CGFloat?, right: CGFloat?) {
        return (120, 0)
    }
    
    func spreadsheet(layout: SpreadsheetLayout, widthForColumnAtIndex index: Int) -> CGFloat {
        return 300
    }
    
    func heightsOfHeaderAndFooterColumnsInSpreadsheet(layout: SpreadsheetLayout) -> (headerHeight: CGFloat?, footerHeight: CGFloat?) {
        return (50, 0)
    }
}
