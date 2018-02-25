//
//  LaunchDetailViewModel.swift
//  spacex
//
//  Created by omer kantar on 25.02.2018.
//  Copyright © 2018 arabam.com. All rights reserved.
//

import UIKit

class LaunchDetailViewModel: BaseCellViewModel {

    var model: LaunchModel
    var title: String?
    var descriptionText: String?
    var dateText: String?
    var videoURL: URL?
    var imageURL: URL?
    var sections = [[LaunchDetailTableViewCellType]]()
    

    init(launch: LaunchModel) {
        self.model = launch
        self.title = launch.rocketModel?.titleText
        self.videoURL = launch.linksModel?.videoLink?.url
        self.imageURL = launch.linksModel?.missionPatch?.url
        self.descriptionText = launch.detail
        self.dateText = launch.dateUtc?.utcDate?.string
        // First Section Detail
        sections.append([.detail])
        var secondSection = [LaunchDetailTableViewCellType]()
        if let article = launch.linksModel?.articleLink?.url {
            secondSection.append(.article(url: article))
        }
        if let reddit = launch.linksModel?.redditMedia?.url {
            secondSection.append(.redditMedia(url: reddit))
        }
        if let reddit = launch.linksModel?.redditCampaign?.url {
            secondSection.append(.redditCampaign(url: reddit))
        }
        if let reddit = launch.linksModel?.redditLaunch?.url {
            secondSection.append(.redditLaunch(url: reddit))
        }
        if let presskit = launch.linksModel?.presskit?.url {
            secondSection.append(.presskit(url: presskit))
        }
        
        if secondSection.count > 0 {
            sections.append(secondSection)
        }
    }
    
}

// MARK: -
extension LaunchDetailViewModel {
    enum LaunchDetailTableViewCellType {
        case detail
        case links
        case article(url: URL)
        case redditMedia(url: URL)
        case redditCampaign(url: URL)
        case redditLaunch(url: URL)
        case presskit(url: URL)
        
        var title: String {
            switch self {
                // Sections
            case .detail:
                return "Description 📯"
            case .links:
                return "Links 🔗"
                // Cells
            case .article:
                return "Article 📚"
            case .presskit:
                return "Presskit"
            case .redditMedia:
                return "Reddit Media 📺"
            case .redditCampaign:
                return "Reddit Campaign 🎁"
            case .redditLaunch:
                return "Reddit Launch 🚀"
            }
        }
        
        var cellType: UITableView.CellType {
            switch self {
            case .detail:
                return .launchDetail
            default:
                return .launchLink
            }
        }
    }
}




// MARK: - Table View DataSource
extension LaunchDetailViewModel {
    var numberOfSections: Int {
        return sections.count
    }
    
    func numberOfRows(section: Int) -> Int {
        return sections[section].count
    }
    
    func tableViewCellType(indexPath: IndexPath) -> LaunchDetailTableViewCellType {
        return sections[indexPath.section][indexPath.row]
    }
}

