args ={...}
local serviceregistryname = table.concat(args," ")
local modem = peripheral.find("modem") or error("No modem attached", 0)
modem.open(15)

modem.transmit(0, 0, "amtsr")
local event, side, channel, replyChannel, message, distance
repeat
  event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
until channel == 0
if message == "wr" then
  modem.transmit(0, 0, serviceregistryname)
end

repeat
  event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
until channel == 0
print("Received a reply: " .. tostring(message))