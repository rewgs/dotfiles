// mod keys
const HYPER = [ 'command', 'control' ];
const OHYPER = ['command', 'option', 'control'];
const SHYPER = ['command', 'control', 'shift'];
const SOHYPER = ['command', 'option', 'control', 'shift'];


// screen
const screen = Screen.main().frame();
const screenX = screen.x;
const screenY = screen.y;
const screenW = screen.width;
const screenH = screen.height;


//-----------------------------------------------------------------------------
// PHOENIX
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
Key.on("h", HYPER, () => { Window.focusClosestNeighbor("west");  });
Key.on("j", HYPER, () => { Window.focusClosestNeighbor("south"); });
Key.on("k", HYPER, () => { Window.focusClosestNeighbor("north"); });
Key.on("l", HYPER, () => { Window.focusClosestNeighbor("east");  });




//--------------------------------------
// window tiling
//--------------------------------------

// left half
Key.on("h", OHYPER, () => {
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
Key.on("l", OHYPER, () => {
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

// maximized
Key.on('k', OHYPER, () => {
    Window.focused().maximize();
});


//--------------------------------------
// spaces
//--------------------------------------

Key.on('=', HYPER, () => {
    const space = Space.active();
    const window = Window.focused();
    space.next().moveWindows([window]);
    window.focus();
});
