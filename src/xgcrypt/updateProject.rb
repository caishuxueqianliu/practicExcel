 #!/usr/bin/ruby -w
 # -*- coding: UTF-8 -*-

 require 'xcodeproj'
 require 'pathname'
 require 'find'
 require 'fileutils'
 require 'tmpdir'
 require 'optparse'


 options = {}
 option_parser = OptionParser.new do |opts|
  opts.on('-d DIRECTORY','--direction DIRECTORY','directory to process') do |value|
        options[:directory] = value
  end
 end.parse!

 if options[:directory].nil? then
        puts "   \033[31merro ==== > (打包好的工程路径)\033[0m\n"
        puts "   \033[33m比如 (工程路径是:xx/xxx/proj.ios_100_102_103_201_203_206)\033[0m\n"
        exit
 end

 global_directory = options[:directory]
isCN=true
 # 旧工程路径
 @oldProj_Root = global_directory
 @oldProj_Dir = @oldProj_Root + '/ios/./'

 curent_Dir = Pathname.new(File.dirname(__FILE__)).realpath
 project_name = File.basename(curent_Dir)

 # Resource 资源文件夹
 @resources_Dir =  File.dirname(@oldProj_Root)
 @oldResources_Dir = @resources_Dir + '/' + 'Resource/'
 @oldFiles_Dir = @resources_Dir + '/' + 'Classes/'

  # 引擎层路径
 #cocos2d_libs_path = File.join(File.dirname(__FILE__),'../../cocos2d-x/build/cocos2d_libs.xcodeproj')
 # puts(cocos2d_libs_path)
 #cocos2d_js_bindings_path = File.join(File.dirname(__FILE__),'../../cocos2d-x/cocos/scripting/js-bindings/proj.ios_mac/cocos2d_js_bindings.xcodeproj')
path = curent_Dir.to_s.split('/') 
l=path.length

arr=[]
for variable  in 1..l-3
arr.push(path[variable])

end
arr=arr.join('/')
#puts(arr)

 # 引擎层路径
cocos2d_libs_path = ('../../cocos2d-x/build/cocos2d_libs.xcodeproj')
#cocos2d_libs_path = File.join(File.dirname(__FILE__),'../../cocos2d-x/build/cocos2d_libs.xcodeproj')
puts(cocos2d_libs_path)
cocos2d_js_bindings_path =('../../cocos2d-x/cocos/scripting/js-bindings/proj.ios_mac/cocos2d_js_bindings.xcodeproj').to_s
#cocos2d_js_bindings_path =File.join(File.dirname(__FILE__),'../../cocos2d-x/cocos/scripting/js-bindings/proj.ios_mac/cocos2d_js_bindings.xcodeproj')
 

 a_BundleId = ''
 old_project = Xcodeproj::Project.open(global_directory + '/SanGuo2R.xcodeproj')
 old_project.targets[0].build_configurations.each do |config|
    a_BundleId = config.build_settings['PRODUCT_BUNDLE_IDENTIFIER']
 end 

 # 修改本地文件夹名称
 new_sdk_fileName = 'SDK'
 new_code_fileName = 'Code'
 new_classes = 'Classes'

 file_name = new_code_fileName
 resouce_fileName = 'Images.xcassets'

 project_last_name = '.xcodeproj'
 project_path = './' + project_name + project_last_name
 project_path = File.join(File.dirname(__FILE__), project_path)

 # 打开项目工程.xcodeproj 获取当前文件的完整目录
 project = Xcodeproj::Project.open(project_path)

 # 根据分割的字符串适当加入编译宏的代码 @oldProj_Root
 sdkCode = @oldProj_Root.to_s.split('_')

 # 遍历找到config.build_settings、添加路径以及设置自动引入计数器为MRC
 # project.build_configurations.each do |config1|

 # config1.build_settings["iOS DEPLOYMENT TARGET"] = "iOS 9.0"

 # end


 project.targets[0].build_configurations.each do |config|
 	gcc_preprocessors_debug = ['COCOS2D_DEBUG=1', 'USE_FILE32API', 'COCOS2D_JAVASCRIPT', 'CC_ENABLE_CHIPMUNK_INTEGRATION', 'XI_DEFINE=1', 'WORK_IOS=1']
 	gcc_preprocessors_release = ['NDEBUG', 'USE_FILE32API', 'COCOS2D_JAVASCRIPT', 'CC_ENABLE_CHIPMUNK_INTEGRATION', 'XI_DEFINE=1', 'WORK_IOS=1']

 	for i in sdkCode do
	 	 if i == '2'
		 	gcc_preprocessors_debug.push('GAME_FACEBOOK=1')
		 	gcc_preprocessors_release.push('GAME_FACEBOOK=1')
      isCN=false
		 end
		 	
		 if i == '4'
		 	gcc_preprocessors_debug.push('GAME_TWITTER=1')
		 	gcc_preprocessors_release.push('GAME_TWITTER=1')
		 end

		 if i == '53'
		 	gcc_preprocessors_debug.push('GAME_YOUDIAN=1')
		 	gcc_preprocessors_release.push('GAME_YOUDIAN=1')
		 end
		 	
		 if i == '103'
		 	gcc_preprocessors_debug.push('GAME_WXWORK=1')
		 	gcc_preprocessors_release.push('GAME_WXWORK=1')
		 end
		 	
		 if i == '201'
		 	gcc_preprocessors_debug.push('STAT_TAPDB=1')
		 	gcc_preprocessors_release.push('STAT_TAPDB=1')
		 end

		 if i == '203'
		 	gcc_preprocessors_debug.push('STAT_TOUTIAO=1')
		 	gcc_preprocessors_release.push('STAT_TOUTIAO=1')
		 end	

		 if i == '204'
		 	gcc_preprocessors_debug.push('STAT_APPSFLYER=1')
		 	gcc_preprocessors_release.push('STAT_APPSFLYER=1')
		 end
     if i == '207'
      gcc_preprocessors_debug.push('STAT_MOB=1')
      gcc_preprocessors_release.push('STAT_MOB=1')
     end
 	end

   # 设置runsearch path 路径
   framework_root = "$(SRCROOT)/#{project_name}/SDK"
   header_root = '$(SRCROOT)/../../cocos2d-x/cocos/editor-support'
   library_root = framework_root
   user_roots = ['$(inherited)', '$(SRCROOT)/../../cocos2d-x/external/spidermonkey/include/ios', '$(SRCROOT)/../../cocos2d-x/plugin/jsbindings/auto',
             '$(SRCROOT)/../../cocos2d-x/plugin/jsbindings/manual', '$(SRCROOT)/../../cocos2d-x/cocos', '$(SRCROOT)/../../cocos2d-x', '$(SRCROOT)/../../cocos2d-x/cocos/scripting/js-bindings/manual']
   otherlink_root = '-ObjC'
   prefHeder_path = "$(SRCROOT)/#{project_name}/Classes/Prefix.pch"

   reference_style = 'NO'
   retain_style = 'NO'
   bitocde_enable = 'NO'
   valid_archs = ['arm64', 'arm64e']
   
   framework_paths = ['$(inherited)', framework_root]
   header_paths = ['$(inherited)', header_root]
   library_paths = ['$(inherited)', library_root]
   user_paths = user_roots

   config.build_settings['FRAMEWORK_SEARCH_PATHS'] = framework_paths
   config.build_settings['HEADER_SEARCH_PATHS'] = header_paths
   config.build_settings['LIBRARY_SEARCH_PATHS'] = library_paths
   config.build_settings['USER_HEADER_SEARCH_PATHS'] = user_paths
   config.build_settings['OTHER_LDFLAGS'] = otherlink_root
   config.build_settings['CLANG_ENABLE_OBJC_ARC'] = reference_style
   config.build_settings['CLANG_ENABLE_OBJC_WEAK'] = reference_style
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
   config.build_settings['ENABLE_BITCODE'] = bitocde_enable
   config.build_settings['VALID_ARCHS'] = valid_archs
   config.build_settings['GCC_PREFIX_HEADER'] = prefHeder_path
   config.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] = a_BundleId
 
   if config.name == 'Debug'
       config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] = gcc_preprocessors_debug
   elsif config.name == 'Release'
       config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] = gcc_preprocessors_release
   end

   config.build_settings["PROVISIONING_PROFILE_SPECIFIER"] = "wildprofileDev"
   config.build_settings["DEVELOPMENT_TEAM"] = "5737XM2N76"
   config.build_settings["CODE_SIGN_STYLE"] = "Manual"
   config.build_settings["CODE_SIGN_IDENTITY"] = "iPhone Developer"
   config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "iOS 9.0"
 end

 ########################### 在工程中引入Framework .a文件 或 bundele文件  ####################
 # 找到需要操作的target
 targetIndex = 0
 project.targets.each_with_index do |target,index|
     if target.name == project_name
        targetIndex = index
     end
 end

 # target
 target = project.targets[targetIndex]

 # 文件夹用于存放代码以及framework\ # 找到要插入的group (参数中true表示如果找不到group，就创建一个group) project_name
 ios_group = project.main_group.find_subpath(File.join(project_name,file_name), true)

 # 获取所有静态库文件引用
 framework_ref_list = target.frameworks_build_phases.files_references
 # 获取所有资源文件引用
 bundle_ref_list = target.resources_build_phase.files_references

 # 获取全部的文件引用
 file_ref_list = target.source_build_phase.files_references
 project_framework_refs = project.frameworks_group.files;
 

 # 添加系统自带的framework
 framework_names = ['AVKit','CoreMedia','AdSupport', 'AudioToolbox', 'AVFoundation', 'CoreGraphics', 'CoreMotion', 'CoreText', 'Foundation', 'GameController', 'iAd',
 'MediaPlayer', 'OpenAL', 'OpenGLES', 'QuartzCore', 'Security', 'SystemConfiguration', 'UIKit', 'MediaAccessibility', 'CoreTelephony',
 'AudioToolbox','WebKit']

 # 添加系统自带的tbd库
 library_names = ['libsqlite3', 'libc++', 'libiconv', 'libz']

 path_sdk_name = 'iPhoneOS'
 path_sdk_version = '13.2'

 for i in framework_names do
     path = "System/Library/Frameworks/#{i}.framework"

     # 先检测project中是否已经有两者的引用，避免重复添加
     is_framework_exist = false
     for ref in project_framework_refs
         # puts i
         if ref.name == i + '.framework' then
             is_framework_exist = true
             break
         end
     end

     if !is_framework_exist then
         reference = project.frameworks_group.new_file(path, :sdk_root)
         target.frameworks_build_phases.add_file_reference(reference)
     else
         puts "framwork reference already exist!"
     end

 end


 for tbd in library_names do
     path = "usr/lib/#{tbd}.tbd"

     # 先检测project中是否已经有两者的引用，避免重复添加
     is_tbd_exist = false
     for ref in project_framework_refs
         if ref.name == tbd + '.tbd' then
             is_tbd_exist = true
             break
         end
     end

     if !is_tbd_exist then
         reference = project.frameworks_group.new_file(path, :sdk_root)
         target.frameworks_build_phases.add_file_reference(reference)
     else
         puts "tbd reference already exist!"
     end
 end

 # 根据发版平台需求添加渠道代码
 root_project_name = './' + project_name;
 @newProj_Dir = root_project_name + '/'
 project_paths = File.join(File.dirname(__FILE__), @newProj_Dir)
 
 @oldProj_Dir = @oldProj_Dir

 # 拷贝、删除特有的文件 rf直接删除、而r 会保存引用
 FileUtils.cp_r @oldProj_Dir, @newProj_Dir
 FileUtils.cp_r @oldResources_Dir, @newProj_Dir
 FileUtils.cp_r @oldFiles_Dir, @newProj_Dir
 
 FileUtils.rm_r(project_paths + 'Assets.xcassets')
 File.rename(project_paths + 'Images.xcassets', project_paths + 'Assets.xcassets')

 # 删除代码引用
 # 找到要操作的文件夹（此文件夹已存在且添加到项目中）
a_file = project.main_group.find_subpath(File.join(project_name), false)

# 移除 .h索引
a_h_ref = a_file.find_file_by_path("AppDelegate.h")
a_file.remove_reference(a_h_ref)

# 移除 .m索引和Compile Sources引用
a_m_ref = a_file.find_file_by_path("AppDelegate.m")
target.source_build_phase.remove_file_reference(a_m_ref)
a_file.remove_reference(a_m_ref)

# 删除源文件
system "rm ./#{project_name}/AppDelegate.h"
system "rm ./#{project_name}/AppDelegate.m"
system "rm ./#{project_name}/XIInter/sdks/InApp/AppleLoginManager.h"
system "rm ./#{project_name}/XIInter/sdks/InApp/AppleLoginManager.m"



#删除指定代码


def DelLines(filePath,keyWord)

arr=[]
File.open(filePath, "r") do |file|
    file.each_line do |line|
        if line.start_with?(keyWord)then
          line=""
        end
        arr.push(line)
    end
end
 arr=arr.join('')

aFile = File.new(filePath, "w")
if aFile
   aFile.write(arr)
end

 # File.write（arr）
end
# DelLines('./'+project_name+'/XIInter/main/XIMain.mm','#import <TwitterKit/TWTRKit.h>')
# DelLines('./'+project_name+'/XIInter/main/XIDefines.h','#import "../sdks/InApp/AppleLoginManager.h"')
# DelLines('./'+project_name+'/XIInter/main/XIDefines.h','#define APPLELOGINCls AppleLoginManager')
# DelLines('./'+project_name+'/XIInter/main/XIDefines.h','            xiManager = [APPLELOGINCls sharedGameInstance];')

# if isCN==false then
# DelLines('./'+project_name+'/XIInter/main/XIMain.mm','#import <FBSDKCoreKit/FBSDKCoreKit.h>')
# DelLines('./'+project_name+'/XIInter/main/XIMain.mm','#import <FBSDKLoginKit/FBSDKLoginKit.h>')
# end

 # 检测需要添加的文件是否存在
 def isFilePreferenceExist(filename,target,group)
     $file_ref_mark = false
     # 获取全部的文件引用
     file_phase_ref_list = target.source_build_phase.files_references
     file_phase_ref_list.each do |file_ref_temp|
         if !file_ref_temp.nil? then
             if File.basename(file_ref_temp.path.to_s) == filename then
                 $file_ref_mark = true
             end
         end
     end

     if !$file_ref_mark then
         file_head_ref_list = group.files
     
         file_head_ref_list.each do |file_head_ref_temp|
             if !file_head_ref_temp.nil? then
                 if File.basename(file_head_ref_temp.path.to_s) == filename then
                     $file_ref_mark = true
                 end
             end
         end
     end
     return $file_ref_mark
 end


 if File.directory?(@newProj_Dir)
     Dir.foreach(@newProj_Dir) do |entry|
         filePath = File.join(@newProj_Dir, entry)
           # 过滤掉文件夹
           if !File.directory?(filePath) && entry != '.' and entry != '..'
                 if entry.to_s.end_with?('Info.plist', 'main.m', 'SceneDelegate.h', 'SceneDelegate.m', 'ViewController.h', 'ViewController.m', 'GameScene.h', 'GameScene.m', 'GameScene.sks', 'Actions.sks') then
                 	# puts '暂时不移动'
                 else
                 	FileUtils.cp_r filePath, @newProj_Dir + new_classes + '/'
                 	FileUtils.cp_r File.join(@newProj_Dir, 'RootViewController.h'), @newProj_Dir + new_classes + '/'
                 	FileUtils.rm_r filePath 
                 end               
           end
     end
 end

 FileUtils.rm_r File.join(@newProj_Dir, 'RootViewController.h')   

 # 遍历文件夹添加
 def add_fileToProj(aTarget, aGroup, aDirectory)
    
     Dir.foreach(aGroup.real_path) do |entry|
         filePath = File.join(aGroup.real_path, entry)
         # 过滤目录和.DS_Store文件
         if !File.directory?(filePath) && entry != ".DS_Store" || entry.end_with?(".a", ".bundle", ".framework", "xcassets", ".plist", ".png", "data", "project.manifest", "res") then
           # 判断资源里面是否含有相同的文件资源
             $file_ref_mark = isFilePreferenceExist(entry, aTarget, aGroup)
             fileReference = ""
             if $file_ref_mark == false
                 # 向group中增加文件引用
                 if  entry.to_s.end_with?("IAPHelper_.m", "IAPShare.m","InAppPay.m") then
                     fileReference = aGroup.new_reference(filePath)
                     aTarget.add_file_references([fileReference], '-fobjc-arc')
                 elsif entry.end_with?(".m", ".mm", ".cpp") then
                 	if entry.to_s.end_with?('egister_all_game.cpp', 'AppDelegate.cpp')  then
   						# ...
                      else
                      	 fileReference = aGroup.new_reference(filePath)
                         aTarget.add_file_references([fileReference])
                      end

                 elsif entry.end_with?(".a", ".framework") then
                     if entry.to_s.end_with?('TwitterCore.framework', 'TwitterKit.framework') then
                       embed_frameworks_build_phase = aTarget.new_copy_files_build_phase('Embed Frameworks')
                       framework_ref = aGroup.new_file(filePath)
                       frameworks_build_phase = aTarget.build_phases.find { |build_phase| build_phase.to_s == 'FrameworksBuildPhase'}
                       build_file = embed_frameworks_build_phase.add_file_reference(framework_ref)
                       frameworks_build_phase.add_file_reference(framework_ref)
                           
                       aTarget.copy_files_build_phases.each do |item|
                          item.dst_subfolder_spec = "10"
                          item.files[0].settings = Hash.new
                          item.files[0].settings["ATTRIBUTES"] = ["CodeSignOnCopy"]
                       end
                           # build_file.settings = { 'ATTRIBUTES' => ['CodeSignOnCopy'] }
                     else
                       fileReference = aGroup.new_reference(filePath);
                       build_phase = aTarget.frameworks_build_phase;
                       build_phase.add_file_reference(fileReference);
                     end

               elsif entry.end_with?(".bundle", ".plist") && filePath.to_s.include?('XIInter') then
                   framework_ref = aGroup.new_file(filePath)
                   aTarget.resources_build_phase.add_file_reference(framework_ref)
               elsif entry.to_s.end_with?("data", "project.manifest", "res") then
 				           framework_ref = aGroup.new_file(filePath)
                   aTarget.resources_build_phase.add_file_reference(framework_ref)
                elsif filePath.to_s.include?('XIInter') || filePath.to_s.include?('Classes') && entry.end_with?(".h") || entry.end_with?(".pch") then
                	if entry.to_s.end_with?('register_all_game.h')  then
                		# ...
                	else
                		fileReference = aGroup.new_reference(filePath)
                	end
               else
                # puts '什么鬼，其他文件暂未考虑，请联系开发者'
               end
             end

         # 目录情况下, 递归添加
         elsif File.directory?(filePath) && entry != '.' && entry != '..' then
            if filePath.to_s.include?('XIInter') || filePath.to_s.include?('SDK') || filePath.to_s.include?('Resource') || entry.to_s.end_with?("Classes")
              subGroup = aGroup.find_subpath(File.join(entry))
             if !subGroup then
                 subGroup = aGroup.new_group(File.join(entry), entry, '<group>')
             end
              subGroup = aGroup.find_subpath(File.join(entry))
            	add_fileToProj(aTarget, subGroup, filePath)
            end
         end
     end
 end


 # 文件夹代码 .h .m
 name_temp = @newProj_Dir + file_name
 add_fileToProj(target, ios_group, name_temp)
 project.save

####################################################### 引入引擎层添加到主工程 ###########################################################
class SubProjectDispose
    attr_reader :mainproj_path, :subproj_path, :subproj_pathss, :main_project ,:sub_project,:subproj_ref_in_mainproj,:subproj_product_group_ref
    def initialize(mainproj_path,subproj_path,subproj_pathss)
        @mainproj_path = mainproj_path
        @subproj_path = subproj_path
        @subproj_pathss = subproj_pathss
        @main_project = Xcodeproj::Project.open(mainproj_path)
    end

    #根据productReference 找到其对应的target
    def get_target_with_productReference(productReference,project)
        project.native_targets.each { |target|
            if target.product_reference == productReference
                # puts "target = #{target}"
                return target
            end
        }
    end

    def add_new_subProj(group, path, source_tree)
    @subproj_ref_in_mainproj = Xcodeproj::Project::FileReferencesFactory.send(:new_file_reference, group, path, :group)
      @subproj_ref_in_mainproj.include_in_index = nil
      @subproj_ref_in_mainproj.name = Pathname(path).basename.to_s
      product_group_ref = group.project.new(Xcodeproj::Project::PBXGroup)
      product_group_ref.name = "Products" #手动拖动创建的group名字就是Products
      @sub_project = Xcodeproj::Project.open(path) #打开子工程

      @sub_project.products_group.files.each do |product_reference|
        # puts "product_reference = #{product_reference},name = #{product_reference.name},path = #{product_reference.path}"#product_reference = FileReference,name = ,path = ChencheMaBundle.bundle reference_proxy.file_type = wrapper.plug-in
        container_proxy = group.project.new(Xcodeproj::Project::PBXContainerItemProxy)
        container_proxy.container_portal = @subproj_ref_in_mainproj.uuid
        container_proxy.proxy_type = Xcodeproj::Constants::PROXY_TYPES[:reference]
        container_proxy.remote_global_id_string = product_reference.uuid
        #container_proxy.remote_info = 'Subproject' #这里和手动添加的是不一致的,手动的,这里是targets的名字
        subproj_native_target = get_target_with_productReference(product_reference,@sub_project)
        container_proxy.remote_info = subproj_native_target.name
        reference_proxy = group.project.new(Xcodeproj::Project::PBXReferenceProxy)
        extension = File.extname(product_reference.path)[2..-2]
        # puts("product_reference.path = #{product_reference.path}")
        if extension == "bundle"
            #xcodeproj的定义中,后缀为bundle的对应的是'bundle'       => 'wrapper.plug-in',但是我们手动拖动添加的是 'wrapper.cfbundle'
            reference_proxy.file_type = 'wrapper.cfbundle'
        elsif
          reference_proxy.file_type = Xcodeproj::Constants::FILE_TYPES_BY_EXTENSION[extension]
        end

        reference_proxy.path = product_reference.path
        reference_proxy.remote_ref = container_proxy
        reference_proxy.source_tree = 'BUILT_PRODUCTS_DIR'
        product_group_ref << reference_proxy
    end

        @subproj_product_group_ref = product_group_ref
        attribute = Xcodeproj::Project::PBXProject.references_by_keys_attributes.find { |attrb| attrb.name == :project_references }
        project_reference = Xcodeproj::Project::ObjectDictionary.new(attribute, group.project.root_object)
        project_reference[:project_ref] = @subproj_ref_in_mainproj
        project_reference[:product_group] = product_group_ref
        group.project.root_object.project_references << project_reference
        product_group_ref
    end

    def add_frameworks_build_phase()
        # puts("self.subproj_product_group_ref = #{self.subproj_product_group_ref}")
        reference_proxys = self.subproj_product_group_ref.children.grep(Xcodeproj::Project::PBXReferenceProxy)
        # puts("reference_proxys = #{reference_proxys}")
        reference_proxys.each do |reference_proxy|
          # puts("reference_proxy = #{reference_proxy.path}")
            if (reference_proxy.path.include?('iOS')) then
                native_target = self.main_project.native_targets.first
                native_target.frameworks_build_phase.add_file_reference(reference_proxy)
            end
        end
    end

    def add_subproject()
        allprojs = []
        allprojs.push(subproj_path)
        allprojs.push(subproj_pathss)

        for i in allprojs do
          add_new_subProj(self.main_project.main_group,i,:group)
          add_frameworks_build_phase()
         add_dependencies()
        end
    end

    def add_dependencies()
        native_target = self.main_project.native_targets.first
        @sub_project.native_targets.each do |nativeTarget|
            if (nativeTarget.product_type == Xcodeproj::Constants::PRODUCT_TYPE_UTI[:static_library]) then
                # puts("nativeTarget.productType = #{nativeTarget.product_type}")
                container_proxy = self.main_project.new(Xcodeproj::Project::PBXContainerItemProxy)
                container_proxy.container_portal = @subproj_ref_in_mainproj.uuid
                container_proxy.proxy_type = Xcodeproj::Constants::PROXY_TYPES[:native_target] #1
                container_proxy.remote_global_id_string = nativeTarget.uuid
                container_proxy.remote_info = nativeTarget.product_name

                target_dependency = @main_project.new(Xcodeproj::Project::PBXTargetDependency)
                if nativeTarget.name.include?('iOS')
                  target_dependency.name = nativeTarget.name
                  target_dependency.target_proxy = container_proxy
                  native_target.dependencies << target_dependency
                end
            end
        end
    end

    def close()
        self.main_project.save()
    end

end

dispose = SubProjectDispose.new(project_name + project_last_name,cocos2d_libs_path,cocos2d_js_bindings_path)
dispose.add_subproject()
dispose.close()





