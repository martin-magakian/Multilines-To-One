//
//  ViewController.m
//  multilinesToOne
//
//  Created by martin on 03/08/2013.
//  Copyright (c) 2013 doduck.com. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    multiToOne = [[MultilinesToOne alloc] initWithTxt:@"Doduck.com prototype your ideas. And Goi is awsomemqrtin is the mushy"];
    multiToOne.frame = CGRectMake(10, 50, 100, 30);
    multiToOne.backgroundColor = [UIColor yellowColor];
    [multiToOne createOnMultiLines];
    [self.view addSubview:multiToOne];
}


- (IBAction)multiLine:(id)sender {
    [multiToOne onMultiLine];
}

- (IBAction)oneLine:(id)sender {
    [multiToOne oneline];
}

-(void)dealloc{
    [multiToOne release];
    [super dealloc];
}

@end
