// mod keys
const HYPER = [ 'command', 'control' ];
const OHYPER = ['command', 'option', 'control'];
const SHYPER = ['command', 'control', 'shift'];
const SOHYPER = ['command', 'option', 'control', 'shift'];


//-----------------------------------------------------------------------------
// META
//-----------------------------------------------------------------------------

Phoenix.set({
  daemon: false,
  openAtLogin: true,
});

Key.on('r', SOHYPER, () => {
    Phoenix.reload()
    Phoenix.notify("Reloaded");
});


//-----------------------------------------------------------------------------
// WINDOW MANAGEMENT
//-----------------------------------------------------------------------------

// BUG: not working!?
Key.on("h", OHYPER, () => { 
    const window = Window.focused();
    window.focusClosestNeighbor("west");
});

Key.on("j", OHYPER, () => {
    const window = Window.focused();
    window.focusClosestNeighbor("south"); 
});
Key.on("k", OHYPER, () => { 
    const window = Window.focused();
    window.focusClosestNeighbor("north");
});
Key.on("l", OHYPER, () => { 
    const window = Window.focused();
    window.focusClosestNeighbor("east");
});




//--------------------------------------
// window tiling
//--------------------------------------

// maximized
Key.on('k', HYPER, () => {
    Window.focused().maximize();
});

// left half
Key.on("h", HYPER, () => {
    // Phoenix.notify("Snapping left half");
    const window = Window.focused(),
    screenFrame = window.screen().flippedVisibleFrame();
    window.setFrame({
        x: screenFrame.x,
        y: screenFrame.y,
        width: screenFrame.width / 2,
        height: screenFrame.height,
    });
});

// right half
Key.on("l", HYPER, () => {
    // Phoenix.notify("Snapping right half");
    const window = Window.focused();
    const screenFrame = window.screen().flippedVisibleFrame();
    window.setFrame({
        x: screenFrame.x + screenFrame.width / 2,
        y: screenFrame.y,
        width: screenFrame.width / 2,
        height: screenFrame.height,
        });
});

// TODO: bottom left quarter
// TODO: bottom right quarter
// TODO: top left quarter
// TODO: top right quarter
// TODO: left one-third
// TODO: left two-thirds
// TODO: right one-third
// TODO: right two-thirds

// Key.on("[", SOHYPER, () => {
//     debug("Center and resize to 2/3 of screen");
//     const window = Window.focused();
//     const screenFrame = window.screen().flippedVisibleFrame();
//     window.setFrame({
//         x: screenFrame.width / 6,
//         y: screenFrame.height / 6,
//         width: (2 * screenFrame.width) / 3,
//         height: (2 * screenFrame.height) / 3,
//     });
// });



//--------------------------------------
// spaces
//--------------------------------------

Key.on('=', HYPER, () => {
    const space = Space.active();
    const window = Window.focused();
    space.next().moveWindows([window]);
    window.focus();
});
