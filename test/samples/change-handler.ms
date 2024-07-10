mypot1 = teapot() --create a teapot
fn whendeleted = --define a callback function
(
local deletedobjects = callbacks.notificationParam()
format "Callback: %\n" deletedobjects
-- This will printevery object that was deleted.
-- By this point, the object isstillattached to it's parents
-- and is still in groups etc...
-- Nothing has been done to the nodeyet.
)
when mypot1 deleted id:#foo obj do --define a when construct
(
format "When Construct:%\n" obj
)
--unregisterany preDeletecallbacks
callbacks.removeScripts #selectedNodesPreDelete
--register the function as general callback
callbacks.addscript #selectedNodesPreDelete "whendeleted()"

b1 = box()
b2 = box()
b3 = box()
when transform $box001 changes do
$box002.pos = $box001.pos + delta
max select all
when names selection change obj do update_name_table obj
when #($box001, $box002, $box003) deleted obj do
(
messageBox "Warning!"
deleteItem obj_table (findItem obj_table obj)
)
when select $ changes obj do update_modifier_list obj