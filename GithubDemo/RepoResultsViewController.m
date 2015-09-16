//
//  RepoResultsViewController.m
//  GithubDemo
//
//  Created by Nicholas Aiwazian on 9/15/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "RepoResultsViewController.h"
#import "MBProgressHUD.h"
#import "GithubRepo.h"
#import "GithubRepoSearchSettings.h"
#import "RepoCell.h"

@interface RepoResultsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) GithubRepoSearchSettings *searchSettings;
@property (nonatomic, strong) NSArray *repoResponse;
@end

@implementation RepoResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.searchSettings = [[GithubRepoSearchSettings alloc] init];
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    [self.searchBar sizeToFit];
    self.navigationItem.titleView = self.searchBar;
    [self doSearch];
    [self.tableView reloadData];
}

- (void)doSearch {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [GithubRepo fetchRepos:self.searchSettings successCallback:^(NSArray *repos) {
        for (GithubRepo *repo in repos) {
            NSLog(@"%@", [NSString stringWithFormat:
                   @"Name:%@\n\tDescription:%@\n\tStars:%ld\n\tForks:%ld,Owner:%@\n\tAvatar:%@\n\t",
                          repo.name,
                          repo.repoDescription,
                          repo.stars,
                          repo.forks,
                          repo.ownerHandle,
                          repo.ownerAvatarURL
                   ]);
        }
        self.repoResponse = repos;
        
        [self.tableView reloadData];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.repoResponse count];
    
}

- (RepoCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    RepoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RepoCell" forIndexPath:indexPath];
    
    
    
    GithubRepo *repo = self.repoResponse[indexPath.row];
    
    //cell.textLabel.text = self.repoResponse[indexPath.row][@"name"];
    //cell.textLabel.text = repo.name;
    [cell setData:repo];
    return cell;
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    [searchBar resignFirstResponder];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.searchSettings.searchString = searchBar.text;
    [searchBar resignFirstResponder];
    [self doSearch];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
