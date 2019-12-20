var type = "normal";
var disabled = false;

window.addEventListener("message", function (event) {
    if (event.data.action == "display") {
        type = event.data.type
        disabled = false;

  if (type === "normal") {
            $(".info-div").hide();
        } else if (type === "trunk") {
            $(".info-div").show();
        } else if (type === "property") {
            $(".info-div").hide();
        } else if (type === "glovebox") {
            $(".info-div").show();
        } else if (type === "player") {
            $(".info-div").show();
        }

        $(".ui").fadeIn();
    } else if (event.data.action == "hide") {
        $("#dialog").dialog("close");
        $(".ui").fadeOut();
        $(".item").remove();
        $("#otherInventory").html("<div id=\"noSecondInventoryMessage\"></div>");
        $("#noSecondInventoryMessage").html(invLocale.secondInventoryNotAvailable);
    } else if (event.data.action == "setItems") {
        inventorySetup(event.data.itemList);

        $('.item').draggable({
            helper: 'clone',
            appendTo: 'body',
            zIndex: 99999,
            revert: 'invalid',
            start: function (event, ui) {
                if (disabled) {
                    return false;
                }

                $(this).css('background-image', 'none');
                itemData = $(this).data("item");

                if (!itemData.canRemove) {
                    $("#drop").addClass("disabled");
                    $("#give").addClass("disabled");
                }

                if (!itemData.usable) {
                    $("#use").addClass("disabled");
                }
            },
            stop: function () {
                itemData = $(this).data("item");

                if (itemData !== undefined && itemData.name !== undefined) {
                    $(this).css('background-image', 'url(\'img/items/' + itemData.name + '.png\'');
                    $("#drop").removeClass("disabled");
                    $("#use").removeClass("disabled");
                    $("#give").removeClass("disabled");
                }
            }
        });
    } else if (event.data.action == "setSecondInventoryItems") {
        secondInventorySetup(event.data.itemList);
    } else if (event.data.action == "setInfoText") {
        $(".info-div").html(event.data.text);
    } else if (event.data.action == "nearPlayers") {
        $("#nearPlayers").html("");

        $.each(event.data.players, function (index, player) {
            $("#nearPlayers").append('<button class="nearbyPlayerButton" data-player="' + player.player + '">' + player.label + ' (' + player.player + ')</button>');
        });

        $("#dialog").dialog("open");

        $(".nearbyPlayerButton").click(function () {
            $("#dialog").dialog("close");
            player = $(this).data("player");
            $.post("http://esx_inventoryhud/GiveItem", JSON.stringify({
                player: player,
                item: event.data.item,
                number: parseInt($("#count").val())
            }));
        });
    }
});

function closeInventory() {
    $.post("http://esx_inventoryhud/NUIFocusOff", JSON.stringify({}));
}

function inventorySetup(items) {
    $("#playerInventory").html("");
    $.each(items, function (index, item) {
        count = setCount(item);

        $("#playerInventory").append('<div class="slot"><div id="item-' + index + '" class="item" style = "background-image: url(\'img/items/' + item.name + '.png\')">' +
            '<div class="item-count">' + count + '</div> <div class="item-name">' + item.label + '</div> </div ><div class="item-name-bg"></div></div>');
        $('#item-' + index).data('item', item);
        $('#item-' + index).data('inventory', "main");
    });
}

function secondInventorySetup(items) {
    $("#otherInventory").html("");
    $.each(items, function (index, item) {
        count = setCount(item);

        $("#otherInventory").append('<div class="slot"><div id="itemOther-' + index + '" class="item" style = "background-image: url(\'img/items/' + item.name + '.png\')">' +
            '<div class="item-count">' + count + '</div> <div class="item-name">' + item.label + '</div> </div ><div class="item-name-bg"></div></div>');
        $('#itemOther-' + index).data('item', item);
        $('#itemOther-' + index).data('inventory', "second");
    });
}

function disableInventory(ms) {
    disabled = true;

    setInterval(function () {
        disabled = false;
    }, ms);
}

function setCount(item) {
    count = item.count

    if (item.limit > 0) {
        count = item.count + " / " + item.limit
    }

    if (item.type === "item_weapon") {
        if (count == 0) {
            count = "";
        } else {
            count = '<img src="img/bullet.png" class="ammoIcon"> ' + item.count;
        }
    }

    if (item.type === "item_account" || item.type === "item_money") {
        count = formatMoney(item.count);
    }

    return count;
}

function formatMoney(n, c, d, t) {
    var c = isNaN(c = Math.abs(c)) ? 2 : c,
        d = d == undefined ? "." : d,
        t = t == undefined ? "," : t,
        s = n < 0 ? "-" : "",
        i = String(parseInt(n = Math.abs(Number(n) || 0).toFixed(c))),
        j = (j = i.length) > 3 ? j % 3 : 0;

    return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t);
};

$(document).ready(function () {
    $("#count").focus(function () {
        $(this).val("")
    }).blur(function () {
        if ($(this).val() == "") {
            $(this).val("1")
        }
    });

    $("body").on("keyup", function (key) {
        if (Config.closeKeys.includes(key.which)) {
            closeInventory();
        }
    });

    $('#use').droppable({
        hoverClass: 'hoverControl',
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            if (itemData.usable) {
                $.post("http://esx_inventoryhud/UseItem", JSON.stringify({
                    item: itemData
                }));
            }
        }
    });

    $('#give').droppable({
        hoverClass: 'hoverControl',
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            if (itemData.canRemove) {
                $.post("http://esx_inventoryhud/GetNearPlayers", JSON.stringify({
                    item: itemData
                }));
            }
        }
    });

    $('#drop').droppable({
        hoverClass: 'hoverControl',
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            if (itemData.canRemove) {
                $.post("http://esx_inventoryhud/DropItem", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            }
        }
    });

$('#playerInventory').droppable({
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "trunk" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://esx_inventoryhud/TakeFromTrunk", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "property" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://esx_inventoryhud/TakeFromProperty", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "glovebox" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://esx_inventoryhud/TakeFromGlovebox", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "player" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://esx_inventoryhud/TakeFromPlayer", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            }
        }
    });

    $('#otherInventory').droppable({
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");
 if (type === "trunk" && itemInventory === "main") {
            disableInventory(500);
            $.post("http://esx_inventoryhud/PutIntoTrunk", JSON.stringify({
                item: itemData,
                number: parseInt($("#count").val())
            }));
        } else if (type === "property" && itemInventory === "main") {
            disableInventory(500);
            $.post("http://esx_inventoryhud/PutIntoProperty", JSON.stringify({
                item: itemData,
                number: parseInt($("#count").val())
            }));
        } else if (type === "glovebox" && itemInventory === "main") {
            disableInventory(500);
            $.post("http://esx_inventoryhud/PutIntoGlovebox", JSON.stringify({
                item: itemData,
                number: parseInt($("#count").val())
            }));
        } else if (type === "player" && itemInventory === "main") {
            disableInventory(500);
            $.post("http://esx_inventoryhud/PutIntoPlayer", JSON.stringify({
                item: itemData,
                number: parseInt($("#count").val())
            }));
        }
    }
});

    $("#count").on("keypress keyup blur", function (event) {
        $(this).val($(this).val().replace(/[^\d].+/, ""));
        if ((event.which < 48 || event.which > 57)) {
            event.preventDefault();
        }
    });
});

$.widget('ui.dialog', $.ui.dialog, {
    options: {
        // Determine if clicking outside the dialog shall close it
        clickOutside: false,
        // Element (id or class) that triggers the dialog opening 
        clickOutsideTrigger: ''
    },
    open: function () {
        var clickOutsideTriggerEl = $(this.options.clickOutsideTrigger),
            that = this;
        if (this.options.clickOutside) {
            // Add document wide click handler for the current dialog namespace
            $(document).on('click.ui.dialogClickOutside' + that.eventNamespace, function (event) {
                var $target = $(event.target);
                if ($target.closest($(clickOutsideTriggerEl)).length === 0 &&
                    $target.closest($(that.uiDialog)).length === 0) {
                    that.close();
                }
            });
        }
        // Invoke parent open method
        this._super();
    },
    close: function () {
        // Remove document wide click handler for the current dialog
        $(document).off('click.ui.dialogClickOutside' + this.eventNamespace);
        // Invoke parent close method 
        this._super();
    },
});