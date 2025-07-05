import Cocoa
import Foundation
/*
   _____  _  __    ____                               __
  / ___/ | |/ /   / __ )  ____   ____ _   _____  ____/ /
  \__ \  |   /   / __  | / __ \ / __ `/  / ___/ / __  /
 ___/ / /   |   / /_/ / / /_/ // /_/ /  / /    / /_/ /
/____/ /_/|_|  /_____/  \____/ \__,_/  /_/     \__,_/
 By Ivan Koskov (Evan Matthew)
 SXMac © 2025 by Ivan Koskov (aka Evan Matthew) is licensed under BSD 3-Clause License
*/

let Application = NSApplication.shared
let delegate = AppDelegate()
Application.delegate = delegate
Application.setActivationPolicy(.accessory)
Application.activate(ignoringOtherApps: true)


Application.run()
