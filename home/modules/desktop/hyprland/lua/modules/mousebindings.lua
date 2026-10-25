hl.bind("mouse:275", function()
    hl.exec_cmd("playerctl play-pause")
end)


hl.gesture({
    fingers = 4,
    direction = "up",
    action = function()
        hl.exec_cmd("playerctl previous")
    end
})

hl.gesture({
    fingers = 4,
    direction = "down",
    action = function()
        hl.exec_cmd("playerctl next")
    end
})
