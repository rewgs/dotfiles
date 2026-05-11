import { hyper } from "./mods";

const maximize = Key.on("k", hyper, () => {
  Window.focused().maximize();
});

export default {
    maximize
}
