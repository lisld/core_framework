local Log = require "logging":new()
local ffi = require "lffi"

-- 数据类型长度测试
Log:DEBUG("uint8_t长度为:"..ffi.sizeof(ffi.new("uint8_t")))
Log:DEBUG("uint16_t长度为:"..ffi.sizeof(ffi.new("uint16_t")))
Log:DEBUG("uint32_t长度为:"..ffi.sizeof(ffi.new("uint32_t")))
Log:DEBUG("uint64_t长度为:"..ffi.sizeof(ffi.new("uint64_t")))

-- 字符串测试
local cdata = ffi.new("char [?]", #"admin", "admin")
Log:DEBUG("将lua字符串转换为cdata:", cdata)
local str = ffi.string(cdata)
Log:DEBUG("将cdata转换为lua字符串:", str)

Log:DEBUG("测试cdata字符串类型是否可以索引:", cdata[0], cdata[1], cdata[2], cdata[3], cdata[4])
Log:DEBUG("测试cdata字符串类型是否可以转换:", string.char(cdata[0])..string.char(cdata[1])..string.char(cdata[2])..string.char(cdata[3])..string.char(cdata[4]))

-- 整型数组测试
local array = ffi.new("int[?]", 3, 1, 2, 3) -- 初始化方法 1
local array = ffi.new("int[3]", 1, 2, 3) -- 初始化方法 2
Log:DEBUG(array[0], array[1], array[2])

-- 结构体创建测试
ffi.cdef [[
  typedef struct cuboid { uint8_t h, w, l; } cuboid_t;
]]

local cuboid = ffi.new("cuboid_t", 2 ^ 4, 2 ^ 5, 2 ^ 6)
Log:DEBUG("创建长方体", cuboid, cuboid.h, cuboid.w, cuboid.l)
Log:DEBUG("计算体积", cuboid.h * cuboid.w * cuboid.l)

local cuboid_array = ffi.new("cuboid_t[3]", {{11, 12, 13}, {21, 22, 23}, {31, 32, 33}})
Log:DEBUG("创建3个长方体并且初始化", cuboid_array)
Log:DEBUG("3个长方体的长度分别为:", cuboid_array[0].l, cuboid_array[1].l, cuboid_array[2].l)
Log:DEBUG("3个长方体的宽度分别为:", cuboid_array[0].w, cuboid_array[1].w, cuboid_array[2].w)
Log:DEBUG("3个长方体的高度分别为:", cuboid_array[0].h, cuboid_array[1].h, cuboid_array[2].h)
