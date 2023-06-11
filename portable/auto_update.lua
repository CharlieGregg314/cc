


while true do
  local event, text = os.pullEvent("paste")
  print('"' .. text .. '" was pasted')
  os.execute("pastebin")
end