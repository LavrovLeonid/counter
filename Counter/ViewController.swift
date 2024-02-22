//
//  ViewController.swift
//  Counter
//
//  Created by Леонид Лавров on 2/22/24.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Properties
    
    var counter = Counter() {
        didSet {
            updateUI()
        }
    }
    
    // MARK: Outlets

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var historyTextViewLabel: UITextView!
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    // MARK: Private API
    
    private func updateUI() {
        countLabel.text = counter.countDisplayText
        historyTextViewLabel.text = "История изменений:\n\(counter.getHistoryDisplayText())"
        
        
        let scrollY = historyTextViewLabel.contentSize.height - historyTextViewLabel.bounds.size.height
        
        if scrollY > 0 {
            historyTextViewLabel.setContentOffset(.init(x: 0, y: scrollY), animated: false)
        }
    }
    
    // MARK: Actions
    
    @IBAction private func onClickIncrement() {
        counter.increment()
    }
    
    @IBAction private func onClickDecrement() {
        counter.decrement()
    }
    
    @IBAction private func onClickReset() {
        counter.reset()
    }
}

