//
//  O2ODetailController.m
//  MagicWindowShow
//
//  Created by Tiyang Lou on 4/13/16.
//  Copyright © 2016 cafei. All rights reserved.
//

#import "O2ODetailController.h"
#import "O2OShowCell.h"
#import "SocialShareHelper.h"

@interface O2ODetailController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) SocialShareHelper *socialShareHelper;
@end

@implementation O2ODetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.allowsSelection = NO;
    self.socialShareHelper = [[SocialShareHelper alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
    [super viewWillDisappear:animated];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"O2OShowCell";
    [tableView registerNib:[UINib nibWithNibName:@"O2OShowCell" bundle:nil] forCellReuseIdentifier:identifier];
    O2OShowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CGRectGetWidth(tableView.frame)*385/400 + 223 + 88;
}

#pragma mark - IBActions

- (IBAction)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)shareButtonClicked:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"分享该页面到：" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *wechatFriends = [UIAlertAction actionWithTitle:@"微信好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.socialShareHelper sendWeChatWithScene:ShareTypeWXSession Title:@"HUGGIES好奇银装纸尿裤促销中" Content:@"美国品牌，妈妈们的第一选择！" ThumbImageData:UIImagePNGRepresentation([UIImage imageNamed:@"share-wechat"]) Url:@"http://documentation.magicwindow.cn/demo/49/index.html"];
    }];
    UIAlertAction *wechatMoments = [UIAlertAction actionWithTitle:@"朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.socialShareHelper sendWeChatWithScene:ShareTypeWXTimeline Title:@"HUGGIES好奇银装纸尿裤促销中" Content:@"美国品牌，妈妈们的第一选择！" ThumbImageData:UIImagePNGRepresentation([UIImage imageNamed:@"share-wechat"]) Url:@"http://documentation.magicwindow.cn/demo/49/index.html"];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:wechatFriends];
    [alert addAction:wechatMoments];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
