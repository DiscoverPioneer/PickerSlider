//
//  ViewController.m
//  Slidable Picker
//
//  Created by Phil Scarfi on 7/8/14.
//  Copyright (c) 2014 Pioneer Mobile Applications. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) NSLayoutConstraint *containerVerticalConstraint;
@property (strong, nonatomic) UIPickerView *filterPicker;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Set up views
    [self setUpContainerView];
    [self setUpFilterPicker];
    [self setUpToolbar];
    
}

- (void)setUpContainerView {
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height + 200, self.view.frame.size.width, 200)];
    self.containerView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.containerView];
    [self.containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSArray *hConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"|[containerView]|"
                                                                   options:0
                                                                   metrics:@{}
                                                                     views:@{@"containerView": self.containerView}];
    NSArray *vConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[containerView(==200)]"
                                                                   options:0
                                                                   metrics:@{}
                                                                     views:@{@"containerView": self.containerView}];
    self.containerVerticalConstraint = [NSLayoutConstraint constraintWithItem:self.containerView
                                                                    attribute:NSLayoutAttributeBottom
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.view
                                                                    attribute:NSLayoutAttributeBottom
                                                                   multiplier:1 constant:200];
    [self.view addConstraints:hConstraint];
    [self.view addConstraints:vConstraint];
    [self.view addConstraints:@[self.containerVerticalConstraint]];
}

- (void)setUpFilterPicker {
    self.filterPicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    self.filterPicker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    self.filterPicker.delegate = self;
    self.filterPicker.dataSource = self;
    [self.containerView addSubview:self.filterPicker];
}

- (void)setUpToolbar {
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    toolbar.barTintColor = [UIColor clearColor];
    [self.containerView addSubview:toolbar];
    
    UIButton *doneButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-50, 0, 50, 40)];
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(showAction:) forControlEvents:UIControlEventTouchUpInside];
    doneButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [toolbar addSubview:doneButton];
}

#pragma mark - UIPicker

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1; 
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (row) {
        case 0:
            return @"Option 1";
            break;
        case 1:
            return @"Option 2";
            break;
        case 2:
            return @"Option 3";
            break;
            
        default:
            break;
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (row) {
        case 0:
            NSLog(@"Selected Option 1");
            break;
        case 1:
            NSLog(@"Selected Option 2");
            break;
        case 2:
            NSLog(@"Selected Option 3");
            break;
            
        default:
            break;
    }
}

- (IBAction)showAction:(id)sender {
    [self.view layoutIfNeeded];
    self.containerVerticalConstraint.constant = self.containerVerticalConstraint.constant == 0 ? 200 : 0;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];}

@end
