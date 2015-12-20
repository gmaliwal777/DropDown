//
//  DropDownView.m
//  eCitzens
//
//  Created by Ghanshyam on 3/23/15.
//  Copyright (c) 2015 Ghanshyam. All rights reserved.
//

#import "DropDownView.h"

@implementation DropDownView

@synthesize strTitle = _strTitle;

#pragma mark--
#pragma mark-- Getter & Setter
-(NSString *)strTitle{
    return _strTitle;
}

-(void)setStrTitle:(NSString *)strTitle{
    _strTitle = strTitle;
    NSLog(@"title is in setter%@",_strTitle);
    self.lblHeader.text = _strTitle;
}

#pragma mark--
#pragma mark-- UIView Class LifeCycle

-(id)initWithFrame:(CGRect)frame color:(UIColor *)tColor{
    self = [super initWithFrame:frame];
    if (self) {
        tintColor = tColor;
        [[NSBundle mainBundle] loadNibNamed:@"DropDownView" owner:self options:nil];
        [self addSubview:self.view];
        [_lblHeader setText:_strTitle];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [self initWithCoder:aDecoder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"DropDownView" owner:self options:nil];
        [self addSubview:self.view];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"DropDownView" owner:self options:nil];
        [self addSubview:self.view];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    [self.view setFrame:self.bounds];
    //self.view.frame = self.bounds;
    NSLog(@"view frame is %@",NSStringFromCGRect(self.view.frame));
    [_btnCancel setTintColor:UIColorFromRedGreenBlue(0.f, 171.f, 234.f)];
    [_btnDone setTintColor:UIColorFromRedGreenBlue(0.f, 171.f, 234.f)];
    
    [_lblHeader setText:_strTitle];
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.strTitle = nil;
    // arrMenuOptions = nil;
    NSLog(@"custom calendar dealloc");
}

-(void)setOptions:(NSArray *)arrOptions{
    _arrMenuOptions = arrOptions;
    [_lblHeader setText:_strTitle];
    
    [_pickerView reloadAllComponents];
}

#pragma mark--
#pragma mark-- UIPickerViewDataSource && Delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    //Return no of Components in PickerView
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    //Return No of row in component
    return [_arrMenuOptions count];
}


-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    Options *option = [_arrMenuOptions objectAtIndex:row];
    NSMutableAttributedString *attributedTitle =[[NSMutableAttributedString alloc] initWithString:option.name];
    if(option.isSelected){
        [attributedTitle addAttribute:NSForegroundColorAttributeName value:UIColorFromRedGreenBlue(0.f, 171.f, 234.f) range:NSMakeRange(0, attributedTitle.length)];
    }else{
        [attributedTitle addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, attributedTitle.length)];
    }
    return attributedTitle;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

}

#pragma mark--
#pragma mark-- IBAction Methods
-(IBAction)cancelAction:(id)sender{
    if (_delegate != nil) {
        NSLog(@"delegate existing");
    }else{
        NSLog(@"delegate not existing");
    }
    if ([_delegate conformsToProtocol:@protocol(DropDownDelegate)] &&
        [_delegate respondsToSelector:@selector(dropDownCancelled:)]) {
        [_delegate dropDownCancelled:_callingObj];
    }
}


-(IBAction)doneAction:(id)sender{
    NSLog(@"calling done action");
    Options *selectedOption = [_arrMenuOptions objectAtIndex:[_pickerView selectedRowInComponent:0]];
    
    if ([_delegate conformsToProtocol:@protocol(DropDownDelegate)] &&
        [_delegate respondsToSelector:@selector(dropDownDidSelect:referenceObj:)]) {
        [_delegate dropDownDidSelect:selectedOption referenceObj:_callingObj];
    }
}

@end
