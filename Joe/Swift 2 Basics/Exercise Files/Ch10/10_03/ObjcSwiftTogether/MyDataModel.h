//
//  MyDataModel.h
//  ObjcSwiftTogether
//
//  Created by J Nastos on 12/16/15.
//  Copyright © 2015 J Nastos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyDataModel : NSObject

@property (strong) NSString *stringProperty;
@property int intProperty;

- (int) intPropertySquared;

@end
