import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate{

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

    func applicationDidFinishLaunching(_ notification: Notification) {
        setupStatusBar()
        setupMenu()
        
        onLaunch()
        
        loadWelcome()

    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        true
    }
    
    private func onLaunch(){
        let file = File(fileName: ".sxboardlog", pathAt: homeDir().absoluteString)
        let _  = file.createPlaneConfigFile()
    }
    
    @objc func loadWelcome(){
        greetingViewController = GreetingController()
        greetWindow = NSWindow(
            contentRect: NSMakeRect(0, 0, 400, 400),
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
        
        statusBarMainApplication.button?.image = NSImage.sxboard
        statusBarMainApplication.button?.imagePosition = .imageOnly
        statusBarMainApplication.button?.image?.size = NSSize(width: 15, height: 15)
        statusBarMainApplication.button?.action = #selector(loadMainWindow)
        statusBarMainApplication.button?.title = ""
        statusBarMainApplication.isVisible = true
       // menu.addItem(statusBarMainApplication)
        
    }
    
    @objc private func exit(){
        NSApplication.shared.terminate(self)
    }
    
    
    @objc func loadMainWindow(){
        
        let mainController = MainViewController()
        
        mainWindow = Window(
            contentRect: NSMakeRect(0, 0, 400, 300),
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        
        mainWindow.delegate = mainController
        mainWindow.center()
        mainWindow.collectionBehavior = [.canJoinAllSpaces]
        mainWindow.titleVisibility = .hidden
        mainWindow.level = .statusBar
        mainWindow.backgroundColor = .clear
        mainWindow.isMovableByWindowBackground = true
        mainWindow.orderFrontRegardless()
        mainWindow.hasShadow = true
        mainWindow.title = "SXBoard"
        mainWindow.contentViewController = mainController
        mainWindow.makeKeyAndOrderFront(nil)
        
        
    }


}
