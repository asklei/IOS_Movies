//
//  Movie.m
//  Movies
//
//  Created by Lei Xu on 7/27/16.
//  Copyright © 2016 Uber. All rights reserved.
//

#import "Movie.h"

@implementation Movie
- (NSArray*) actors {
    if (!_actors) {
        _actors = @[];
    }
    return _actors;
}

- (void)searchMovie:(NSString*)movie {
    
}
@end
