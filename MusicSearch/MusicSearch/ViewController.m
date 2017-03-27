//
//  ViewController.m
//  MusicSearch
//
//  Created by Ganesh, Ashwin on 3/25/17.
//  Copyright © 2017 Ashwin. All rights reserved.
//

#import "ViewController.h"
#import "SearchTableViewCell.h"
#import "SearchTrackService.h"
#import "TrackModel.h"
#import "DetailViewController.h"

@interface ViewController ()

@property (nonatomic, retain) NSMutableArray *trackResultsArray;
@property (nonatomic, retain) NSMutableArray *albumResultsArray;
@property (nonatomic, retain) NSMutableArray *artistResultsArray;
@property (nonatomic, retain) NSMutableArray *searchResultsArray;

@property (nonatomic, retain) SearchTrackService *trackService;
@end

@implementation ViewController
static NSString *CellIdentifier = @"CellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.searchTableView registerNib:[UINib nibWithNibName:@"SearchTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellIdentifier];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.searchResultsArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchTableViewCell *cell = (SearchTableViewCell *)[self.searchTableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    TrackModel *track = [self.searchResultsArray objectAtIndex:(long)[indexPath row]];
    // to do
    //change label to label name
    cell.trackName.text = track.trackName;
    cell.albumName.text = track.albumName;
    cell.artistName.text = track.artistName;
    
    if (track.albumImage) {
        cell.albumImage.image = track.albumImage;
    } else {
        // set default user image while image is being downloaded
        cell.albumImage.image = [UIImage imageNamed:@"batman.png"];
        
        // download the image asynchronously
        NSURL *url = [NSURL URLWithString:track.albumImageName];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url
                                                    completionHandler:^(NSURL *location,NSURLResponse *response, NSError *error) {
                                                        
                                                        NSData *imageData = [NSData dataWithContentsOfURL:location];
                                                        track.albumImage = [UIImage imageWithData:imageData];
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            cell.albumImage.image = track.albumImage;

                                                        });
                                                    }];
        [task resume];
        
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
    if(self.trackService == nil) {
        self.trackService = [[SearchTrackService alloc] init];
    }
    __block ViewController *weakSelf = self;
    NSArray *parametersArray = [NSArray arrayWithObjects:self.searchBar.text, nil];
    [self.trackService callTrackService:parametersArray callBack:^(NSMutableArray *arr){
        if (arr.count > 0) {
        weakSelf.searchResultsArray = arr;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.searchTableView reloadData];
            [weakSelf.searchTableView setContentOffset:CGPointZero animated:NO];
        });
        } else {
            
        }
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"detailSegue"]) {
        NSIndexPath *indexPath = [self.searchTableView indexPathForSelectedRow];
        DetailViewController *detailVC = (DetailViewController *)segue.destinationViewController;
        TrackModel *track = [self.searchResultsArray objectAtIndex:(long)[indexPath row]];
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
