# Package

version       = "0.1.0"
author        = "Jasmine"
description   = "Desktop version of a website I made before using WebUI"
license       = "MIT"
bin           = @["gpassui"]


# Tasks

before build:
  exec"nim js script.nim"


# Dependencies

requires "nim >= 1.4.0"
requires "https://github.com/neroist/webui"
