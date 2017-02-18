//
//  MessageViewController.m
//  MVVMDemo
//
//  Created by mofeini on 17/2/12.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageViewModel.h"
#import "UploadRequestItem.h"

@interface MessageViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) MessageViewModel *vm;
@property (nonatomic, strong) UIImagePickerController *imgPC;

@end

@implementation MessageViewController

- (UIImagePickerController *)imgPC {
    if (_imgPC == nil) {
        _imgPC = [UIImagePickerController new];
        _imgPC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _imgPC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        _imgPC.allowsEditing = YES;
        
    }
    return _imgPC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"消息";
    
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    b.frame = CGRectMake(100, 100, 200, 50);
    b.backgroundColor = kColor(200, 200, 50, 1.0);
    [self.view addSubview:b];
    [b addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

    self.imgPC.delegate = self;
}

- (void)btnClick:(UIButton *)b {
    
    [self presentViewController:self.imgPC animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // 获取图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSString *url = info[UIImagePickerControllerReferenceURL];
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
            // 上传图片
            [self upload:image name:url];
        }];
    }];
    
}

- (void)upload:(UIImage *)image name:(NSString *)name {
    
    /// 保存
    [self.vm xy_viewModelWithProgress:nil success:^(id responseObject) {
        
        // 上传成功后，返回datas，拿到后将其传给updateTrendFile
        if ([responseObject[@"code"] integerValue] == 0) {
            // 上传图片
            [self.vm xy_viewModelWithConfigRequest:^(id<XYRequestProtocol> request) {
                // 配置请求对象
                UploadRequestItem*item = (UploadRequestItem *)request;
                
                // file，tid=10673， type=1，file=image.jpg(数组)
                item.xy_params = @{@"tid": responseObject[@"datas"], @"type": @"1", @"file": UIImagePNGRepresentation(image)};
                item.xy_fileConfig = [[XYRequestFileConfig alloc] initWithFormData:UIImagePNGRepresentation(image) name:@"file" fileName:@"image.jpg" mimeType:@"image/jpg"];
                
            } progress:^(NSProgress *progress) {
                NSLog(@"%@", progress);
            } success:^(id responseObject) {
                NSLog(@"%@", responseObject);
            } failure:^(NSError *error) {
                NSLog(@"%@", error);
            }];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    
}

- (MessageViewModel *)vm {
    if (_vm == nil) {
        _vm = [MessageViewModel new];
    }
    return _vm;
}


@end
