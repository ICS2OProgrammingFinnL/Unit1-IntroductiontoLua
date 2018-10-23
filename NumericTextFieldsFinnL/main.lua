-----------------------------------------------------------------------------------------
--Title: Numeric Text Field
--Name: Finn
--Course: ICS20
--This program displays a math question and asks the user to answer in a numeric text field terminal.
-----------------------------------------------------------------------------------------

-- Hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- sets the background colour
display.setDefault("background" , 200/255, 50/255, 100/255)


--------------------------------------------------------------------------------------------
-- LOCAL VARIABLES
--------------------------------------------------------------------------------------------

-- create my local variables
local questionObject
local correctObject
local numericField
local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer
local incorrectAnswer
local randomOperator
local startingPoints = 0
local points
local GameOverImage




--variables for the  timer
local totalSeconds = 10
local secondsLeft = 10
local clockText
local countdownTimer

--variables for the lives
local lives = 4
local heart1
local heart2
local heart3
local heart4
----------------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------
local function UpdateLives()


	if (lives == 3 ) then
		heart1.isVisible = false
	elseif ( lives == 2) then
		heart2.isVisible = false
	elseif ( lives == 1) then 
		heart3.isVisible = false
	elseif ( lives == 0) then
		heart4.isVisible = false
		GameOverImage.isVisible = true
	end
end		

local function UpdateTime() 

	-- decrement the number of seconds
	secondsLeft = secondsLeft - 1

	--display the number of seconds left in the clock object
	clockText.text = secondsLeft .. ""

		if (secondsLeft == 0 ) then
			-- reset the number of seconds left
			secondsLeft = totalSeconds
			lives = lives - 1
			

			-- Call the askquestion function	
			AskQuestion()
	end
end			


--functions that calls the timer
local function StartTimer()
	-- Create a countdown timer that loops infinitely
	countdownTimer = timer.performWithDelay( 1000, UpdateTime, 0)
end





local function AskQuestion() 
	-- generate 2 random numbers between a max. and a min. number
	randomNumber1 = math.random(0, 10)
	randomNumber2 = math.random(0, 10)
	randomOperator = math.random(1,3)

	if (randomOperator == 1) then
	
		correctAnswer = randomNumber1 + randomNumber2

		-- create question in text object
		questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "

	elseif (randomOperator == 2) then

		correctAnswer = randomNumber1 - randomNumber2

		--create question in text object
		questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. " = "

	elseif (randomOperator == 3) then

		correctAnswer = randomNumber1 * randomNumber2

		--create question in text object
		questionObject.text = randomNumber1 .. " * " .. randomNumber2 .. " = "
	end
end









	

local function HideCorrect()
	correctObject.isVisible = false
	AskQuestion()
end

local function HideIncorrect()
	incorrectObject.isVisible = false
	AskQuestion()
end

local function NumericFieldListener(event)

	-- user begins editing "numeric field"
	if ( event.phase == "began") then
		---clear text field
		event.target.text = ""

		elseif event.phase == "submitted" then 
			-- when the answer is (enter key is pressed) set user input to user's answer
			userAnswer = tonumber(event.target.text)

			-- if the users answer and the correct answer are the same:
			if (userAnswer == correctAnswer) then 
				correctObject.isVisible = true
				startingPoints = startingPoints + 1
				timer.performWithDelay(1000, HideCorrect)

				--display the points going up
				points.text = " Points = " .. startingPoints
			else
				--if they aren't the same
				incorrectObject.isVisible = true
				timer.performWithDelay(1000, HideIncorrect)
				lives = lives - 1
				UpdateLives()
			end

			event.target.text = ""
		end
    end

---------------------------------------------------------------------------------------------
--OBJECT CREATION
--------------------------------------------------------------------------------------------

--displays a  question and sets the colour
questionObject = display.newText("", display.contentWidth/3, display.contentHeight/2, nil, 50 )
questionObject:setTextColor(155/255, 100/255, 100/255)

points = display.newText("Points = " .. startingPoints , display.contentWidth/1.4, display.contentHeight/2, nil, 50 )
points:setTextColor(155/255, 100/255, 100/255)

--create the correct text object and make it visible
correctObject = display.newText ("Correct!", display.contentWidth/2, display.contentHeight*2/3, nil, 50)
correctObject:setTextColor(255/255, 10/255, 50/255)
correctObject.isVisible = false


incorrectObject = display.newText ("Incorrect!", display.contentWidth/2, display.contentHeight*2/3, nil, 50)
incorrectObject:setTextColor(255/255, 10/255, 50/255)
incorrectObject.isVisible = false


--create numeric field 
numericField = native .newTextField( display.contentWidth/2, display.contentHeight/2, 150, 80)
numericField.inputType = "number"

numericField:addEventListener( "userInput", NumericFieldListener )
--add thier event listener for the numeric field

--dislay heart shapes
heart1 = display.newImageRect("Images/heart.png" , 100,100)
heart2 = display.newImageRect("Images/heart.png" , 100,100)
heart3 = display.newImageRect("Images/heart.png" ,  100,100)
heart4 = display.newImageRect("Images/heart.png" ,  100,100)


-- game over image with width and height 
GameOverImage = display.newImageRect("Images/gameOver.png" , 2048, 1536)
GameOverImage.isVisible = false



-- set the initial x and y position of the hearts
heart1.x = display.contentWidth * 7 / 8
heart1.y = display.contentHeight * 3.5/4

heart2.x = display.contentWidth * 6 / 8
heart2.y = display.contentHeight * 3.5/4

heart3.x = display.contentWidth * 5 / 8
heart3.y = display.contentHeight * 3.5/4

heart4.x = display.contentWidth * 4 / 8
heart4.y = display.contentHeight * 3.5/4
----------------------------------------------------------------------------------------------
--FUNCTION CALLS
---------------------------------------------------------------------------------------------

-- call the function to ask the question
AskQuestion()