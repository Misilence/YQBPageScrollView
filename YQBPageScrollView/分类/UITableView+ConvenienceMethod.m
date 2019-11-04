
#import "UITableView+ConvenienceMethod.h"

@implementation UITableView (ConvenienceMethod)
+(UITableView *)tableViewWithFrame:(CGRect)frame
                             Style:(UITableViewStyle)style
                          delegate:(id<UITableViewDelegate>)delegate
                        dataSource:(id<UITableViewDataSource>)dataSource
                    sectionHeaderH:(CGFloat)shh
                    sectionFooterH:(CGFloat)sfh
                     cellClassName:(__unsafe_unretained Class)cellClassName
                  cellNibClassName:(__unsafe_unretained Class)cellNibClassName{
    UITableView *tableView  = [[UITableView alloc] initWithFrame:frame
                                                            style:style];
     if (delegate) {
         tableView.delegate                  = delegate  ;
     }
     if (dataSource) {
         tableView.dataSource                = dataSource  ;
     }
    tableView.sectionHeaderHeight       = shh!=0?:0.01;
    tableView.sectionFooterHeight       = sfh!=0?:0.01;
    
    tableView.tableFooterView           = [UIView new];
    if (cellClassName!=nil) {
        [tableView registerClass:cellClassName forCellReuseIdentifier:NSStringFromClass(cellClassName)];
    }else if (cellNibClassName!=nil){
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass(cellNibClassName) bundle:nil] forCellReuseIdentifier:NSStringFromClass(cellNibClassName)];
    }
    return tableView;
}

+(UITableView *)tableViewWithFrame:(CGRect)frame
                             Style:(UITableViewStyle)style
                     cellClassName:(__unsafe_unretained Class)cellClassName
                          delegate:(id<UITableViewDelegate>)delegate
                        dataSource:(id<UITableViewDataSource>)dataSource
                    sectionHeaderH:(CGFloat)shh
                    sectionFooterH:(CGFloat)sfh{
    return [self tableViewWithFrame:frame Style:style delegate:delegate dataSource:dataSource sectionHeaderH:shh sectionFooterH:sfh cellClassName:cellClassName cellNibClassName:nil];
}

+(UITableView *)tableViewWithFrame:(CGRect)frame
                             Style:(UITableViewStyle)style
                  cellNibClassName:(Class)cellNibClassName
                          delegate:(id<UITableViewDelegate>)delegate
                        dataSource:(id<UITableViewDataSource>)dataSource
                    sectionHeaderH:(CGFloat)shh
                    sectionFooterH:(CGFloat)sfh{
    return [self tableViewWithFrame:frame Style:style delegate:delegate dataSource:dataSource sectionHeaderH:shh sectionFooterH:sfh cellClassName:nil cellNibClassName:cellNibClassName];
}


+(UITableView *)tableViewWithStyle:(UITableViewStyle)style
                          delegate:(id<UITableViewDelegate>)delegate
                        dataSource:(id<UITableViewDataSource>)dataSource
                    sectionHeaderH:(CGFloat)shh
                    sectionFooterH:(CGFloat)sfh{
    return [self tableViewWithFrame:CGRectZero Style:style delegate:delegate dataSource:dataSource sectionHeaderH:shh sectionFooterH:sfh cellClassName:nil cellNibClassName:nil];
}
@end
