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
    
    @IBOutlet weak var profileImageContainerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    weak var delegate: TweetTableViewCellDelegate?
    
    var tweet: TweetCellViewModel? {
        didSet {
            guard let model = self.tweet else {
                self.profileImage.image = nil
                self.tweet?.viewUpdateDelegate = nil
                self.delegate = nil
                return
            }
            model.viewUpdateDelegate = self
            self.delegate = model
            
            self.nameLabel.text = model.name
            self.usernameLabel.text = model.username
            self.tweetTextLabel.text = model.tweetText
            self.commentCountLabel.text = model.commentCount
            self.retweetCountLabel.text = model.retweetCount
            self.likeCountLabel.text = model.likeCount
            self.profileImage.imageFromServerURL(model.profileImage, placeHolder: UIImage(systemName: "rays"))
            
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewConfig()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.delegate?.didSelectTweet()
        }
    }
    
    override func prepareForReuse() {
        self.tweet = nil
    }
    
    func viewConfig() {
        self.containerView.clipsToBounds = true
        self.containerView.layer.cornerRadius = 5
        
        self.profileImageContainerView.clipsToBounds = true
        self.profileImageContainerView.layer.cornerRadius = 25
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
