local modem = peripheral.find("modem") or error("No modem attached", 0)
modem.open(0)
serviceregistry = {}
while 1 do
    sleep(0.00001)
    local event, side, channel, replyChannel, message, distance, service
    repeat
        event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    until channel ~= nil
    if message == "wts" then
        modem.transmit(channel, replyChannel, "ws")
        repeat
            event, side, channel, replyChannel, service, distance = os.pullEvent("modem_message")
        until channel == channel
        if not serviceregistry[service] then
            modem.transmit(channel, replyChannel, "service does not exist")
        end
        if serviceregistry[service] then
            modem.transmit(channel, replyChannel, "whtose")
            repeat
                event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
            until channel == channel
            modem.transmit(service, replyChannel, message)
        end
    end
    if message == "amtsr" then
        modem.transmit(channel, replyChannel, "wr")
        repeat
            event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
        until channel == channel
        serviceregistry[message] = channel
        print("added to serviceregistry: " .. message .. ":" .. channel)
    end
end
