//
//  Movie.h
//  RottenTomatoes
//
//  Created by Liron Yahdav on 3/16/14.
//  Copyright (c) 2014 Liron Yahdav. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *synopsis;
@property (nonatomic, strong) NSString *posterURL;
@property (nonatomic, strong) NSString *detailedPosterURL;
@property (nonatomic, strong) NSString *cast;
@property (nonatomic, assign) NSInteger criticsScore;

+ (NSArray *)moviesFromJSON:(NSArray *)jsonArray;

@end
