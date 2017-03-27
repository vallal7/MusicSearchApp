//
//  ViewController.m
//  MusicSearch
//
//  Created by Ganesh, Ashwin on 3/25/17.
//  Copyright © 2017 Ashwin. All rights reserved.
//

#import "ViewController.h"
#import "SearchTrackService.h"
#import "SearchTrackModel.h"
#import "DetailViewController.h"

// Step1 - add imports

@interface ViewController ()

@property (nonatomic, retain) NSMutableArray *trackResultsArray;
@property (nonatomic, retain) NSMutableArray *albumResultsArray;
@property (nonatomic, retain) NSMutableArray *artistResultsArray;
@property (nonatomic, retain) NSMutableArray *searchResultsArray;

// step 2 - add property for datasource

@property (nonatomic, retain) SearchTrackService *trackService;
@end

@implementation ViewController
static NSString *CellIdentifier = @"CellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SearchScreenTitle;
    // step 3 - register the table view cell from pod
    // step 4 initiailize and set the datasource
    // step 5 - provide the dataarray
    // step 6 - set the number of sections
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if(searchBar.text) {
        if(self.trackService == nil) {
            self.trackService = [[SearchTrackService alloc] init];
        }
        __block ViewController *weakSelf = self;
        NSArray *parametersArray = [NSArray arrayWithObjects:self.searchBar.text, nil];
        [self.activityIndicator startAnimating];
        [self.trackService callTrackService:parametersArray callBack:^(NSMutableArray *arr){
            if (arr.count > 0) {
                weakSelf.searchResultsArray = arr;
            } else {
                [weakSelf.searchResultsArray removeAllObjects];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                // step 7 - provide the datasource the new music results array object
                [weakSelf.activityIndicator stopAnimating];
            });
        }];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"detailSegue"]) {
        NSIndexPath *indexPath = [self.searchTableView indexPathForSelectedRow];
        DetailViewController *detailVC = (DetailViewController *)segue.destinationViewController;
        SearchTrackModel *track = [self.searchResultsArray objectAtIndex:(long)[indexPath row]];
        // to do
        //change label to label name
        detailVC.trackName = track.trackName;
        detailVC.albumName = track.albumName;
        detailVC.artistName = track.artistName;
        detailVC.trackImage = track.albumImage;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
