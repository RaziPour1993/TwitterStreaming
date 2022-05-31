//
//  TweetTableViewCell.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import UIKit


protocol TweetTableViewCellDelegate: AnyObject {
    func didSelectTweet()
}

class TweetTableViewCell: UITableViewCell, ReusableView, NibLoadableView {

    weak var delegate: TweetTableViewCellDelegate?
    
    var tweet: TweetCellViewModel? {
        didSet {
            guard let model = self.tweet else {
                return
            }
            
            model.viewUpdateDelegate = self
            debugPrint("model.name", model.name)
            self.delegate = model
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.delegate?.didSelectTweet()
        }
    }
    
    override func prepareForReuse() {
        self.tweet?.viewUpdateDelegate = nil
        self.delegate = nil
        self.tweet = nil
    }
    
}

extension TweetTableViewCell: ConfigurableTableViewCell {
    
    func configure(with model: TableViewCellModel, indexPath: IndexPath) {
        guard let tweet = model as? TweetCellViewModel else { fatalError(self.description) }
        self.tweet = tweet
    }
    
}

extension TweetTableViewCell: TweetCellViewUpdateDelegate {
    
}
