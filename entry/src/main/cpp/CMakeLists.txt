# 配置CMake编译参数。配置需要添加的hello.cpp文件，编译后的so文件名为libhello.so。
# project、add_library方法中的内容可以根据实际情况修改。

# 声明使用 CMAKE 的最小版本号
cmake_minimum_required(VERSION 3.4.1)

# 配置项目信息
project(NativeTemplateDemo)

# set命令，格式为set(key value)，表示设置key的值为value
set(NATIVERENDER_ROOT_PATH ${CMAKE_CURRENT_SOURCE_DIR})

# 设置头文件的搜索目录
include_directories(
    ${NATIVERENDER_ROOT_PATH}
    ${NATIVERENDER_ROOT_PATH}/include
)

# 添加日志库
find_library(
    # 设置路径变量的名称，给日志库，取一个名称
    hilog-lib

    # 指定NDK库的名称，鸿蒙底层C C++，日志输出的动态库：liblog_ndk.z.so。
    hilog_ndk.z
)

# 添加名为hello的库，库文件名为libhello.so
add_library(hello SHARED hello.cpp)

# 添加构建需要链接的库
target_link_libraries(hello PUBLIC ${hilog-lib} libace_napi.z.so libc++.a)