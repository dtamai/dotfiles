# Awesome files

These configuration files depends on https://github.com/copycat-killer/awesome-copycats.

After installing _awesome-copycats_ themes, create a **curent** folder in the _themes_ directory and a link to _theme.lua_ inside that folder, also create a link to **icons** from the relevant theme and a link **wall** pointing to some wallpaper.

## Problems

For some reason the audio control doesn't work very well. To fix that, make the
following change in the Lain code:

```lua
-- lain/widgets/alsa.lua

...

function alsa.update()
--    local f = assert(io.popen(string.format("amixer -c %s -M get %s", alsa.card, alsa.channel)))

    local f = assert(io.popen(string.format("amixer -D %s -M get %s", "pulse", alsa.channel)))
...
```
