//
//  Service.h
//  MusicSearch
//
//  Created by Ganesh, Ashwin on 3/25/17.
//  Copyright © 2017 Ashwin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Service : NSObject

@property (nonatomic, retain) NSURLSession *session;
@property (nonatomic, retain) NSURLSessionDataTask *dataTask;
@end
