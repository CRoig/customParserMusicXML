//
//  XMLParser.m
//  customParserMusicXML
//
//  Created by Carles Roig (ATIC) on 10/05/13.
//  Copyright (c) 2013 Carles Roig (ATIC). All rights reserved.
//

#import "readXML.h"
#import "XMLParser.h"
#import "Score.h"
#import "Note.h"

@implementation XMLParser

- (XMLParser *) initXMLParser{
    readerXML = (readXML*)[[UIApplication sharedApplication] delegate];
    return self;
}

- (void) parser:(NSXMLParser *) parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if([elementName isEqualToString:@"score-partwise"]){
        Scores = [[NSMutableArray alloc] init];
        
    }else if([elementName isEqualToString:@"part"]){
        aScore = [[Score alloc] init]; //Initialize the book
        aScore.noteStream = [[NSMutableArray alloc] init];
        
        aScore.divisionInt = [[attributeDict objectForKey:@"divisionInt"] integerValue];
        aScore.fifthsInt = [[attributeDict objectForKey:@"fifthsInt"] integerValue];
        aScore.modeString = [[attributeDict objectForKey:@"modeString"] stringValue];
        aScore.beatInt = [[attributeDict objectForKey:@"beatInt"] integerValue];
        aScore.typeInt = [[attributeDict objectForKey:@"typeInt"] integerValue];
        aScore.clefSignString = [[attributeDict objectForKey:@"clefSignString"] stringValue];
        aScore.clefLineInt = [[attributeDict objectForKey:@"clefLineInt"] integerValue];
        
    }else if([elementName isEqualToString:@"note"]){
        aNote = [[Note alloc] init];
        
        aNote.typeNote = [[attributeDict objectForKey:@"typeNote"] stringValue];
        aNote.stepNote = [[attributeDict objectForKey:@"stepNote"] stringValue];
        aNote.alterNote = [[attributeDict objectForKey:@"alterNote"] integerValue];
        aNote.octaveNote = [[attributeDict objectForKey:@"octaveNote"] integerValue];
        aNote.duratNote = [[attributeDict objectForKey:@"duratNote"] integerValue];
    }
    
//    NSLog(@"Processing Element: %@", elementName);
}

- (void) parser:(NSXMLParser *) parser foundCharacters:(NSString *)string{
    
    if (!currentElementValue){
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    }else{
        [currentElementValue appendString:string];
    }
}

- (void) parser:(NSXMLParser *) parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"score-partwise"]) {
        return;
    }
    
    if ([elementName isEqualToString:@"part"]) {
        [Scores addObject:aScore];
        aScore = nil;
        
    }else if([elementName isEqualToString:@"note"]){
        [aScore.noteStream addObject:aNote];
        aNote = nil;
        
    }else{
        NSString *currentElementClean = [currentElementValue stringByReplacingOccurrencesOfString:@" " withString:@""];
        currentElementClean = [currentElementClean stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        // NSLog(@"musicXML data => %@: %@", elementName, currentElementClean);
        
        //Filter important data
        if ([elementName isEqualToString:@"divisions"]) {
            [aScore setValue:[NSNumber numberWithInt:[currentElementClean intValue]] forKey:@"divisionInt"];
        }else if ([elementName isEqualToString:@"fifths"]) {
            [aScore setValue:[NSNumber numberWithInt:[currentElementClean intValue]] forKey:@"fifthsInt"];
        }else if ([elementName isEqualToString:@"mode"]) {
            [aScore setValue:[NSString stringWithString:currentElementClean] forKey:@"modeString"];
        }else if ([elementName isEqualToString:@"beats"]) {
            [aScore setValue:[NSNumber numberWithInt:[currentElementClean intValue]] forKey:@"beatInt"];
        }else if ([elementName isEqualToString:@"beat-type"]) {
            [aScore setValue:[NSNumber numberWithInt:[currentElementClean intValue]] forKey:@"typeInt"];
        }else if ([elementName isEqualToString:@"sign"]) {
            [aScore setValue:[NSString stringWithString:currentElementClean] forKey:@"clefSignString"];
        }else if ([elementName isEqualToString:@"line"]) {
            [aScore setValue:[NSNumber numberWithInt:[currentElementClean intValue]] forKey:@"clefLineInt"];
        }else{
            //Filter note data
            if ([elementName isEqualToString:@"pitch"]) {
                [aNote setValue:[NSString stringWithFormat:@"note"] forKey:@"typeNote"];
                [aNote setValue:[NSNumber numberWithInt:0] forKey:@"alterNote"];
            }else if ([elementName isEqualToString:@"rest"]){
                [aNote setValue:[NSString stringWithFormat:@"rest"] forKey:@"typeNote"];
                [aNote setValue:[NSString stringWithFormat:@"no"] forKey:@"stepNote"];
                [aNote setValue:[NSNumber numberWithInt:0] forKey:@"octaveNote"];
                [aNote setValue:[NSNumber numberWithInt:0] forKey:@"alterNote"];
            }else if ([elementName isEqualToString:@"step"]) {
                [aNote setValue:[NSString stringWithString:currentElementClean] forKey:@"stepNote"];
            }else if ([elementName isEqualToString:@"octave"]) {
                [aNote setValue:[NSNumber numberWithInt:[currentElementClean intValue]] forKey:@"octaveNote"];
            }else if ([elementName isEqualToString:@"duration"]) {
                [aNote setValue:[NSNumber numberWithInt:[currentElementClean intValue]] forKey:@"duratNote"];
            }else if ([elementName isEqualToString:@"alter"]) {
                [aNote setValue:[NSNumber numberWithInt:[currentElementClean intValue]] forKey:@"alterNote"];
            }
        }
    }
//    [currentElementValue release];
    currentElementValue = nil;
}

- (void) dealloc {
    [aScore release];
    [currentElementValue release];
    [super dealloc];
}

- (NSMutableArray *) returnScores {
    return Scores;
}

@end
