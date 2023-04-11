@echo off
title Monster Battle Game

setlocal enabledelayedexpansion

:: Define variables
set "player_hp=50"
set "player_dmg=10"
set "monster_hp=80"
set "monster_dmg=15"

:: Game loop
:game_loop
cls
echo Monster Battle Game
echo.
echo Player HP: %player_hp%
echo Monster HP: %monster_hp%
echo.
echo 1) Attack
echo 2) Heal (costs 10 HP)
echo.
set /p "input=Enter your choice: "

:: Validate input
set "valid=true"
if not defined input (
  set "valid=false"
) else if not "%input%" equ "1" if not "%input%" equ "2" (
  set "valid=false"
)

:: Process input
if %valid% equ true (
  if "%input%" equ "1" (
    set /a "monster_hp-=player_dmg"
    if %monster_hp% leq 0 (
      set "monster_hp=0"
      echo You win!
      pause >nul
      exit
    )
    set /a "player_hp-=monster_dmg"
    if %player_hp% leq 0 (
      set "player_hp=0"
      echo You lose!
      pause >nul
      exit
    )
  ) else (
    if %player_hp% lss 10 (
      echo Not enough HP to heal.
    ) else (
      set /a "player_hp-=10"
      set /a "player_hp+=player_dmg"
      if %player_hp% gtr 50 (
        set "player_hp=50"
      )
    )
  )
) else (
  echo Invalid input. Please try again.
  pause >nul
)

:: Loop
goto game_loop
