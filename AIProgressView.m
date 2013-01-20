//  AIProgressView.m
//
//  Created by Alexey Ivlev on 8/2/12.
//  Copyright (c) 2012 Alexey Ivlev. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "AIProgressView.h"

static AIProgressView *_singleton;

@interface AIProgressView()

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation AIProgressView

+ (void)showInView:(UIView *)view
{
    if (!_singleton) {
        _singleton = [[AIProgressView alloc] initWithFrame:CGRectZero];
    }
    
    if (_singleton.superview != view) {
        _singleton.frame = view.bounds;
        [_singleton setNeedsLayout];
        
        [_singleton removeFromSuperview];
        
        _singleton.alpha = 0.0;
        [view addSubview:_singleton];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.15f];
        _singleton.alpha = 1.0;
        [UIView commitAnimations];
    }
}

+ (void)hide
{
    if (_singleton.superview) {
        [UIView animateWithDuration:0.25f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             _singleton.alpha = 0.0; 
                         }
                         completion:^(BOOL finished){
                             [_singleton removeFromSuperview];
                         }];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicator.frame = CGRectZero;
        _activityIndicator.hidesWhenStopped = YES;
        [self addSubview:_activityIndicator]; 
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGSize activitySize = self.activityIndicator.bounds.size;
  
    self.activityIndicator.frame = CGRectMake(ceilf(self.bounds.size.width/2 - activitySize.width/2),
                                              ceilf(self.bounds.size.height/2 - activitySize.height/2),
                                              activitySize.width,
                                              activitySize.height);
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [self.activityIndicator startAnimating];
}

@end
