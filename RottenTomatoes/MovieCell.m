//
//  MovieCell.m
//  RottenTomatoes
//
//  Created by Liron Yahdav on 3/16/14.
//  Copyright (c) 2014 Liron Yahdav. All rights reserved.
//

#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"

@interface MovieCell ()

@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *castLabel;

@end

@implementation MovieCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Public methods

- (void)setMovie:(Movie *)movie {
    _movie = movie;
    self.movieTitleLabel.text = movie.title;
    self.synopsisLabel.text = movie.synopsis;
    self.castLabel.text = movie.cast;
    
    [self.posterImage setImageWithURL:[NSURL URLWithString:movie.posterURL]];
}

+ (CGFloat)rowHeight {
    static CGFloat height = 0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
        height = view.bounds.size.height;
    });
    return height;
}

@end
