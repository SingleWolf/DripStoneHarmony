// 添加 接口文件 以及 接口配置文件。
// 接口文件index.d.ts用于对外提供方法说明。
// 接口配置文件oh-package.json5文件中将index.d.ts与CMake编译的so文件关联起来。
// 模块级目录下oh-package.json5文件添加so文件依赖。
export const myHypot : (a: number, b: number) => number;

export const add: (a: number, b: number) => number;

export const getMyHypotLabel: () => string;

export const getAddLabel: () => string;