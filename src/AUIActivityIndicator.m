//
//  AUIActivityIndicator.m
//
//

#import "AUIActivityIndicator.h"
#import <QuartzCore/QuartzCore.h>

@interface AUIActivityIndicator()
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) NSString *indicatorTitle;
@end

@implementation AUIActivityIndicator

@synthesize activityIndicator, indicatorTitle;

- (id)initWithTitle:(NSString *)title
{
    CGRect frame;
    
    if(title != nil)
        frame = CGRectMake(20, 20, 120, 80);
    else
        frame = CGRectMake(40, 40, 120, 120);
    
    self = [super initWithFrame:frame];
    if (self) {
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        self.indicatorTitle = title;
    }
    return self;
}

- (void)layoutSubviews 
{   
    CGFloat viewX = (self.superview.frame.size.width / 2) - 60;
    CGFloat viewY = (self.superview.frame.size.height / 2) - 80;
    self.frame = CGRectMake(viewX, viewY, 120, 80);
    
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.75;
    
    self.activityIndicator.frame = CGRectMake(50, 15, self.activityIndicator.frame.size.width, self.activityIndicator.frame.size.height);
    
    self.layer.cornerRadius = 10;
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, 85, 44)];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.text = self.indicatorTitle;
    
    [self addSubview:lblTitle];
    [self addSubview:self.activityIndicator];
}

#pragma mark - Activity Indicator View

- (void)hide
{
    self.activityIndicator.hidden = YES;
}

- (void)show
{
    [self.activityIndicator startAnimating];
    self.activityIndicator.hidden = NO;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
