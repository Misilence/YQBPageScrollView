

#import "YQBPageScrollView.h"
#import "YQBTitleCollectionViewCell.h"

@interface YQBPageScrollView()

/**
 当前title编号 默认0
 */
@property (assign,nonatomic) NSUInteger currentTitleIndex;

/**
 item大小
 */
@property (assign,nonatomic) CGSize  itemSize;



@end

static NSString * const kCollectionViewCellRI = @"collectionViewCell";
static NSString * const kTableViewCellRI      = @"tableViewCell";

@implementation YQBPageScrollView
@synthesize itemW = _itemW;

#pragma mark - 3个初始化方法
+(instancetype)pageScrollViewWithFrame:(CGRect)frame titles:(NSArray *)titles{
    YQBPageScrollView *pageTableView = [[YQBPageScrollView alloc] initWithFrame:frame];
       [pageTableView setTitleModelMAWithTitles:titles];
       return pageTableView;
}

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        
        ///创建布局对象
        _flowLayout          = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing      = 0;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.sectionInset    = UIEdgeInsetsZero;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        ///创建集合视图
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:_flowLayout];
        _collectionView.backgroundColor                = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator   = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.contentInset = UIEdgeInsetsZero;
        _collectionView.dataSource   = self;
        _collectionView.delegate     = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"YQBTitleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kCollectionViewCellRI];
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        ///集合视图添加滑块视图
        _sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 8)];
        _sliderView.backgroundColor = [UIColor blackColor];
        [_collectionView addSubview:_sliderView];
        
        ///self添加集合视图
        [self addSubview:_collectionView];
        
        ///self 添加 分割线
        _breakLineView = [UIView new];
        _breakLineView.backgroundColor = [UIColor colorWithRed:229 green:229 blue:229 alpha:1];
        [self addSubview:_breakLineView];
        
        //中部视图 用来自定义放置一些视图  不会
        _centerView = [UIView new];
        _centerView.backgroundColor = [UIColor whiteColor];
        _centerView.clipsToBounds = YES;
        [self addSubview:_centerView];
        
        //中部视图底部的分割线。
        _centerViewBottomLine = [UIView new];
        _centerViewBottomLine.backgroundColor = [UIColor colorWithRed:229 green:229 blue:229 alpha:1];
        [_centerView addSubview:_centerViewBottomLine];
        
        
        ///self 添加滚动视图
        _scrollView = [UIScrollView new];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator   = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate      = self;
        [self addSubview:_scrollView];
        
        ///初始化数据
        [self initData];
        
        [self updateFrame];
    }
    return self;
}

-(void)initData{
    _collectionView.frame = CGRectMake(0, 0, 0, 35);
    _itemW                = 70;
    _itemSize             = CGSizeMake(_itemW, _collectionView.yqb_height);
    _flowLayout.itemSize  = _itemSize;
    _selectedTitleColor   = [UIColor blackColor];
    _unselectedTitleColor = [UIColor blackColor];
    _selectedTitleFont    = [UIFont systemFontOfSize:12];
    _unselectedTitleFont  = [UIFont systemFontOfSize:12];
    _sliderView.yqb_width     = 35;
    _sliderView.yqb_height     = 2;
    _sliderView.backgroundColor = [UIColor blackColor];
    _currentTitleIndex    = 0;
    
    _viewMD          = [NSMutableDictionary dictionary];
    
}

#pragma mark - 自定义的方法
//数据刷新以后
-(void)updateData{
    //设置titles以后 需要更新数据
    [self.collectionView reloadData];
    [self layoutIfNeeded];
}

-(void)updateFrame{
    CGFloat selfH         = self.bounds.size.height;
    //集合视图
    CGFloat collectionViewX   = _collectionView.yqb_x;
    CGFloat collectionViewY   = _collectionView.yqb_y;
    CGFloat collectionViewW   = _collectionView.yqb_width == 0?self.yqb_width:_collectionView.yqb_width;
    CGFloat collectionViewH   = _collectionView.yqb_height;
    self.collectionView.frame = CGRectMake(collectionViewX, collectionViewY, collectionViewW, collectionViewH);
    
    //滑块视图
    CGFloat sliderViewW   = _sliderView.yqb_width;
    CGFloat sliderViewH   = _sliderView.yqb_height;
    CGFloat sliderViewX   = self.currentTitleIndex*self.itemSize.width + (self.itemSize.width - sliderViewW)/2 + _flowLayout.sectionInset.left;
    CGFloat sliderViewY   = _collectionView.yqb_height-sliderViewH;
    self.sliderView.yqb_origin = CGPointMake(sliderViewX, sliderViewY);
    
    //分割线视图
    CGFloat breakLineViewW   = self.yqb_width;
    CGFloat breakLineViewH   = 1/[UIScreen mainScreen].scale;
    CGFloat breakLineX       = 0;
    CGFloat breakLineY       = collectionViewY +_collectionView.yqb_height;
    self.breakLineView.frame = CGRectMake(breakLineX, breakLineY, breakLineViewW, breakLineViewH);
    
    //中部视图
    [self.centerView bringSubviewToFront:self.centerViewBottomLine];
    self.centerView.frame = CGRectMake(0, _breakLineView.yqb_bottom, self.yqb_width, self.centerViewHeight);
    //中部视图底部的分割线
    CGFloat centerViewBottomLineH = 1/[UIScreen mainScreen].scale;
    self.centerViewBottomLine.frame =CGRectMake(0, self.centerViewHeight-centerViewBottomLineH, self.centerView.yqb_width, centerViewBottomLineH);
    
    //下面的滚动视图
    CGFloat scrollViewX   = 0;
    CGFloat scrollViewY   = self.centerView.yqb_bottom;
    CGFloat scrollViewW   = self.yqb_width;
    CGFloat scrollViewH   = selfH-scrollViewY;
    self.scrollView.frame = CGRectMake(scrollViewX, scrollViewY, scrollViewW, scrollViewH);
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width * self.titleModelMA.count, scrollViewH);
    
    if (self.viewMD.count!=0) {
        [self.viewMD enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, __kindof UIView * _Nonnull obj, BOOL * _Nonnull stop) {
            obj.frame = CGRectMake(obj.tag*scrollViewW, 0, scrollViewW, scrollViewH);
        }];
    }
}


/**
 更新sliderViewX
 */
-(void)updateSliderViewFrameWithContentOffsetX:(CGFloat)x{
    CGRect  frame   = self.sliderView.frame;
    CGFloat originX =  (self.itemW - CGRectGetWidth(frame))/2;
    frame.origin.x  = originX + x;//originX指的是sliderViewX的起点
    self.sliderView.frame = frame;
}

#pragma mark - 公开方法

-(void)setTitleModelMAWithTitles:(NSArray *)titles{
    NSMutableArray      *titleModelMA  =  [NSMutableArray array];
    [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [titleModelMA addObject:[YQBTitleModel titleModelWithTitle:obj font:12 textAlignment:NSTextAlignmentCenter]];
    }];
    self.titleModelMA = titleModelMA;
}

-(void)changeTitle:(NSString *)title forPageIndex:(NSUInteger )index{
    if (index>=_titleModelMA.count) {
        return;
    }
    _titleModelMA[index].title = title;
    YQBTitleCollectionViewCell *cell = (YQBTitleCollectionViewCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    cell.titleLabel.text = title;
    
}

-(void)autoLoadCurrentViewData{
    if ([self.delegate respondsToSelector:@selector(pageScrollView:tableViewForIndexOfTitle:)]) {
        [self.delegate pageScrollView:self tableViewForIndexOfTitle:self.currentTitleIndex];
    }
}
-(void)selectViewWithIndex:(NSUInteger)index{
    if (index>=self.titleModelMA.count) {
        return;
    }
    //1.选中当前
    [self collectionView:self.collectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
}
-(void)addPageView:(__kindof UIView *)view forKey:(NSString *)titleKey index:(NSUInteger)index{
    if (!view) {
        return;
    }
    [self.viewMD setValue:view forKey:titleKey];
    view.tag = index;
    [self.scrollView  addSubview:view];
    [self setNeedsLayout];

}

#pragma mark - 重写系统方法
-(void)layoutSubviews{
    [super layoutSubviews];

    [self updateFrame];

}

#pragma mark  - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titleModelMA.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YQBTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellRI forIndexPath:indexPath];
    cell.titleModel = self.titleModelMA[indexPath.row];
    if (indexPath.row == _currentTitleIndex) {
        cell.titleLabel.textColor = self.selectedTitleColor;
        cell.titleLabel.font = self.selectedTitleFont;
    }else{
        cell.titleLabel.textColor = self.unselectedTitleColor;
        cell.titleLabel.font = self.unselectedTitleFont;
    }
    return cell;
}
#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ///数据驱动视图变化
    //更新当前标题索引
    self.currentTitleIndex=indexPath.row;
    //滚动视图滚动到对应title的位置
    [self.scrollView setContentOffset:CGPointMake(self.currentTitleIndex*self.scrollView.bounds.size.width, 0) animated:YES];
    if ([self.delegate respondsToSelector:@selector(pageScrollView:tableViewForIndexOfTitle:)]) {
        [self.delegate pageScrollView:self tableViewForIndexOfTitle:self.currentTitleIndex];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.itemSize;
}


#pragma mark - UIScrollViewDelegate 滚动视图变化驱动数据变化

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isMemberOfClass:[UIScrollView class]]) {
        [self updateSliderViewFrameWithContentOffsetX:self.itemW*scrollView.contentOffset.x/self.yqb_width];//100上面item的宽度
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    //滚动视图滚动到对应title的位置
    if ([scrollView isMemberOfClass:[UIScrollView class]]) {
        //更新当前索引
        NSUInteger newTitleNumber = scrollView.contentOffset.x/self.bounds.size.width;
        if (newTitleNumber == _currentTitleIndex) {
            return;
        }
        self.currentTitleIndex = newTitleNumber;
        if ([_delegate respondsToSelector:@selector(pageScrollView:tableViewForIndexOfTitle:)]) {
            [_delegate pageScrollView:self tableViewForIndexOfTitle:self.currentTitleIndex];
        };
    }
}



#pragma mark - Setter
//数据区
-(void)setCurrentTitleIndex:(NSUInteger)currentTitleNumber{
    NSUInteger oldIndex = _currentTitleIndex;
    _currentTitleIndex = currentTitleNumber;
    //之前的选中cell 变为非选中状态 进行相关设置
    YQBTitleCollectionViewCell * oldCell = (YQBTitleCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:oldIndex inSection:0]];
    //属性设置
    oldCell.titleLabel.textColor = self.unselectedTitleColor;
    oldCell.titleLabel.font = self.unselectedTitleFont;
    //当前cell 设置选中状态相关属性设置
    YQBTitleCollectionViewCell *currentCell = (YQBTitleCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentTitleIndex inSection:0]];
    //相关属性设置
    currentCell.titleLabel.textColor = self.selectedTitleColor;
    currentCell.titleLabel.font      = self.selectedTitleFont;
    //完成以后 滚动到指定选项。
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentTitleIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
}

-(void)setItemW:(CGFloat)itemW{
    _itemW    = itemW;
    _itemSize = CGSizeMake(itemW, _collectionView.yqb_height);
    [self.collectionView reloadData];
}

-(void)setTitleModelMA:(NSMutableArray<YQBTitleModel *> *)titleModelMA{
    _titleModelMA = titleModelMA;
    [self updateData];
}




@end
