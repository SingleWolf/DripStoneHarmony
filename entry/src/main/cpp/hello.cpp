#include <hilog/log.h>       // 鸿蒙提供的底层日志头文件
#include "napi/native_api.h" // 默认被鸿蒙调用 __attribute__ 的 鸿蒙核心 napi 头文件
#include "./common/common.h" // 通用的标记

#include "math.h" // 数学计算 相关的API系列
#include <cstring>

// 4. 与 index.d.ts 的 myHypot 关联的 MyHypot，是真正执行逻辑干活的方法
// 使用C标准库的hypot方法进行计算，引入C标准库头文件math.h。
// 使用double类型解析传入的参数后，调用C标准库方法hypot计算两数平方的和后计算平方根。
// 使用NAPI接口napi_create_double将结果转化为napi_value类型 的 变量 并 返回
static napi_value MyHypot(napi_env env, napi_callback_info info) {
    if ((nullptr == env) || (nullptr == info)) {
        OH_LOG_Print(LOG_APP, LOG_ERROR, LOG_PRINT_DOMAIN, "MyHypot", "env或info为空");
        return nullptr;
    }

    size_t argc = PARAMETER_COUNT; // 参数数量

    napi_value args[PARAMETER_COUNT] = {nullptr}; // 定义参数数组

    // 获取传入的参数并放入参数数组中
    if (napi_ok != napi_get_cb_info(env, info, &argc, args, nullptr, nullptr)) {
        OH_LOG_Print(LOG_APP, LOG_ERROR, LOG_PRINT_DOMAIN, tag, "api_get_cb_info操作检测失败");
        return nullptr;
    }

    // 将传入的参数转化为double类型
    double valueX = 0.0;
    double valueY = 0.0;
    if (napi_ok != napi_get_value_double(env, args[0], &valueX) ||
        napi_ok != napi_get_value_double(env, args[1], &valueY)) {
        OH_LOG_Print(LOG_APP, LOG_ERROR, LOG_PRINT_DOMAIN, tag, "napi_get_value_double操作检测失败");
        return nullptr;
    }

    // 调用C标准库的hypot接口进行计算
    double result = hypot(valueX, valueY);

    // 创建返回结果并返回
    napi_value napiResult;
    if (napi_ok != napi_create_double(env, result, &napiResult)) {
        OH_LOG_Print(LOG_APP, LOG_ERROR, LOG_PRINT_DOMAIN, tag, "napi_create_double操作检测失败");
        return nullptr;
    }
    return napiResult;
}

static napi_value Add(napi_env env, napi_callback_info info) {
    size_t argc = 2;
    napi_value args[2] = {nullptr};

    napi_get_cb_info(env, info, &argc, args, nullptr, nullptr);

    napi_valuetype valuetype0;
    napi_typeof(env, args[0], &valuetype0);

    napi_valuetype valuetype1;
    napi_typeof(env, args[1], &valuetype1);

    double value0;
    napi_get_value_double(env, args[0], &value0);

    double value1;
    napi_get_value_double(env, args[1], &value1);

    napi_value sum;
    napi_create_double(env, value0 + value1, &sum);

    return sum;
}

static napi_value GetMyHypotLabel(napi_env env, napi_callback_info info) {
    char *result = "计算两个给定数平方和的平方根";
    // 创建返回结果并返回
    napi_value napiResult;
    if (napi_ok != napi_create_string_utf8(env, result, strlen(result), &napiResult)) {
        OH_LOG_Print(LOG_APP, LOG_ERROR, LOG_PRINT_DOMAIN, tag, "napi_create_string_utf8");
        return nullptr;
    }
    return napiResult;
}

static napi_value GetAddLabel(napi_env env, napi_callback_info info) {
    char *result = "计算两个给定数的和";
    // 创建返回结果并返回
    napi_value napiResult;
    if (napi_ok != napi_create_string_utf8(env, result,strlen(result), &napiResult)) {
        OH_LOG_Print(LOG_APP, LOG_ERROR, LOG_PRINT_DOMAIN, tag, "napi_create_string_utf8");
        return nullptr;
    }
    return napiResult;
}

// 3.做一些基础校验检查工作。
// 注意 File->New->Create Project -> 【Native C++模板] 创建项目会自动生成此结构代码，开发者可根据实际情况修改其中内容哈
EXTERN_C_START
static napi_value Init(napi_env env, napi_value exports) {
    if ((nullptr == env) || (nullptr == exports)) {
        OH_LOG_Print(LOG_APP, LOG_ERROR, LOG_PRINT_DOMAIN, tag_init, "env 或者 exports 是空的啊");
        return exports;
    }

    // 在 napi_property_descriptor desc[]中，我们需要将编写的MyHypot方法 与 对外提供的接口myHypot接口进行关联，其他参数使用示例默认值填写。
    napi_property_descriptor desc[] = {
        {"myHypot", nullptr, MyHypot, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"add", nullptr, Add, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"getMyHypotLabel", nullptr, GetMyHypotLabel, nullptr, nullptr, nullptr, napi_default, nullptr},
        {"getAddLabel", nullptr, GetAddLabel, nullptr, nullptr, nullptr, napi_default, nullptr}
    };

    // 使用Native API接口napi_define_properties 构建包含方法 对应列表的 返回值。
    if (napi_ok != napi_define_properties(env, exports, sizeof(desc) / sizeof(desc[0]), desc)) {
        OH_LOG_Print(LOG_APP, LOG_ERROR, LOG_PRINT_DOMAIN, tag_init, "napi_define_properties 失败了，请检查代码");
        return nullptr;
    }
    return exports;
}
EXTERN_C_END

// 1.下面代码为：配置模块描述信息，设置Init方法为 napi_module 的入口方法。
static napi_module demoModule = {
    .nm_version = 1,
    .nm_flags = 0,
    .nm_filename = nullptr,
    .nm_register_func = Init, // napi_module入口方法
    .nm_modname = "hello",    // napi_module模块名
    .nm_priv = ((void *)0),
    .reserved = {0}};

// 2.下面代码为：__attribute__((constructor))修饰的方法 由系统自动调用哦
// 注意 File->New->Create Project -> 【Native C++模板] 创建项目会自动生成此结构代码，开发者可根据实际情况修改其中内容哈
extern "C" __attribute__((constructor)) void RegisterModule(void) {
    // 使用 Native API接口napi_module_register()传入模块描述信息进行模块注册。
    napi_module_register(&demoModule);
}