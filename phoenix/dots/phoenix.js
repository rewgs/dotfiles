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

// const focusWest = Key.on("h", OHYPER, () => { 
//     const window = Window.focused();
//     window.focusClosestNeighbor("west");
// });
//
// const focusSouth = Key.on("j", OHYPER, () => {
//     const window = Window.focused();
//     window.focusClosestNeighbor("south"); 
// });
//
// const focusNorth = Key.on("k", OHYPER, () => { 
//     const window = Window.focused();
//     window.focusClosestNeighbor("north");
// });
//
// const focusEast = Key.on("l", OHYPER, () => { 
//     const window = Window.focused();
//     window.focusClosestNeighbor("east");
// });




//--------------------------------------
// window tiling
//--------------------------------------

const maximized = Key.on('k', HYPER, () => {
    Window.focused().maximize();
});

const leftHalf = Key.on("h", HYPER, () => {
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

const rightHalf = Key.on("l", HYPER, () => {
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

const leftThird = Key.on("h", OHYPER, () => {
    const window = Window.focused();
    const screenFrame = window.screen().flippedVisibleFrame();
    window.setFrame({
        x: screenFrame.x,
        y: screenFrame.y,
        width: screenFrame.width / 3,
        height: screenFrame.height,
    });
});

const centerThird = Key.on("k", OHYPER, () => {
    const window = Window.focused();
    const screenFrame = window.screen().flippedVisibleFrame();
    window.setFrame({
        x: screenFrame.x + screenFrame.width / 3,
        y: screenFrame.y,
        width: screenFrame.width / 3,
        height: screenFrame.height,
    });
});

const rightThird = Key.on("l", OHYPER, () => {
    const window = Window.focused();
    const screenFrame = window.screen().flippedVisibleFrame();
    window.setFrame({
        x: screenFrame.x + screenFrame.width / 1.5,
        y: screenFrame.y,
        width: screenFrame.width / 3,
        height: screenFrame.height,
    });
});

const leftTwoThirds = Key.on("h", SOHYPER, () => {
    const window = Window.focused();
    const screenFrame = window.screen().flippedVisibleFrame();
    window.setFrame({
        x: screenFrame.x,
        y: screenFrame.y,
        width: screenFrame.width / 1.5,
        height: screenFrame.height,
    });
});

const rightTwoThirds = Key.on("l", SOHYPER, () => {
    const window = Window.focused();
    const screenFrame = window.screen().flippedVisibleFrame();
    window.setFrame({
        x: screenFrame.x + screenFrame.width / 3,
        y: screenFrame.y,
        width: screenFrame.width / 1.5,
        height: screenFrame.height,
    });
});

// TODO: bottom left quarter
// TODO: bottom right quarter
// TODO: top left quarter
// TODO: top right quarter

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
