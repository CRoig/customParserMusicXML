//
//  XMLParser.h
//  customParserMusicXML
//
//  Created by Carles Roig (ATIC) on 10/05/13.
//  Copyright (c) 2013 Carles Roig (ATIC). All rights reserved.
//

#import <Foundation/Foundation.h>

@class readXML, Score, Note;

@interface XMLParser : NSObject {
    NSMutableString *currentElementValue;
    
    readXML         *readerXML;
    NSMutableArray  *Scores;
    Score           *aScore;
    Note            *aNote;
}

- (XMLParser *) initXMLParser;
- (NSMutableArray *) returnScores;

@end