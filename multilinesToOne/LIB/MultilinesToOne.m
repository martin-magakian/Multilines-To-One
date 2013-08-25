//
//  MultilinesToOne.m
//  multilinesToOne
//
//  Created by martin on 03/08/2013.
//  Copyright (c) 2013 doduck.com. All rights reserved.
//

#import "MultilinesToOne.h"
#import "MultilineToOneLabel.h"

@implementation MultilinesToOne

#define SINGLE_MULTILINE_ANNIMATION_DURATION 0.9

@synthesize font,text,originalSize,oneLineSize;

- (id)initWithTxt:(NSString *)_text
{
    self = [super init];
    if (self) {
        self.text = _text;
        self.font = [UIFont systemFontOfSize:14];
        self.labelLines = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)createOnMultiLines{
    NSArray *words = [self.text componentsSeparatedByString:@" "];
    NSArray *lines = [self createLines:words];
    
    CGFloat y = 0;
    for(NSArray *line in lines){
        NSString *labelTxt = [self createTxtLine:line];
        MultilineToOneLabel *l = [[MultilineToOneLabel alloc] init];
        l.font = self.font;
        l.text = labelTxt;
        [l sizeToFit];
        l.frame = CGRectMake(0,
                             y,
                             l.frame.size.width,
                             l.frame.size.height);
        l.original = l.frame;
        y += l.frame.size.height;
        [self addSubview:l];
        [self.labelLines addObject:l];
    }
    [self autoResize];
    self.originalSize = self.frame.size;
    self.oneLineSize = [self calculateLabelPositionOnOneLine];
}

-(void)autoResize{
    
    MultilineToOneLabel *last = nil;
    CGFloat wilder = 0.0f;
    for(MultilineToOneLabel *l in self.labelLines){
        if(l.frame.size.width > wilder){
            wilder = l.frame.size.width;
        }
        last = l;
    }
    
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            wilder,
                            last.frame.origin.y+last.frame.size.height);
}

-(CGSize)calculateLabelPositionOnOneLine{
    
    CGFloat spaceWidth = [@" " sizeWithFont:self.font].width;
    CGFloat x = -spaceWidth; //first element will add it back
    
    MultilineToOneLabel* last = nil;
    for(MultilineToOneLabel* l in self.labelLines){
        l.oneLine = CGRectMake(x + spaceWidth, //todo resize go here !?
                               0,
                               l.frame.size.width,
                               l.frame.size.height);
        x += l.frame.size.width + spaceWidth;
        last = l;
    }
    return CGSizeMake(last.oneLine.origin.x + last.oneLine.size.width,
                      last.oneLine.size.height);
}

-(void)oneline{
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            self.oneLineSize.width,
                            self.oneLineSize.height);
    for(MultilineToOneLabel* l in self.labelLines){
        [UIView animateWithDuration:SINGLE_MULTILINE_ANNIMATION_DURATION animations:^(void){
            l.frame = l.oneLine;
        }];
    }
}

-(void)onMultiLine{
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            self.originalSize.width,
                            self.originalSize.height);
    for(MultilineToOneLabel* l in self.labelLines){
        [UIView animateWithDuration:SINGLE_MULTILINE_ANNIMATION_DURATION animations:^(void){
            l.frame = l.original;
        }];
    }
}

-(NSArray *)createLines:(NSArray *)staticWords{
    NSMutableArray *words = [[NSMutableArray alloc] initWithArray:staticWords];
    NSMutableArray *lines = [[[NSMutableArray alloc] init] autorelease];
    
    NSArray* useds = nil;
    do{
        useds = [self createLine:words];
        if(useds != nil){
            [lines addObject:useds];
            for(NSString *used in useds){
                [words removeObject:used];
            }
        }
    }while (useds != nil);
    
    
    return lines;
}

-(NSArray *)createLine:(NSArray *)words{
    NSMutableArray *used = [[[NSMutableArray alloc] init] autorelease];
    if(words.count == 0){
        return nil;
    }
    
    [used addObject:[words objectAtIndex:0]];
    
    for(int i=1; i<words.count; i++){
        if([self fitInLine:used withWord:[words objectAtIndex:i]]){
            [used addObject:[words objectAtIndex:i]];
        }else{
            return used;
        }
    }
    
    return used;
}

-(BOOL) fitInLine:(NSArray *)words withWord:(NSString *)word{
    NSMutableString *sb = [[[NSMutableString alloc] init] autorelease];
    
    for(NSString *s in words){
        [sb appendString:s];
        [sb appendString:@" "];
    }
    
    [sb appendString:word];
    
    CGFloat needWidth = [sb sizeWithFont:self.font].width;
    if(needWidth < self.frame.size.width){
        return YES;
    }
    return NO;
}

-(NSString *)createTxtLine:(NSArray *)words{
    NSMutableString *sb = [[[NSMutableString alloc] init] autorelease];
    
    for(int i = 0; i<words.count; i++){
        [sb appendString:[words objectAtIndex:i]];
        if(i!=words.count-1){
            [sb appendString:@" "];
        }
    }
    return sb;
}


@end
