//
//  DetailDetailTableViewCell.swift
//  TwitterStreaming
//
//  Created by Mohammad on 6/4/22.
//

import UIKit

protocol TweetDetailTableViewCellDelegate: AnyObject {}

class TweetDetailTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    
    @IBOutlet weak var profileImageContainerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var hashtagsLabel: UILabel!
    @IBOutlet weak var twitterButtonOutlet: UIButton!
    
    weak var delegate: TweetDetailTableViewCellDelegate?
    
    var tweet: TweetDetailCellViewModel? {
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
            self.sourceLabel.text = model.source
            self.hashtagsLabel.text = model.hashtags
            self.twitterButtonOutlet.isHidden = !model.openInTwitter
            
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewConfig()
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
    
    @IBAction func twitterButtonAction(_ sender: Any) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(tweet!.url!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(tweet!.url!)
        }
    }
    
}

extension TweetDetailTableViewCell: ConfigurableTableViewCell {
    
    func configure(with model: TableViewCellModel, indexPath: IndexPath) {
        guard let tweet = model as? TweetDetailCellViewModel else { fatalError(self.description) }
        self.tweet = tweet
    }
    
}

extension TweetDetailTableViewCell: TweetDetailCellViewUpdateDelegate {
    
}
