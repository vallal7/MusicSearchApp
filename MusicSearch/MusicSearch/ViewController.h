//
//  ViewController.h
//  MusicSearch
//
//  Created by Ganesh, Ashwin on 3/25/17.
//  Copyright © 2017 Ashwin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (weak, nonatomic) IBOutlet UISearchController *searchController;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

