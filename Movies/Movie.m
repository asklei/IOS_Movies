//
//  Movie.m
//  Movies
//
//  Created by Lei Xu on 7/27/16.
//  Copyright © 2016 Uber. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (void)searchMovie:(NSString*)movie {
    NSString *omdbSearchURL = [NSString stringWithFormat:@"http://www.omdbapi.com/?t=%@", movie];
    omdbSearchURL = [omdbSearchURL stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:omdbSearchURL]
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                NSLog(@"Received data!");
                                                
                                                self.title = json[@"Title"];
                                                self.actors = json[@"Actors"];
                                                self.plot = json[@"Plot"];
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    [self.delegate updated];
                                                });
                                            }];
    [dataTask resume];
}
@end
