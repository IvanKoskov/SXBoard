import Cocoa
import HotKey

class AppDelegate: NSObject, NSApplicationDelegate{
    //"Hot keys"
    var openMainWindowFromBackgroundGlobally: HotKey!

    //UI
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

    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        true
    }
    
    func onLaunch(){
        openMainWindowFromBackgroundGlobally = HotKey(key: .m, modifiers: [.command, .option])
        openMainWindowFromBackgroundGlobally.keyDownHandler = loadMainWindow
        
        let file = File(fileName: ".sxboardlog", pathAt: homeDir().absoluteString)
        let record  = file.createPlaneConfigFile()
        switch record {
        case false:
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
            contentRect: NSMakeRect(0, 0, 420, 420),
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
        
        if mainWindow == nil {
            
            let mainController = MainViewController()
            
            mainWindow = Window(
                contentRect: NSMakeRect(0, 0, 400, 300),
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
        }
        else {
            mainWindow.makeKeyAndOrderFront(nil)
        }
        
    }


}
