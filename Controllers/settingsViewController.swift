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
    var tabNames: [(String, String)] = [("General", "gearshape.fill"), ("Advanced", "wrench.and.screwdriver"), ("Bindings", "text.and.command.macwindow"), ("Updates", "arrow.trianglehead.clockwise"), ("Credits", "person")]

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

        for (index, view) in segmentViews.enumerated() {
            view.isHidden = index != selectedIndex
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
        segmentViews[0].layer?.borderWidth = 2
        segmentViews[0].layer?.borderColor = NSColor.white.cgColor
        segmentViews[0].layer?.cornerRadius = 10
        segmentViews[0].addSubview(darkBlur)
    }

    
}
