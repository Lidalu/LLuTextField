//
//  ViewController.m
//  UITextField练习
//
//  Created by ma c on 16/1/22.
//  Copyright © 2016年 lu. All rights reserved.
//

#import "ViewController.h"
#import "LLuTextField.h"
#import "UIColor+HEX.h"

static NSUInteger kMargin = 20;
#define kTextFieldWidth [UIScreen mainScreen].bounds.size.width - 2*kMargin

@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, strong) LLuTextField * userNameTextField;

@property (nonatomic, strong) LLuTextField * passwordTextField;

@property (nonatomic, strong) UIButton * LoginButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f7f8f3"];

    [self.view addSubview:self.userNameTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.LoginButton];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

-(UITextField *)userNameTextField {
    
    if (!_userNameTextField) {
        
        CGRect frame = CGRectMake(kMargin, 80, kTextFieldWidth, 44);
        _userNameTextField = [[LLuTextField alloc] initWithFrame:frame leftImageName:@"userName"];
        _userNameTextField.delegate = self;
        _userNameTextField.placeholder = @"请输入手机号/邮箱";
        _userNameTextField.keyboardType = UIKeyboardTypeDefault;
        _userNameTextField.returnKeyType = UIReturnKeyNext;
    }
    return _userNameTextField;
}

-(UITextField *)passwordTextField {
    
    if (!_passwordTextField) {
        
        CGRect frame = CGRectMake(kMargin, CGRectGetMaxY(_userNameTextField.frame) + 30, kTextFieldWidth, 44);
        _passwordTextField = [[LLuTextField alloc] initWithFrame:frame leftImageName:@"password"];
        _passwordTextField.delegate = self;
        // 密码模式
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.placeholder = @"请输入密码";
        _passwordTextField.returnKeyType = UIReturnKeyGo;
        _passwordTextField.keyboardType = UIKeyboardTypeDefault;
    }
    return _passwordTextField;
}

- (UIButton *)LoginButton
{
    if (!_LoginButton) {
        CGFloat pointY = CGRectGetMaxY(_passwordTextField.frame) + 50;
        _LoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _LoginButton.frame = CGRectMake(kMargin, pointY, kTextFieldWidth, 44);
        [_LoginButton setTitle:@"登录" forState:UIControlStateNormal];
        _LoginButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_LoginButton setBackgroundImage:[UIImage imageNamed:@"beijing"] forState:UIControlStateNormal];
        [_LoginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
        _LoginButton.layer.cornerRadius = 4.0f;
        _LoginButton.layer.masksToBounds = YES;
        _LoginButton.enabled = NO;
    }
    return _LoginButton;
}

- (void)loginAction
{
    NSLog(@"userName:%@ password:%@", _userNameTextField.text, _passwordTextField.text);
    if ([self.userNameTextField.text isEqualToString:@"1304020510"] && [self.passwordTextField.text isEqualToString:@"abcde123"]) {
        [[[UIAlertView alloc] initWithTitle:nil message:@"登陆成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        return;
    }
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    //values 数组定义了表单应该到哪些位置。
    animation.values = @[ @0, @15, @-15, @15, @0 ];
    //设置 keyTimes 属性让我们能够指定关键帧动画发生的时间。它们被指定为关键帧动画总持续时间的一个分数。
    animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    animation.duration = 0.4;
    
    //设置 additive 属性为 YES 使 Core Animation 在更新 presentation layer 之前将动画的值添加到 model layer 中去。这使我们能够对所有形式的需要更新的元素重用相同的动画，且无需提前知道它们的位置。因为这个属性从 CAPropertyAnimation 继承，所以你也可以在使用 CABasicAnimation 时使用它。
    animation.additive = YES;
    
    [self.passwordTextField.layer addAnimation:animation forKey:@"shake"];
    self.userNameTextField.text = @"";
    self.passwordTextField.text = @"";
    [self.userNameTextField becomeFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (self.userNameTextField == textField) {
        [self.passwordTextField becomeFirstResponder];
    } else if (self.passwordTextField == textField) {
        [self loginAction];
    }
    else {
        [textField becomeFirstResponder];
    }
    
    return YES;
}

- (void)textFieldTextDidChange:(NSNotification *)notifi {
    
//    if ([_passwordTextField.text isEqualToString:@""] || [_userNameTextField.text isEqualToString:@""]||(![self.passwordTextField.text isEqualToString:@""]&&[self.userNameTextField.text isEqualToString:@""])) {
//        self.LoginButton.enabled = NO;
//    }else{
//        self.LoginButton.enabled = YES;
//    }
    
    if ([_passwordTextField.text isEqualToString:@""] || [_userNameTextField.text isEqualToString:@""]) {
            self.LoginButton.enabled = NO;
    }else{
            self.LoginButton.enabled = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
