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
            [self downloadMoviePoster:json[@"Poster"]];
            [self.delegate updated];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self.delegate receivedError:error.localizedDescription];
    }];
}

-(void)downloadMoviePoster:(NSString *)posterURL {
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:posterURL]]];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id data) {
        NSLog(@"Image Response: %@", data);
        [self.delegate receivedPosterImage:data];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Image error: %@", error);
        [self.delegate receivedError:error.localizedDescription];
    }];
    [requestOperation start];
}
@end
