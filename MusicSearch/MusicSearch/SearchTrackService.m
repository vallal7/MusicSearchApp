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

/**
 * @name callTrackService
 * @propertyOf SearchTrackService
 * @param searchParameters updateUI
 * @description
 * Make the service call after configuring the URL
 * If response is valid, serialize the json data and parse it
 */
-(void)callTrackService:(NSArray*)searchParameters callBack:(void (^)(NSMutableArray *array))updateUI {
    NSURL *url = [ApiConfigProvider configureTrackSearch:searchParameters];
    
    self.dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // typecase the NSURLResponse to HTTPResponse
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        if(httpResponse.statusCode == 200) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSMutableArray *resultArray = [NSMutableArray array];
            @try {
                // Parse the data, based on the results key
                NSArray *resultsArray = [json valueForKey:TrackResultsDictKey];
                for (NSDictionary *dict in resultsArray) {
                    SearchTrackModel *track = [[SearchTrackModel alloc]init];
                    // Parse the response data
                    [track parseData:dict];
                    [resultArray addObject:track];
                }
                // the callback is triggered with the formatted response object
                updateUI(resultArray);
            } @catch (NSException *exception) {
                NSLog(@"Track Service Exception %@",exception);
            } @finally {
                NSLog(@"Track Service Completed");
            }
        } else {
            // If response is invalid, handle the app accordingly
            NSLog(@"Invalid Response Code Search Track Service, Status - %ld",httpResponse.statusCode);
            NSMutableArray *resultArray = [NSMutableArray array];
            updateUI(resultArray);
        }
    }];
    [self.dataTask resume];
}
@end
