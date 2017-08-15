isZero = false

function showtime ()
local time = getRealTime()
local minutes = time.minute

	if minutes == 0 then
		isZero = true
	else
		isZero = false
	end
end
setTimer(showtime, 1000,0)
addEventHandler ( "onResourceStart", getRootElement(), showtime )

addEventHandler ( "onResourceStart", getRootElement(), function() 
setTimer(
function() 
	for _,thePlayer in ipairs(getElementsByType ( "player" )) do
		setElementData(thePlayer, "onlineSpent", getElementData(thePlayer,"onlineSpent") + 1)
	end
end, 60 * 1000,0)
end)

function giveDogtags()
local multiplier = if getPlayerCount() > 15 then 2 else 1 end
	if isZero then
		for _,thePlayer in ipairs(getElementsByType ( "player" )) do
		local playerAccount = getPlayerAccount(thePlayer)
			if getElementData ( thePlayer, "onlineSpent" ) >= 60 then
			   setElementData (thePlayer, "Жетон" ,getElementData(thePlayer ,"Жетон") + multiplier)
			   setAccountData ( playerAccount, "onlineSpent", 0 )
			   setElementData ( thePlayer, "onlineSpent", 0 )

			end
		end
	end
end
setTimer(giveDogtags, 1000,0)
addEventHandler ( "onResourceStart", getRootElement(), giveDogtags )

addEventHandler ( "onPlayerQuit", getRootElement(), function()
local playerAccount = getPlayerAccount(source)
	setAccountData ( playerAccount, "onlineSpent", getAccountData(playerAccount, "onlineSpent") + getElementData (source, "onlineSpent"))
end)

addEventHandler ( "onPlayerLogin", getRootElement(), function()
local playerAccount = getPlayerAccount(source)
if getAccountData(playerAccount,"onlineSpent") == false  then
	setAccountData ( playerAccount, "onlineSpent", 0 )
	setElementData ( source, "onlineSpent", 0 )
end
	setElementData ( source, "onlineSpent", getAccountData( playerAccount, "onlineSpent") or 0 )
end)

