local plugins = {}

function plugins.isPluginLoaded(pluginName)
  -- local ok, _ = pcall(require, "packer")
  -- if not ok then
  --   return false
  -- end

  return packer_plugins[pluginName] and packer_plugins[pluginName].loaded
end

return plugins
