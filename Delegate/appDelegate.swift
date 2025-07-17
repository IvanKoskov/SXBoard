import Cocoa
import HotKey

class AppDelegate: NSObject, NSApplicationDelegate{
    //"Hot keys"
    var openMainWindowFromBackgroundGlobally: HotKey!
    var openSettingsWindowFromBackgroundGlobally: HotKey!
    //UI
    var settingsWindow: WindowSettings!
    var greetWindow: NSWindow!
    var greetingViewController: GreetingController!
    var mainWindow: Window!
    var mainWindowViewController: MainViewController!
    var menu: NSMenu! //Main menu object that holds everything that is located left on menu bar for a specific app
    var appMenu: NSMenuItem!
    var SXBoardMenu: NSMenu! //Submenu of the menu
    var quitMenuItem: NSMenuItem! //Located in SXBoardMenu
    var statusBar: NSStatusBar!
    var statusBarMainApplication: NSStatusItem!
    var statusBarOnlyApplicationModule: NSStatusItem!
    var statusBarMenu: NSMenu!
    var statusBarMenuItemSettings: NSMenuItem!
    var statusBarMenuItemAboutSXBoard: NSMenuItem!
    var statusBarMenuItemDonations: NSMenuItem!
    var statusBarMenuItemWipeClipsHistory: NSMenuItem!
    
    // Data
    var dataManagement: DataManager!
    
    var infoHUD: HUD!

    func applicationDidFinishLaunching(_ notification: Notification) {
        dataManagement = DataManager()
        dataManagement.loadData()
        print(GlobalDataModel.shared.clipBoardItems)
        print(GlobalDataModel.shared.clipBoardItems.count)


        setupStatusBar()
        setupMenu()
        loadHUD()
        onLaunch()

    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        true
    }
    
    func onLaunch(){
        openMainWindowFromBackgroundGlobally = HotKey(key: .m, modifiers: [.command, .option])
        openMainWindowFromBackgroundGlobally.keyDownHandler = loadMainWindow
        openSettingsWindowFromBackgroundGlobally = HotKey(key: .s, modifiers: [.command, .option])
        openSettingsWindowFromBackgroundGlobally.keyDownHandler = loadSettings
      
        
        let file = File(fileName: ".sxboardlog", pathAt: homeDir().absoluteString)
        let record  = file.createPlaneConfigFile()
        switch record {
        case false:
            betaAlert()
            loadWelcome()
            break;
        case true:
            print("Skipping welcome")
            break;
        }
    }
    
    @objc func loadWelcome(){
        greetingViewController = GreetingController()
        greetWindow = NSWindow(
            contentRect: NSMakeRect(0, 0, 440, 440),
            styleMask: [.borderless, .resizable],
            backing: .buffered,
            defer: false
        )
        greetWindow.delegate = greetingViewController
        greetWindow.center()
        greetWindow.collectionBehavior = [.canJoinAllSpaces]
        greetWindow.titleVisibility = .hidden
        greetWindow.level = .statusBar
        greetWindow.backgroundColor = .clear
        greetWindow.isMovableByWindowBackground = true
        greetWindow.orderFrontRegardless()
        greetWindow.hasShadow = true
        greetWindow.title = "Hello SXBoard"
        greetWindow.identifier = NSUserInterfaceItemIdentifier("welcome")
        print(greetWindow.identifier?.rawValue ?? "no-id")
        greetWindow.contentViewController = greetingViewController
        greetWindow.makeKeyAndOrderFront(nil)
    }
    
    func setupMenu(){
        menu = NSMenu()
        appMenu = NSMenuItem()
        menu.addItem(appMenu)
        
        SXBoardMenu = NSMenu(title: "SXBoard")
        quitMenuItem = NSMenuItem(title: "Finish session", action: #selector(exit), keyEquivalent: "q")
        SXBoardMenu.addItem(quitMenuItem)
        
        appMenu.submenu = SXBoardMenu
        
        NSApplication.shared.mainMenu = menu
    }
    
    func setupStatusBar(){
        
        statusBar = NSStatusBar()
        statusBarMainApplication = statusBar.statusItem(withLength: -1)
        statusBarOnlyApplicationModule = statusBar.statusItem(withLength: 36)
        statusBarOnlyApplicationModule.button?.image?.size = NSSize(width: 15, height: 15)
       // statusBarOnlyApplicationModule.button?.image = NSImage(systemSymbolName: "gearshape.fill", accessibilityDescription: nil)
        statusBarOnlyApplicationModule.button?.image = NSImage(systemSymbolName: "paperclip.badge.ellipsis", accessibilityDescription: nil)
        statusBarOnlyApplicationModule.button?.imagePosition = .imageOnly
        statusBarOnlyApplicationModule.button?.action = nil
        statusBarOnlyApplicationModule.isVisible = true
        statusBarOnlyApplicationModule.button?.title = ""
        
        statusBarMenu = NSMenu()
        statusBarMenuItemSettings = NSMenuItem(title: "Global settings", action: #selector(loadSettings), keyEquivalent: "s")
        statusBarMenu.addItem(statusBarMenuItemSettings)
        statusBarMenu.addItem(NSMenuItem.separator())
        statusBarMenuItemAboutSXBoard = NSMenuItem(title: "About SXBoard...", action: nil, keyEquivalent: "")
        statusBarMenu.addItem(statusBarMenuItemAboutSXBoard)
        statusBarMenuItemDonations = NSMenuItem(title: "Donate ♡", action: nil, keyEquivalent: "")
        statusBarMenu.addItem(statusBarMenuItemDonations)
        statusBarMenuItemWipeClipsHistory = NSMenuItem(title: "Wipe all the clips", action: #selector(wipeHistory), keyEquivalent: "")
        statusBarMenu.addItem(statusBarMenuItemWipeClipsHistory)
        
        
        statusBarOnlyApplicationModule.menu = statusBarMenu
        
        statusBarMainApplication.button?.image = NSImage.sxboard
        statusBarMainApplication.button?.imagePosition = .imageOnly
        statusBarMainApplication.button?.image?.size = NSSize(width: 15, height: 15)
        statusBarMainApplication.button?.action = #selector(loadMainWindow)
        statusBarMainApplication.button?.title = ""
        statusBarMainApplication.isVisible = true
        if (GlobalDataModel.shared.showMainApplicationOptional == 0){
            statusBarMainApplication.isVisible = true
        } else if (GlobalDataModel.shared.showMainApplicationOptional == 1) {
            statusBarMainApplication.isVisible = false
        }
        
        
       // menu.addItem(statusBarMainApplication)
        
    }
    
    @objc private func exit(){ exitAlert() }
    
    
    @objc func loadMainWindow(){
        
        if mainWindow == nil {
            
            let mainController = MainViewController()
            let rect = Window.snapTo(.topRightCorner)
            mainWindow = Window(
                contentRect: rect,
                styleMask: [.borderless, .resizable],
                backing: .buffered,
                defer: false
            )
            
            mainWindow.delegate = mainController
            //mainWindow.center()
            
            mainWindow.collectionBehavior = [.canJoinAllSpaces]
            mainWindow.titleVisibility = .hidden
            mainWindow.level = .statusBar
            mainWindow.backgroundColor = .clear
            mainWindow.isMovableByWindowBackground = false
            mainWindow.orderFrontRegardless()
            mainWindow.hasShadow = true
            mainWindow.title = "SXBoard"
            mainWindow.contentViewController = mainController
            mainWindow.makeKeyAndOrderFront(nil)
            mainWindow.identifier = NSUserInterfaceItemIdentifier("mainwin")
            print(mainWindow.identifier?.rawValue ?? "no-id")
        }
        else {
            mainWindow.makeKeyAndOrderFront(nil)
        }
        
    }
    
    func loadHUD(){
        if infoHUD == nil {
            let hudController = WatermarkViewController()
            infoHUD = HUD(contentR: NSRect(x: 6, y:820, width: 340, height: 40), delegate: hudController, viewController: hudController)
        }else {
            infoHUD.showWindowIfWasClosed()
        }
        }
    
    @objc func loadSettings(){
        if settingsWindow == nil {
            let settingsController: SettingsViewController = SettingsViewController()
            settingsController.applicationDelegate = self
            settingsWindow = WindowSettings(contentR: NSRect(x: 0, y: 800, width: 500, height: 400), delegate: settingsController, viewController: settingsController)
            
        } else {
            settingsWindow.showWindowIfWasClosed()
        }
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        dataManagement.saveData()
    }
    
    @objc func wipeHistory(){
        GlobalDataModel.shared.wipeClipsHistory()
    }

}
