//
//  ViewController.m
//  Movies
//
//  Created by Lei Xu on 7/26/16.
//  Copyright © 2016 Uber. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "Movie.h"

@interface ViewController ()
@property (nonatomic, weak) UIActivityIndicatorView *activityIndicatorView;
@property(nonatomic, weak) UISearchBar *search;
@property(nonatomic, weak) UITextView *content;
@property(nonatomic, weak) UIImageView *image;
@property(nonatomic, strong) Movie* movie;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIActivityIndicatorView *activityIndicatorView = [UIActivityIndicatorView new];
    UISearchBar *search = [UISearchBar new];
    UITextView *content = [UITextView new];
    UIImageView *image = [UIImageView new];
    self.activityIndicatorView = activityIndicatorView;
    self.search = search;
    self.content = content;
    self.image = image;
    [self.view addSubview:search];
    [self.view addSubview:content];
    [self.view addSubview:image];
    [self.view addSubview:activityIndicatorView];
    
    search.placeholder = @"search";
    search.searchBarStyle = UISearchBarStyleMinimal;
    content.editable = false;
    content.layer.borderColor = [[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0] CGColor];
    content.layer.cornerRadius = 5.0f;
    content.layer.borderWidth = 0.5f;
    image.layer.cornerRadius = 5.0f;
    //Customize activity indicator view
    self.activityIndicatorView.color = [UIColor grayColor];
    
    self.search.delegate = self;
    self.movie = [Movie new];
    self.movie.delegate = self;
    
    int spaceD = 10;
    
    [search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide).offset(spaceD);
        make.leading.equalTo(self.view.mas_leading).offset(spaceD);
        make.trailing.equalTo(self.view.mas_trailing).offset(-spaceD);
    }];
    
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.search.mas_bottom).offset(spaceD*2);
        make.leading.equalTo(self.search.mas_leading);
        make.trailing.equalTo(self.search.mas_trailing);
        make.bottom.equalTo(self.image.mas_top).offset(-spaceD*2);
    }];
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.greaterThanOrEqualTo(self.content.mas_height);
        make.leading.equalTo(self.search.mas_leading);
        make.trailing.equalTo(self.search.mas_trailing);
        make.bottom.equalTo(self.view.mas_bottom).offset(-spaceD*2);
    }];
    
    [self.activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    [self.content sizeToFit];
    [self.image sizeToFit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

# pragma mark: UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.activityIndicatorView startAnimating];
    [searchBar resignFirstResponder];
    [self.movie searchMovie:searchBar.text];
}

# pragma mark: MovieDelegate
- (void) updated {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ \n", self.movie.title]
                                                                             attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:20]}]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ \n", self.movie.actors]
                                                                             attributes:@{NSFontAttributeName: [UIFont italicSystemFontOfSize:14]}]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ \n", self.movie.plot]
                                                                             attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]}]];
    self.content.attributedText = attributedString;
    NSLog(@"updated");
}

-(void)receivedPosterImage:(UIImage *)posterImage {
    [self.image setImage:posterImage];
    [self.activityIndicatorView stopAnimating];
}

@end
