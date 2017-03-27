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

// step 1 - add imports

@interface ViewController ()

// Private properties to handle the search results and avoid same string search
@property (nonatomic, retain) NSMutableArray *searchResultsArray;
@property (nonatomic, retain) NSString *searchedString;

// step 2 - add property for pod datasource

// To initiate the search track service
@property (nonatomic, retain) SearchTrackService *trackService;
@end

@implementation ViewController

#pragma mark - UIViewController

/**
 * @name viewDidLoad
 * @propertyOf ViewController
 * @description
 * Once the view loads, register the custom table view cell
 * Map the datasource to the tableview
 * set the numberOfSections to the Pod
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SearchScreenTitle;
    // step 3 - register the table view cell from pod

    // step 4 initiailize and set the datasource

    // step 5 - provide the dataarray

    // step 6 - set the number of sections
}

/**
 * @name didReceiveMemoryWarning
 * @propertyOf ViewController
 * @description
 * If there is a memory warning, handle the app accordingly
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"App Memory Warning");
}

#pragma mark - TableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // On selecting any cell, display the lyrics details of the song
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
}

#pragma mark - Search Bar Delegate
/**
 * @name searchBarSearchButtonClicked
 * @propertyOf ViewController
 * @param searchBar
 * @description
 * Once the user enters text to search, validate the input and do the search
 * Update the DataSource based on the results
 */
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    // Do a search only when text is entered and only when new text has been entered
    if(searchBar.text) {
        if( ![searchBar.text isEqualToString:self.searchedString]){
            // Initiate the trackservice if it doesn't exist
            if(self.trackService == nil) {
                self.trackService = [[SearchTrackService alloc] init];
            }
            // To access the self inside block
            __block ViewController *weakSelf = self;
            // Construct the parameters object to be appended to the URL and trigger the search service
            NSArray *parametersArray = [NSArray arrayWithObjects:self.searchBar.text, nil];
            [self.activityIndicator startAnimating];
            [self.trackService callTrackService:parametersArray callBack:^(NSMutableArray *arr){
                if (arr.count > 0) {
                    weakSelf.searchResultsArray = arr;
                } else {
                    // if response is invalid, clear the array
                    [weakSelf.searchResultsArray removeAllObjects];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    // step 7 - provide the datasource the new music results array object
                    [weakSelf.activityIndicator stopAnimating];
                });
            }];
            self.searchedString = searchBar.text;
        }
    }
    [searchBar resignFirstResponder];
}

#pragma mark - Segue

/**
 * @name prepareForSegue
 * @propertyOf ViewController
 * @param sender 
 * @description
 * If the segue is detailSegue, populate the LyricsDetails Controller with the required inputs
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"detailSegue"]) {
        NSIndexPath *indexPath = [self.searchTableView indexPathForSelectedRow];
        DetailViewController *detailVC = (DetailViewController *)segue.destinationViewController;
        // Retrieve the selected index model object and pass the relevant parameters
        SearchTrackModel *track = [self.searchResultsArray objectAtIndex:(long)[indexPath row]];
        detailVC.trackName = track.trackName;
        detailVC.albumName = track.albumName;
        detailVC.artistName = track.artistName;
        detailVC.trackImage = track.albumImage;
    }
}

@end
