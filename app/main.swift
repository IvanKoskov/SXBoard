import Cocoa
import Foundation


let Application = NSApplication.shared
let delegate = AppDelegate()
Application.delegate = delegate
Application.setActivationPolicy(.accessory)
Application.activate(ignoringOtherApps: true)
Application.run()
