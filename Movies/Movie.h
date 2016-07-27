//
//  Movie.h
//  Movies
//
//  Created by Lei Xu on 7/27/16.
//  Copyright © 2016 Uber. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;

@protocol MovieDelegate
@optional
-(void) updated;
-(void)receivedPosterImage:(UIImage *)posterImage;
@end

@interface Movie : NSObject
@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSString *actors;
@property(strong, nonatomic) NSString *plot;
@property(weak, nonatomic) id<MovieDelegate> delegate;
- (void)searchMovie:(NSString*)movie;
-(void)downloadMoviePoster:(NSString *)posterURL;
@end
