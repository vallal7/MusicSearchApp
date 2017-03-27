//
//  DetailViewController.m
//  MusicSearch
//
//  Created by Ganesh, Ashwin on 3/25/17.
//  Copyright © 2017 Ashwin. All rights reserved.
//

#import "DetailViewController.h"
#import "SearchLyricsService.h"
#import "LyricsModel.h"

@interface DetailViewController ()

@property (nonatomic, retain)SearchLyricsService *lyricsService;

@end

@implementation DetailViewController

#pragma mark - UIViewController

/**
 * @name viewDidLoad
 * @propertyOf DetailViewController
 * @description
 * Once the view loads, set the navigation bar title of the screen
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = LyricsScreenTitle;
    // Do any additional setup after loading the view.
}

/**
 * @name didReceiveMemoryWarning
 * @propertyOf DetailViewController
 * @description
 * If there is a memory warning, handle the app accordingly
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * @name viewWillAppear
 * @propertyOf DetailViewController
 * @description
 * Once the view appears, update the labels and image with appropriate values
 * Trigger the Search Lyrics service
 */
-(void)viewWillAppear:(BOOL)animated {
    self.trackNameLabel.text = self.trackName;
    self.artistNameLabel.text = self.artistName;
    self.albumNameLabel.text = self.albumName;
    self.trackImageView.image = self.trackImage;
    // Initiate the lyricsService if it doesn't exist
    if(self.lyricsService == nil) {
        self.lyricsService = [[SearchLyricsService alloc] init];
    }
    // To access the self inside block
    __block DetailViewController *weakSelf = self;
    // Construct the parameters object to be appended to the URL and trigger the search service
    NSArray *parametersArray = [NSArray arrayWithObjects:self.artistName,self.trackName, nil];
    [self.animatingIndicator startAnimating];
    [self.lyricsService callLyricsService:parametersArray callBack:^(LyricsModel *lyrics) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the lyrics text view with the lyrics information
            weakSelf.lyricsTextView.text = [NSString stringWithFormat:@"%@", lyrics.lyricsContent];
            [weakSelf.animatingIndicator stopAnimating];
        });
    }];
}

@end
