% Grade 9 - Snake Rendition
View.Set ("graphics:400;400;nobuttonbar,offscreenonly,Title:Snake")

%Variables used
var snakeBodx : array 1 .. 100 of int
var snakeBody : array 1 .. 100 of int
var dir : int := 1
var lengthSnake : int := 1
var candyx : int := 20
var candyy : int := 20
var lose : boolean := false
var chars : array char of boolean

%set intial values
snakeBodx (1) := -100
snakeBody (1) := -100
for i : 2 .. 100
    snakeBodx (i) := snakeBodx (i - 1)
    snakeBody (i) := snakeBody (i - 1)
end for
snakeBodx (1) := 0
snakeBody (1) := 1


%Handles Direction Modification, collision Detection, Snake Eating
procedure checkSnake
    %Direction Update
    if dir = 1 then
	snakeBodx (1) += 1
    elsif dir = 2 then
	snakeBodx (1) -= 1
    elsif dir = 3 then
	snakeBody (1) += 1
    elsif dir = 4 then
	snakeBody (1) -= 1
    end if

    %collison with self detection
    for i : 2 .. lengthSnake
	if snakeBody (1) = snakeBody (i) & snakeBodx (1) = snakeBodx (i) then
	    lose := true
	    exit
	end if
    end for

    %border looping
    if snakeBodx (1) > 39 then
	snakeBodx (1) := 1
    end if
    if snakeBody (1) > 39 then
	snakeBody (1) := 1
    end if
    if snakeBodx (1) < 1 then
	snakeBodx (1) := 39
    end if
    if snakeBody (1) < 1 then
	snakeBody (1) := 39
    end if

    %Snake Eating
    if snakeBody (1) = candyy & snakeBodx (1) = candyx then
	lengthSnake += 1
	candyx := Rand.Int (1, 39)
	candyy := Rand.Int (1, 39)
    end if
end checkSnake

%Game Loop
loop
    %Shift Snake parts over a spot
    for decreasing i : lengthSnake .. 2
	snakeBodx (i) := snakeBodx (i - 1)
	snakeBody (i) := snakeBody (i - 1)
    end for
    % Handle Key Input
    Input.KeyDown (chars)

    if chars (KEY_UP_ARROW) & dir not= 4 then
	dir := 3
    end if
    if chars (KEY_RIGHT_ARROW) & dir not= 2 then
	dir := 1
    end if
    if chars (KEY_LEFT_ARROW) & dir not= 1 then
	dir := 2
    end if
    if chars (KEY_DOWN_ARROW) & dir not= 3 then
	dir := 4
    end if
    %Update Sanke Info
    checkSnake
    %Draw updated snake and Food
    cls
    Draw.FillBox (0, 0, 400, 400, black)
    for i : 2 .. lengthSnake
	Draw.FillBox ((snakeBodx (i) - 1) * 10, (snakeBody (i) - 1) * 10, (snakeBodx (i)) * 10, (snakeBody (i)) * 10, red)
    end for
    Draw.FillBox ((snakeBodx (1) - 1) * 10, (snakeBody (1) - 1) * 10, (snakeBodx (1)) * 10, (snakeBody (1)) * 10, green)
    for i : 2 .. lengthSnake
	Draw.Box ((snakeBodx (i) - 1) * 10, (snakeBody (i) - 1) * 10, (snakeBodx (i)) * 10, (snakeBody (i)) * 10, black)
    end for
    Draw.Box ((snakeBodx (1) - 1) * 10, (snakeBody (1) - 1) * 10, (snakeBodx (1)) * 10, (snakeBody (1)) * 10, white)
    Draw.FillBox ((candyx - 1) * 10, (candyy - 1) * 10, (candyx) * 10, (candyy) * 10, blue)

    View.Update
    %Sets game pace
    delay (80)
    if lose then
	exit
    end if
end loop

%Lose Screen
cls
Draw.FillBox (0, 0, 400, 400, black)
Font.Draw ("(:  Thanks For Playing  :)", 15, 230, Font.New ("comicsans:24:Bold"), blue)
Font.Draw ("YOU LOSE", 150, 200, Font.New ("comicsans:14"), red)
Font.Draw ("Score: " + intstr (lengthSnake - 1), 165, 170, Font.New ("comicsans:14"), green)
