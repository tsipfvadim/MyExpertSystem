//
//  casesViewController.h
//  MyExpertSystem
//
//  Created by Admin on 25.11.14.
//  Copyright (c) 2014 tsipfvadim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface casesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) NSNumber* caseID;
@property (weak, nonatomic) IBOutlet UILabel *questionLable;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *button;
- (void)returnScenarios;
@end
