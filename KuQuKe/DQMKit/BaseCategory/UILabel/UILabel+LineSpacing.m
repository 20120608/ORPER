//
//  UILabel+LineSpacing.m
//  KuQuKe
//
//  Created by 漂读网 on 2019/1/9.
//  Copyright © 2019 kuquke. All rights reserved.
//

#import "UILabel+LineSpacing.h"

@implementation UILabel (LineSpacing)

-(void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing {
  if (!text || lineSpacing < 0.01) {
    self.text = text;
    return;
  }
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  [paragraphStyle setLineSpacing:lineSpacing];        //设置行间距
  [paragraphStyle setLineBreakMode:self.lineBreakMode];
  [paragraphStyle setAlignment:self.textAlignment];
  
  NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
  [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
  self.attributedText = attributedString;
}
@end

