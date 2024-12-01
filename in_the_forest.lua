-- in the forest
-- generative textural soundscape
-- v1.0.0

engine.name = 'PolyPerc'

-- music theory helpers
local base_note = 48
local active_notes = {}

-- Scale options for different moods (uncomment the scale of your choice)

-- Pentatonic scale (ethereal, calming)
local scale = {0, 2, 5, 7, 9, 12, 14, 17, 19, 21, 24}

-- Mixolydian scale (dreamy, folk-like)
-- local scale = {0, 2, 4, 5, 7, 9, 10, 12, 14, 16, 17}

-- Lydian scale (floating, bright)
-- local scale = {0, 2, 4, 6, 7, 9, 11, 12, 14, 16, 18}

-- Dorian scale (minor, mystical)
-- local scale = {0, 2, 3, 5, 7, 9, 10, 12, 14, 15, 17}

-- Whole-tone scale (open, hypnotic)
-- local scale = {0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20}


-- visual elements for stars and trees
local stars = {}
for i = 1, 30 do  -- Star count adjust to 50 for a fuller sky
  table.insert(stars, {
    x = math.random(5, 123),
    y = math.random(12, 30),  -- Set stars high in the sky
    brightness = math.random(3, 8),
    flicker_speed = math.random() * 0.5 + 0.1
  })
end

local trees = {}
for i = 1, 10 do
  table.insert(trees, {
    x = math.random(10, 118),
    height = math.random(15, 25),
    width = math.random(6, 10)
  })
end

-- screen drawing helpers
-- Function to draw cross-shaped stars that "twinkle" without rotating
function draw_twinkling_star(star)
  local twinkle = math.sin(util.time() * star.flicker_speed) * 6
  local brightness = math.floor(star.brightness + twinkle)
  screen.level(math.max(1, math.min(15, brightness)))

  -- Cross shape
  screen.pixel(star.x, star.y - 1)  -- top point
  screen.pixel(star.x, star.y + 1)  -- bottom point
  screen.pixel(star.x - 1, star.y)  -- left point
  screen.pixel(star.x + 1, star.y)  -- right point
  screen.fill()
end

-- Updated draw_stars function using draw_twinkling_star
function draw_stars()
  for _, star in ipairs(stars) do
    draw_twinkling_star(star)
  end
end

function draw_tree(x, height, width)
  -- Draw tree trunk
  screen.level(3)
  screen.move(x, 50)
  screen.line(x, 50 - height * 0.5)
  screen.stroke()

  -- Draw branches with tapering layers
  screen.level(4)
  for i = 0, 2 do
    local layer_height = 50 - height * 0.3 * i
    local layer_width = width - (i * 2)
    screen.move(x - layer_width / 2, layer_height)
    screen.line(x, layer_height - 3)
    screen.line(x + layer_width / 2, layer_height)
    screen.stroke()
  end
end

function draw_forest()
  table.sort(trees, function(a, b) return a.x < b.x end)
  for _, tree in ipairs(trees) do
    draw_tree(tree.x, tree.height, tree.width)
  end
end

-- parameter setup
function init()
  -- sound parameters
  params:add_control("reverb_amount", "reverb amount", controlspec.new(0, 1, 'lin', 0, 0.95))
  params:set_action("reverb_amount", function(x) engine.reverb(x) end)
  
  params:add_control("delay_time", "delay time", controlspec.new(0, 1, 'lin', 0, 0.8))
  params:set_action("delay_time", function(x) engine.delay(x) end)
  
  params:add_control("note_release", "note release", controlspec.new(2.0, 12.0, 'lin', 0, 8.0))
  params:set_action("note_release", function(x) engine.release(x) end)
  
  params:add_control("note_density", "note density", controlspec.new(0, 1, 'lin', 0, 0.15))
  
  -- slower timers for more ambient, evolving texture
  metro_notes = metro.init()
  metro_notes.time = 2.0
  metro_notes.event = step_notes
  metro_notes:start()
  
  metro_screen = metro.init()
  metro_screen.time = 1/15
  metro_screen.event = function() redraw() end
  metro_screen:start()
end

function generate_note()
  local note = scale[math.random(1, #scale)]
  local octave = math.random(-1, 1) * 12
  return base_note + note + octave
end

function step_notes()
  -- generate new notes with varying octaves and random velocities
  active_notes = {}
  for i = 1, math.random(1, 3) do
    local note = generate_note()
    engine.hz(midi_to_hz(note))
    local vel = math.random() * 0.2 + 0.3
    engine.amp(vel)
    table.insert(active_notes, note)
  end
end

function midi_to_hz(note)
  return (440 / 32) * (2 ^ ((note - 9) / 12))
end

-- Main screen refresh function
function redraw()
  screen.clear()
  
  draw_stars()  -- stars high in the sky
  draw_forest() -- trees in the background
  
  -- Draw the top line of text
  screen.level(15)
  screen.move(64, 10)  -- Position near the top
  screen.text_center("with the light of")

  -- Draw the bottom line of text
  screen.move(64, 60)  -- Position near the bottom
  screen.text_center("a billion brilliant stars")
  
  screen.update()
end