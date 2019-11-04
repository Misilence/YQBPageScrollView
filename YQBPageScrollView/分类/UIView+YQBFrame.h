

#import <UIKit/UIKit.h>

@interface UIView (YQBFrame)

@property (assign, nonatomic) CGFloat yqb_x;
@property (assign, nonatomic) CGFloat yqb_y;
@property (assign, nonatomic) CGFloat yqb_width;
@property (assign, nonatomic) CGFloat yqb_height;
@property (assign, nonatomic) CGSize  yqb_size;
@property (assign, nonatomic) CGPoint yqb_origin;
@property (assign, nonatomic) CGFloat yqb_top;
@property (assign, nonatomic) CGFloat yqb_left;
@property (assign, nonatomic) CGFloat yqb_bottom;
@property (assign, nonatomic) CGFloat yqb_right;
@property (assign, nonatomic) CGFloat yqb_centerX;
@property (assign, nonatomic) CGFloat yqb_centerY;

+ (NSString *)getIphoneType;

+ (BOOL)XSeries;

+ (BOOL)SmallSizeType;

+ (CGRect)screenFrame;

+ (CGFloat)screenWidth;

+ (CGFloat)screenHeight;

+ (CGFloat)statusBarHeight;

- (CGFloat)coordinateX;

- (CGFloat)coordinateY;

- (CGFloat)sizeHeight;

- (CGFloat)sizeWidth;

+ (UIColor*)styleColor;
@end
