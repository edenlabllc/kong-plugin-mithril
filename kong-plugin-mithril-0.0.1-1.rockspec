package = "kong-plugin-mithril"  -- TODO: rename, must match the info in the filename of this rockspec!
                                  -- as a convention; stick to the prefix: `kong-plugin-`
version = "0.0.1-1"               -- TODO: renumber, must match the info in the filename of this rockspec!
-- The version '0.0.1' is the source code version, the trailing '1' is the version of this rockspec.
-- whenever the source version changes, the rockspec should be reset to 1. The rockspec version is only
-- updated (incremented) when this file changes, but the source remains the same.

supported_platforms = {"linux", "macosx"}
source = {
--   these are initially not required to make it work
--   url = "git://github.com/Mashape/kong_plugin",
--   tag = "0.0.1"
}

description = {
  summary = "Kong is a scalable and customizable API Management Layer built on top of Nginx.",
  homepage = "http://getkong.org",
  license = "MIT"
}

dependencies = {
    "lua-resty-http == 0.11",
    "dkjson == 2.5"
}

local pluginName = "mithril"  -- TODO: rename. This is the name to set in the Kong configuration `custom_plugins` setting.
build = {
  type = "builtin",
  modules = {
    ["kong.plugins."..pluginName..".handler"] = "kong/plugins/"..pluginName.."/handler.lua",
    ["kong.plugins."..pluginName..".schema"] = "kong/plugins/"..pluginName.."/schema.lua",
  }
}