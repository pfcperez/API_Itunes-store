//
//  ViewController.h
//  APi4
//
//  Created by Ramiro Gerardo Perez on 22/12/14.
//  Copyright (c) 2014 Ramiro Perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSMutableArray *array;
- (IBAction)refreshButton:(id)sender;

@end

