local packer_url = 'https://github.com/wbthomason/packer.nvim'
local packer_path = DATA_PATH .. '/site/pack/packer/start/packer.nvim'

local present, packer = pcall(require, "packer")

if not present then
    print("Downloading plugin manager packer.nvim ...")
    -- remove the dir before cloning
    vim.fn.delete(packer_path, "rf")
    vim.fn.system(
        {
            "git",
            "clone",
            packer_url,
            "--depth",
            "20",
            packer_path
        }
    )

    present, packer = pcall(require, "packer")

    if present then
        print("Packer cloned successfully.")
    else
        error("Couldn't clone packer !\nPacker path: " .. packer_path)
    end
end

return packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "single" })
        end
    },
    git = {
        clone_timeout = 600 -- Timeout, in seconds, for git clones
    },
    compile_path = DATA_PATH .. '/site/lua/packer_compiled.lua',
    -- opt_default = true,
    profile = { enable = true },
}
