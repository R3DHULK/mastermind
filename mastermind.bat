@echo off
title Mastermind Game

setlocal enabledelayedexpansion

:: Define variables
set "colors=123456"
set /a "code=%random% %% 6 + 1"
set "guess=____"
set /a "tries=10"

:: Game loop
:game_loop
cls
echo Mastermind Game
echo.
echo Guess the code using the following colors:
echo 1 = Red
echo 2 = Green
echo 3 = Blue
echo 4 = Yellow
echo 5 = Purple
echo 6 = Orange
echo.
echo Guesses left: %tries%
echo Current guess: %guess%
echo.
set /p "input=Enter your guess: "

:: Validate input
set "valid=true"
if not defined input (
  set "valid=false"
) else if not "%input:~0,4%" equ "%input%" (
  set "valid=false"
) else (
  for /l %%i in (1,1,4) do (
    set "char=!input:~%%i,1!"
    if "!colors:%%char%=!" equ "%colors%" (
      set "valid=false"
      goto input_invalid
    )
  )
)

:: Process input
set "correct_pos=0"
set "correct_color=0"
for /l %%i in (1,1,4) do (
  set "char=!input:~%%i,1!"
  if "!code:~%%i,1!" equ "!char!" (
    set /a "correct_pos+=1"
  ) else if "!code!" equ "!code:%%char%=!" (
    set /a "correct_color+=1"
  )
)
set "guess=%input%"
echo.
echo Correct position: %correct_pos%
echo Correct color: %correct_color%
echo.
pause >nul

:: Check win/lose
if "%guess%" equ "%code%" (
  echo You win! The code was %code%.
  pause >nul
  exit
) else if %tries% equ 1 (
  echo You lose! The code was %code%.
  pause >nul
  exit
) else (
  set /a "tries-=1"
)

:: Input invalid
:input_invalid
if not %valid% equ true (
  echo Invalid input. Please try again.
  pause >nul
)

:: Loop
goto game_loop
