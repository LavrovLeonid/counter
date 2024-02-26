//
//  ViewController.swift
//  Counter
//
//  Created by Леонид Лавров on 2/22/24.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Properties
    
    private var counter = Counter()
    
    // MARK: Outlets

    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var historyTextView: UITextView!
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counter.delegate = self
        
        updateUI()
    }
    
    // MARK: Private API
    
    private func updateUI() {
        countLabel.text = counter.countDisplayText
        historyTextView.text = "История изменений:\n\(counter.getHistoryDisplayText())"
        
        let scrollY = historyTextView.contentSize.height - historyTextView.bounds.size.height
        
        if scrollY > 0 {
            historyTextView.setContentOffset(.init(x: 0, y: scrollY), animated: false)
        }
    }
    
    // MARK: Actions
    
    @IBAction private func incrementButtonTapped() {
        counter.increment()
    }
    
    @IBAction private func decrementButtonTapped() {
        counter.decrement()
    }
    
    @IBAction private func resetButtonTapped() {
        counter.reset()
    }
}

extension ViewController: CounterDelegate {
    func counterDidChange() {
        updateUI()
    }
}
