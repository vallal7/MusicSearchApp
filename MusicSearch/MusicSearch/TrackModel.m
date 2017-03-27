//
//  TrackModel.m
//  MusicSearch
//
//  Created by Ganesh, Ashwin on 3/25/17.
//  Copyright © 2017 Ashwin. All rights reserved.
//

#import "TrackModel.h"

@implementation TrackModel


-(void)getAllTack{
    //make the service class call
}

-(void)parseData:(NSDictionary *)responseDict{
    self.trackName = [responseDict objectForKey:@"trackName"];
    self.albumName = [responseDict objectForKey:@"collectionName"];
    self.artistName = [responseDict objectForKey:@"artistName"];
    self.albumImageName = [responseDict objectForKey:@"artworkUrl30"];
}
@end
