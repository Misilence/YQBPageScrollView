

#import "YQBTitleModel.h"

@implementation YQBTitleModel
+(instancetype)titleModelWithTitle:(NSString *)title font:(CGFloat)font textAlignment:(NSTextAlignment)textAlignment{
    YQBTitleModel *titleModel = [YQBTitleModel new];
    titleModel.title = title;
    
    if (font != 0) {
        titleModel.font = [UIFont systemFontOfSize:font];
    }
    
    titleModel.textAlignment = textAlignment;
    
    return titleModel;
}
@end
