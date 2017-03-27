//
//  SearchTrackService.m
//  MusicSearch
//
//  Created by Ganesh, Ashwin on 3/25/17.
//  Copyright © 2017 Ashwin. All rights reserved.
//

#import "SearchTrackService.h"
#import "SearchTrackModel.h"
#import "ApiConfigProvider.h"

@implementation SearchTrackService


-(void)callTrackService:(NSArray*)searchParameters callBack:(void (^)(NSMutableArray *array))updateUI {
    NSURL *url = [ApiConfigProvider configureTrackSearch:searchParameters];
    
   self.dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
       NSMutableArray *resultArray = [NSMutableArray array];
       @try {
           NSArray *resultsArray = [json valueForKey:TrackResultsDictKey];
           for (NSDictionary *dict in resultsArray) {
               SearchTrackModel *track = [[SearchTrackModel alloc]init];
               [track parseData:dict];
               [resultArray addObject:track];
           }
           updateUI(resultArray);
       } @catch (NSException *exception) {
           NSLog(@"Track Service Exception %@",exception);
       } @finally {
           NSLog(@"Track Service Failed");
       }
    }];
    [self.dataTask resume];
}
@end
