//
//  SearchTrackService.m
//  MusicSearch
//
//  Created by Ganesh, Ashwin on 3/25/17.
//  Copyright © 2017 Ashwin. All rights reserved.
//

#import "SearchTrackService.h"
#import "TrackModel.h"
#import "ApiConfigProvider.h"

@implementation SearchTrackService


-(void)callTrackService:(NSArray*)searchParameters callBack:(void (^)(NSMutableArray *array))updateUI {
    NSURL *url = [ApiConfigProvider configureTrackSearch:searchParameters];
    
   self.dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSLog(@"Data task json - %@",json);
       NSMutableArray *resultArray = [NSMutableArray array];
       NSArray *resultsArray = [json valueForKey:@"results"];
       for (NSDictionary *dict in resultsArray) {
           TrackModel *track = [[TrackModel alloc]init];
           [track parseData:dict];
           [resultArray addObject:track];
       }
        updateUI(resultArray);
    }];
    [self.dataTask resume];
}
@end
