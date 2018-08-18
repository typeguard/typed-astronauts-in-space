// To parse this JSON:
//
//   NSError *error;
//   QTAstronautsInSpace *astronautsInSpace = [QTAstronautsInSpace fromJSON:json encoding:NSUTF8Encoding error:&error];
//   QTISSCurrentLocation *iSSCurrentLocation = [QTISSCurrentLocation fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTAstronautsInSpace;
@class QTPerson;
@class QTISSCurrentLocation;
@class QTIssPosition;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface QTAstronautsInSpace : NSObject
@property (nonatomic, copy)   NSString *message;
@property (nonatomic, copy)   NSArray<QTPerson *> *people;
@property (nonatomic, assign) NSInteger number;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTPerson : NSObject
@property (nonatomic, copy) NSString *craft;
@property (nonatomic, copy) NSString *name;
@end

@interface QTISSCurrentLocation : NSObject
@property (nonatomic, strong) QTIssPosition *issPosition;
@property (nonatomic, assign) NSInteger timestamp;
@property (nonatomic, copy)   NSString *message;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTIssPosition : NSObject
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *latitude;
@end

NS_ASSUME_NONNULL_END
