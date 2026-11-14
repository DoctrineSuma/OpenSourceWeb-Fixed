
/datum/stack
	var/list/stack
	var/max_elements = 0

/datum/stack/New(list/elements, max)
	..()
	stack = elements ? elements.Copy() : list()
	if(max)
		max_elements = max

/datum/stack/Destroy()
	Clear()
	. = ..()

/datum/stack/proc/Pop()
	if(is_empty())
		return null
	. = stack[stack.len]
	stack.Cut(stack.len,0)

/datum/stack/proc/Push(element)
	if(max_elements && (stack.len+1 > max_elements))
		return null
	stack += element

/datum/stack/proc/Top()
	if(is_empty())
		return null
	. = stack[stack.len]

/datum/stack/proc/Remove(element)
	stack -= element

/datum/stack/proc/is_empty()
	. = stack.len ? 0 : 1

//Rotate entire stack left with the leftmost looping around to the right

//Rotate entire stack to the right with the rightmost looping around to the left

/datum/stack/proc/Copy()
	var/datum/stack/S=new()
	S.stack = stack.Copy()
	S.max_elements = max_elements
	return S

/datum/stack/proc/Clear()
	stack.Cut()
