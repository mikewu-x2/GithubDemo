//
//  RepoCell.h
//  GithubDemo
//
//  Created by Michael Wu on 9/15/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GithubRepo.h"
#import <UIImageView+AFNetworking.h>

@interface RepoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *repoDescription;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *ownerHandle;
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *stars;
@property (weak, nonatomic) IBOutlet UILabel *forks;

- (void)setData:(GithubRepo *)repo;
@end
