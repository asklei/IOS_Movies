//
//  Movie.m
//  Movies
//
//  Created by Lei Xu on 7/27/16.
//  Copyright © 2016 Uber. All rights reserved.
//

#import "Movie.h"
#import "UIKit/UIImage.h"
#import "AFNetworking.h"

@implementation Movie

- (void)searchMovie:(NSString*)movie {
    NSString *omdbSearchURL = [NSString stringWithFormat:@"http://www.omdbapi.com/?t=%@", movie];
    omdbSearchURL = [omdbSearchURL stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:omdbSearchURL parameters:nil success:^(AFHTTPRequestOperation *operation, id json) {
        NSLog(@"JSON: %@", json);
        if (![json[@"Response"] boolValue]) {
            [self.delegate receivedError:json[@"Error"]];
        } else {
            self.title = json[@"Title"];
            self.actors = json[@"Actors"];
            self.plot = json[@"Plot"];
            self.posterURL = json[@"Poster"];
            [self.delegate updated];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self.delegate receivedError:error.localizedDescription];
    }];
}
@end
