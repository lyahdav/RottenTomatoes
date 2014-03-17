//
//  MovieCell.h
//  RottenTomatoes
//
//  Created by Liron Yahdav on 3/16/14.
//  Copyright (c) 2014 Liron Yahdav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieCell : UITableViewCell

@property (nonatomic, strong) Movie *movie;

+ (CGFloat)rowHeight;

@end
