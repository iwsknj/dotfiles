if not(vim.g.vscode) then
    vim.cmd[[colorscheme tokyonight]]
    vim.cmd[[highlight LineNr guifg=#87CEEB]] -- 行番号が見にくいので色を変えている
end
