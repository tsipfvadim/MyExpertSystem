//
//  scenariosViewController.m
//  MyExpertSystem
//
//  Created by Admin on 25.11.14.
//  Copyright (c) 2014 tsipfvadim. All rights reserved.
//

#define rootURL [NSURL URLWithString:@"http://expert-system.internal.shinyshark.com/scenarios/"]

#import "scenariosViewController.h"
#import "casesViewController.h"

@interface scenariosViewController ()

@end

@implementation scenariosViewController {
    NSArray* _scenarios;
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
    [self setTitle:@"scenarios"];
    NSData* data = [NSData dataWithContentsOfURL:rootURL];
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:kNilOptions
                          error:&error];
    _scenarios=[NSArray arrayWithArray:[json objectForKey:@"scenarios"]];
}

//- (void)parseData:(NSData *)responseData {
//
//    NSError* error;
//    NSDictionary* json = [NSJSONSerialization
//                          JSONObjectWithData:responseData
//                          options:kNilOptions
//                          error:&error];
//    _scenarios=[NSArray arrayWithArray:[json objectForKey:@"scenarios"]];
//    
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_scenarios count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    NSDictionary *scenario=[_scenarios objectAtIndex:indexPath.row];
    cell.textLabel.text = [scenario objectForKey:@"text"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    casesViewController* caseController=[[casesViewController alloc] initWithNibName:@"casesViewController" bundle:nil];
    NSDictionary *scenario=[_scenarios objectAtIndex:indexPath.row];
    caseController.caseID=[scenario objectForKey:@"caseId"];
    [self.navigationController pushViewController:caseController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
