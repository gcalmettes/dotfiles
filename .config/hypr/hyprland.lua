local CONFIGS = os.getenv("HOME") .. "/.config/hypr/config.d"

require(CONFIGS .. "/00-startup")
require(CONFIGS .. "/05-env")
require(CONFIGS .. "/10-bindings")
require(CONFIGS .. "/20-gui")
require(CONFIGS .. "/30-input")
require(CONFIGS .. "/40-monitors")
require(CONFIGS .. "/50-rules-windows")
