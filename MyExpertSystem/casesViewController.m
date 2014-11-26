//
//  casesViewController.m
//  MyExpertSystem
//
//  Created by Admin on 25.11.14.
//  Copyright (c) 2014 tsipfvadim. All rights reserved.
//

#define rootURL @"http://expert-system.internal.shinyshark.com/cases/"

#import "casesViewController.h"

@interface casesViewController ()

@end

@implementation casesViewController{
    NSArray* _answers;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"case"];
    NSURL* caseURL=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",rootURL,_caseID]];
    NSData* data = [NSData dataWithContentsOfURL:caseURL];
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:kNilOptions
                          error:&error];
    NSDictionary* Case=[json objectForKey:@"case"];
    
    _questionLable.text=[Case objectForKey:@"text"];
    if (!([Case objectForKey:@"image"]==[NSNull null])) {
        NSURL*imgURL=[NSURL URLWithString:[Case objectForKey:@"image"]];
        NSData *image=[NSData dataWithContentsOfURL:imgURL];
        _imageView.image=[[UIImage alloc] initWithData:image];
    }

    _answers=[Case objectForKey:@"answers"];
    if (_answers) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                      style:UITableViewStylePlain];
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        [self.view addSubview:self.tableView];
        self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
        NSDictionary *views = @{@"tableView": self.tableView};
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[tableView]-20-|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:views]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[tableView(87)]-20-|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:views]];
    }else{
        _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_button addTarget:self
                   action:@selector(returnScenarios)
         forControlEvents:UIControlEventTouchUpInside];
        [_button setTitle:@"Return to Scenarios" forState:UIControlStateNormal];
        _button.frame = CGRectZero;
        [self.view addSubview:_button];
        self.button.translatesAutoresizingMaskIntoConstraints = NO;
        NSDictionary *button = @{@"button": self.button};
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[button]-20-|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:button]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[button(30)]-20-|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:button]];
    }
}

- (void)returnScenarios{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_answers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    NSDictionary *answer=[_answers objectAtIndex:indexPath.row];
    cell.textLabel.text = [answer objectForKey:@"text"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    casesViewController* caseController=[[casesViewController alloc] initWithNibName:@"casesViewController" bundle:nil];
    NSDictionary *scenario=[_answers objectAtIndex:indexPath.row];
    caseController.caseID=[scenario objectForKey:@"caseId"];
    [self.navigationController pushViewController:caseController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
