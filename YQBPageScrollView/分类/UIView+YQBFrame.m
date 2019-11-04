
#import <sys/utsname.h>
#import "UIView+YQBFrame.h"

@implementation UIView (YQBFrame)
//@property (assign, nonatomic) CGFloat yqb_right;
//@property (assign, nonatomic) CGFloat yqb_centerX;
//@property (assign, nonatomic) CGFloat yqb_centerY;
- (void)setYqb_x:(CGFloat)yqb_x
{
    CGRect frame = self.frame;
    frame.origin.x = yqb_x;
    self.frame = frame;
}
- (CGFloat)yqb_x
{
    return self.frame.origin.x;
}

- (void)setYqb_y:(CGFloat)yqb_y
{
    CGRect frame = self.frame;
    frame.origin.y = yqb_y;
    self.frame = frame;
}

- (CGFloat)yqb_y
{
    return self.frame.origin.y;
}

- (void)setYqb_width:(CGFloat)yqb_w
{
    CGRect frame = self.frame;
    frame.size.width = yqb_w;
    self.frame = frame;
}

- (CGFloat)yqb_width
{
    return self.frame.size.width;
}

- (void)setYqb_height:(CGFloat)yqb_height
{
    CGRect frame = self.frame;
    frame.size.height = yqb_height;
    self.frame = frame;
}

- (CGFloat)yqb_height
{
    return self.frame.size.height;
}

- (void)setYqb_size:(CGSize)yqb_size
{
    CGRect frame = self.frame;
    frame.size = yqb_size;
    self.frame = frame;
}

- (CGSize)yqb_size
{
    return self.frame.size;
}

- (void)setYqb_origin:(CGPoint)yqb_origin
{
    CGRect frame = self.frame;
    frame.origin = yqb_origin;
    self.frame = frame;
}

- (CGPoint)yqb_origin
{
    return self.frame.origin;
}

- (void)setYqb_top:(CGFloat)yqb_top{
    CGRect frame = self.frame;
    frame.origin.y = yqb_top;
    self.frame = frame;
}

- (CGFloat)yqb_top{
    return self.frame.origin.y;
}

- (void)setYqb_left:(CGFloat)yqb_left{
    CGRect frame = self.frame;
    frame.origin.x = yqb_left;
    self.frame = frame;
}

- (CGFloat)yqb_left{
    return self.frame.origin.x;
}

- (void)setYqb_bottom:(CGFloat)yqb_bottom{
    CGRect frame = self.frame;
    frame.origin.y = yqb_bottom-frame.size.height;
    self.frame = frame;
}

- (CGFloat)yqb_bottom{
    return self.yqb_y+self.yqb_height;
}

- (void)setYqb_right:(CGFloat)yqb_right{
    CGRect frame = self.frame;
    frame.origin.x = yqb_right-frame.size.width;
    self.frame = frame;
}

- (CGFloat)yqb_right{
    return self.yqb_x+self.yqb_width;
}

- (void)setYqb_centerX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)yqb_centerX
{
    return self.center.x;
}

- (void)setYqb_centerY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)yqb_centerY
{
    return self.center.y;
}

+ (NSString *)getIphoneType
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone5,1"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"])  return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"])  return@"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"])  return@"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"])  return@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"])  return@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"])  return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,3"])  return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"])  return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone9,4"])  return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    
    if([platform  isEqualToString:@"iPhone11,8"]) return@"iPhone XR";
    
    if([platform  isEqualToString:@"iPhone11,2"]) return@"iPhone XS";
    
    if([platform  isEqualToString:@"iPhone11,4"]) return@"iPhone XS Max";
    
    if([platform  isEqualToString:@"iPhone11,6"]) return@"iPhone XS Max";
    
    if([platform isEqualToString:@"iPhone12,1"])  return @"iPhone 11 X";
    if([platform isEqualToString:@"iPhone12,3"])  return @"iPhone 11 Pro X";
    if([platform isEqualToString:@"iPhone12,5"])  return @"iPhone 11 Pro Max X";
    
    return @"Other Platform";
}

+ (BOOL)XSeries{
    
    if ([[UIView getIphoneType] containsString:@"X"]) {
        return YES;
    }
    return NO;
    
}

+ (BOOL)SmallSizeType
{
    NSString * type = [UIView getIphoneType];
    
    if ([type containsString:@"5"]) return YES;
    
    if ([type containsString:@"SE"]) return YES;
    
    if([type isEqualToString:@"iPhone 6"])  return YES;
    
    if([type isEqualToString:@"iPhone 6s"])  return YES;
    
    if([type isEqualToString:@"iPhone 7"])  return YES;
    
    if([type isEqualToString:@"iPhone 8"])  return YES;
    
    if([type isEqualToString:@"Other Platform"])  return YES;
    
    return NO;
}


+ (CGRect)screenFrame
{
    return [[UIScreen mainScreen] bounds];
}

+ (CGFloat)screenWidth
{
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)screenHeight
{
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGFloat)statusBarHeight
{
    return  [[UIApplication sharedApplication]statusBarFrame].size.height;
}

- (CGFloat)coordinateX
{
    return self.frame.origin.x;
}

- (CGFloat)coordinateY
{
    return self.frame.origin.y;
}

//视图的高
- (CGFloat)sizeHeight
{
    return self.frame.size.height;
}

//视图的宽
- (CGFloat)sizeWidth
{
    return self.frame.size.width;
}

//系统样式颜色
+ (UIColor*)styleColor
{
    return [UIColor colorWithRed:251/255.0 green:129/255.0 blue:72/255.0 alpha:1];
}

@end
