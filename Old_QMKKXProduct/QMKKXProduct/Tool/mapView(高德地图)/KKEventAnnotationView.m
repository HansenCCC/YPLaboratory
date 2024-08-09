//
//  KKEventAnnotationView.m
//  KKLAFProduct
//
//  Created by Hansen on 8/3/20.
//  Copyright © 2020 Hansen. All rights reserved.
//

#import "KKEventAnnotationView.h"

@implementation KKEventAnnotationView
- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = KKColor_FFFFFF;
        self.bounds = CGRectMake(0, 0, 8, 8);
        self.layer.cornerRadius = self.bounds.size.height/2.0;
        self.layer.borderWidth = 2;
        self.layer.borderColor = KKColor_RANDOM.CGColor;
    }
    return self;
}
@end
