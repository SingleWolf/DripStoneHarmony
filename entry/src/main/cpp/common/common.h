// 通用标记的头文件
// Node APIs are not fully supported. To solve the compilation error of the interface cannot be found,
// please include "napi/native_api.h".
#include <napi/native_api.h>

#ifndef DripStone_common_H
#define DripStone_common_H

/**
 * 参数的数量
 */
const int PARAMETER_COUNT = 2;

/**
 * 日志打印区域
 * 日志所在的服务域，十六进制整数形式，取值范围是0x0 ~ 0xFFFF
 */
const unsigned int LOG_PRINT_DOMAIN = 0xF00;

const char * tag = "Walker";

const char * tag_init = "<init>";

#endif //DripStone_common_H
