//
//  ViewController.h
//  multilinesToOne
//
//  Created by martin on 03/08/2013.
//  Copyright (c) 2013 doduck.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultilinesToOne.h"

@interface ViewController : UIViewController{
    MultilinesToOne *multiToOne;
}
- (IBAction)multiLine:(id)sender;
- (IBAction)oneLine:(id)sender;


@end
