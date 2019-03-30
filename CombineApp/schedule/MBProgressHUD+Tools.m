//
//  MBProgressHUD+Tools.m
//  jiuxinjinfu
//
//  Created by getinlight on 2017/9/7.
//  Copyright © 2017年 getinlight. All rights reserved.
//

#import "MBProgressHUD+Tools.h"

@implementation MBProgressHUD (Tools)

+ (void)showText:(NSString *)str {
    [self showText:str on:[UIApplication sharedApplication].delegate.window];
}

+ (void)showText:(NSString *)str on:(UIView *)view {
    if (str == nil || str.length == 0) {
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.numberOfLines = 0;
    hud.label.text = str;
    hud.margin = 10.0f;
    hud.layer.cornerRadius = 5.0f;
    [hud hideAnimated:YES afterDelay:1.5f];
}

+ (void)showHUD {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    hud.graceTime = 0.8;
}

+ (void)showHUDWithText:(NSString *)text {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    hud.label.text = text;
    hud.graceTime = 0.8;
}

+ (void)hideHUD {
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window animated:YES];
}

@end
