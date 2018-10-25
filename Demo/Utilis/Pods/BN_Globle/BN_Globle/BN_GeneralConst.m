//
//  BN_GeneralConst.m
//  HuiZhuBang
//
//  Created by hsf on 2018/5/14.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_GeneralConst.h"


NSString * const kNIl_TEXT            =   @"--";

#pragma mark - - kSet

NSString * const kSet_number            =   @"0123456789";
NSString * const kSet_float             =   @"0123456789.";
NSString * const kSet_alpha             =   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
NSString * const kSet_alpha_num         =   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

#pragma mark - - kTag

const NSInteger kTAG_LABEL = 100;
const NSInteger kTAG_BTN = 200;
const NSInteger kTAG_BTN_RightItem = 260;
const NSInteger kTAG_BTN_BackItem = 261;

const NSInteger kTAG_IMGVIEW = 300;
const NSInteger kTAG_TEXTFIELD = 400;
const NSInteger kTAG_TEXTVIEW = 500;
const NSInteger kTAG_ALERT_VIEW = 600;
const NSInteger kTAG_ACTION_SHEET = 700;
const NSInteger kTAG_PICKER_VIEW = 800;
const NSInteger kTAG_DATE_PICKER = 900;

const NSInteger kTAG_VIEW = 1000;
const NSInteger kTAG_VIEW_Segment = 1100;
const NSInteger kTAG_VIEW_RADIO = 1200;
const NSInteger kTAG_VIEW_Picture = 1300;

const NSInteger kTAG_UItableViewCell = 1500;

const NSInteger kTAG_ICAROUSEL = 950;
const NSInteger kTAG_PAGE_CONTROL = 951;

#pragma mark - -MacroGeometry与计算有关的尺寸属性

const CGFloat kH_StatusBar = 20;
const CGFloat kH_NaviagtionBar = 44;
const CGFloat kH_TabBar = 49;
const CGFloat kH_PickerView = 180;

const CGFloat kH_SegmentOfCustom = 50;
const CGFloat kH_SegmentControl = 44;

const CGFloat kH_searchBar = 36;
const CGFloat kH_searchBarBackgroud = 56;

const CGFloat kH_topView = 49;//itemsView高度
const CGFloat kH_slideView = 5;//指示器高度
const CGFloat kH_CellHeight = 60;

const CGFloat kX_GAP = 15;
const CGFloat kY_GAP = 10;
const CGFloat kPadding = 8.0;

const CGFloat kW_LayerBorder = 0.5;
const CGFloat kWH_ArrowRight = 25;
const CGFloat kTimerValue = 65;
const CGFloat kRatio_IDCard = 1.58;
const CGFloat kAnimationDuration_Toast = 1.0;
const CGFloat kAnimationDuration_Drop = 0.5;
const CGFloat kLeftMenuRatio = 0.8;

const CGFloat kW_item = 80;
const CGFloat kW_progressView = 130;

const CGFloat kH_LABEL = 25;
const CGFloat kH_LABEL_TITLE = 30;
const CGFloat kH_LABEL_SMALL = 20;

const CGFloat kH_TEXTFIELD = 30;
const CGFloat kH_LINE_VIEW =  1/3.0;
const CGFloat kW_LINE_Vert =  3.0;


#pragma mark - -font

const CGFloat KFZ_First =  18;
const CGFloat KFZ_Second = 16;
const CGFloat KFZ_Third =  14;
const CGFloat KFZ_Fouth =  12;
const CGFloat KFZ_Fifth =  10;

#pragma mark - -视图

NSString * const kIMAGE_arrowRight = @"img_arrowRight_gray.png";
NSString * const kIMAGE_arrowDown = @"img_arrowDown_black.png";
NSString * const kIMAGE_arrowBack = @"img_arrowLeft_white.png";

NSString * const kIMAGE_default_User = @"img_portrait_Default.png";
NSString * const kIMAGE_default_User_N = @"img_headPortrait_N.png";
NSString * const kIMAGE_default_User_H = @"img_headPortrait_H.png";
NSString * const kIMAGE_defaultAddPhoto = @"img_photoAddDefault.png";
NSString * const kIMAGE_photoDelete = @"img_Picture_Delete.png";

NSString * const kIMAGE_default_failed = @"imageFailedDefault.png";
NSString * const kIMAGE_default_failed_S = @"imageFailedDefault_S.png";

NSString * const kIMAGE_SexBoy = @"img_sex_boy.png";
NSString * const kIMAGE_SexGril = @"img_sex_gril.png";

NSString * const kIMAGE_elemetDecrease = @"decrease_elemet";
NSString * const kIMAGE_elemetIncrease = @"increase_elemet";

NSString * const kIMAGE_scan = @"img_scan.png";
NSString * const kIMAGE_NFC = @"img_NFC.png";
NSString * const kIMAGE_update = @"img_dialog_update";
NSString * const kIMAGE_inquiry = @"img_dialog_inquiry";
NSString * const kIMAGE_warning = @"img_dialog_warning";


NSString * const kMsg_NetWorkRequesting = @"网络请求中...";
NSString * const kMsg_NetWorkFailed = @"网络请求失败,请稍后再试";
NSString * const kMsg_NetWorkNodata = @"暂无数据";
NSString * const kMsg_NetWorkNoMoredata = @"没有更多数据了";
NSString * const kMsg_NetWorkFailed_Params = @"参数错误,请稍后再试";

NSString * const kMsg_Locationing = @"定位中...";
NSString * const kMsg_LocationSuccess = @"位置信息更新成功!";
NSString * const kMsg_LocationFailed = @"定位失败,请稍后再试";
NSString * const kMsg_IDCardFailed = @"身份证识别失败,请稍后再试";
NSString * const kMsg_IDCardSuccess = @"身份证识别成功";


NSString * const kActionTitle_Know = @"知道了";
NSString * const kActionTitle_Sure = @"确定";
NSString * const kActionTitle_Cancell = @"取消";
NSString * const kActionTitle_Delete = @"删除";
NSString * const kActionTitle_Drop = @"彻底删除";
NSString * const kActionTitle_Call = @"呼叫";
NSString * const kActionTitle_Update = @"立即升级";

NSString * const kActionTitle_Collect = @"收藏";
NSString * const kActionTitle_Recover = @"恢复";


#pragma mark - - 通用

NSString * const kDes_week              =   @"星期一,星期二,星期三,星期四,星期五,星期六,星期天,";

NSString * const kItem_obj              =   @"kItem_obj";
NSString * const kItem_objSeleted       =   @"kItem_objSeleted";
NSString * const kItem_block            =   @"kItem_block";

NSString * const kItem_title            =   @"kItem_title";
NSString * const kItem_titleColor       =   @"kItem_titleColor";
NSString * const kItem_textField        =   @"kItem_textField";

NSString * const kItem_titleSub         =   @"kItem_titleSub";
NSString * const kItem_titleSubColor    =   @"kItem_titleSubColor";
NSString * const kItem_titleSection     =   @"kItem_titleSection";

NSString * const kItem_image            =   @"kItem_image";
NSString * const kItem_image_H          =   @"kItem_image_H";

NSString * const kItem_controller       =   @"kItem_controller";
NSString * const kItem_controller_Title =   @"kItem_controller_Title";
NSString * const kItem_Height           =   @"kItem_Height";

NSString * const kItem_dataList         =   @"kItem_dataList";
NSString * const kItem_finished         =   @"kItem_finish";

NSString * const kItem_header           =   @"kItem_header";
NSString * const kItem_footer           =   @"kItem_footer";

#pragma mark - -推送通知

NSString * const kNoti_title    = @"kNoti_title";
NSString * const kNoti_subtitle = @"kNoti_subtitle";
NSString * const kNoti_body     = @"kNoti_body";
NSString * const kNoti_badge    = @"kNoti_badge";


#pragma mark - -通知

NSString * const kNotiPost_logIn = @"kNotiPost_logIn";
NSString * const kNotiPost_logOut = @"kNotiPost_logOut";
NSString * const kNotiPost_backgroudUploadLocation = @"kNotiPost_backgroudUploadLocation";

@implementation BN_GeneralConst

@end
