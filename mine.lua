ORES = {
    ["minecraft:diamond_ore"] = true,
    ["minecraft:iron_ore"] = true,
    ["minecraft:lapis_ore"] = true,
    ["minecraft:gold_ore"] = true,
    ["minecraft:coal_ore"] = true,
    ["minecraft:emerald_ore"] = true,
    ["minecraft:redstone_ore"] = true,
    ["minecraft:copper_ore"] = true,
    ["create:zinc_ore"] = true,
    ["minecraft:deepslate_diamond_ore"] = true,
    ["minecraft:deepslate_iron_ore"] = true,
    ["minecraft:deepslate_lapis_ore"] = true,
    ["minecraft:deepslate_gold_ore"] = true,
    ["minecraft:deepslate_coal_ore"] = true,
    ["minecraft:deepslate_emerald_ore"] = true,
    ["minecraft:deepslate_redstone_ore"] = true,
    ["minecraft:deepslate_copper_ore"] = true,
    ["create:deepslate_zinc_ore"] = true
}
function refuel()
    if turtle.getFuelLevel()<turtle.getFuelLimit()/2 then
        turtle.select(1)
        local slot = 1
        while not turtle.refuel(10) and slot <= 16 do
            turtle.select(slot)
            slot = slot + 1
        end
    end
end
function is_ore(blocks, is_block, block)
    return is_block and blocks[block.name]
end
function vein_forward(blocks)
    if is_ore(blocks, turtle.inspect()) then
        turtle.dig()
        turtle.forward()
        vein(blocks)
        turtle.back()
    end
end
function vein(blocks)
    vein_forward(blocks)
    if is_ore(blocks, turtle.inspectUp()) then
        turtle.digUp()
        turtle.up()
        vein(blocks)
        turtle.down()
    end
    if is_ore(blocks, turtle.inspectDown()) then
        turtle.digDown()
        turtle.down()
        vein(blocks)
        turtle.up()
    end
    turtle.turnLeft()
    vein_forward(blocks)
    turtle.turnRight()
    turtle.turnRight()
    vein_forward(blocks)
    turtle.turnLeft()
end
function mine(distance, blocks)
    for x = 1,distance do
        vein(blocks)
        turtle.up()
        vein(blocks)
        turtle.down()
        turtle.dig()
        turtle.forward()
        turtle.digUp()
        refuel()
    end
    for x = 1,distance do
        turtle.back()
    end
end
mine(100, {["minecraft:andesite"]=true})