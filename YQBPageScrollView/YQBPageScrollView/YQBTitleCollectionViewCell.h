

#import <UIKit/UIKit.h>
#import "YQBTitleModel.h"
@interface YQBTitleCollectionViewCell : UICollectionViewCell

@property (strong,nonatomic) YQBTitleModel * titleModel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
