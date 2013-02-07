//
//  ModalTemplateViewController.m
//  efePortfolio
//
//  Created by efe on 2/7/13.
//
//

#import "ModalTemplateViewController.h"

@interface ModalTemplateViewController ()

@end

@implementation ModalTemplateViewController

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
    // Do any additional setup after loading the view from its nib.
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onDoneClick:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

@end
