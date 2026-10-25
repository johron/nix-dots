hl.bind("mouse:274", function()
    hl.exec_cmd("playerctl play-pause")
end)

hl.gesture({
    fingers = 3,
    direction = "up",
    action = function()
        hl.exec_cmd("playerctl previous")
    end
})

hl.gesture({
    fingers = 3,
    direction = "down",
    action = function()
        hl.exec_cmd("playerctl next")
    end
})
