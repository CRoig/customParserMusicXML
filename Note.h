//
//  Note.h
//  customParserMusicXML
//
//  Created by Carles Roig (ATIC) on 12/02/14.
//  Copyright (c) 2014 Carles Roig (ATIC). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject {
    NSString    *typeNote;
    NSString    *stepNote;
    int         alterNote;
    int         octaveNote;
    int         duratNote;
}

@property (nonatomic, retain) NSString *typeNote;

@property (nonatomic, retain) NSString *stepNote;
@property                     int      alterNote;
@property                     int      octaveNote;

@property                     int      duratNote;
@end
