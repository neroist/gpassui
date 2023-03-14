import webui

let window = newWindow()
let url = window.newServer("GPass")

if not window.show(url, BrowserEdge):
  window.show(url, BrowserAny)

wait()
