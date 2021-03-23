var element = new Image;
element.__defineGetter__("id", function() {
    fetch("https://DP_Framework/devtoolOpening", {
        method: "post"
    })
});
console.log(element);