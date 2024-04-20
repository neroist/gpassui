import std/strformat
import std/sequtils
import std/sugar
import std/math
import std/dom

proc shannon(list: string): float =
  ## Shannon Entropy - bits of entropy per character

  let 
    elems      = list.deduplicate()
    frequences = collect:
      for elem in elems: 
        list.count(elem) / list.len

  for frequency in frequences:
    result += frequency * log2(frequency)

  -result

proc toIntStr*(num: float): string =
  ## Chops off the trailing ".0" from floats.
  ## If not present, then no work is done
  ## (aside from converting `num` to a string)

  result = $num

  if result[^2..^1] == ".0": result = result[0..^3]

proc adapt {.exportc.} = 
  let 
    password    = $document.getElementById("password").value
    guesses     = document.getElementById("guesses")
    charEntropy = shannon(password) 
    strEntropy  = charEntropy * float password.len # multiply bits per character
                                                   # by password length to find
                                                   # total string entropy

  guesses.innerHTML = if password != "":
      cstring fmt"...can be found within {round(pow(2, strEntropy)).toIntStr()} guesses"
    else:
      cstring "...can be found within 0 guesses"

  guesses.style.color = if strEntropy >= 55.0:
      cstring "green"
    elif strEntropy in 45.0..54.9:
      cstring "yellowgreen"
    elif strEntropy in 20.0..44.9:
      cstring "yellow"
    elif strEntropy in 0.1..19.9:
      cstring "red"
    else:
      cstring "white"

  let
    bitSpan = document.getElementById("bits")

  bitSpan.innerHTML = if password != "" and charEntropy != 0.0:
      cstring fmt"{round(strEntropy, 2)} bits of entropy; {round(charEntropy, 2)} bits per character"
    else:
      cstring "0 bits of entropy; 0 bits per character"

proc toggle(_: Event) {.exportc.} = 
  ## "Show Password" button toggle

  let
    passwordToggle = document.getElementById("password-toggle")
    password       = document.getElementById("password")

    passwordType   = if password.getAttribute("type") == "text": "password"
                     else: "text"

  password.setAttribute("type", cstring passwordType)

  passwordToggle.classList.toggle("fa-eye-slash")
  
