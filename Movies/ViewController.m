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
@property(nonatomic, weak) UISearchBar *search;
@property(nonatomic, weak) UITextView *content;
@property(nonatomic, strong) Movie* movie;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UISearchBar *search = [UISearchBar new];
    UITextView *content = [UITextView new];
    self.search = search;
    self.content = content;
    [self.view addSubview:search];
    [self.view addSubview:content];
    
    
    search.placeholder = @"search";
    search.searchBarStyle = UISearchBarStyleMinimal;
    content.editable = false;
    content.layer.borderColor = [[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0] CGColor];
    content.layer.cornerRadius = 5.0f;
    content.layer.borderWidth = 0.5f;
    
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
        make.bottom.equalTo(self.view.mas_bottom).offset(-spaceD*2);
    }];
    
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
    [searchBar resignFirstResponder];
    [self.movie searchMovie:searchBar.text];
}

# pragma mark: MovieDelegate
- (void) updated {
    NSLog(@"updated");
}

@end
