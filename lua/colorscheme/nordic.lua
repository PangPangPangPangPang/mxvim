local M = {}
M.config = function()
    require(mxvim.current_theme).load()

end

M.colors = function()
    local nord = {
        fg = "#ECEFF4",
        bg = "#2E3440",
        yellow = "#EBCB8B",
        cyan = "#8FBCBB",
        darkblue = "#81A1C1",
        green = "#A3BE8C",
        orange = "#D08770",
        purple = "#B48EAD",
        magenta = "#D27E99",
        blue = "#5E81AC",
        red = "#BF616A",
        line_fg = "#2E3440",
    }
    return nord
end
return M