//
//  Score.h
//  customParserMusicXML
//
//  Created by Carles Roig (ATIC) on 12/02/14.
//  Copyright (c) 2014 Carles Roig (ATIC). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Score : NSObject {
    
    int            divisionInt;
    
    int            fifthsInt;
    NSString       *modeString;
    
    int            beatInt;
    int            typeInt;
    
    NSString       *clefSignString;
    int            clefLineInt;
    
    NSMutableArray *noteStream;
}

@property                      int        divisionInt;

@property                      int        fifthsInt;
@property (nonatomic, retain)  NSString   *modeString;

@property                      int        beatInt;
@property                      int        typeInt;

@property (nonatomic, retain)  NSString   *clefSignString;
@property                      int        clefLineInt;

@property (nonatomic, retain)  NSMutableArray *noteStream;

@end
