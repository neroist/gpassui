# Package

version       = "0.1.0"
author        = "Jasmine"
description   = "A new awesome nimble package"
license       = "MIT"
bin           = @["gpassui"]


# Tasks

before build:
  exec"nim js script.nim"


# Dependencies

requires "nim >= 1.4.0"
requires "https://github.com/neroist/webui"
