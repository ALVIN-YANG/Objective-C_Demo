//
//  ViewController.m
//  02-封装PickView
//
//  Created by 杨卢青 on 15/12/1.
//  Copyright © 2015年 杨卢青. All rights reserved.
//

#import "ViewController.h"
#import "FlagField.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *countryTextField;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.countryTextField.delegate = self;
    self.birthdayTextField.delegate = self;
    self.cityTextField.delegate = self;
}

-(void)textFieldDidBeginEditing:(FlagField *)textField
{
    [textField initWithText];
}
@end
