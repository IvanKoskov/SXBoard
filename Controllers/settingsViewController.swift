//
//  settingsViewController.swift
//  SXBoard
//
//  Created by Evan Matthew on 3/7/25.
//

import Foundation
import Cocoa

class SettingsViewController : NSViewController, NSWindowDelegate {
    
    var darkBlur: NSVisualEffectView!
    var settingsView: NSView! // Main window view
    var segmentedSettings: NSSegmentedControl! // Segment control
    var segmentedControlsViewContainer: NSView! //Holds views (from below) of view controller
    var generalView: NSView!
    var advancedView: NSView!
    var bindingsView: NSView!
    var updateView: NSView!
    var creditsView: NSView!
    var visualBackgroundEffect: NSVisualEffectView!
    var segmentViews: [NSView]! // Holds all the views for the segmented control
    var closeSettings: NSButton!
    var tabNames: [(String, String)] = [("General", "gearshape.fill"), ("Advanced", "wrench.and.screwdriver"), ("Bindings", "text.and.command.macwindow"), ("Updates", "arrow.clockwise"), ("Credits", "person")]
    var generalTabHorizontalSeparator: NSBox! //Visual
    var generalOptionsView: NSStackView!
    var maxNumberOfAllowedSavedClipBoardData: NSPopUpButton!
    var scrollViewGeneralTab: NSScrollView!
    var maxNumberOfClipBoardDataParagraph: NSStackView!
    var maxNumberOfClipBoardDataOptions: [String] = ["10 by default", "20", "30", "40", "50", "60", "70", "80", "90 max"]
    var captionMaxNumber: NSTextField!

    override func loadView() {
        settingsView = NSView()
        settingsView.frame = NSRect(x: 0, y: 0, width: 500, height: 400)
        settingsView.wantsLayer = true
        settingsView.layer?.backgroundColor  = NSColor.white.cgColor
        settingsView.layer?.cornerRadius = 15
        self.view = settingsView
        
        visualBackgroundEffect = NSVisualEffectView(frame: self.view.bounds)
        visualBackgroundEffect.material = .hudWindow
        visualBackgroundEffect.blendingMode = .behindWindow
        if #available(macOS 10.14, *) {
            visualBackgroundEffect.material = .hudWindow
        } else {
            visualBackgroundEffect.material = .sidebar
        }
        visualBackgroundEffect.state = .active
        
        self.view.addSubview(visualBackgroundEffect)
        
        if let image = NSImage(systemSymbolName: "xmark", accessibilityDescription: nil) {
            closeSettings = NSButton(image: image, target: self, action: #selector(closeSettingsWindow))
        } else {
            closeSettings = NSButton(title: "X", target: self, action: #selector(closeSettingsWindow))
        }
        
        closeSettings.isBordered = false
        closeSettings.frame = NSRect(x: 475, y: 375, width: 20, height: 20) // adjusted for 400x300
        closeSettings.autoresizingMask = [.minXMargin, .minYMargin]
        self.view.addSubview(closeSettings)
        loadSettings()
    }
    
    override func viewDidLoad() {
        
    }
    
   @objc func closeSettingsWindow(){
        self.view.window?.orderOut(nil)
    }
    
    func windowShouldClose(_ sender: NSWindow) -> Bool {
       return true
    }
    
    @objc func loadSettings() {
       
        segmentedControlsViewContainer = NSView()
        segmentedControlsViewContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(segmentedControlsViewContainer)


        segmentedSettings = NSSegmentedControl()
        segmentedSettings.segmentCount = tabNames.count
        segmentedSettings.segmentStyle = .rounded
        segmentedSettings.target = self
        segmentedSettings.selectedSegment = 0
        segmentedSettings.action = #selector(segmentChanged)
        segmentedSettings.translatesAutoresizingMaskIntoConstraints = false

        for (index, tab) in tabNames.enumerated() {
            segmentedSettings.setLabel(tab.0, forSegment: index)
            segmentedSettings.setImage(NSImage(systemSymbolName: tab.1, accessibilityDescription: nil), forSegment: index)
        }

        self.view.addSubview(segmentedSettings)

        NSLayoutConstraint.activate([
            segmentedSettings.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            segmentedSettings.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        generalView = NSView()
        advancedView = NSView()
        bindingsView = NSView()
        updateView = NSView()
        creditsView = NSView()

        segmentViews = [generalView, advancedView, bindingsView, updateView, creditsView]

        for view in segmentViews {
            view.translatesAutoresizingMaskIntoConstraints = false
            segmentedControlsViewContainer.addSubview(view)

            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: segmentedControlsViewContainer.topAnchor),
                view.leadingAnchor.constraint(equalTo: segmentedControlsViewContainer.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: segmentedControlsViewContainer.trailingAnchor),
                view.bottomAnchor.constraint(equalTo: segmentedControlsViewContainer.bottomAnchor)
            ])

            view.isHidden = true
        }
        
        NSLayoutConstraint.activate([
            segmentedControlsViewContainer.topAnchor.constraint(equalTo: segmentedSettings.bottomAnchor, constant: 10),
            segmentedControlsViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            segmentedControlsViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            segmentedControlsViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])

        
        segmentViews[0].isHidden = false
        
        setupGeneralTab()
        
    }

    
    @objc func segmentChanged() {
        let selectedIndex = segmentedSettings.selectedSegment

        for view in segmentViews {
            view.isHidden = true
        }

        segmentViews[selectedIndex].isHidden = false

        switch selectedIndex {
        case 0:
            setupGeneralTab()
        case 1:
            setupAdvancedTab()
        case 2:
            setupBindingsTab()
        case 3:
            setupUpdatesTab()
        case 4:
            setupCreditsTab()
        default:
            break
        }
    }

    
    @objc func segmentedViewDarkBlurLoad(){
        darkBlur = NSVisualEffectView(frame: self.view.bounds)
        darkBlur.material = .hudWindow
        darkBlur.blendingMode = .behindWindow
        darkBlur.material = .sidebar
        darkBlur.state = .active
    }
    
    @objc func setupGeneralTab(){
        segmentedViewDarkBlurLoad()
        segmentViews[0].wantsLayer = true
        segmentViews[0].layer?.borderWidth = 1
        segmentViews[0].layer?.borderColor = NSColor.white.cgColor
        segmentViews[0].layer?.cornerRadius = 10
        segmentViews[0].addSubview(darkBlur)
        
        generalTabHorizontalSeparator = NSBox()
        generalTabHorizontalSeparator.boxType = .separator
        generalTabHorizontalSeparator.borderColor = NSColor.white
        generalTabHorizontalSeparator.borderWidth = 1
        generalTabHorizontalSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        
        scrollViewGeneralTab = NSScrollView()
        scrollViewGeneralTab.documentView = generalOptionsView
        scrollViewGeneralTab.hasVerticalScroller = true
        
        maxNumberOfClipBoardDataParagraph = setupHorizontalView()
        
        maxNumberOfAllowedSavedClipBoardData = NSPopUpButton()
        maxNumberOfAllowedSavedClipBoardData.pullsDown = false
        for item in maxNumberOfClipBoardDataOptions {
            maxNumberOfAllowedSavedClipBoardData.addItem(withTitle: item)
        }
        maxNumberOfAllowedSavedClipBoardData.target = self
        maxNumberOfAllowedSavedClipBoardData.action = #selector(updateMaxNumberOfClipBoardSavedData)
        
        captionMaxNumber = setupLabel(content: "Clipboard saves limit")
        captionMaxNumber.toolTip = "Because of how MacOS and our app manages the pasteboard contents the more user saves the more junk can collect. Consider leaving it as it is or incresing for a needed range"
        
        maxNumberOfClipBoardDataParagraph.addArrangedSubview(captionMaxNumber)
        maxNumberOfClipBoardDataParagraph.addArrangedSubview(maxNumberOfAllowedSavedClipBoardData)
        
        generalOptionsView = NSStackView()
        generalOptionsView.spacing = 10
        generalOptionsView.orientation = .vertical
        generalOptionsView.distribution = .fill
        generalOptionsView.alignment = .leading
        generalOptionsView.translatesAutoresizingMaskIntoConstraints = false
        generalOptionsView.addArrangedSubview(maxNumberOfClipBoardDataParagraph)
        generalOptionsView.addArrangedSubview(generalTabHorizontalSeparator)
        
        segmentViews[0].addSubview(generalOptionsView)
        segmentViews[0].addSubview(scrollViewGeneralTab)
        
        NSLayoutConstraint.activate([
            generalOptionsView.topAnchor.constraint(equalTo: segmentViews[0].topAnchor, constant: 10),
            generalOptionsView.leadingAnchor.constraint(equalTo: segmentViews[0].leadingAnchor, constant: 10),
            generalOptionsView.trailingAnchor.constraint(equalTo: segmentViews[0].trailingAnchor, constant: -10),
            generalOptionsView.bottomAnchor.constraint(lessThanOrEqualTo: segmentViews[0].bottomAnchor, constant: -10)
        ])

        
    }
    
    @objc func setupAdvancedTab(){
        //segmentedViewDarkBlurLoad()
        let blur = NSVisualEffectView(frame: self.view.bounds)
           blur.material = .sidebar
           blur.blendingMode = .behindWindow
           blur.state = .active
        segmentViews[1].wantsLayer = true
        segmentViews[1].layer?.borderWidth = 1
        segmentViews[1].layer?.borderColor = NSColor.white.cgColor
        segmentViews[1].layer?.cornerRadius = 10
        segmentViews[1].addSubview(blur)
        
    }
    
    @objc func setupHorizontalView() -> NSStackView{
        var stack = NSStackView()
        stack.spacing = 6
        stack.orientation = .horizontal
        stack.distribution = .fill
        //stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }
    
    @objc func setupLabel(content: String) -> NSTextField{
        var label = NSTextField(string: content)
        label.textColor = .white
        label.isEditable = false
        label.isBezeled = false
        label.drawsBackground = false
        label.isSelectable = false
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    @objc func updateMaxNumberOfClipBoardSavedData(){
        let choice = maxNumberOfAllowedSavedClipBoardData.indexOfSelectedItem
        switch choice {
        case 0:
            if (GlobalDataModel.shared.clipBoardSavedItemsLimit == 10) {
                print("Ignore")
            } else {
                GlobalDataModel.shared.clipBoardSavedItemsLimit = 10
            }
        case 1:
            GlobalDataModel.shared.clipBoardSavedItemsLimit = 20
        case 2:
            GlobalDataModel.shared.clipBoardSavedItemsLimit = 30
        case 3:
            GlobalDataModel.shared.clipBoardSavedItemsLimit = 40
        case 4:
            GlobalDataModel.shared.clipBoardSavedItemsLimit = 50
        case 5:
            GlobalDataModel.shared.clipBoardSavedItemsLimit = 60
        case 6:
            GlobalDataModel.shared.clipBoardSavedItemsLimit = 70
        case 7:
            GlobalDataModel.shared.clipBoardSavedItemsLimit = 80
        case 8:
            GlobalDataModel.shared.clipBoardSavedItemsLimit = 90
        default:
        print("ERROR, cant update max clips")
        }
    }
    
    @objc func setupBindingsTab(){
  
    }

    @objc func setupUpdatesTab(){
  
    }
    
    @objc func setupCreditsTab(){
  
    }
    
}
