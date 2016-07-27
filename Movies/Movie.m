//
//  Movie.m
//  Movies
//
//  Created by Lei Xu on 7/27/16.
//  Copyright © 2016 Uber. All rights reserved.
//

#import "Movie.h"
#import "UIKit/UIImage.h"

@implementation Movie

- (void)searchMovie:(NSString*)movie {
    NSString *omdbSearchURL = [NSString stringWithFormat:@"http://www.omdbapi.com/?t=%@", movie];
    omdbSearchURL = [omdbSearchURL stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:omdbSearchURL]
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                NSLog(@"Received data! \n %@", json);
                                                self.title = json[@"Title"];
                                                self.actors = json[@"Actors"];
                                                self.plot = json[@"Plot"];
                                                [self downloadMoviePoster:json[@"Poster"]];
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    [self.delegate updated];
                                                });
                                            }];
    [dataTask resume];
}

-(void)downloadMoviePoster:(NSString *)posterURL {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:[NSURL URLWithString:posterURL] completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSData *data = [NSData dataWithContentsOfURL:location];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate receivedPosterImage:[UIImage imageWithData:data]];
        });
    }];
    [downloadTask resume];
}
@end
