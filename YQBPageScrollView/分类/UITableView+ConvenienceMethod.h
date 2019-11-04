

#import <UIKit/UIKit.h>

@interface UITableView (ConvenienceMethod)
+(UITableView *)tableViewWithFrame:(CGRect)frame
                             Style:(UITableViewStyle)style
                     cellClassName:(Class)cellClassName
                          delegate:(id<UITableViewDelegate>)delegate
                        dataSource:(id<UITableViewDataSource>)dataSource
                    sectionHeaderH:(CGFloat)shh
                    sectionFooterH:(CGFloat)sfh;
                     

+(UITableView *)tableViewWithFrame:(CGRect)frame
                             Style:(UITableViewStyle)style
                  cellNibClassName:(Class)cellNibClassName
                          delegate:(id<UITableViewDelegate>)delegate
                        dataSource:(id<UITableViewDataSource>)dataSource
                    sectionHeaderH:(CGFloat)shh
                    sectionFooterH:(CGFloat)sfh;
                  

+(UITableView *)tableViewWithStyle:(UITableViewStyle)style
                          delegate:(id<UITableViewDelegate>)delegate
                        dataSource:(id<UITableViewDataSource>)dataSource
                    sectionHeaderH:(CGFloat)shh
                    sectionFooterH:(CGFloat)sfh;
@end
