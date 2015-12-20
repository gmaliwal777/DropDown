//
//  DropDownView.h
//  eCitzens
//
//  Created by Ghanshyam on 3/23/15.
//  Copyright (c) 2015 Ghanshyam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Options.h"

@protocol DropDownDelegate <NSObject>
-(void)dropDownCancelled:(id)referenceObj;
-(void)dropDownDidSelect:(Options *)option referenceObj:(id)referenceObj;
@end

@interface DropDownView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>{
  UIColor     *tintColor;
}

@property(nonatomic,weak)               id<DropDownDelegate>        delegate;
@property(nonatomic,weak)   IBOutlet    UIBarButtonItem             *btnCancel;
@property(nonatomic,weak)   IBOutlet    UIBarButtonItem             *btnDone;
@property(nonatomic,weak)   IBOutlet    UILabel                     *lblHeader;
@property(nonatomic,weak)               id                          callingObj;
@property(nonatomic,assign)             BOOL                        showing;
@property(nonatomic,strong)             NSString                    *strTitle;
@property(nonatomic,strong) IBOutlet    UIView                      *view;
@property(nonatomic,weak)   IBOutlet    UIPickerView                *pickerView;
@property(nonatomic,strong)             NSArray                     *arrMenuOptions;


-(id)initWithFrame:(CGRect)frame color:(UIColor *)tColor;
-(void)setOptions:(NSArray *)arrOptions;


@end
