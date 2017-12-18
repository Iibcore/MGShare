一、微信SDK
1.版本：1.7.7
2.依赖关系：
Other Linker Flags ->
-ObjC
-all_load
Library Search Path -> （库文件所在位置）
$(PROJECT_DIR)/ZLQShare/ShareLib/libWechatSDK
3.依赖库：
Link Binary With Libraries -> （避免链接阶段由于库的设置错误导致程序崩溃）
SystemConfiguration.framework
libz.dylib
libsqlite3.0.dylib
libc++.dylib
Security.framework
CoreTelephony.framework
CFNetwork.framework

二、QQSDK
1.版本：3.2.1
2.依赖关系：
Other Linker Flags ->
-fobjc-arc
3.依赖库：
Link Binary With Libraries -> （避免链接阶段由于库的设置错误导致程序崩溃）
Security.framework
libiconv.dylib
SystemConfiguration.framework
CoreGraphics.Framework
libsqlite3.dylib
CoreTelephony.framework
libstdc++.dylib
libz.dylib

三、新浪微博SDK
1.版本：3.2.0
2.依赖关系：
Other Linker Flags -> （避免静态库中类加载不全造成程序崩溃）
-ObjC
3.依赖库：
Link Binary With Libraries -> （避免链接阶段由于库的设置错误导致程序崩溃）
QuartzCore.framework
ImageIO.framework
SystemConfiguration.framework
Security.framework
CoreTelephony.framework
CoreText.framework
UIKit.framework
Foundation.framework
CoreGraphics.framework
libz.dylib
libsqlite3.dylib








注：
需要添加白名单
<key>LSApplicationQueriesSchemes</key>
<array>
<string>mqq</string>
<string>mqqapi</string>
<string>mqqwpa</string>
<string>mqqbrowser</string>
<string>mttbrowser</string>
<string>mqqOpensdkSSoLogin</string>
<string>mqqopensdkapiV2</string>
<string>mqqopensdkapiV3</string>
<string>mqqopensdkapiV4</string>
<string>wtloginmqq2</string>
<string>mqzone</string>
<string>mqzoneopensdk</string>
<string>mqzoneopensdkapi</string>
<string>mqzoneopensdkapi19</string>
<string>mqzoneopensdkapiV2</string>
<string>mqqapiwallet</string>
<string>mqqopensdkfriend</string>
<string>mqqopensdkdataline</string>
<string>mqqgamebindinggroup</string>
<string>mqqopensdkgrouptribeshare</string>
<string>tencentapi.qq.reqContent</string>
<string>tencentapi.qzone.reqContent</string>
<string>tim</string>
<string>timapi</string>
<string>timopensdkfriend</string>
<string>timwpa</string>
<string>timgamebindinggroup</string>
<string>timapiwallet</string>
<string>timOpensdkSSoLogin</string>
<string>wtlogintim</string>
<string>timopensdkgrouptribeshare</string>
<string>timopensdkapiV4</string>
<string>timgamebindinggroup</string>
<string>timopensdkdataline</string>
<string>wtlogintimV1</string>
<string>timapiV1</string>
<string>sinaweibohd</string>
<string>sinaweibo</string>
<string>weibosdk</string>
<string>weibosdk2.5</string>
<string>weixin</string>
<string>weichat</string>
</array>
