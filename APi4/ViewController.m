//
//  ViewController.m
//  APi4
//
//  Created by Ramiro Gerardo Perez on 22/12/14.
//  Copyright (c) 2014 Ramiro Perez. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong)NSMutableData *dataReceived;
@property (nonatomic,strong)NSURLConnection *connection;
@property (nonatomic, strong)NSDictionary *dictionary;
@end

@implementation ViewController
@synthesize array;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableview setDelegate:self];
    [self.tableview setDataSource:self];
    self.array = [[NSMutableArray alloc]init];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    [self.dataReceived setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [self.dataReceived appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSDictionary *Jsondictionary = [NSJSONSerialization JSONObjectWithData:self.dataReceived options:NSJSONReadingAllowFragments error:nil];
    
    NSDictionary *feedDict =[Jsondictionary objectForKey:@"feed"];
    
    NSArray *entrArray = [feedDict objectForKey:@"entry"];
    
    for (NSDictionary *dict in entrArray) {
        
        NSDictionary *title = [dict objectForKey:@"title"];
        
        NSString *label = [title objectForKey:@"label"];
        
        [array addObject:label];
        
    }
    [self.tableview reloadData];
}



- (IBAction)refreshButton:(id)sender {
    
    NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/mx/rss/newpaidapplications/limit=10/json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    self.connection =[NSURLConnection connectionWithRequest:request delegate:self];
    
    if (self.connection) {
        
        self.dataReceived = [[NSMutableData alloc]init];
        
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.array count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier =@"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    
    return cell;
}


@end
