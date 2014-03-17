//
//  Movie.m
//  RottenTomatoes
//
//  Created by Liron Yahdav on 3/16/14.
//  Copyright (c) 2014 Liron Yahdav. All rights reserved.
//

#import "Movie.h"

@implementation Movie

+ (NSArray *)moviesFromJSON:(NSArray *)jsonArray {
    NSMutableArray *movies = [[NSMutableArray alloc] init];

    for (NSDictionary *movieDictionary in jsonArray) {
        Movie *movie = [[Movie alloc] init];
        movie.title = movieDictionary[@"title"];
        movie.synopsis = movieDictionary[@"synopsis"];
        movie.posterURL = movieDictionary[@"posters"][@"thumbnail"];
        movie.detailedPosterURL = movieDictionary[@"posters"][@"detailed"];
        movie.cast = [self castFromJSON:movieDictionary[@"abridged_cast"]];
        movie.criticsScore = [movieDictionary[@"ratings"][@"critics_score"] integerValue];
        [movies addObject:movie];
    }
    
    return movies;
}

+ (NSString *)castFromJSON:(NSArray *)jsonArray {
    return [[jsonArray valueForKey:@"name"] componentsJoinedByString:@", "];
}

@end
