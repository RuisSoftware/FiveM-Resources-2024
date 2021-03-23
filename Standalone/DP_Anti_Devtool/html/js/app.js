var element = new Image;
element.__defineGetter__("id", function() {
    fetch("https://DP_Anti_Devtool/devtoolOpening", {
        method: "post"
    })
});
console.log(element);
