import Cocoa

class GreetingController: NSViewController {
    var logoButton: NSButton!
    var logo: NSImage!
    var subViewOrderedGreetingTitle: NSStackView!
    var visualSeparator: NSBox!
    var secondVisualSeparator: NSBox!
    var viewGreet: NSView!
    var closeGreeting: NSButton!
    var orderedGreetingView: NSStackView!  // Holds the title and basically is the greeting
    var greetingTitle: NSTextField!
    var orderedFirstLineView: NSStackView!  // Holds first sentence and contents of the first line
    var firstSentence: NSTextField!
    var orderedSecondLineView: NSStackView!
    var secondSentence: NSTextField!
    var thirdSentence: NSTextField!
    var orderedThirdLineView: NSStackView!
    var fourthSentence: NSTextField!
    var orderedFourthLineView: NSStackView!
    var thirdVisualSeparator: NSBox!
    var fourthVisualSeparator: NSBox!
    var developedByView: NSStackView!

    override func loadView() {
        viewGreet = NSView()
        viewGreet.frame = NSRect(x: 0, y: 0, width: 400, height: 400)
        viewGreet.wantsLayer = true
        viewGreet.layer?.backgroundColor = NSColor.white.cgColor
        viewGreet.layer?.cornerRadius = 15
        self.view = viewGreet

        let blurView = NSVisualEffectView(frame: self.view.bounds)
        blurView.autoresizingMask = [.width, .height]  // resizes with window
        blurView.blendingMode = .behindWindow
        if #available(macOS 10.14, *) {
            blurView.material = .hudWindow
        } else {
            blurView.material = .sidebar
        }
        blurView.state = .active

        self.view.addSubview(blurView)

        if let image = NSImage(systemSymbolName: "xmark", accessibilityDescription: "") {
            closeGreeting = NSButton(image: image, target: self, action: #selector(closingGreeting))
        } else {
            print("Image 'xmark' not found, using fallback.")
            closeGreeting = NSButton(title: "X", target: self, action: #selector(closingGreeting))
        }
        closeGreeting.isBordered = false
        closeGreeting.frame = NSRect(x: 375, y: 375, width: 20, height: 20)
        closeGreeting.autoresizingMask = [.minXMargin, .minYMargin]
        
        subViewOrderedGreetingTitle = NSStackView()
        subViewOrderedGreetingTitle.orientation = .horizontal
        subViewOrderedGreetingTitle.alignment = .centerY
        subViewOrderedGreetingTitle.distribution = .fill
        subViewOrderedGreetingTitle.spacing = 10
        subViewOrderedGreetingTitle.translatesAutoresizingMaskIntoConstraints = false

        orderedGreetingView = NSStackView()
        orderedGreetingView.orientation = .vertical
        orderedGreetingView.alignment = .leading
        orderedGreetingView.distribution = .fill
        orderedGreetingView.spacing = 10
        orderedGreetingView.translatesAutoresizingMaskIntoConstraints = false
        
        if let logo = NSImage(named: "sxboard") {
            logoButton = NSButton(image: logo, target: self, action: #selector(visitGitHubSXBoard))
            logoButton.isBordered = false
            logoButton.translatesAutoresizingMaskIntoConstraints = false
        } else {
            // fallback button if image missing
            logoButton = NSButton(title: "Logo", target: self, action: #selector(visitGitHubSXBoard))
            logoButton.isBordered = false
            logoButton.translatesAutoresizingMaskIntoConstraints = false
        }

        greetingTitle = NSTextField(string: "Welcome SXBoard!")
        greetingTitle.isEditable = false
        greetingTitle.isBezeled = false
        greetingTitle.drawsBackground = false
        greetingTitle.textColor = .white
        greetingTitle.isSelectable = true
        greetingTitle.font = .systemFont(ofSize: 25, weight: .bold)

        subViewOrderedGreetingTitle.addArrangedSubview(logoButton)
        subViewOrderedGreetingTitle.addArrangedSubview(greetingTitle)
        subViewOrderedGreetingTitle.setCustomSpacing(30, after: logoButton)
        

      //  orderedGreetingView.addArrangedSubview(subViewOrderedGreetingTitle)

        orderedFirstLineView = NSStackView()
        orderedFirstLineView.orientation = .horizontal
        orderedFirstLineView.spacing = 10
        orderedFirstLineView.distribution = .fill
        orderedFirstLineView.translatesAutoresizingMaskIntoConstraints = false
        orderedFirstLineView.alignment = .leading

        firstSentence = NSTextField(string: "Starting to use it as a your main clipboard manager!")
        firstSentence.textColor = .white
        firstSentence.isEditable = false
        firstSentence.isBezeled = false
        firstSentence.drawsBackground = false
        firstSentence.isSelectable = true
        firstSentence.font = .systemFont(ofSize: 11, weight: .bold)

        orderedFirstLineView.addArrangedSubview(firstSentence)
        orderedGreetingView.addArrangedSubview(orderedFirstLineView)
        //orderedGreetingView.setCustomSpacing(20, after: subViewOrderedGreetingTitle)
        self.view.addSubview(subViewOrderedGreetingTitle)

        visualSeparator = NSBox()
        visualSeparator.boxType = .separator
        visualSeparator.translatesAutoresizingMaskIntoConstraints = false
        orderedGreetingView.addArrangedSubview(visualSeparator)

        orderedSecondLineView = NSStackView()
        orderedSecondLineView.orientation = .horizontal
        orderedSecondLineView.spacing = 10
        orderedSecondLineView.distribution = .fill
        orderedSecondLineView.translatesAutoresizingMaskIntoConstraints = false
        orderedSecondLineView.alignment = .leading

        secondSentence = NSTextField(
            string: "• Fast access to saved clips from anywhere on the Mac!")
        secondSentence.textColor = .white
        secondSentence.isEditable = false
        secondSentence.isBezeled = false
        secondSentence.drawsBackground = false
        secondSentence.isSelectable = true
        secondSentence.font = .systemFont(ofSize: 15)

        orderedSecondLineView.addArrangedSubview(secondSentence)
        orderedGreetingView.addArrangedSubview(orderedSecondLineView)

        secondVisualSeparator = NSBox()
        secondVisualSeparator.boxType = .separator
        secondVisualSeparator.translatesAutoresizingMaskIntoConstraints = false
        orderedGreetingView.addArrangedSubview(secondVisualSeparator)
        
        thirdSentence = NSTextField(
            string: "• Menu bar centered interface with global access")
        thirdSentence.textColor = .white
        thirdSentence.isEditable = false
        thirdSentence.isBezeled = false
        thirdSentence.drawsBackground = false
        thirdSentence.isSelectable = true
        thirdSentence.font = .systemFont(ofSize: 15)
        
        orderedThirdLineView = NSStackView()
        orderedThirdLineView.orientation = .horizontal
        orderedThirdLineView.alignment = .leading
        orderedThirdLineView.spacing = 10
        orderedThirdLineView.translatesAutoresizingMaskIntoConstraints = false
        orderedThirdLineView.distribution = .fill
        
        orderedThirdLineView.addArrangedSubview(thirdSentence)
        orderedGreetingView.addArrangedSubview(orderedThirdLineView)
        
        thirdVisualSeparator = NSBox()
        thirdVisualSeparator.boxType = .separator
        thirdVisualSeparator.translatesAutoresizingMaskIntoConstraints = false
        orderedGreetingView.addArrangedSubview(thirdVisualSeparator)
        
        fourthSentence = NSTextField(
            string: "• Intuitive design aimed to integrate into your workflow")
        fourthSentence.textColor = .white
        fourthSentence.isEditable = false
        fourthSentence.isBezeled = false
        fourthSentence.drawsBackground = false
        fourthSentence.isSelectable = true
        fourthSentence.font = .systemFont(ofSize: 15)
        
        orderedFourthLineView = NSStackView()
        orderedFourthLineView.orientation = .horizontal
        orderedFourthLineView.alignment = .leading
        orderedFourthLineView.spacing = 10
        orderedFourthLineView.translatesAutoresizingMaskIntoConstraints = false
        orderedFourthLineView.distribution = .fill
        
        orderedFourthLineView.addArrangedSubview(fourthSentence)
        orderedGreetingView.addArrangedSubview(orderedFourthLineView)
        
        fourthVisualSeparator = NSBox()
        fourthVisualSeparator.boxType = .separator
       // fourthVisualSeparator.translatesAutoresizingMaskIntoConstraints = false
        orderedGreetingView.addArrangedSubview(fourthVisualSeparator)
        
        orderedGreetingView.setCustomSpacing(35, after: orderedFourthLineView)
        
        developedByView = NSStackView()

        self.view.addSubview(orderedGreetingView)
        self.view.addSubview(closeGreeting)

        // Constraints
        NSLayoutConstraint.activate([
            subViewOrderedGreetingTitle.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: 45),
            subViewOrderedGreetingTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            
            orderedGreetingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 10),
            orderedGreetingView.centerYAnchor.constraint(equalTo: self.view.topAnchor, constant: 170),

            visualSeparator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 14),
            visualSeparator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -14),

            secondVisualSeparator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 14),
            secondVisualSeparator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -14),
            
            thirdVisualSeparator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 14),
            thirdVisualSeparator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -14),
            
            fourthVisualSeparator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 14),
            fourthVisualSeparator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -14),
            
            
            // Logo button size
            logoButton.widthAnchor.constraint(equalToConstant: 40),
            logoButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    @objc func closingGreeting() {
        self.view.window?.close()
    }

    @objc func visitGitHubSXBoard(){
        let url = URL(string:"https://github.com/IvanKoskov/SXBoard")!
        NSWorkspace.shared.open([url],
                               withAppBundleIdentifier:"com.apple.Safari",
                               options: [],
                               additionalEventParamDescriptor: nil,
                               launchIdentifiers: nil)
    }
}

