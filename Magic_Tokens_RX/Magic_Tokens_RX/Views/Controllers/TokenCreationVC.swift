//
//  TokenCreationVC.swift
//  Magic_Tokens_RX
//
//  Created by Jackson Ho on 11/10/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit

class TokenCreationVC: UIViewController {
    private var prefixTree: PrefixTree = premadePrefixTree
    private var timer = Timer()
    var selectedColor: [UIColor] = []
    var coordinator: MainCoordinator?
    var autocompleteCharaterCount = 0
    // MARK: - Custom UIs
    private let tokenHousing = TokenHousingView(frame: .zero)
    private let colorButtonStack = ColorStackView(frame: .zero)
    private let statsButton = StatsButton(frame: .zero)
    // add stat button
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        setupTokenHousing()
        setupStatsButton()
        setupColorStackView()
        setupNavBar()
    }
}

// MARK: - Setup UIs
extension TokenCreationVC {
    private func setupTokenHousing() {
        view.addSubview(tokenHousing)
        tokenHousing.textField.delegate = self
        NSLayoutConstraint.activate([
            tokenHousing.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tokenHousing.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tokenHousing.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            tokenHousing.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3)
        ])
    }
    
    private func setupStatsButton() {
        view.addSubview(statsButton)
        NSLayoutConstraint.activate([
            statsButton.topAnchor.constraint(equalTo: tokenHousing.bottomAnchor, constant: -10),
            statsButton.trailingAnchor.constraint(equalTo: tokenHousing.trailingAnchor, constant: -20),
            statsButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 15)
        ])
    }
    
    private func setupColorStackView() {
        view.addSubview(colorButtonStack)
        NSLayoutConstraint.activate([
            colorButtonStack.topAnchor.constraint(equalTo: statsButton.bottomAnchor, constant: 30),
            colorButtonStack.leadingAnchor.constraint(equalTo: tokenHousing.leadingAnchor, constant: 0),
            colorButtonStack.trailingAnchor.constraint(equalTo: tokenHousing.trailingAnchor, constant: 0)
            ])
        
        view.layoutSubviews()
        let sideInsets = view.layoutMargins.right * 2
        let buttonHeight = (tokenHousing.bounds.width - (80 + sideInsets)) / 5
        colorButtonStack.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
    }
    
    private func setupNavBar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissAndUpdate))
        navigationItem.rightBarButtonItem = doneButton
    }
}

// MARK: - OBJC Functions
extension TokenCreationVC {
    @objc private func dismissAndUpdate() {
        if let text = self.tokenHousing.textField.text {
            prefixTree.updateUserWeight(word: text)
        }
        coordinator?.navigationController.popViewController(animated: true)
    }
}

// MARK: - TextField Delegate
extension TokenCreationVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { //1
        var subString = (textField.text!.capitalized as NSString).replacingCharacters(in: range, with: string) // 2
        subString = formatSubstring(subString: subString)
        
        if subString.isEmpty { // 3 when a user clears the textField
            resetValues()
        } else {
            autoCompleteWithSubstring(substring: subString)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            let attributeText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            self.tokenHousing.textField.attributedText = attributeText
            autocompleteCharaterCount = text.count
        }
        
        return true
    }
    
    private func formatSubstring(subString: String) -> String {
        let formatted = String(subString.dropLast(autocompleteCharaterCount)).lowercased().capitalized //5
        return formatted
    }
    
    private func resetValues() {
        autocompleteCharaterCount = 0
        self.tokenHousing.textField.text = ""
    }
    
    private func autoCompleteWithSubstring(substring: String) {
        prefixTree.autoCompleteOne(currentString: substring, completion: { result in
            switch result {
            case .success(let string):
                self.timer = .scheduledTimer(withTimeInterval: 0.01, repeats: false, block: { _ in
                    print(string)
                    let formattedAutoCompleted = self.formatAutoResult(substring: substring, result: string)
                    self.putColourFormattedTextInTextField(autocompleteResult: formattedAutoCompleted, userQuery: substring)
                    self.moveCaretToEndOfUserQueryPosition(userQuery: substring)
                })
                
            case .failure(let error):
                #if DEBUG
                print(error.localizedDescription)
                #endif
                self.timer = .scheduledTimer(withTimeInterval: 0.01, repeats: false, block: { (_) in
                    DispatchQueue.main.async {
                        self.tokenHousing.textField.text = substring
                        self.autocompleteCharaterCount = 0
                    }
                })
            }
        })
    }
    
    private func putColourFormattedTextInTextField(autocompleteResult: String, userQuery: String) {
        let colouredString: NSMutableAttributedString = NSMutableAttributedString(string: userQuery + autocompleteResult)
        colouredString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: NSRange(location: userQuery.count, length: autocompleteResult.count))
        self.tokenHousing.textField.attributedText = colouredString
    }
    
    private func moveCaretToEndOfUserQueryPosition(userQuery: String) {
        if let newPosition = self.tokenHousing.textField.position(from: self.tokenHousing.textField.beginningOfDocument, offset: userQuery.count) {
            self.tokenHousing.textField.selectedTextRange = self.tokenHousing.textField.textRange(from: newPosition, to: newPosition)
        }
        let selectedRange: UITextRange? = self.tokenHousing.textField.selectedTextRange
        self.tokenHousing.textField.offset(from: self.tokenHousing.textField.beginningOfDocument, to: (selectedRange?.start)!)
    }
    
    private func formatAutoResult(substring: String, result: String) -> String {
        // This function remove the number of character at the front of the autocomplete result string for concatenating
        var autoCompleteResult = result
        autoCompleteResult.removeSubrange(autoCompleteResult.startIndex ..< autoCompleteResult.index(autoCompleteResult.startIndex, offsetBy: substring.count))
        autocompleteCharaterCount = autoCompleteResult.count
        return autoCompleteResult
    }
}
