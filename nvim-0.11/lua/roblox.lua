local function build_github_url(branch, line_num)
	local git_url = vim.fn.system("git config --get remote.origin.url")
	if git_url == "" then
		error("Not a git repository")
		return
	end
	-- if string.find(git_url, "https://") then
	-- 	git_url = string.sub(git_url, 1, -6)
	-- elseif string.find(git_url, "git@") then
	-- 	git_url = "https://github.com/" .. string.sub(git_url, 16, -1)
	-- end

    git_url = git_url:gsub("[\n\r]", "")
	local path = vim.fn.expand("%")
	local url = git_url .. "/blob/" .. branch .. "/" .. path
    if line_num ~= nil then
        url = url .. "#L" .. line_num
    end
	return url
end

vim.api.nvim_create_user_command("CopyGithubLinkFromMasterWithLine", function()
	local line_num = vim.api.nvim__buf_stats(0).current_lnum
    local url = build_github_url("master", line_num)
    vim.fn.setreg("+", url)
end, {})

vim.api.nvim_create_user_command("CopyGithubLinkFromCurrentBranchWithLine", function()
	local line_num = vim.api.nvim__buf_stats(0).current_lnum
    local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD")
    local url = build_github_url(branch, line_num)
    vim.fn.setreg("+", url)
end, {})

vim.api.nvim_create_user_command("CopyGithubLinkFromMaster", function()
    local url = build_github_url("master")
    vim.fn.setreg("+", url)
end, {})

vim.api.nvim_create_user_command("CopyGithubLinkFromCurrentBranch", function()
    local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD")
    local url = build_github_url(branch)
    vim.fn.setreg("+", url)
end, {})

-- vim.keymap.set("n", "<leader>glm", ":CopyGithubLinkFromMaster<CR>", { desc = "Copy Github link for master" })
-- vim.keymap.set("n", "<leader>glb", ":CopyGithubLinkFromCurrentBranch<CR>", { desc = "Copy Github link for current branch" })

