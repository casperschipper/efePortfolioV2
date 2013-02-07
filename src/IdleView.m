//
//  IdleView.m
//  efePortfolio
//
//  Created by efe on 2/6/13.
//
//

#import "IdleView.h"

@implementation IdleView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleWidth];
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(drawRect:) name:UIDeviceOrientationDidChangeNotification object:nil];
        
    }
    
    return self;
}

- (void)updateView{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 0, 0, 0, .66);
    
    UIFont *helveticaBold = [UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
    UIColor *theColor = [UIColor lightGrayColor];
    [theColor set];
    NSString *myString = @"We are waiting...";
        
    
    if(orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight){
        
        NSLog(@"landscape");
        [myString drawInRect:CGRectMake(rect.size.width /2 - 110,rect.size.height /2 - 30,300,20) withFont:helveticaBold];
        
        //spinner.center = CGPointMake(rect.size.width / 2,rect.size.height/2 + 30);
        
    }
    else if (orientation == UIDeviceOrientationPortrait){
        NSLog(@"portrait");
        [myString drawInRect:CGRectMake(rect.size.width /2 - 110,rect.size.height /2 - 30,300,20) withFont:helveticaBold];
        
        //spinner.center = CGPointMake(rect.size.width / 2,rect.size.height/2 + 30);
    }
    else{
        NSLog(@"upside down");
        [myString drawInRect:CGRectMake(rect.size.width /2 - 110,rect.size.height /2 - 30,300,20) withFont:helveticaBold];
        
        //spinner.center = CGPointMake(rect.size.width / 2,rect.size.height/2 + 30);
    }
    
    
}

@end
