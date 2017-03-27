//
//  DetailViewController.m
//  MusicSearch
//
//  Created by Ganesh, Ashwin on 3/25/17.
//  Copyright © 2017 Ashwin. All rights reserved.
//

#import "DetailViewController.h"
#import "SearchLyricsService.h"
@interface DetailViewController ()

@property (nonatomic, retain)UITextView *lyrics;
@property (nonatomic, retain)SearchLyricsService *lyricsService;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    self.trackNameLabel.text = self.trackName;
    self.artistNameLabel.text = self.artistName;
    self.albumNameLabel.text = self.albumName;
    self.trackImageView.image = self.trackImage;
    if(self.lyricsService == nil) {
        self.lyricsService = [[SearchLyricsService alloc] init];
    }
    __block DetailViewController *weakSelf = self;
    NSArray *parametersArray = [NSArray arrayWithObjects:self.artistName,self.trackName, nil];
    
    [self.lyricsService callLyricsService:parametersArray callBack:^(NSMutableArray *arr){
        if (arr.count > 0) {
            /*
            weakSelf.searchResultsArray = arr;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.searchTableView reloadData];
                [weakSelf.searchTableView setContentOffset:CGPointZero animated:NO];
            });
             */
        } else {
            
        }
    }];
    
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
