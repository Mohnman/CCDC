args ={...}
local service = table.concat(args," ")
local modem = peripheral.find("modem") or error("No modem attached", 0)
modem.open(43)

modem.transmit(0, 0, "wts")
local event, side, channel, replyChannel, message, distance
repeat
  event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
until channel == 0
if message == "ws" then
    modem.transmit(0, 0, service)
end
repeat
  event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
until channel == 0
if message == "service does not exist" then
    print(message)
    return
end
if message == "whtose" then
     modem.transmit(0, 0,table.concat(table.remove(args,1)," "))
end


