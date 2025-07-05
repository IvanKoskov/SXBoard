//
//  settingsViewController.swift
//  SXBoard
//
//  Created by Evan Matthew on 3/7/25.
//

import Foundation
import Cocoa

class SettingsViewController : NSViewController, NSWindowDelegate {
    
    var applicationDelegate: AppDelegate! // For accessing other SXBoard components
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
    var tabHorizontalSeparator: NSBox! //Visual
    var generalOptionsView: NSStackView!
    var scrollViewGeneralTab: NSScrollView!
    
    var maxNumberOfAllowedSavedClipBoardData: NSPopUpButton!
    var maxNumberOfClipBoardDataParagraph: NSStackView!
    var maxNumberOfClipBoardDataOptions: [String] = ["10 by default", "20", "30", "40", "50", "60", "70", "80", "90 max"]
    var captionMaxNumber: NSTextField!
    
    var showMainApplicationWindowParagraph: NSStackView!
    var captionMainApplicationVisability: NSTextField!
    var showMainApplicationWindowOptions: [String] = ["Default (Both menu and interface", "Only menu bar"]
    var showMainApplicationButton: NSPopUpButton!
    
    // Flags to prevent multiple UI recreation
    private var isGeneralTabLoaded = false
    private var isAdvancedTabLoaded = false
    private var isBindingsTabLoaded = false
    private var isUpdatesTabLoaded = false
    private var isCreditsTabLoaded = false
    
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
        guard !isGeneralTabLoaded else { return }
        isGeneralTabLoaded = true
        
        segmentedViewDarkBlurLoad()
        segmentViews[0].wantsLayer = true
        segmentViews[0].layer?.borderWidth = 1
        segmentViews[0].layer?.borderColor = NSColor.white.cgColor
        segmentViews[0].layer?.cornerRadius = 10
        segmentViews[0].addSubview(darkBlur)
        
        tabHorizontalSeparator = NSBox()
        tabHorizontalSeparator.boxType = .separator
        tabHorizontalSeparator.borderColor = NSColor.white
        tabHorizontalSeparator.borderWidth = 1
        tabHorizontalSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        
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
        
        showMainApplicationWindowParagraph = setupHorizontalView()
        
        showMainApplicationButton = NSPopUpButton()
        showMainApplicationButton.pullsDown = false
        for option in showMainApplicationWindowOptions {
            showMainApplicationButton.addItem(withTitle: option)
        }
        showMainApplicationButton.target = self
        showMainApplicationButton.action = #selector(updateShowMainApplication)
        
        captionMainApplicationVisability = setupLabel(content: "Control which interface is used")
        captionMainApplicationVisability.toolTip = "This option controls if SXBoard limits its own usability down to menu bar level or also allowing floating UI elements and custom windows with more content (Recommended for the full experience)"
        
        showMainApplicationWindowParagraph.addArrangedSubview(captionMainApplicationVisability)
        showMainApplicationWindowParagraph.addArrangedSubview(showMainApplicationButton)
        
        generalOptionsView = setupVerticalView()
        generalOptionsView.addArrangedSubview(maxNumberOfClipBoardDataParagraph)
        generalOptionsView.addArrangedSubview(showMainApplicationWindowParagraph)
        generalOptionsView.addArrangedSubview(tabHorizontalSeparator)
        
        segmentViews[0].addSubview(generalOptionsView)
        segmentViews[0].addSubview(scrollViewGeneralTab)
        
        NSLayoutConstraint.activate([
            generalOptionsView.topAnchor.constraint(equalTo: segmentViews[0].topAnchor, constant: 10),
            generalOptionsView.leadingAnchor.constraint(equalTo: segmentViews[0].leadingAnchor, constant: 10),
            generalOptionsView.trailingAnchor.constraint(equalTo: segmentViews[0].trailingAnchor, constant: -10),
            generalOptionsView.bottomAnchor.constraint(lessThanOrEqualTo: segmentViews[0].bottomAnchor, constant: -10)
        ])

        asLoadedsetupAllInitialGeneralTabUI()
    }
    
    @objc func setupAdvancedTab(){
        guard !isAdvancedTabLoaded else { return }
        isAdvancedTabLoaded = true
        
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
    
    @objc func setupBindingsTab(){
        guard !isBindingsTabLoaded else { return }
        isBindingsTabLoaded = true
        
        
    }
    
    @objc func setupUpdatesTab(){
        guard !isUpdatesTabLoaded else { return }
        isUpdatesTabLoaded = true
        
       
    }
    
    @objc func setupCreditsTab(){
        guard !isCreditsTabLoaded else { return }
        isCreditsTabLoaded = true
        
        
    }
    
    @objc func setupVerticalView() -> NSStackView {
        let stack = NSStackView()
        stack.spacing = 10
        stack.orientation = .vertical
        stack.distribution = .fill
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }
    
    @objc func setupHorizontalView() -> NSStackView{
        let stack = NSStackView()
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
    
    @objc func updateShowMainApplication(){
        let choice = showMainApplicationButton.indexOfSelectedItem
        switch choice {
        case 0:
            applicationDelegate.statusBarMainApplication.button?.isHidden = false
            GlobalDataModel.shared.showMainApplicationOptional = 0
        case 1:
            applicationDelegate.statusBarMainApplication.button?.isHidden = true
            GlobalDataModel.shared.showMainApplicationOptional = 1
        default:
            print("ERROR")
        }
    }
    
    @objc func asLoadedsetupAllInitialGeneralTabUI(){
        // Makes sure UI also reflects loaded contents from last boot via UserDefaults
        // We retrive all of those from global data model in sequance and manually update all of them
        
        if (GlobalDataModel.shared.showMainApplicationOptional == 0){
            showMainApplicationButton.selectItem(at: 0)
        } else {
            showMainApplicationButton.selectItem(at: 1)
            applicationDelegate.statusBarMainApplication.button?.isHidden = true
        }
        
        switch GlobalDataModel.shared.clipBoardSavedItemsLimit {
        case 10:
            maxNumberOfAllowedSavedClipBoardData.selectItem(at: 0)
        case 20:
            maxNumberOfAllowedSavedClipBoardData.selectItem(at: 1)
        case 30:
            maxNumberOfAllowedSavedClipBoardData.selectItem(at: 2)
        case 40:
            maxNumberOfAllowedSavedClipBoardData.selectItem(at: 3)
        case 50:
            maxNumberOfAllowedSavedClipBoardData.selectItem(at: 4)
        case 60:
            maxNumberOfAllowedSavedClipBoardData.selectItem(at: 5)
        case 70:
            maxNumberOfAllowedSavedClipBoardData.selectItem(at: 6)
        case 80:
            maxNumberOfAllowedSavedClipBoardData.selectItem(at: 7)
        case 90:
            maxNumberOfAllowedSavedClipBoardData.selectItem(at: 8)
        default:
            print("ERROR: could not set UI for max clips in settings")
        }

        
        
    }
    
}
