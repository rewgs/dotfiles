// mod keys
const HYPER = ["command", "control"];
const OHYPER = ["command", "option", "control"];
const SHYPER = ["command", "control", "shift"];
const SOHYPER = ["command", "option", "control", "shift"];

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

// const focusWest = Key.on("h", HYPER, () => {
//     const window = Window.focused();
//     if (window !== undefined) {
//         window.focusClosestNeighbor("west");
//     }
//     return;
// });

// const focusSouth = Key.on("j", HYPER, () => {
//     const window = Window.focused();
//     if (window !== undefined) {
//         window.focusClosestNeighbor("south");
//     }
//     return;
// });

// const focusNorth = Key.on("k", HYPER, () => {
//     const window = Window.focused();
//     if (window !== undefined) {
//         window.focusClosestNeighbor("north");
//     }
//     return;
// });

// const focusEast = Key.on("l", HYPER, () => {
//     const window = Window.focused();
//     if (window !== undefined) {
//         window.focusClosestNeighbor("east");
//     }
//     return;
// });

//--------------------------------------
// window tiling
//--------------------------------------

const maximize = Key.on("k", HYPER, () => {
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

// TODO: update
//
// const upperLeftQuarter = Key.on(",", HYPER, () => {
//   const window = Window.focused();
//   const screenFrame = window.screen().flippedVisibleFrame();
//   window.setFrame({
//     x: screenFrame.x,
//     y: screenFrame.y,
//     width: screenFrame.width / 2,
//     height: screenFrame.height / 2,
//   });
// });

// TODO: update
//
// const upperRightQuarter = Key.on(".", HYPER, () => {
//   const window = Window.focused();
//   const screenFrame = window.screen().flippedVisibleFrame();
//   window.setFrame({
//     x: screenFrame.x + screenFrame.width / 2,
//     y: screenFrame.y,
//     width: screenFrame.width / 2,
//     height: screenFrame.height / 2,
//   });
// });

// TODO: update
//
// const lowerLeftQuarter = Key.on(",", SHYPER, () => {
//   const window = Window.focused();
//   const screenFrame = window.screen().flippedVisibleFrame();
//   window.setFrame({
//     x: screenFrame.x,
//     y: screenFrame.y + screenFrame.height / 2,
//     width: screenFrame.width / 2,
//     height: screenFrame.height / 2,
//   });
// });

// TODO: update
//
// const lowerRightQuarter = Key.on(".", SHYPER, () => {
//   const window = Window.focused();
//   const screenFrame = window.screen().flippedVisibleFrame();
//   window.setFrame({
//     x: screenFrame.x + screenFrame.width / 2,
//     y: screenFrame.y + screenFrame.height / 2,
//     width: screenFrame.width / 2,
//     height: screenFrame.height / 2,
//   });
// });

// 1/5

// TODO: update
//
// const firstFifth = Key.on("1", OHYPER, () => {
//   const window = Window.focused();
//   const screenFrame = window.screen().flippedVisibleFrame();
//   window.setFrame({
//     x: screenFrame.x,
//     y: screenFrame.y,
//     width: screenFrame.width / 5,
//     height: screenFrame.height,
//   });
// });

// TODO: update
//
// const secondFifth = Key.on("2", OHYPER, () => {
//   const window = Window.focused();
//   const screenFrame = window.screen().flippedVisibleFrame();
//   window.setFrame({
//     x: screenFrame.x + screenFrame.width / 5,
//     y: screenFrame.y,
//     width: screenFrame.width / 5,
//     height: screenFrame.height,
//   });
// });

// TODO: update
//
// const thirdFifth = Key.on("3", OHYPER, () => {
//   const window = Window.focused();
//   const screenFrame = window.screen().flippedVisibleFrame();
//   window.setFrame({
//     x: screenFrame.x + (screenFrame.width / 5) * 2,
//     y: screenFrame.y,
//     width: screenFrame.width / 5,
//     height: screenFrame.height,
//   });
// });

// TODO: update
//
// const fourthFifth = Key.on("4", OHYPER, () => {
//   const window = Window.focused();
//   const screenFrame = window.screen().flippedVisibleFrame();
//   window.setFrame({
//     x: screenFrame.x + (screenFrame.width / 5) * 3,
//     y: screenFrame.y,
//     width: screenFrame.width / 5,
//     height: screenFrame.height,
//   });
// });

// TODO: update
//
// const fifthFifth = Key.on("5", OHYPER, () => {
//   const window = Window.focused();
//   const screenFrame = window.screen().flippedVisibleFrame();
//   window.setFrame({
//     x: screenFrame.x + (screenFrame.width / 5) * 4,
//     y: screenFrame.y,
//     width: screenFrame.width / 5,
//     height: screenFrame.height,
//   });
// });

// 2/5

// TODO: update
//
// const leftTwoFifths = Key.on("[", OHYPER, () => {
//   const window = Window.focused();
//   const screenFrame = window.screen().flippedVisibleFrame();
//   window.setFrame({
//     x: screenFrame.x,
//     y: screenFrame.y,
//     width: (screenFrame.width / 5) * 2,
//     height: screenFrame.height,
//   });
// });

// TODO: update
//
// const rightTwoFifths = Key.on("]", OHYPER, () => {
//   const window = Window.focused();
//   const screenFrame = window.screen().flippedVisibleFrame();
//   window.setFrame({
//     x: screenFrame.x + (screenFrame.width / 5) * 3,
//     y: screenFrame.y,
//     width: (screenFrame.width / 5) * 2,
//     height: screenFrame.height,
//   });
// });

// 3/5

// TODO: update
//
// const leftThreeFifths = Key.on("[", SOHYPER, () => {
//   const window = Window.focused();
//   const screenFrame = window.screen().flippedVisibleFrame();
//   window.setFrame({
//     x: screenFrame.x,
//     y: screenFrame.y,
//     width: (screenFrame.width / 5) * 3,
//     height: screenFrame.height,
//   });
// });

// TODO: update
//
// const middleThreeFifths = Key.on("\\", SOHYPER, () => {
//   const window = Window.focused();
//   const screenFrame = window.screen().flippedVisibleFrame();
//   window.setFrame({
//     x: screenFrame.x + screenFrame.width / 5,
//     y: screenFrame.y,
//     width: (screenFrame.width / 5) * 3,
//     height: screenFrame.height,
//   });
// });

// TODO: update
//
// const rightThreeFifths = Key.on("]", SOHYPER, () => {
//   const window = Window.focused();
//   const screenFrame = window.screen().flippedVisibleFrame();
//   window.setFrame({
//     x: screenFrame.x + (screenFrame.width / 5) * 2,
//     y: screenFrame.y,
//     width: (screenFrame.width / 5) * 3,
//     height: screenFrame.height,
//   });
// });

// TODO: update
//
// const leftFourFifths = Key.on("-", SOHYPER, () => {
//   const window = Window.focused();
//   const screenFrame = window.screen().flippedVisibleFrame();
//   window.setFrame({
//     x: screenFrame.x,
//     y: screenFrame.y,
//     width: (screenFrame.width / 5) * 4,
//     height: screenFrame.height,
//   });
// });

// TODO: update
//
// const rightFourFifths = Key.on("=", SOHYPER, () => {
//   const window = Window.focused();
//   const screenFrame = window.screen().flippedVisibleFrame();
//   window.setFrame({
//     x: screenFrame.x + screenFrame.width / 5,
//     y: screenFrame.y,
//     width: (screenFrame.width / 5) * 4,
//     height: screenFrame.height,
//   });
// });

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

// FIXME:
// const moveWindowToNextSpace = Key.on("=", HYPER, () => {
//   const space = Space.active();
//   const window = Window.focused();
//   space.next().moveWindows([window]);
//   window.focus();
// });

// FIXME:
// const moveWindowToPrevSpace = Key.on("-", HYPER, () => {
//   const space = Space.active();
//   const window = Window.focused();
//   space.next().moveWindows([window]);
//   window.focus();
// });

// TODO:
// const missionControl = Key.on("up", HYPER, () => {
// })
