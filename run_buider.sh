flutter packages pub run build_runner build

/**
一、常规办法
执行flutter packages pub run build_runner build后报code 78错误
1、flutter packages pub run build_runner clean
2、flutter packages pub run build_runner build --delete-conflicting-outputs
以上方法会解决大部分错误

二、备用方法
需要删除本地安装的插件
1、flutter clean
2、flutter doctor
3、flutter packages pub run build_runner clean
4、flutter packages pub run build_runner build --delete-conflicting-outputs

*/