# esx_inventoryhud 2.3.0
Inventory HUD for ESX. You can open and close inventory using F2. Part of code was taken from [es_extended](https://github.com/ESX-Org/es_extended).

## Requirements
* [es_extended](https://github.com/ESX-Org/es_extended)
* [pNotify](https://forum.fivem.net/t/release-pnotify-in-game-js-notifications-using-noty/20659)

## Features
- Drag and drop
- Using items
- Dropping items
- Giving items
- Cash included
- Accounts support (bank, black money, ...)
- Weapons support
- esx_property support
- Another players inventory support
- Fully configurable (check config.lua and html/js/config.js)
- Locale files included (check locales/ and html/locales/ directories)
- Close inventory using client trigger (**esx_inventoryhud:doClose**)

## Addons
* [Vehicle trunk inventory](https://github.com/Nertigel/esx_inventoryhud_trunk/tree/master)

## Screens
* [https://i.imgur.com/YPYowrJ.png](https://i.imgur.com/YPYowrJ.png)
![image](https://i.imgur.com/YPYowrJ.png)

## Commands
* **/openinventory <player_id>** - opens given player inventory (`inventory.openinventory` permission)
* **/closeinv** - force closes inventory if it gets bugged

## Download

### Using Git
```
cd resources
git clone https://github.com/Nertigel/esx_inventoryhud [esx]/esx_inventoryhud
```

### Manually
- Download https://github.com/Nertigel/esx_inventoryhud/archive/master.zip
- Put it in the `[esx]` directory

## Installation
Check [wiki file](https://github.com/Nertigel/esx_inventoryhud/blob/master/WIKI.md)

## Config files
* config.lua
* html/js/config.js
