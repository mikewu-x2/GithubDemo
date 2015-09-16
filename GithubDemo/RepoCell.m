//
//  RepoCell.m
//  GithubDemo
//
//  Created by Michael Wu on 9/15/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "RepoCell.h"
#import "GitHubRepo.h"

@implementation RepoCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(GithubRepo *)repo {
    self.name.text = repo.name;
    self.stars.text = [NSString stringWithFormat:@"%li", repo.stars];
    self.forks.text = [NSString stringWithFormat:@"%li", repo.forks];
    
    NSString *ownerText = [@"By: " stringByAppendingString:repo.ownerHandle];
    
    self.ownerHandle.text = ownerText;
    //self.ownerAvatarURL = repo.ownerAvatarURL;
    [self.avatarView setImageWithURL: [NSURL URLWithString:repo.ownerAvatarURL]];
    self.repoDescription.text = repo.repoDescription;
    //[self.repoDescription align];
    
    [self updateConstraintsIfNeeded];
}

- (void)awakeFromNib {
    //self.repoDescription.preferredMaxLayoutWidth = self.repoDescription.frame.size.width;
}

@end
