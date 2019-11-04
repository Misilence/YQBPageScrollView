

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YQBTitleModel : NSObject

@property (strong,nonatomic) NSString * title;
@property (strong,nonatomic) UIFont   * font;
@property (assign,nonatomic) NSTextAlignment textAlignment;

+(instancetype)titleModelWithTitle:(NSString *)title font:(CGFloat)font textAlignment:(NSTextAlignment)textAlignment;

@end
