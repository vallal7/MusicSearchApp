//
//  SearchTrackService.h
//  MusicSearch
//
//  Created by Ganesh, Ashwin on 3/25/17.
//  Copyright © 2017 Ashwin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Service.h"
@interface SearchTrackService : Service
-(void)callTrackService:(NSArray*)searchParameters callBack:(void (^)(NSMutableArray *array))updateUI;

@end
