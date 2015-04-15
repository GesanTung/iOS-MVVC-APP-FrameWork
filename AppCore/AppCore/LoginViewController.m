//
//  LoginViewController.m
//  AppCore
//
//  Created by Gesantung on 15-4-8.
//  Copyright (c) 2015年 Gesantung. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
- (IBAction)logonClick:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)logonClick:(id)sender {
    NSString *post =@"username=15708483462&password=098765&loginsubmit=yes";
    Message *msg =[Message Message];
    msg.url = @"http://tibetbss.cn/api.php?mod=xzksLogin";
    msg.METHOD = @"POST";
    msg.postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    [self.dataLog SEND_ACTION:msg];
   // __block LoginViewController* weakself = self;
    self.dataLog.callBack = ^(NSDictionary* dic){
  
    };
    
}
@end
