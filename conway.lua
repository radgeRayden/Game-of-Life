local conway = {}

local function dotp(x, y)
  local self = {}
  self.x = x
  self.y = y

  local neighbours = {
    {x = self.x - 1, y = self.y}, --west
    {x = self.x - 1, y = self.y - 1}, --northwest
    {x = self.x, y = self.y - 1}, --north
    {x = self.x + 1, y = self.y - 1}, --northeast
    {x = self.x + 1, y = self.y}, --east
    {x = self.x + 1, y = self.y + 1}, --southeast
    {x = self.x, y = self.y + 1}, --south
    {x = self.x -1, y = self.y + 1}  --southwest
  }

  self.neighbours = neighbours
  self.currentState = false
  self.nextState = false
  return self
end

local function getDot(x, y)
  return conway.grid[((y - 1) * conway.width) + x]
end

local function checkNeighbours(x, y)
  local activeNeighbours = 0
  for i,v in ipairs(getDot(x, y).neighbours) do
    local dot = getDot(v.x, v.y)
    if dot and dot.currentState then
      activeNeighbours = activeNeighbours + 1
    end
  end
  return activeNeighbours
end

function conway.init(width, height)
  conway.width = width
  conway.height = height
  conway.grid = {}
  for x=1,width do
    for y=1,height do
      conway.grid[((y - 1) * width) + x] = dotp(x, y)
    end
  end
end

function conway.setDot(x, y)
  local dot = getDot(x, y)
  dot.currentState = true
end

function conway.advanceGeneration()
  for i,v in ipairs(conway.grid) do
    local n = checkNeighbours(v.x, v.y)
    if n > 3 then v.nextState = false end
    if n < 2 then v.nextState = false end
    if n == 2 and v.currentState then v.nextState = true end 
    if n == 3 then v.nextState = true end
  end

  for i,v in ipairs(conway.grid) do
    v.currentState = v.nextState
  end
end

return conway
