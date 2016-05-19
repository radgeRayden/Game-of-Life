io.stdout:setvbuf('no')



local conway = require 'conway'


local mousePosition = {}

function love.load()
  scale = 8
  conway.init(1280 / scale, 720 / scale)
  mainCanvas = love.graphics.newCanvas(1280 / scale, 720 / scale)
  mainCanvas:setFilter('nearest', 'nearest')
end

function love.update(dt)
  mousePosition.x, mousePosition.y = love.mouse.getPosition()
  mousePosition.x = (mousePosition.x - mousePosition.x % scale) / scale
  mousePosition.y = (mousePosition.y - mousePosition.y % scale) / scale
  if love.mouse.isDown(1) then
    conway.setDot(mousePosition.x, mousePosition.y)
  end
end

function love.keypressed(key)
  if key == 'space' then
    conway.advanceGeneration()
  end
end

function love.draw()
  love.graphics.print("use the mouse to make some dots then press space", 15, 15)
  love.graphics.setCanvas(mainCanvas)
  love.graphics.clear()
  for i,v in ipairs(conway.grid) do
    if v.currentState then love.graphics.points(v.x + 0.5, v.y + 0.5) end
  end
  love.graphics.setColor(255, 0, 0)
  love.graphics.points(mousePosition.x + 0.5, mousePosition.y + 0.5)
  love.graphics.setColor(255, 255, 255)
  love.graphics.setCanvas()
  love.graphics.draw(mainCanvas,0,0, 0, scale, scale)
  love.graphics.setColor(255, 255, 255, 100)
  for x=0,1280 / scale do
    love.graphics.line(x * scale + 0.5, 0, x * scale + 0.5, 720)
  end
  for y=0,720 / scale do
    love.graphics.line(0, y * scale + 0.5, 1280, y * scale + 0.5)
  end
  love.graphics.setColor(255, 255, 255)
end
