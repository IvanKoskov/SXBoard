import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    var greetWindow: NSWindow!
    var greetingViewController: GreetingController!

    func applicationDidFinishLaunching(_ notification: Notification) {
        
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
    
    func loadWelcome(){
        greetingViewController = GreetingController()
        greetWindow = NSWindow(
            contentRect: NSMakeRect(0, 0, 400, 400),
            styleMask: [.borderless, .resizable],
            backing: .buffered,
            defer: false
        )

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

}
