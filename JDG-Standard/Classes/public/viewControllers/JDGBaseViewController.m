//
//  JDGBaseViewController.m
//  JDG-Standard
//
//  Created by JDGan on 2018/11/27.
//

#import "JDGBaseViewController.h"
#import "JDGBaseTableViewCell.h"
#import "JDGBaseCollectionViewCell.h"

@interface JDGBaseViewController ()

@end

@interface JDGBaseViewController (View)
<UITableViewDataSource
,UITableViewDelegate
,UICollectionViewDataSource
,UICollectionViewDelegateFlowLayout
,UIGestureRecognizerDelegate>
@end

@interface JDGBaseViewController (Data)

@end

@interface JDGBaseViewController (Action)

@end

@implementation JDGBaseViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    // 添加主题监听通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshThemeSubviews) name:kHYThemeChangedNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%@ Dealloced",self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray array];
    [self refreshThemeSubviews];
}

+ (instancetype)create {
    if([self storyBoardName]) {
        UIStoryboard *s = [UIStoryboard storyboardWithName:[self storyBoardName] bundle:nil];
        JDGBaseViewController *v = [s instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
        return v;
    }
    return nil;
}

+ (NSString *)storyBoardName {
    NSLog(@"调用create方法需要加载的方法，请在子类实现对应的操作");
    return nil;
}

- (void)object:(id)object shouldProcessExtraData:(id)data {
    NSLog(@"如果需要做数据处理事件，请在子类实现对应的操作");
}

- (void)refreshThemeSubviews {
    NSLog(@"如果需要做根据主题通知刷新UI，请在子类实现对应的操作");
}

@end

@implementation JDGBaseViewController (View)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    JDGBaseListSection *sec = [self.dataSource objectAtIndex:section];
    return sec.children.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JDGBaseListSection *sec = [self.dataSource objectAtIndex:indexPath.section];
    JDGBaseListObject *obj = [sec.children objectAtIndex:indexPath.row];
    JDGBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:obj.cellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    [cell customizeWithData:obj.data];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    JDGBaseListSection *sec = [self.dataSource objectAtIndex:indexPath.section];
    JDGBaseListObject *obj = [sec.children objectAtIndex:indexPath.row];
    return obj.itemHeight;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    JDGBaseListSection *sec = [self.dataSource objectAtIndex:section];
    return sec.children.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JDGBaseListSection *sec = [self.dataSource objectAtIndex:indexPath.section];
    JDGBaseListObject *obj = [sec.children objectAtIndex:indexPath.row];
    JDGBaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:obj.cellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    [cell customizeWithData:obj.data];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    JDGBaseListSection *sec = [self.dataSource objectAtIndex:indexPath.section];
    JDGBaseListObject *obj = [sec.children objectAtIndex:indexPath.row];
    return obj.itemSize;
}

@end

@implementation JDGBaseViewController (Data)

@end

@implementation JDGBaseViewController (Action)

@end
