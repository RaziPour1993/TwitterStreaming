//
//  RuleTableViewCell.swift
//  TwitterStreaming
//
//  Created by Mohammad on 6/2/22.
//

import UIKit

protocol RuleTableViewCellDelegate: AnyObject {
    func didTapDeleteRule()
}

class RuleTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    weak var delegate: RuleTableViewCellDelegate?
    
    var rule: RuleCellViewModel? {
        didSet {
            guard let model = self.rule else {
                return
            }
            
            self.tagLabel.text = "Tag: \(model.tag)"
            self.valueLabel.text = "Value: \(model.value)"
            model.viewUpdateDelegate = self
            self.delegate = model
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        self.delegate?.didTapDeleteRule()
    }
    
    override func prepareForReuse() {
        self.rule?.viewUpdateDelegate = nil
        self.delegate = nil
        self.rule = nil
    }
    
}

extension RuleTableViewCell: ConfigurableTableViewCell {
    
    func configure(with model: TableViewCellModel, indexPath: IndexPath) {
        guard let rule = model as? RuleCellViewModel else { fatalError(self.description) }
        self.rule = rule
    }
    
}

extension RuleTableViewCell: RuleCellViewUpdateDelegate {
    
}
