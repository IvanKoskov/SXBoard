//
//  aboutViewController.swift
//  SXBoard
//
//  Created by Evan Matthew on 26/7/25.
//

import Foundation
import AppKit

class aboutViewController : NSSplitViewController, NSWindowDelegate {
    let mainAboutVC = mainAboutViewController()
    let socialVC = socialsViewController()
    var applicationDelegate: AppDelegate!
    
    override func viewDidLoad() {
    super.loadView()
    self.splitView.wantsLayer = true
    self.splitView.layer?.cornerRadius = 15
    self.splitView.dividerStyle = .thin
    self.splitView.layer?.borderColor = .white
    self.splitView.layer?.borderWidth = 1
    let mainItem = NSSplitViewItem(viewController: mainAboutVC)
    mainItem.minimumThickness = 420
    let socialItem = NSSplitViewItem(viewController: socialVC)
        socialItem.minimumThickness = 80
        
    self.splitView.isVertical = false
    
    
        
    addSplitViewItem(mainItem)
    addSplitViewItem(socialItem)
    
    
    
    }

}
