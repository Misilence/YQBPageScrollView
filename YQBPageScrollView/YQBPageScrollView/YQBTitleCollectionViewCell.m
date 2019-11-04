

#import "YQBTitleCollectionViewCell.h"

@implementation YQBTitleCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setTitleModel:(YQBTitleModel *)titleModel{
    _titleModel = titleModel;
    
    _titleLabel.text = titleModel.title;
    _titleLabel.font = titleModel.font;
    _titleLabel.textAlignment = titleModel.textAlignment;
    
}
@end
