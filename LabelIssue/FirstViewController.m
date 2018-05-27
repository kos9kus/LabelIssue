//
//  FirstViewController.m
//  LabelIssue
//
//  Created by KONSTANTIN KUSAINOV on 27/05/2018.
//  Copyright © 2018 KONSTANTIN KUSAINOV. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    static NSDictionary *result;
    static UIFont *font;
    if (!font)
    {
        font = [UIFont systemFontOfSize:17];
    }
    if (!result)
    {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineSpacing = 2.0f;
        
        result = @{NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraph};
    }
    __auto_type text = @"Новосибирская дорожная яма появилась на Google Maps в разделе «Достопримечательности».\n\nИ на неё уже есть\nпрекрасные  отзывы\n";
    __auto_type attributedString = [[NSAttributedString alloc] initWithString:text attributes:result];
    
    __auto_type label = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 250, 177)];
    label.numberOfLines = 0;
    label.attributedText = attributedString;
    label.backgroundColor = [UIColor redColor];
    [self.view addSubview:label];
    
    
    __auto_type textH = label.attributedText;
    __auto_type highlightedRanges = [NSMutableArray<NSValue *> array];
    __block __auto_type previosRange = NSMakeRange(0, 0);
    __auto_type highlight = @"отзыв";
    __auto_type pattern = [NSString stringWithFormat:@"(?<=\\W|^)%@", highlight];
    __auto_type regexpr = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    
    __auto_type unusebleLenght = previosRange.location + previosRange.length;
    __auto_type range = NSMakeRange(unusebleLenght, text.length - unusebleLenght);
    [regexpr enumerateMatchesInString:textH.string
                              options:0
                                range:range
                           usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                               *stop = YES;
                               if (result.range.length)
                               {
                                   previosRange = result.range;
                                   [highlightedRanges addObject:[NSValue valueWithRange:result.range]];
                               }
                           }];
     CGRect rect;
    for (NSValue *rangeValue in highlightedRanges)
    {
        __auto_type range = [rangeValue rangeValue];
        __auto_type textStorage = [[NSTextStorage alloc] initWithAttributedString:textH];
        __auto_type textContainer = [[NSTextContainer alloc] initWithSize:label.bounds.size];
        textContainer.lineFragmentPadding = 0.f;
        
        __auto_type layoutManager = [[NSLayoutManager alloc] init];
        [textStorage addLayoutManager:layoutManager];
        [layoutManager addTextContainer:textContainer];
        
        NSRange glyphRange;
        
        [layoutManager characterRangeForGlyphRange:range actualGlyphRange:&glyphRange];
        
        __unused __auto_type usedrect = [layoutManager usedRectForTextContainer:textContainer];
        rect = [layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:textContainer];
        NSLog(@"");
    }
    
    CGPoint boundedOrigin = label.frame.origin;
    rect.origin.x += boundedOrigin.x;
    rect.origin.y += boundedOrigin.y;
    
    __auto_type highlightedLayer = [[CALayer alloc] init];
    highlightedLayer.frame = rect;
    highlightedLayer.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5].CGColor;
    highlightedLayer.cornerRadius = 4.0;
    highlightedLayer.shadowOffset = CGSizeMake(0, 2);
    highlightedLayer.shadowRadius = 2;
    highlightedLayer.shadowOpacity = 0.2;
    [self.view.layer addSublayer:highlightedLayer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
