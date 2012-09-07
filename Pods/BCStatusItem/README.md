BCStatusItem
===============
BCStatusItem is a view & NSStatusItem category to let you easily expand the functionality of NSStatusItem. 
One issue with NSStatusItem is getting it's location/frame on the screen. You can do this if it has a custom view, 
so one of the features of BCStatusItem is to by default have a custom view that behaves like NSStatusItem does by default.

Current features
----------------
* Adds - [NSStatusItem frame] via custom view's window frame (lets you easily position a window near it)
* Makes it easy to enable drag & drop on the status item

Unfinished
----------------
* Title drawing
* Action/doubleAction support
* Possible convenient way of adding an 'accessory view'
* See issues for more

License
----------------
BSD license, See LICENSE.md 
