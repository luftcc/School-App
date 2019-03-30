//
//  MBProgressHUD+Tools.h
//  jiuxinjinfu
//
//  Created by getinlight on 2017/9/7.
//  Copyright © 2017年 getinlight. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Tools)

+ (void)showText:(NSString *)str;

+ (void)showText:(NSString *)str on:(UIView *)view;

+ (void)showHUD;
+ (void)showHUDWithText:(NSString *)text;

+ (void)hideHUD;

@end
