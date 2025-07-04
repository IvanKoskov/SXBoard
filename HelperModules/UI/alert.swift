//
//  alert.swift
//  SXBoard
//
//  Created by Evan Matthew on 3/7/25.
//

import Foundation
import AppKit

func exitAlert(){
    var alert: NSAlert = NSAlert()
    alert.icon = NSImage(systemSymbolName: "exclamationmark.triangle", accessibilityDescription: nil)
    alert.addButton(withTitle: "Exit anyway")
    alert.addButton(withTitle: "Back")
    alert.messageText = "SXBoard is about to terminate!"
    alert.informativeText = "The clipboard manager will not be able to save any of the data related to your clips, saved texts or anything else that was managed by SXBoard due to complete app termination. However the settings are going to be saved.  Are u sure to proceed?"
    
    let choice = alert.runModal()
    
    switch choice {
    case NSApplication.ModalResponse.alertFirstButtonReturn:
        NSApplication.shared.terminate(nil)
    case NSApplication.ModalResponse.alertSecondButtonReturn:
        print("Canceled")
    default:
        print("ERROR")
    }
}

func betaAlert(){
    var alert: NSAlert = NSAlert()
    alert.addButton(withTitle: "Exit")
    alert.addButton(withTitle: "Continue")
    alert.addButton(withTitle: "GitHub Issues")
    alert.messageText = "SXBoard is in development"
    alert.informativeText = "Currently you are using 1.0.0 ARM dev build of SXBoard that is not intended to be fully used in public. If you observed any bugs, problems please report them on our GitHub or contact support."
    
    let choice = alert.runModal()
    
    switch choice {
    case NSApplication.ModalResponse.alertFirstButtonReturn:
        NSApplication.shared.terminate(nil)
    case NSApplication.ModalResponse.alertSecondButtonReturn:
        print("Proceed")
    case NSApplication.ModalResponse.alertThirdButtonReturn:
        let url = URL(string:"https://github.com/IvanKoskov/SXBoard/issues")!
        NSWorkspace.shared.open([url],
                               withAppBundleIdentifier:"com.apple.Safari",
                               options: [],
                               additionalEventParamDescriptor: nil,
                               launchIdentifiers: nil)
    default:
        print("ERROR")
    }
}

func limitIsOver(){
    var alert: NSAlert = NSAlert()
    alert.icon = NSImage(systemSymbolName: "exclamationmark.triangle", accessibilityDescription: nil)
    alert.addButton(withTitle: "Proceed")
    alert.messageText = "Invalid limiting"
    alert.informativeText = "Clipboard's limiter capacity that was selected by user in SXBoard settings does not match the actual count of clips. In this case all old (in order of creation) clips will be removed freeing space."
    
    let choice = alert.runModal()
    
    switch choice {
    case NSApplication.ModalResponse.alertFirstButtonReturn:
        print("Notified")
    default:
        print("ERROR")
    }
}

