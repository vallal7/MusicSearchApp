//
//  Service.h
//  MusicSearch
//
//  Created by Ganesh, Ashwin on 3/25/17.
//  Copyright © 2017 Ashwin. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString *searchLyricsUrl=@"http://lyrics.wikia.com/api.php?func=getSong&artist=Tom+Waits&song=new+coat+of+paint&fmt=json";

@interface Service : NSObject

@property (nonatomic, retain) NSURLSession *session;
@property (nonatomic, retain) NSURLSessionDataTask *dataTask;
@end
