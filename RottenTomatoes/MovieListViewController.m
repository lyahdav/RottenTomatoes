//
//  MovieListViewController.m
//  RottenTomatoes
//
//  Created by Liron Yahdav on 3/16/14.
//  Copyright (c) 2014 Liron Yahdav. All rights reserved.
//

#import "MovieListViewController.h"
#import "AFNetworking.h"
#import "Movie.h"
#import "MovieCell.h"
#import "MovieViewController.h"
#import "ZAActivityBar.h"

static NSString * const BaseURLString = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/";
static NSString * const RottenTomatoesAPIKey = @"3jc296gretaxvsuvvn6pvgdk";

@interface MovieListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *movies;
@property (weak, nonatomic) IBOutlet UIImageView *errorImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *errorViewHeight;
@property (nonatomic, copy) NSString *errorMessage;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@end

@implementation MovieListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self loadMovies];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    self.errorMessage = nil;

    self.title = @"Movies";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    UINib *movieCellNib = [UINib nibWithNibName:@"MovieCell" bundle:nil];
    [self.tableView registerNib:movieCellNib forCellReuseIdentifier:@"MovieCell"];

    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self loadMovies];    
    [refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadMovies {
    [ZAActivityBar showWithStatus:@"Loading movie information..."];

    NSString *url = [BaseURLString stringByAppendingFormat:@"in_theaters.json?apikey=%@", RottenTomatoesAPIKey];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.errorMessage = nil;
        self.movies = [Movie moviesFromJSON:responseObject[@"movies"]];
        [self.tableView reloadData];
        [ZAActivityBar dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.errorMessage = [NSString stringWithFormat:@"Network error: %@", [error localizedDescription]];
        [ZAActivityBar dismiss];
    }];
}

- (void)setErrorMessage:(NSString *)errorMessage {
    _errorMessage = errorMessage;
    static CGFloat originalHeight = 0;
    if (originalHeight == 0) {
        originalHeight = self.errorViewHeight.constant;
    }
    
    self.errorViewHeight.constant = errorMessage != nil ? originalHeight : 0;
    self.errorLabel.text = errorMessage;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];

    cell.movie = self.movies[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MovieCell rowHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Movie *movie = self.movies[indexPath.row];
    MovieViewController *vc = [[MovieViewController alloc] initWithMovie:movie];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
