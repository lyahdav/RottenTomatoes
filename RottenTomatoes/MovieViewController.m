//
//  MovieViewController.m
//  RottenTomatoes
//
//  Created by Liron Yahdav on 3/16/14.
//  Copyright (c) 2014 Liron Yahdav. All rights reserved.
//

#import "MovieViewController.h"
#import "Movie.h"
#import "UIImageView+AFNetworking.h"

@interface MovieViewController ()

@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *castLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *criticsScoreLabel;
@property (strong, nonatomic) Movie *movie;

@end

@implementation MovieViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (instancetype)initWithMovie:(Movie *)movie {
    self = [super init];
    if (self) {
        self.movie = movie;
    }
    
    return self;
}

- (void)reload {
    self.synopsisLabel.text = self.movie.synopsis;
    self.castLabel.text = self.movie.cast;
    self.criticsScoreLabel.text = [NSString stringWithFormat:@"%ld%%", (long)self.movie.criticsScore];
    
    [self.posterImage setImageWithURL:[NSURL URLWithString:self.movie.detailedPosterURL]];
}

- (void)setMovie:(Movie *)movie {
    _movie = movie;
    self.title = self.movie.title;
    if (self.view.window) {
        [self reload];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self reload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
