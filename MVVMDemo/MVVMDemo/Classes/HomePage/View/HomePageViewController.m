//
//  HomePageViewController.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/12.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "HomePageViewController.h"
#import "XYHomePageViewModel.h"
#import "HomePageRequestItem.h"

@interface HomePageViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imgPC;
@property (nonatomic, strong) XYHomePageViewModel *vm;

@end

@implementation HomePageViewController

- (UIImagePickerController *)imgPC {
    if (_imgPC == nil) {
        _imgPC = [UIImagePickerController new];
        _imgPC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _imgPC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        _imgPC.allowsEditing = YES;
        
    }
    return _imgPC;
}

- (XYHomePageViewModel *)vm {
    if (_vm == nil) {
        _vm = [XYHomePageViewModel new];
    }
    return _vm;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"首页";
    
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    b.frame = CGRectMake(100, 100, 200, 50);
    b.backgroundColor = kColor(200, 200, 50, 1.0);
    [self.view addSubview:b];
    [b addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.imgPC.delegate = self;
}

/// 上传图片到服务器
- (void)btnClick:(UIButton *)b {
    
    [self presentViewController:self.imgPC animated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // 获取图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSString *url = info[UIImagePickerControllerReferenceURL];
    
    
    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        // 上传图片
        [self upload:image name:url];
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)upload:(UIImage *)image name:(NSString *)name {
    
    [self.vm xy_viewModelWithConfigRequest:^(id<XYRequestProtocol> requestItem) {
        
        /// 处理request
        HomePageRequestItem *item = (HomePageRequestItem *)requestItem;
        item.xy_fileConfig = [XYRequestFileConfig fileConfigWithFormData:UIImagePNGRepresentation(image) name:@"name" fileName:@"sas" mimeType:@"image/png"];
        
    } progress:nil success:^(id responseObject) {
//        NSLog(@"---%@", responseObject);
        id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"---%@", obj);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    
}

@end
