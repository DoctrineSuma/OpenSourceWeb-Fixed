
client
	var/manual_focus = 0
	proc
		KeyDown(KeyCode,shift)
		KeyUp(KeyCode,shift)
KeyState
	var/key_repeat = 0
	var/open = 1
	proc
		open()
			open = 1
			if(client)client.KeyFocus()
		close()
			open = 0
			if(client)client<<browse(null,null)
/*
KeyState library
Created by Loduwijk
June 2005
*/

KeyState
	var
		client/client
		shift = 0
		list/key[255]
		mouse_x=0;mouse_y=0
	New(client/C)
		if(C)client=C
		var/index
		for(index = 1 to 255)
			key[index]=0
	proc
		Update(event,KeyCode)
			var/T=KeyCode
			KeyCode=text2num(KeyCode)
			switch(event)
				if("KeyUp")
					if(key[KeyCode])
						key[KeyCode]=0
						switch(KeyCode)
							if(16)shift&=~1
							if(17)shift&=~2
							if(18)shift&=~4
						if(client)client.KeyUp(KeyCode,shift)
				if("KeyDown")
					if(!key[KeyCode])
						key[KeyCode]=1
						switch(KeyCode)
							if(16)shift|=1
							if(17)shift|=2
							if(18)shift|=4
						if(client)client.KeyDown(KeyCode,shift)
					else if(key_repeat&&client)client.KeyDown(KeyCode)
				if("MouseCoordinate")
					mouse_x=copytext(T,1,findtext(T,","))
					mouse_y=copytext(T,findtext(T,",")+1,0)

client
	var
		KeyState/keystate
		resolution
		avail_resolution
		system_type
		color_quality
	Topic(href,href_list[])
		if("action" in href_list)
			if(href_list["action"]=="KeyState")
				var/event = href_list[2]
				keystate.Update(event,href_list[event])
			if(href_list["action"]=="infosetup")
				resolution=href_list["resolution"]
				avail_resolution=href_list["availresolution"]
				color_quality=href_list["color"]
				system_type=href_list["os"]
		return ..()
	verb/manual_focus()
		set hidden = 1
		if(!keystate)return
		if(manual_focus&&keystate.open)
			KeyFocus()
	proc
		//info return functions
		resolution()return resolution
		avail_resolution()return avail_resolution
		system_type()return system_type
		color_quality()return color_quality
		//action functions
		key_repeat(repeat)keystate.key_repeat=repeat
		KeySetup(focus=1)
			keystate=new(src)
			if(focus)KeyFocus()
		InfoSetup()
			src<<browse({"
<html>
<head>
</head>
<body>
<script type="text/javascript">
resolution=screen.width+","+screen.height
avail_res=screen.availWidth+","+screen.availHeight
avail_y=screen.availHeight
color=screen.colorDepth
os=navigator.platform
window.location="?action=infosetup&resolution="+resolution+"&availresolution="+avail_res+"&color="+color+"&os="+os
</script>
</body>
</html>
"},"window=infosetup;size=0x0;can_resize=0;titlebar=0")
		MouseUpdate()
			src<<browse({"
<html>
<head>
<script type="text/javascript">
function coordinate(event)
{
window.location="?action=KeyState&MouseCoordinate="+event.screenX+","+event.screenY
}
</script>
</head>
<body onload="coordinate(event)">
</body>
</html>
"},"window=coordinate;size=0x0;can_resize=0;titlebar=0")

		KeyFocus()
			var/key_repeat_code
			if(keystate.key_repeat)
				key_repeat_code = {"
<html>
<head>
<script type="text/javascript">
function KeyUp(event)
{
	window.location="?action=KeyState&KeyUp="+event.keyCode
}
function KeyDown(event)
{
	window.location="?action=KeyState&KeyDown="+event.keyCode
}
</script>
</head>
<body onkeydown="KeyDown(event)" onkeyup="KeyUp(event)">
<script type="text/javascript">
this.focus()
</script>
</body></html>"}
			else
				key_repeat_code = {"
<html>
<head>
<script type="text/javascript">
function KeyUp(event)
{
	window.location="?action=KeyState&KeyUp="+event.keyCode
	down\[event.keyCode]=0
}
function KeyDown(event)
{
if(down\[event.keyCode]==0)
{
	down\[event.keyCode]=1
	window.location="?action=KeyState&KeyDown="+event.keyCode
}
}
</script>
</head>
<body onkeydown="KeyDown(event)" onkeyup="KeyUp(event)">
<script type="text/javascript">
down = new Array(255);
for(index=0; index<255; index+=1)
{
	down\[index]=0;
}
this.focus()
</script>
</body></html>"}
			src<<browse(key_repeat_code,"window=KeyEvent;size=0x0;can_resize=0;titlebar=0")

var/list/opposite_dirs = list(SOUTH,NORTH,null,WEST,null,null,null,EAST)

/client
	var/tmp
		mloop = 0
		move_dir = 0 //keep track of the direction the player is currently trying to move in.
		true_dir = 0
		keypresses = 0
		CAN_MOVE_DIAGONALLY = 0

	//rebind your interface so that your north/south/east/west keypresses are bound to:
	//keydown: MoveKey [Direction] 1
	//keyup: MoveKey [Direction] 0
	//Directions:
	//NORTH = 1
	//SOUTH = 2
	//EAST = 4
	//WEST = 8

/client/verb/MoveKey(Dir as num,State as num)
	set hidden = 1
	set instant = 1
	//if we are currently not moving at the start of this function call, set a flag for later
	if(!move_dir)
		. = 1
	//get the opposite direction
	var/opposite = opposite_dirs[Dir]
	if(State)
		//turn on the bitflags
		move_dir |= Dir
		keypresses |= Dir
		//make sure that conflicting directions result in the newest one being dominant.
		if(opposite&keypresses)
			move_dir &= ~opposite

	else
		//turn off the bitflags
		move_dir &= ~Dir
		keypresses &= ~Dir

		//restore non-dominant directional keypress
		if(opposite&keypresses)
			move_dir |= opposite

		else
			move_dir |= keypresses

	if(CAN_MOVE_DIAGONALLY)
		true_dir = move_dir
	else
		true_dir = move_dir^(move_dir&move_dir-1)

	//if earlier flag was set, and we now are going to be moving
	if(.&&true_dir)
		move_loop()

/client/North()
/client/South()
/client/East()
/client/West()

/client/proc/move_loop()
	set waitfor = 0
	if(src.mloop) return
	mloop = 1
	src.Move(mob.loc,true_dir)
	while(src.true_dir)
		sleep(world.tick_lag)
		if(src.true_dir)
			src.Move(mob.loc,true_dir)
	mloop = 0