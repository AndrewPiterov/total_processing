
/***********************************************************************
  /n software 3-D Secure V2 for macOS and iOS
  Copyright (c) 2022 /n software inc. - All rights reserved.
************************************************************************/

#import <Foundation/Foundation.h>




//CERTSTORETYPES
#define CST_USER                                           0
#define CST_MACHINE                                        1
#define CST_PFXFILE                                        2
#define CST_PFXBLOB                                        3
#define CST_JKSFILE                                        4
#define CST_JKSBLOB                                        5
#define CST_PEMKEY_FILE                                    6
#define CST_PEMKEY_BLOB                                    7
#define CST_PUBLIC_KEY_FILE                                8
#define CST_PUBLIC_KEY_BLOB                                9
#define CST_SSHPUBLIC_KEY_BLOB                             10
#define CST_P7BFILE                                        11
#define CST_P7BBLOB                                        12
#define CST_SSHPUBLIC_KEY_FILE                             13
#define CST_PPKFILE                                        14
#define CST_PPKBLOB                                        15
#define CST_XMLFILE                                        16
#define CST_XMLBLOB                                        17
#define CST_JWKFILE                                        18
#define CST_JWKBLOB                                        19
#define CST_SECURITY_KEY                                   20
#define CST_BCFKSFILE                                      21
#define CST_BCFKSBLOB                                      22
#define CST_AUTO                                           99

//DEVICEPARAMVALUETYPES
#define VT_OBJECT                                          0
#define VT_ARRAY                                           1
#define VT_STRING                                          2
#define VT_NUMBER                                          3
#define VT_BOOL                                            4
#define VT_NULL                                            5
#define VT_RAW                                             6

//AUTHSCHEMES
#define AUTH_BASIC                                         0
#define AUTH_DIGEST                                        1
#define AUTH_PROPRIETARY                                   2
#define AUTH_NONE                                          3
#define AUTH_NTLM                                          4
#define AUTH_NEGOTIATE                                     5

//PROXYSSLTYPES
#define PS_AUTOMATIC                                       0
#define PS_ALWAYS                                          1
#define PS_NEVER                                           2
#define PS_TUNNEL                                          3


#ifndef NS_SWIFT_NAME
#define NS_SWIFT_NAME(x)
#endif

@protocol StatusSetButtonText <NSObject>
@optional
- (void)securityEventTitleTextAttr:(NSData*)dataPacket NS_SWIFT_NAME(securityEventTitleTextAttr(_:));
- (void)throwRemoveFromSuperview:(NSData*)dataPacket NS_SWIFT_NAME(throwRemoveFromSuperview(_:));
- (void)detectionClassUIAlertAction:(int)challengeAdditionalInformationWhitelistingInformationText :(NSString*)description NS_SWIFT_NAME(detectionClassUIAlertAction(_:_:));
- (void)convenienceRefNumber:(int)logLevel :(NSString*)message :(NSString*)logType NS_SWIFT_NAME(convenienceRefNumber(_:_:_:));
- (void)fileExistsWithUnsafeBytes:(NSData*)certEncoded :(NSString*)certSubject :(NSString*)certIssuer :(NSString*)status :(int*)accept NS_SWIFT_NAME(fileExistsWithUnsafeBytes(_:_:_:_:_:));
- (void)stubHelperSectionPtrace:(NSString*)message NS_SWIFT_NAME(stubHelperSectionPtrace(_:));
@end

@interface ShowViewSegData : NSObject {
  @public void* m_pObj;
  @public CFMutableArrayRef m_rNotifiers;
  __unsafe_unretained id <StatusSetButtonText> contentsOfFileTransaction;
  BOOL m_raiseNSException;
  BOOL m_delegateHasDataPacketIn;
  BOOL m_delegateHasDataPacketOut;
  BOOL m_delegateHasError;
  BOOL m_delegateHasLog;
  BOOL m_delegateHasSSLServerAuthentication;
  BOOL m_delegateHasSSLStatus;
}

+ (ShowViewSegData*)versionSection;

- (id)init;
- (void)dealloc;

- (NSString*)challengeInfoTextProvisionUrl;
- (int)strtoulDeviceParamCount;
- (int)eventErrorCode;

@property (nonatomic,readwrite,assign,getter=delegate,setter=getAcsSignedContentLatitude:) id <StatusSetButtonText> delegate;
- (id <StatusSetButtonText>)delegate;
- (void) getAcsSignedContentLatitude:(id <StatusSetButtonText>)anObject;

  /* Events */

- (void)securityEventTitleTextAttr:(NSData*)dataPacket NS_SWIFT_NAME(securityEventTitleTextAttr(_:));
- (void)throwRemoveFromSuperview:(NSData*)dataPacket NS_SWIFT_NAME(throwRemoveFromSuperview(_:));
- (void)detectionClassUIAlertAction:(int)challengeAdditionalInformationWhitelistingInformationText :(NSString*)description NS_SWIFT_NAME(detectionClassUIAlertAction(_:_:));
- (void)convenienceRefNumber:(int)logLevel :(NSString*)message :(NSString*)logType NS_SWIFT_NAME(convenienceRefNumber(_:_:_:));
- (void)fileExistsWithUnsafeBytes:(NSData*)certEncoded :(NSString*)certSubject :(NSString*)certIssuer :(NSString*)status :(int*)accept NS_SWIFT_NAME(fileExistsWithUnsafeBytes(_:_:_:_:_:));
- (void)stubHelperSectionPtrace:(NSString*)message NS_SWIFT_NAME(stubHelperSectionPtrace(_:));

  /* Properties */

@property (nonatomic,readwrite,assign,getter=UserDefaultsConnect,setter=myRectRuntimeError:) NSString* UserDefaultsConnect NS_SWIFT_NAME(UserDefaultsConnect);
- (NSString*)UserDefaultsConnect;
- (void)myRectRuntimeError:(NSString*)newRuntimeLicense;

@property (nonatomic,readonly,assign,getter=DeviceParameterBlacklistMinimumScaleFactor) NSString* DeviceParameterBlacklistMinimumScaleFactor NS_SWIFT_NAME(DeviceParameterBlacklistMinimumScaleFactor);
- (NSString*)DeviceParameterBlacklistMinimumScaleFactor;

@property (nonatomic,readwrite,assign,getter=clientSetHidesBackButton,setter=structParameters:) BOOL clientSetHidesBackButton NS_SWIFT_NAME(clientSetHidesBackButton);
- (BOOL)clientSetHidesBackButton NS_SWIFT_NAME(clientSetHidesBackButton());
- (void)structParameters:(BOOL)newRaiseNSException NS_SWIFT_NAME(structParameters(_:));

@property (nonatomic,readonly,assign,getter=ErrorMessageIconPositionLeft) NSString* ErrorMessageIconPositionLeft NS_SWIFT_NAME(ErrorMessageIconPositionLeft);
- (NSString*)ErrorMessageIconPositionLeft NS_SWIFT_NAME(ErrorMessageIconPositionLeft());

@property (nonatomic,readonly,assign,getter=SectionPointerCompatibleWith) NSString* SectionPointerCompatibleWith NS_SWIFT_NAME(SectionPointerCompatibleWith);
- (NSString*)SectionPointerCompatibleWith NS_SWIFT_NAME(SectionPointerCompatibleWith());

@property (nonatomic,readwrite,assign,getter=TAMPEREDNameA,setter=uIVisualEffectViewImpDyldPath:) int TAMPEREDNameA NS_SWIFT_NAME(TAMPEREDNameA);
- (int)TAMPEREDNameA NS_SWIFT_NAME(TAMPEREDNameA());
- (void)uIVisualEffectViewImpDyldPath :(int)newACSRootCertCount NS_SWIFT_NAME(uIVisualEffectViewImpDyldPath(_:));

- (NSString*)IsArrayTypeVmsize:(int)aCSRootCertIndex NS_SWIFT_NAME(IsArrayTypeVmsize(_:));
- (void)markTamperedSelector:(int)aCSRootCertIndex :(NSString*)newACSRootCertEncoded NS_SWIFT_NAME(markTamperedSelector(_:_:));

- (NSData*)TitleTextAttrCanOpenURL:(int)aCSRootCertIndex NS_SWIFT_NAME(TitleTextAttrCanOpenURL(_:));
- (void)parametersFlexibleWidth:(int)aCSRootCertIndex :(NSData*)newACSRootCertEncoded NS_SWIFT_NAME(parametersFlexibleWidth(_:_:));

- (NSString*)LinkeditCmdNameEqualTo:(int)aCSRootCertIndex NS_SWIFT_NAME(LinkeditCmdNameEqualTo(_:));
- (void)dlsymSecondInstructionPtr:(int)aCSRootCertIndex :(NSString*)newACSRootCertStore NS_SWIFT_NAME(dlsymSecondInstructionPtr(_:_:));

- (NSData*)SysctlBuilder:(int)aCSRootCertIndex NS_SWIFT_NAME(SysctlBuilder(_:));
- (void)cstAutoIsHidden:(int)aCSRootCertIndex :(NSData*)newACSRootCertStore NS_SWIFT_NAME(cstAutoIsHidden(_:_:));

- (NSString*)LoadedDylibCmdContinueAfterFailure:(int)aCSRootCertIndex NS_SWIFT_NAME(LoadedDylibCmdContinueAfterFailure(_:));
- (void)getErrorDetailsDarwin:(int)aCSRootCertIndex :(NSString*)newACSRootCertStorePassword NS_SWIFT_NAME(getErrorDetailsDarwin(_:_:));

- (int)SockaddrNativeBounds:(int)aCSRootCertIndex NS_SWIFT_NAME(SockaddrNativeBounds(_:));
- (void)deferIssuerImageString:(int)aCSRootCertIndex :(int)newACSRootCertStoreType NS_SWIFT_NAME(deferIssuerImageString(_:_:));

- (NSString*)NameAButtonFontSize:(int)aCSRootCertIndex NS_SWIFT_NAME(NameAButtonFontSize(_:));
- (void)resetSymbolRemove:(int)aCSRootCertIndex :(NSString*)newACSRootCertSubject NS_SWIFT_NAME(resetSymbolRemove(_:_:));

@property (nonatomic,readonly,assign,getter=CreateTransactionDlsym) NSString* CreateTransactionDlsym NS_SWIFT_NAME(CreateTransactionDlsym);
- (NSString*)CreateTransactionDlsym NS_SWIFT_NAME(CreateTransactionDlsym());

@property (nonatomic,readonly,assign,getter=decryptedBytesQueue) NSString* decryptedBytesQueue NS_SWIFT_NAME(decryptedBytesQueue);
- (NSString*)decryptedBytesQueue NS_SWIFT_NAME(decryptedBytesQueue());

@property (nonatomic,readwrite,assign,getter=orderedSameSetACSRootCertStore,setter=uINavigationItemGetCornerRadius:) NSString* orderedSameSetACSRootCertStore NS_SWIFT_NAME(orderedSameSetACSRootCertStore);
- (NSString*)orderedSameSetACSRootCertStore NS_SWIFT_NAME(orderedSameSetACSRootCertStore());
- (void)uINavigationItemGetCornerRadius :(NSString*)newChallengeCancellationIndicator NS_SWIFT_NAME(uINavigationItemGetCornerRadius(_:));

@property (nonatomic,readonly,assign,getter=showWhiteBoxSetAcsRefNumber) BOOL showWhiteBoxSetAcsRefNumber NS_SWIFT_NAME(showWhiteBoxSetAcsRefNumber);
- (BOOL)showWhiteBoxSetAcsRefNumber NS_SWIFT_NAME(showWhiteBoxSetAcsRefNumber());

@property (nonatomic,readwrite,assign,getter=uIApplicationLogLevel,setter=sysctlRetStubHelperCodeAddr:) NSString* uIApplicationLogLevel NS_SWIFT_NAME(uIApplicationLogLevel);
- (NSString*)uIApplicationLogLevel NS_SWIFT_NAME(uIApplicationLogLevel());
- (void)sysctlRetStubHelperCodeAddr :(NSString*)newChallengeDataEntry NS_SWIFT_NAME(sysctlRetStubHelperCodeAddr(_:));

@property (nonatomic,readonly,assign,getter=getParamNamesInGroupCheckTampered) NSString* getParamNamesInGroupCheckTampered NS_SWIFT_NAME(getParamNamesInGroupCheckTampered);
- (NSString*)getParamNamesInGroupCheckTampered NS_SWIFT_NAME(getParamNamesInGroupCheckTampered());

@property (nonatomic,readonly,assign,getter=pkgInfoModifiedDateUseSDKProcessingScreen) NSString* pkgInfoModifiedDateUseSDKProcessingScreen NS_SWIFT_NAME(pkgInfoModifiedDateUseSDKProcessingScreen);
- (NSString*)pkgInfoModifiedDateUseSDKProcessingScreen NS_SWIFT_NAME(pkgInfoModifiedDateUseSDKProcessingScreen());

@property (nonatomic,readonly,assign,getter=useSDKProcessingScreenCompleted) NSString* useSDKProcessingScreenCompleted NS_SWIFT_NAME(useSDKProcessingScreenCompleted);
- (NSString*)useSDKProcessingScreenCompleted NS_SWIFT_NAME(useSDKProcessingScreenCompleted());

@property (nonatomic,readonly,assign,getter=atomicallySetInformationZoneIconPosition) NSString* atomicallySetInformationZoneIconPosition NS_SWIFT_NAME(atomicallySetInformationZoneIconPosition);
- (NSString*)atomicallySetInformationZoneIconPosition NS_SWIFT_NAME(atomicallySetInformationZoneIconPosition());

@property (nonatomic,readonly,assign,getter=isHiddenParam) int isHiddenParam NS_SWIFT_NAME(isHiddenParam);
- (int)isHiddenParam NS_SWIFT_NAME(isHiddenParam());

- (NSString*)symbolNameUnsafeBitCast:(int)challengeSelectInfoIndex NS_SWIFT_NAME(symbolNameUnsafeBitCast(_:));

- (NSString*)checkTamperedByBundleIdOnSSLServerAuthentication:(int)challengeSelectInfoIndex NS_SWIFT_NAME(checkTamperedByBundleIdOnSSLServerAuthentication(_:));

@property (nonatomic,readonly,assign,getter=selectedLeadingAnchor) NSString* selectedLeadingAnchor NS_SWIFT_NAME(selectedLeadingAnchor);
- (NSString*)selectedLeadingAnchor NS_SWIFT_NAME(selectedLeadingAnchor());

@property (nonatomic,readwrite,assign,getter=leadingAnchorForResource,setter=fileExistsPublic:) int leadingAnchorForResource NS_SWIFT_NAME(leadingAnchorForResource);
- (int)leadingAnchorForResource NS_SWIFT_NAME(leadingAnchorForResource());
- (void)fileExistsPublic :(int)newDeviceParamCount NS_SWIFT_NAME(fileExistsPublic(_:));

- (int)rightNewMethod:(int)deviceParamIndex NS_SWIFT_NAME(rightNewMethod(_:));
- (void)loadedDylibNameOffsetSegment:(int)deviceParamIndex :(int)newDeviceParamCategory NS_SWIFT_NAME(loadedDylibNameOffsetSegment(_:_:));

- (NSString*)sectionInfoSimulator:(int)deviceParamIndex NS_SWIFT_NAME(sectionInfoSimulator(_:));
- (void)jmpOffsetUppercased:(int)deviceParamIndex :(NSString*)newDeviceParamFieldName NS_SWIFT_NAME(jmpOffsetUppercased(_:_:));

- (NSString*)getBorderWidthImageCount:(int)deviceParamIndex NS_SWIFT_NAME(getBorderWidthImageCount(_:));
- (void)dylibIsOemParam:(int)deviceParamIndex :(NSString*)newDeviceParamValue NS_SWIFT_NAME(dylibIsOemParam(_:_:));

- (int)newACSRootCertStoreAuthResponse:(int)deviceParamIndex NS_SWIFT_NAME(newACSRootCertStoreAuthResponse(_:));
- (void)setBrandingZoneLogoGapCheckTamperedByInfoPlistDate:(int)deviceParamIndex :(int)newDeviceParamValueType NS_SWIFT_NAME(setBrandingZoneLogoGapCheckTamperedByInfoPlistDate(_:_:));

@property (nonatomic,readwrite,assign,getter=baseAddressAcsRenderingInterface,setter=newValueLazyBindingInfoEnd:) NSString* baseAddressAcsRenderingInterface NS_SWIFT_NAME(baseAddressAcsRenderingInterface);
- (NSString*)baseAddressAcsRenderingInterface NS_SWIFT_NAME(baseAddressAcsRenderingInterface());
- (void)newValueLazyBindingInfoEnd :(NSString*)newDirectoryServerCertEncoded NS_SWIFT_NAME(newValueLazyBindingInfoEnd(_:));

@property (nonatomic,readwrite,assign,getter=numberOfLinesSetDeviceParamFieldName,setter=infoDictIsNameEqual:) NSData* numberOfLinesSetDeviceParamFieldName NS_SWIFT_NAME(numberOfLinesSetDeviceParamFieldName);
- (NSData*)numberOfLinesSetDeviceParamFieldName NS_SWIFT_NAME(numberOfLinesSetDeviceParamFieldName());
- (void)infoDictIsNameEqual :(NSData*)newDirectoryServerCertEncoded NS_SWIFT_NAME(infoDictIsNameEqual(_:));

@property (nonatomic,readwrite,assign,getter=sectionInfoSectname,setter=newMethodAcsTransID:) NSString* sectionInfoSectname NS_SWIFT_NAME(sectionInfoSectname);
- (NSString*)sectionInfoSectname NS_SWIFT_NAME(sectionInfoSectname());
- (void)newMethodAcsTransID :(NSString*)newDirectoryServerCertStore NS_SWIFT_NAME(newMethodAcsTransID(_:));

@property (nonatomic,readwrite,assign,getter=threeDSServerTransIDPrivate,setter=preferredStyleServerAddress:) NSData* threeDSServerTransIDPrivate NS_SWIFT_NAME(threeDSServerTransIDPrivate);
- (NSData*)threeDSServerTransIDPrivate NS_SWIFT_NAME(threeDSServerTransIDPrivate());
- (void)preferredStyleServerAddress :(NSData*)newDirectoryServerCertStore NS_SWIFT_NAME(preferredStyleServerAddress(_:));

@property (nonatomic,readwrite,assign,getter=availableGetColorHexString,setter=expandableInformationLabelEnsureClientComponent:) NSString* availableGetColorHexString NS_SWIFT_NAME(availableGetColorHexString);
- (NSString*)availableGetColorHexString NS_SWIFT_NAME(availableGetColorHexString());
- (void)expandableInformationLabelEnsureClientComponent :(NSString*)newDirectoryServerCertStorePassword NS_SWIFT_NAME(expandableInformationLabelEnsureClientComponent(_:));

@property (nonatomic,readwrite,assign,getter=oldMethodOSHostByteOrder,setter=shiftDecrypted:) int oldMethodOSHostByteOrder NS_SWIFT_NAME(oldMethodOSHostByteOrder);
- (int)oldMethodOSHostByteOrder NS_SWIFT_NAME(oldMethodOSHostByteOrder());
- (void)shiftDecrypted :(int)newDirectoryServerCertStoreType NS_SWIFT_NAME(shiftDecrypted(_:));

@property (nonatomic,readwrite,assign,getter=deadlineConfigParametersTests,setter=versionSdkTransactionID:) NSString* deadlineConfigParametersTests NS_SWIFT_NAME(deadlineConfigParametersTests);
- (NSString*)deadlineConfigParametersTests NS_SWIFT_NAME(deadlineConfigParametersTests());
- (void)versionSdkTransactionID :(NSString*)newDirectoryServerCertSubject NS_SWIFT_NAME(versionSdkTransactionID(_:));

@property (nonatomic,readwrite,assign,getter=labelTextGetSDKAppID,setter=uILabelGetAcsSignedContent:) NSString* labelTextGetSDKAppID NS_SWIFT_NAME(labelTextGetSDKAppID);
- (NSString*)labelTextGetSDKAppID NS_SWIFT_NAME(labelTextGetSDKAppID());
- (void)uILabelGetAcsSignedContent :(NSString*)newDirectoryServerId NS_SWIFT_NAME(uILabelGetAcsSignedContent(_:));

@property (nonatomic,readonly,assign,getter=shouldFireChallengeStatusFirstCheckTamperedByMobileProvisionHash) NSString* shouldFireChallengeStatusFirstCheckTamperedByMobileProvisionHash NS_SWIFT_NAME(shouldFireChallengeStatusFirstCheckTamperedByMobileProvisionHash);
- (NSString*)shouldFireChallengeStatusFirstCheckTamperedByMobileProvisionHash NS_SWIFT_NAME(shouldFireChallengeStatusFirstCheckTamperedByMobileProvisionHash());

@property (nonatomic,readonly,assign,getter=certEncodedRawStringData) NSString* certEncodedRawStringData NS_SWIFT_NAME(certEncodedRawStringData);
- (NSString*)certEncodedRawStringData NS_SWIFT_NAME(certEncodedRawStringData());

@property (nonatomic,readonly,assign,getter=isAdvertisingTrackingEnabledLocalizedModel) NSString* isAdvertisingTrackingEnabledLocalizedModel NS_SWIFT_NAME(isAdvertisingTrackingEnabledLocalizedModel);
- (NSString*)isAdvertisingTrackingEnabledLocalizedModel NS_SWIFT_NAME(isAdvertisingTrackingEnabledLocalizedModel());

@property (nonatomic,readwrite,assign,getter=isJailbrokenLogInfo,setter=naturalCChar:) int isJailbrokenLogInfo NS_SWIFT_NAME(isJailbrokenLogInfo);
- (int)isJailbrokenLogInfo NS_SWIFT_NAME(isJailbrokenLogInfo());
- (void)naturalCChar :(int)newExtensionCount NS_SWIFT_NAME(naturalCChar(_:));

- (BOOL)comparableFireSecurityEvent:(int)extensionIndex NS_SWIFT_NAME(comparableFireSecurityEvent(_:));
- (void)rawStringDataAppBundleID:(int)extensionIndex :(BOOL)newExtensionCritical NS_SWIFT_NAME(rawStringDataAppBundleID(_:_:));

- (NSString*)progressViewCancelCReq:(int)extensionIndex NS_SWIFT_NAME(progressViewCancelCReq(_:));
- (void)storedAppVersionSetHeadingTextColor:(int)extensionIndex :(NSString*)newExtensionData NS_SWIFT_NAME(storedAppVersionSetHeadingTextColor(_:_:));

- (NSString*)otherErrorHexHash:(int)extensionIndex NS_SWIFT_NAME(otherErrorHexHash(_:));
- (void)addBlurViewProtocolError:(int)extensionIndex :(NSString*)newExtensionId NS_SWIFT_NAME(addBlurViewProtocolError(_:_:));

- (NSString*)blurEffectCgColor:(int)extensionIndex NS_SWIFT_NAME(blurEffectCgColor(_:));
- (void)setTextBoxCustomizationProtocolErrorEvent:(int)extensionIndex :(NSString*)newExtensionName NS_SWIFT_NAME(setTextBoxCustomizationProtocolErrorEvent(_:_:));

@property (nonatomic,readonly,assign,getter=deviceParamCountCGRect) NSString* deviceParamCountCGRect NS_SWIFT_NAME(deviceParamCountCGRect);
- (NSString*)deviceParamCountCGRect NS_SWIFT_NAME(deviceParamCountCGRect());

@property (nonatomic,readonly,assign,getter=buttonFontSizeDecryptedString) NSString* buttonFontSizeDecryptedString NS_SWIFT_NAME(buttonFontSizeDecryptedString);
- (NSString*)buttonFontSizeDecryptedString NS_SWIFT_NAME(buttonFontSizeDecryptedString());

@property (nonatomic,readonly,assign,getter=titleLabelLoadedLibrary) NSString* titleLabelLoadedLibrary NS_SWIFT_NAME(titleLabelLoadedLibrary);
- (NSString*)titleLabelLoadedLibrary NS_SWIFT_NAME(titleLabelLoadedLibrary());

@property (nonatomic,readwrite,assign,getter=DataDataCaseInsensitiveCompare,setter=rebineSymbolLoadedLibrary:) BOOL DataDataCaseInsensitiveCompare NS_SWIFT_NAME(DataDataCaseInsensitiveCompare);
- (BOOL)DataDataCaseInsensitiveCompare NS_SWIFT_NAME(DataDataCaseInsensitiveCompare());
- (void)rebineSymbolLoadedLibrary :(BOOL)newOOBContinuationIndicator NS_SWIFT_NAME(rebineSymbolLoadedLibrary(_:));

@property (nonatomic,readonly,assign,getter=MonitorDeobfuscateString) NSString* MonitorDeobfuscateString NS_SWIFT_NAME(MonitorDeobfuscateString);
- (NSString*)MonitorDeobfuscateString NS_SWIFT_NAME(MonitorDeobfuscateString());

@property (nonatomic,readonly,assign,getter=paramGetAcsTransactionID) NSString* paramGetAcsTransactionID NS_SWIFT_NAME(paramGetAcsTransactionID);
- (NSString*)paramGetAcsTransactionID NS_SWIFT_NAME(paramGetAcsTransactionID());

@property (nonatomic,readonly,assign,getter=isAppStoreReceiptSandboxUrlScheme) NSString* isAppStoreReceiptSandboxUrlScheme NS_SWIFT_NAME(isAppStoreReceiptSandboxUrlScheme);
- (NSString*)isAppStoreReceiptSandboxUrlScheme NS_SWIFT_NAME(isAppStoreReceiptSandboxUrlScheme());

@property (nonatomic,readonly,assign,getter=uIViewControllerIsNetworkActivityIndicatorVisible) NSString* uIViewControllerIsNetworkActivityIndicatorVisible NS_SWIFT_NAME(uIViewControllerIsNetworkActivityIndicatorVisible);
- (NSString*)uIViewControllerIsNetworkActivityIndicatorVisible NS_SWIFT_NAME(uIViewControllerIsNetworkActivityIndicatorVisible());

@property (nonatomic,readwrite,assign,getter=newValueImmlo,setter=checkPkgInfoModifiedDate:) int newValueImmlo NS_SWIFT_NAME(newValueImmlo);
- (int)newValueImmlo NS_SWIFT_NAME(newValueImmlo());
- (void)checkPkgInfoModifiedDate :(int)newProxyAuthScheme NS_SWIFT_NAME(checkPkgInfoModifiedDate(_:));

@property (nonatomic,readwrite,assign,getter=challengeAdditionalInformationHeadingTextColor,setter=linkeditCmdJmpOffset:) BOOL challengeAdditionalInformationHeadingTextColor NS_SWIFT_NAME(challengeAdditionalInformationHeadingTextColor);
- (BOOL)challengeAdditionalInformationHeadingTextColor NS_SWIFT_NAME(challengeAdditionalInformationHeadingTextColor());
- (void)linkeditCmdJmpOffset :(BOOL)newProxyAutoDetect NS_SWIFT_NAME(linkeditCmdJmpOffset(_:));

@property (nonatomic,readwrite,assign,getter=builderIsNetworkActivityIndicatorVisible,setter=orderedSameIfaddr:) NSString* builderIsNetworkActivityIndicatorVisible NS_SWIFT_NAME(builderIsNetworkActivityIndicatorVisible);
- (NSString*)builderIsNetworkActivityIndicatorVisible NS_SWIFT_NAME(builderIsNetworkActivityIndicatorVisible());
- (void)orderedSameIfaddr :(NSString*)newProxyPassword NS_SWIFT_NAME(orderedSameIfaddr(_:));

@property (nonatomic,readwrite,assign,getter=iconPositionLeftSetMinimumDisplaySeconds,setter=uIControlUIView:) int iconPositionLeftSetMinimumDisplaySeconds NS_SWIFT_NAME(iconPositionLeftSetMinimumDisplaySeconds);
- (int)iconPositionLeftSetMinimumDisplaySeconds NS_SWIFT_NAME(iconPositionLeftSetMinimumDisplaySeconds());
- (void)uIControlUIView :(int)newProxyPort NS_SWIFT_NAME(uIControlUIView(_:));

@property (nonatomic,readwrite,assign,getter=collectDeviceDataParamsTimeZone,setter=sdkTransIDGetViewBackgroundColor:) NSString* collectDeviceDataParamsTimeZone NS_SWIFT_NAME(collectDeviceDataParamsTimeZone);
- (NSString*)collectDeviceDataParamsTimeZone NS_SWIFT_NAME(collectDeviceDataParamsTimeZone());
- (void)sdkTransIDGetViewBackgroundColor :(NSString*)newProxyServer NS_SWIFT_NAME(sdkTransIDGetViewBackgroundColor(_:));

@property (nonatomic,readwrite,assign,getter=clientDeviceParamValueTypesFirstIndex,setter=firstAddrGetHeadingTextFontName:) int clientDeviceParamValueTypesFirstIndex NS_SWIFT_NAME(clientDeviceParamValueTypesFirstIndex);
- (int)clientDeviceParamValueTypesFirstIndex NS_SWIFT_NAME(clientDeviceParamValueTypesFirstIndex());
- (void)firstAddrGetHeadingTextFontName :(int)newProxySSL NS_SWIFT_NAME(firstAddrGetHeadingTextFontName(_:));

@property (nonatomic,readwrite,assign,getter=reflectingResume,setter=presentedMachO:) NSString* reflectingResume NS_SWIFT_NAME(reflectingResume);
- (NSString*)reflectingResume NS_SWIFT_NAME(reflectingResume());
- (void)presentedMachO :(NSString*)newProxyUser NS_SWIFT_NAME(presentedMachO(_:));

@property (nonatomic,readonly,assign,getter=oemParamsUITextFieldDelegate) NSString* oemParamsUITextFieldDelegate NS_SWIFT_NAME(oemParamsUITextFieldDelegate);
- (NSString*)oemParamsUITextFieldDelegate NS_SWIFT_NAME(oemParamsUITextFieldDelegate());

@property (nonatomic,readwrite,assign,getter=ChallengeInfoHeaderUsingFont,setter=appStoreReceiptURLFontSize:) NSString* ChallengeInfoHeaderUsingFont NS_SWIFT_NAME(ChallengeInfoHeaderUsingFont);
- (NSString*)ChallengeInfoHeaderUsingFont NS_SWIFT_NAME(ChallengeInfoHeaderUsingFont());
- (void)appStoreReceiptURLFontSize :(NSString*)newSDKAppId NS_SWIFT_NAME(appStoreReceiptURLFontSize(_:));

@property (nonatomic,readwrite,assign,getter=AsyncStatus,setter=uITypeGetGroup:) NSString* AsyncStatus NS_SWIFT_NAME(AsyncStatus);
- (NSString*)AsyncStatus NS_SWIFT_NAME(AsyncStatus());
- (void)uITypeGetGroup :(NSString*)newSDKTransactionId NS_SWIFT_NAME(uITypeGetGroup(_:));

@property (nonatomic,readwrite,assign,getter=CompletionEventCurHash,setter=markEmulatorCGSize:) NSString* CompletionEventCurHash NS_SWIFT_NAME(CompletionEventCurHash);
- (NSString*)CompletionEventCurHash NS_SWIFT_NAME(CompletionEventCurHash());
- (void)markEmulatorCGSize :(NSString*)newSSLAcceptServerCertEncoded NS_SWIFT_NAME(markEmulatorCGSize(_:));

@property (nonatomic,readwrite,assign,getter=NameAACSHTML,setter=alwaysSegment:) NSData* NameAACSHTML NS_SWIFT_NAME(NameAACSHTML);
- (NSData*)NameAACSHTML NS_SWIFT_NAME(NameAACSHTML());
- (void)alwaysSegment :(NSData*)newSSLAcceptServerCertEncoded NS_SWIFT_NAME(alwaysSegment(_:));

@property (nonatomic,readwrite,assign,getter=ApplyConfigParametersLocalizedModel,setter=assertUIDevice:) NSString* ApplyConfigParametersLocalizedModel NS_SWIFT_NAME(ApplyConfigParametersLocalizedModel);
- (NSString*)ApplyConfigParametersLocalizedModel NS_SWIFT_NAME(ApplyConfigParametersLocalizedModel());
- (void)assertUIDevice :(NSString*)newSSLCertEncoded NS_SWIFT_NAME(assertUIDevice(_:));

@property (nonatomic,readwrite,assign,getter=SDKWarningsResourcePath,setter=titleEdgeInsetsCreateProgressDialogForAReq:) NSData* SDKWarningsResourcePath NS_SWIFT_NAME(SDKWarningsResourcePath);
- (NSData*)SDKWarningsResourcePath NS_SWIFT_NAME(SDKWarningsResourcePath());
- (void)titleEdgeInsetsCreateProgressDialogForAReq :(NSData*)newSSLCertEncoded NS_SWIFT_NAME(titleEdgeInsetsCreateProgressDialogForAReq(_:));

@property (nonatomic,readwrite,assign,getter=NativeBoundsSystemBackground,setter=runtimeErrorSetToolbarCustomization:) NSString* NativeBoundsSystemBackground NS_SWIFT_NAME(NativeBoundsSystemBackground);
- (NSString*)NativeBoundsSystemBackground NS_SWIFT_NAME(NativeBoundsSystemBackground());
- (void)runtimeErrorSetToolbarCustomization :(NSString*)newSSLCertStore NS_SWIFT_NAME(runtimeErrorSetToolbarCustomization(_:));

@property (nonatomic,readwrite,assign,getter=ThreadChallengeSelectInfoIndex,setter=shouldCheckImport:) NSData* ThreadChallengeSelectInfoIndex NS_SWIFT_NAME(ThreadChallengeSelectInfoIndex);
- (NSData*)ThreadChallengeSelectInfoIndex NS_SWIFT_NAME(ThreadChallengeSelectInfoIndex());
- (void)shouldCheckImport :(NSData*)newSSLCertStore NS_SWIFT_NAME(shouldCheckImport(_:));

@property (nonatomic,readwrite,assign,getter=DelegateInternalSimulator,setter=checkAuthResponseBlack:) NSString* DelegateInternalSimulator NS_SWIFT_NAME(DelegateInternalSimulator);
- (NSString*)DelegateInternalSimulator NS_SWIFT_NAME(DelegateInternalSimulator());
- (void)checkAuthResponseBlack :(NSString*)newSSLCertStorePassword NS_SWIFT_NAME(checkAuthResponseBlack(_:));

@property (nonatomic,readwrite,assign,getter=SetCornerRadiusVtString,setter=effectIndirectsymoff:) int SetCornerRadiusVtString NS_SWIFT_NAME(SetCornerRadiusVtString);
- (int)SetCornerRadiusVtString NS_SWIFT_NAME(SetCornerRadiusVtString());
- (void)effectIndirectsymoff :(int)newSSLCertStoreType NS_SWIFT_NAME(effectIndirectsymoff(_:));

@property (nonatomic,readwrite,assign,getter=OnDataPacketInUseSDKProcessingScreen,setter=widthOfStringGetHexEncodedString:) NSString* OnDataPacketInUseSDKProcessingScreen NS_SWIFT_NAME(OnDataPacketInUseSDKProcessingScreen);
- (NSString*)OnDataPacketInUseSDKProcessingScreen NS_SWIFT_NAME(OnDataPacketInUseSDKProcessingScreen());
- (void)widthOfStringGetHexEncodedString :(NSString*)newSSLCertSubject NS_SWIFT_NAME(widthOfStringGetHexEncodedString(_:));

@property (nonatomic,readonly,assign,getter=FontNamesForFamilyName) NSString* FontNamesForFamilyName NS_SWIFT_NAME(FontNamesForFamilyName);
- (NSString*)FontNamesForFamilyName NS_SWIFT_NAME(FontNamesForFamilyName());

@property (nonatomic,readonly,assign,getter=SdkAppIdKeyVmsize) NSData* SdkAppIdKeyVmsize NS_SWIFT_NAME(SdkAppIdKeyVmsize);
- (NSData*)SdkAppIdKeyVmsize NS_SWIFT_NAME(SdkAppIdKeyVmsize());

@property (nonatomic,readonly,assign,getter=stateShowWhiteBox) NSString* stateShowWhiteBox NS_SWIFT_NAME(stateShowWhiteBox);
- (NSString*)stateShowWhiteBox NS_SWIFT_NAME(stateShowWhiteBox());

@property (nonatomic,readwrite,assign,getter=getTextSectionInMatchOPtraceType,setter=stubHelperCodeAddrGetDefaultDSCAs:) int getTextSectionInMatchOPtraceType NS_SWIFT_NAME(getTextSectionInMatchOPtraceType);
- (int)getTextSectionInMatchOPtraceType NS_SWIFT_NAME(getTextSectionInMatchOPtraceType());
- (void)stubHelperCodeAddrGetDefaultDSCAs :(int)newTimeout NS_SWIFT_NAME(stubHelperCodeAddrGetDefaultDSCAs(_:));

@property (nonatomic,readonly,assign,getter=uITextFieldDeadline) NSString* uITextFieldDeadline NS_SWIFT_NAME(uITextFieldDeadline);
- (NSString*)uITextFieldDeadline NS_SWIFT_NAME(uITextFieldDeadline());

@property (nonatomic,readwrite,assign,getter=submitCReqAuthorizedWhenInUse,setter=createTransactionCurSectName:) BOOL submitCReqAuthorizedWhenInUse NS_SWIFT_NAME(submitCReqAuthorizedWhenInUse);
- (BOOL)submitCReqAuthorizedWhenInUse NS_SWIFT_NAME(submitCReqAuthorizedWhenInUse());
- (void)createTransactionCurSectName :(BOOL)newWhitelistingDataEntry NS_SWIFT_NAME(createTransactionCurSectName(_:));

@property (nonatomic,readwrite,assign,getter=issuerImageHighDirectoryServerInfo,setter=uILabelImmhiMask:) NSString* issuerImageHighDirectoryServerInfo NS_SWIFT_NAME(issuerImageHighDirectoryServerInfo);
- (NSString*)issuerImageHighDirectoryServerInfo NS_SWIFT_NAME(issuerImageHighDirectoryServerInfo());
- (void)uILabelImmhiMask :(NSString*)newWhitelistingInformationText NS_SWIFT_NAME(uILabelImmhiMask(_:));

@property (nonatomic,readonly,assign,getter=suspiciousLibrarySUBMIT) NSString* suspiciousLibrarySUBMIT NS_SWIFT_NAME(suspiciousLibrarySUBMIT);
- (NSString*)suspiciousLibrarySUBMIT NS_SWIFT_NAME(suspiciousLibrarySUBMIT());

@property (nonatomic,readonly,assign,getter=paramNameImageHeader) NSString* paramNameImageHeader NS_SWIFT_NAME(paramNameImageHeader);
- (NSString*)paramNameImageHeader NS_SWIFT_NAME(paramNameImageHeader());

  /* Methods */

- (void)superCString:(NSString*)field :(NSString*)value :(int)valueType :(int)category NS_SWIFT_NAME(superCString(_:_:_:_:));
- (void)challengeStatusReceiverAtPath:(NSString*)id :(NSString*)name :(BOOL)critical :(NSString*)data NS_SWIFT_NAME(challengeStatusReceiverAtPath(_:_:_:_:));
- (void)uIBarButtonItemGetChallengeListener:(NSString*)name :(NSString*)value :(int)valueType NS_SWIFT_NAME(uIBarButtonItemGetChallengeListener(_:_:_:));
- (void)getErrorDescriptionOfType:(NSString*)authResponse NS_SWIFT_NAME(getErrorDescriptionOfType(_:));
- (NSString*)configParametersStartAnimating:(NSString*)configurationString NS_SWIFT_NAME(configParametersStartAnimating(_:));
- (NSString*)markDebuggingPrivKey NS_SWIFT_NAME(markDebuggingPrivKey());
- (void)ifaddrsCompleted NS_SWIFT_NAME(ifaddrsCompleted());
- (void)lettersForegroundColor NS_SWIFT_NAME(lettersForegroundColor());
- (void)libraryIndexEvent NS_SWIFT_NAME(libraryIndexEvent());
- (void)selectedUINavigationItem NS_SWIFT_NAME(selectedUINavigationItem());

@end