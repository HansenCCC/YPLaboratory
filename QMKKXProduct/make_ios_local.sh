#!/bin/sh
#自动打包脚本,xcode版本为:Xcode 10.3

#使用方法
#步骤1、⚠️ cd 到当前项目目录下面， 使用sh make_ios_local.sh 或者. make_ios_local.sh 命令行
#步骤2、⚠️ 等
#步骤3、⚠️ ipa打包成功，会在桌面弹框显示

#使用说明
#1、⚠️检查kProjectName是否对应项目targets正确
#2、⚠️确保项目目录下面存在打包配置exportOptions.plist

#工程名称❗️❗️❗️此处填写项目targets  例如Bee或者BeeDev❗️❗️❗️
kProjectName="Bee"
echo "工程targets $kProjectName"
#打包方式
kConfiguration="Debug"
echo "打包方式 $kConfiguration"
#工程当前路径
kProjectDir=$(pwd)
echo "工程当前路径 $kProjectDir"
#配置文件完整路径
kExportOptionsPlist="$kProjectDir/exportOptions.plist"
echo "配置文件完整路径 $kExportOptionsPlist"
#版本号
kVersion="{VERSION}"
echo "版本号 $kVersion"
#工程所在目录
if [ ! -d $projectDir ];
then
echo "工程所在目录不存在，$projectDir 请cd到当前工程目录下，打包失败"
exit 1
fi
#xcode当前版本
kXcodeVersion=`xcodebuild -version | grep -e "Xcode [\d\.]*" | sed 's/Xcode //'`
echo "xcode当前版本 $kXcodeVersion"
#通配符
kXcworkspace=".xcworkspace"
echo "通配符 $kXcworkspace"
for files in "$kProjectDir/*"
do
echo "正在查找当前目录xcode可编译项目..."
done

#工程文件路径
kProject=""
for value in ${files[@]}
do
strA=$value
strB=$kXcworkspace
result=$(echo $strA | grep "${strB}")
if [[ "$result" != "" ]]
then
kProject=$value
fi
done

if [[ $kProject == "" ]]
then
echo "当前目录没有存在xcode可打包项目，打包失败"
exit 1;
fi

echo "工程文件路径 $kProject"

echo "开始编译 项目工程目录$kProject scheme$kProjectName"

#临时的工作目录
kDate=`date +%Y%m%d_%H%M%S`
echo "临时的工作目录 $kDate"
#获取当前桌面路径
kRoot_file=~/Desktop
echo "ipa存放路径 $kRoot_file"
#ipa包所在的目录
kIpaDstDir="$kRoot_file/ipa"
echo "ipa包所在的目录 $kIpaDstDir"
#项目生成路径命
kWorkspace="$kIpaDstDir/${kProjectName}_${kXcodeVersion}_${kDate}"
echo "项目生成路径命 $kWorkspace"
#归档存放路径
kArchivePath="$kWorkspace/$kProjectName.xcarchive"
echo "归档存放路径 $kArchivePath"
if [ ! -d $kWorkspace ]
then
mkdir -p $kWorkspace
fi
#打印log
kLogFile="$kWorkspace/make_ios.log"
echo "打印log $kLogFile"
#ipad路径
kIpaFile="$kWorkspace/"
echo "ipad路径 $kIpaFile"

#exit 1

#1.清理缓存
echo 1>"$kLogFile"
[ -f "$kIpaFile" ] && rm "$kIpaFile"
xcodebuild clean -workspace $kProject -scheme $kProjectName -configuration $kConfiguration | tee -a "$kLogFile"
#2.使用archive打包
xcodebuild archive -workspace $kProject -scheme $kProjectName -configuration $kConfiguration -archivePath $kArchivePath | tee -a "$kLogFile"
#3.导出ipa包
xcodebuild -exportArchive -archivePath $kArchivePath -exportPath $kIpaFile -exportOptionsPlist $kExportOptionsPlist | tee -a
open $kIpaFile
exit 1

