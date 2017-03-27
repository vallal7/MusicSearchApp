//
//  SearchLyricsService.m
//  MusicSearch
//
//  Created by Ganesh, Ashwin on 3/25/17.
//  Copyright © 2017 Ashwin. All rights reserved.
//

#import "SearchLyricsService.h"
#import "ApiConfigProvider.h"

@implementation SearchLyricsService

-(void)callLyricsService:(NSArray*)searchParameters callBack:(void (^)(NSMutableArray *array))updateUI {
    {
        NSURL *url = [ApiConfigProvider configureLyricsSearch:searchParameters];
        
        self.dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSString *str = [NSString stringWithUTF8String:[data bytes]];

            //NSString *str2 = @"8+9=17";
            NSRange equalRange = [str rangeOfString:@"{" options:NSBackwardsSearch];
            if (equalRange.location != NSNotFound) {
                str = [str substringFromIndex:equalRange.location + equalRange.length -1];
            }
            
            NSRange pos = [str rangeOfString:@"@"];
            if (pos.location != NSNotFound && pos.location+1 != NSNotFound) {
                str = [str substringToIndex:pos.location+1];
            }
            NSError *err2;
            NSData *data2 = [str dataUsingEncoding:NSUTF8StringEncoding];
            id json2 = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableContainers error:&err2];
            NSLog(@"Data task json - %@",json2);
            
            NSMutableArray *resultArray = [NSMutableArray array];
           /*
            NSArray *resultsArray = [json valueForKey:@"results"];
            for (NSDictionary *dict in resultsArray) {
                TrackModel *track = [[TrackModel alloc]init];
                [track parseData:dict];
                [resultArray addObject:track];
            }
            */
            updateUI(resultArray);
        }];
        [self.dataTask resume];
    }
}

@end
