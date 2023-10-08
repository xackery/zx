`#zx` commands for eqemu

NOTE: At this time, #zx is still early preview and is incomplete!
If you use this, feel free to let me know in any method you like, and we can see how we can improve it.


## What is this?

#zx is a set of lua alias commands to use on EQEmu servers.

## How do I use it?

- Clone this repository to your lua_modules/commands/ subfolder, so once cloned it'll be lua_modules/commands/zx/
- Go into your lua_modules folder and edit commands.lua, adding a link to the commands like so:
```lua
commands["zx"] = { 50, require(commands_path .. "zx") };
```
- Note the `50`` value. This means nobody under 50 status will see these commands.
- In game, type `#reload quest``
- In game, type `#zx`
- If everything is fine, you should see a #zx menu list.


## What does it look like?

![zx](images/zx.png)

Once you run a command, it tells you the 'true' command:
![wp](images/wp.png)

But of course, you can use the #zx prefixed version as well, arguments are passed to the real command:
![wp-add](images/wp-add.png)