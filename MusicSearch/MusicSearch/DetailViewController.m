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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = LyricsScreenTitle;
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
    [self.animatingIndicator startAnimating];
    [self.lyricsService callLyricsService:parametersArray callBack:^(LyricsModel *lyrics) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.lyrics.text = [NSString stringWithFormat:@"%@", lyrics.lyricsContent];
            [weakSelf.animatingIndicator stopAnimating];
        });
    }];
}

@end
