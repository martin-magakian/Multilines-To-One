//
//  MultilinesToOne.h
//  multilinesToOne
//
//  Created by martin on 03/08/2013.
//  Copyright (c) 2013 doduck.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultilinesToOne : UIView{
}

-(void)createOnMultiLines;

-(void)oneline;
-(void)onMultiLine;

- (id)initWithTxt:(NSString *)_text;
@property(retain, nonatomic) NSString *text;
@property(retain, nonatomic) UIFont *font;
@property(retain, nonatomic) NSMutableArray *labelLines;

@property(assign) CGSize originalSize;
@property(assign) CGSize oneLineSize;


@end