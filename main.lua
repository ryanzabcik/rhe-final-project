debug = true

function love.load()
    params = {
        width = 1920,
        height = 1080,
        protag = {
            width = 50,
            height = 76
        }
    }
    love.physics.setMeter(64) --the height of a meter our worlds will be 64px
    world = love.physics.newWorld(0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
    love.graphics.setBackgroundColor(255,255,255)
    love.window.setMode(params.width, params.height)

    protag = {}
    protag.body = love.physics.newBody(world, params.width/2, params.height/2, 'dynamic') -- the player starts off at the center of the world and falls to the ground
    protag.shape = love.physics.newRectangleShape(params.protag.width, params.protag.height)
    protag.fixture = love.physics.newFixture(protag.body, protag.shape, 1) -- the last arg is density
    protag.sprite = love.graphics.newImage("img/protag.standing.left.png")
    ground = {}
    ground.body = love.physics.newBody(world, params.width/2, params.height - 50, 'static')
    ground.shape = love.physics.newRectangleShape(params.width, 50)
    ground.fixture = love.physics.newFixture(ground.body, ground.shape)
end

function love.update(dt)
    world:update(dt)
    protag.x, protag.y = protag.body:getWorldPoints(protag.shape:getPoints())
end

function love.draw()
    love.graphics.clear()
    love.graphics.setColor(255,255,255)
    love.graphics.draw(protag.sprite, protag.x, protag.y)
    -- debug: bounding box for the protag
    love.graphics.setColor(0,0,0)
    love.graphics.polygon("line", protag.body:getWorldPoints(protag.shape:getPoints()))
    love.graphics.setColor(0, 255, 0)
    love.graphics.polygon("fill", ground.body:getWorldPoints(ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates
end
