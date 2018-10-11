//
//  MineViewController.m
//  YXChat
//
//  Created by ios on 2018/10/9.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "MineViewController.h"
#import "masonry.h"
#import <JMessage/JMessage.h>

@interface MineViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic,strong) UIButton *logoutButton;
@property (nonatomic,strong) UIButton *uploadThumbButton;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)initUI{
    self.logoutButton = [[UIButton alloc] init];
    [self.view addSubview:self.logoutButton];
    self.logoutButton.backgroundColor = [UIColor orangeColor];
    [self.logoutButton setTitle:@"注销" forState:UIControlStateNormal];
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(60);
        make.right.mas_equalTo(-60);
        make.height.mas_equalTo(50);
    }];
    [self.logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *uploadThumbButton = [[UIButton alloc] init];
    self.uploadThumbButton = uploadThumbButton;
    [self.view addSubview:uploadThumbButton];
    self.uploadThumbButton.backgroundColor = [UIColor orangeColor];
    [self.uploadThumbButton setTitle:@"上传头像" forState:UIControlStateNormal];
    [self.uploadThumbButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.logoutButton.mas_bottom).offset(30);
        make.left.mas_equalTo(60);
        make.right.mas_equalTo(-60);
        make.height.mas_equalTo(50);
    }];
    [self.uploadThumbButton addTarget:self action:@selector(uploadThumb) forControlEvents:UIControlEventTouchUpInside];
}
- (void)uploadThumb{
    UIAlertView * Alert=[[UIAlertView alloc]initWithTitle:@"请选择获取方式" message:@""
                                                 delegate:self cancelButtonTitle:@"取消" otherButtonTitles:
                         @"打开照相机",@"从手机相册获取", nil];
    Alert.delegate=self;
    [Alert show ];
}
- (void)logout{
    __weak typeof(self) weakSelf = self;
    [JMSGUser logout:^(id resultObject, NSError *error) {
        [weakSelf logoutNotification];
    }];
}

- (void)logoutNotification{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"logoutNotification" object:nil];
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self getAvatatFormCamera:self];//调用相机
    }
    if (buttonIndex ==2) {
        [self getAvatatFormPhotoLibrary:self];//调用相册
    }
}
- (void)getAvatatFormPhotoLibrary:(UIViewController *)controller
{
    //这里可以判断类型是相册还是相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        //加上下面这句会有编辑框
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }
}
- (void)getAvatatFormCamera:(UIViewController *)controller
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    picker.showsCameraControls = YES;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma - mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //这里可以选择image类型,
    //原图:UIImagePickerControllerOriginalImage
    //获取编辑框里的图:UIImagePickerControllerEditedImage
    UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    __weak typeof(self) weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        CGSize newSize = CGSizeMake(300, 300);
        UIGraphicsBeginImageContext(newSize);
        UIImage *imagechuansong = image;
        [imagechuansong drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        //上传图片,以文件形式,还是base64在这调用就ok、
        [weakSelf updateThumb:imagechuansong];
    }];
}

- (void)updateThumb:(UIImage *)image{
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    [JMSGUser updateMyInfoWithParameter:imageData userFieldType:kJMSGUserFieldsAvatar completionHandler:^(id resultObject, NSError *error) {
        NSLog(@"error = %@",error);
        
    }];
}
@end
