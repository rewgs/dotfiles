// mod keys
const HYPER = ["command", "control"];
const OHYPER = ["command", "option", "control"];
const SHYPER = ["command", "control", "shift"];
const SOHYPER = ["command", "option", "control", "shift"];

//-----------------------------------------------------------------------------
// META
//-----------------------------------------------------------------------------

Phoenix.set({
  daemon: false,
  openAtLogin: true,
});

// Key.on('r', SOHYPER, () => {
//     Phoenix.reload()
//     Phoenix.notify("Reloaded");
// });

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

const maximized = Key.on("k", HYPER, () => {
  Window.focused().maximize();
});

// halves

const leftHalf = Key.on("h", HYPER, () => {
  const window = Window.focused();
  const screenFrame = window.screen().flippedVisibleFrame();
  window.setFrame({
    x: screenFrame.x,
    y: screenFrame.y,
    width: screenFrame.width / 2,
    height: screenFrame.height,
  });
});

const rightHalf = Key.on("l", HYPER, () => {
  const window = Window.focused();
  const screenFrame = window.screen().flippedVisibleFrame();
  window.setFrame({
    x: screenFrame.x + screenFrame.width / 2,
    y: screenFrame.y,
    width: screenFrame.width / 2,
    height: screenFrame.height,
  });
});

// 1/3

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

// 2/3

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

// quarters

const upperLeftQuarter = Key.on(",", HYPER, () => {
  const window = Window.focused();
  const screenFrame = window.screen().flippedVisibleFrame();
  window.setFrame({
    x: screenFrame.x,
    y: screenFrame.y,
    width: screenFrame.width / 2,
    height: screenFrame.height / 2,
  });
});

const upperRightQuarter = Key.on(".", HYPER, () => {
  const window = Window.focused();
  const screenFrame = window.screen().flippedVisibleFrame();
  window.setFrame({
    x: screenFrame.x + screenFrame.width / 2,
    y: screenFrame.y,
    width: screenFrame.width / 2,
    height: screenFrame.height / 2,
  });
});

const lowerLeftQuarter = Key.on(",", SHYPER, () => {
  const window = Window.focused();
  const screenFrame = window.screen().flippedVisibleFrame();
  window.setFrame({
    x: screenFrame.x,
    y: screenFrame.y + screenFrame.height / 2,
    width: screenFrame.width / 2,
    height: screenFrame.height / 2,
  });
});

const lowerRightQuarter = Key.on(".", SHYPER, () => {
  const window = Window.focused();
  const screenFrame = window.screen().flippedVisibleFrame();
  window.setFrame({
    x: screenFrame.x + screenFrame.width / 2,
    y: screenFrame.y + screenFrame.height / 2,
    width: screenFrame.width / 2,
    height: screenFrame.height / 2,
  });
});

// 1/5

const firstFifth = Key.on("1", OHYPER, () => {
  const window = Window.focused();
  const screenFrame = window.screen().flippedVisibleFrame();
  window.setFrame({
    x: screenFrame.x,
    y: screenFrame.y,
    width: screenFrame.width / 5,
    height: screenFrame.height,
  });
});

const secondFifth = Key.on("2", OHYPER, () => {
  const window = Window.focused();
  const screenFrame = window.screen().flippedVisibleFrame();
  window.setFrame({
    x: screenFrame.x + screenFrame.width / 5,
    y: screenFrame.y,
    width: screenFrame.width / 5,
    height: screenFrame.height,
  });
});

const thirdFifth = Key.on("3", OHYPER, () => {
  const window = Window.focused();
  const screenFrame = window.screen().flippedVisibleFrame();
  window.setFrame({
    x: screenFrame.x + (screenFrame.width / 5) * 2,
    y: screenFrame.y,
    width: screenFrame.width / 5,
    height: screenFrame.height,
  });
});

const fourthFifth = Key.on("4", OHYPER, () => {
  const window = Window.focused();
  const screenFrame = window.screen().flippedVisibleFrame();
  window.setFrame({
    x: screenFrame.x + (screenFrame.width / 5) * 3,
    y: screenFrame.y,
    width: screenFrame.width / 5,
    height: screenFrame.height,
  });
});

const fifthFifth = Key.on("5", OHYPER, () => {
  const window = Window.focused();
  const screenFrame = window.screen().flippedVisibleFrame();
  window.setFrame({
    x: screenFrame.x + (screenFrame.width / 5) * 4,
    y: screenFrame.y,
    width: screenFrame.width / 5,
    height: screenFrame.height,
  });
});

// 2/5

const leftTwoFifths = Key.on("[", OHYPER, () => {
  const window = Window.focused();
  const screenFrame = window.screen().flippedVisibleFrame();
  window.setFrame({
    x: screenFrame.x,
    y: screenFrame.y,
    width: (screenFrame.width / 5) * 2,
    height: screenFrame.height,
  });
});

const rightTwoFifths = Key.on("]", OHYPER, () => {
  const window = Window.focused();
  const screenFrame = window.screen().flippedVisibleFrame();
  window.setFrame({
    x: screenFrame.x + (screenFrame.width / 5) * 3,
    y: screenFrame.y,
    width: (screenFrame.width / 5) * 2,
    height: screenFrame.height,
  });
});

// 3/5

const leftThreeFifths = Key.on("[", SOHYPER, () => {
  const window = Window.focused();
  const screenFrame = window.screen().flippedVisibleFrame();
  window.setFrame({
    x: screenFrame.x,
    y: screenFrame.y,
    width: (screenFrame.width / 5) * 3,
    height: screenFrame.height,
  });
});

const middleThreeFifths = Key.on("\\", SOHYPER, () => {
  const window = Window.focused();
  const screenFrame = window.screen().flippedVisibleFrame();
  window.setFrame({
    x: screenFrame.x + screenFrame.width / 5,
    y: screenFrame.y,
    width: (screenFrame.width / 5) * 3,
    height: screenFrame.height,
  });
});

const rightThreeFifths = Key.on("]", SOHYPER, () => {
  const window = Window.focused();
  const screenFrame = window.screen().flippedVisibleFrame();
  window.setFrame({
    x: screenFrame.x + (screenFrame.width / 5) * 2,
    y: screenFrame.y,
    width: (screenFrame.width / 5) * 3,
    height: screenFrame.height,
  });
});

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

const moveWindowToNextSpace = Key.on("=", HYPER, () => {
  const space = Space.active();
  const window = Window.focused();
  space.next().moveWindows([window]);
  window.focus();
});

const moveWindowToPrevSpace = Key.on("-", HYPER, () => {
  const space = Space.active();
  const window = Window.focused();
  space.next().moveWindows([window]);
  window.focus();
});

// const missionControl = Key.on("up", HYPER, () => {
// })
