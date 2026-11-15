// tmux-style prefix: ctrl-space opens this popup, the next key runs its
// action. Esc or any unbound key closes it.

import { View, div } from "gpui-kit";
import { v_flex, h_flex } from "gpui-base";
import { run, hc, props, focused, openOverlay, closeOverlay, nextCommand, theme } from "herdr";

// Matched against the event's keystroke, else the character it types.
// `keys` lets one row cover several keys; the pressed key is passed to `act`.
const BINDINGS = [
  { key: "|", label: "Split right", act: () => run("pane.split", { direction: "right" }) },
  { key: "_", label: "Split down", act: () => run("pane.split", { direction: "down" }) },
  { key: "x", label: "Close pane", act: (_t, _k, pane) => pane && confirm("Close pane?", "pane.close", { pane }) },
  { key: "c", label: "New tab", act: () => run("tab.new", {}) },
  { key: "b", label: "Toggle sidebar", act: () => run("layout.toggle", { id: "sidebar" }) },
  { key: "s", label: "Go to space", act: () => run("mod.open", { name: "picker" }) },
  { key: "ctrl-f", label: "Go to space", act: () => run("mod.open", { name: "picker" }) },
  { key: "ctrl-n", label: "New space", act: () => openOverlay({ mod: "prompt", kind: "dialog", width: 360, props: { title: "New space", command: { name: "space.new" } } }) },
  { key: "ctrl-space", label: "Send ctrl-space", act: (terminal) => terminal && hc(["keys", terminal, "ctrl+space"]) },
];

// Opens the shipped confirm dialog: Enter runs the command, Esc cancels.
const confirm = (title, name, args) =>
  openOverlay({ mod: "confirm", kind: "dialog", width: 360, height: 150, props: { title, command: { name, args } } });

const matches = (b, k) => (b.keys ?? [b.key]).includes(k);

export default class Leader extends View {
  init(_props, cx) {
    this.terminal = focused()?.terminal;
    this.pane = focused()?.pane;
    this.handle = cx.focus_handle();
    this.handle.focus();
    // ctrl-space is bound globally to open this popup, so keys.json routes it
    // here as "leader.send" instead of letting it toggle the popup closed.
    cx.spawn(async () => {
      for (;;) if ((await nextCommand()) === "send") this.press("ctrl-space");
    });
  }

  key(e, cx) {
    cx.stop_propagation();
    this.press(e.keystroke, e.key_char);
  }

  press(keystroke, char) {
    closeOverlay(props().overlay);
    const k = BINDINGS.some((b) => matches(b, keystroke)) ? keystroke : char;
    BINDINGS.find((b) => matches(b, k))?.act(this.terminal, k, this.pane);
  }

  render() {
    const t = theme();
    return v_flex()
      .id("leader")
      .track_focus(this.handle)
      .on_key_down((e, cx) => this.key(e, cx))
      .w_full()
      .p(14)
      .gap(6)
      .bg(t.popover)
      .text_size(12.5)
      .children(
        BINDINGS.map((b) =>
          h_flex()
            .gap(10)
            .child(div().w(80).text_color(t.accent).child(b.key))
            .child(div().text_color(t.foreground).child(b.label)),
        ),
      );
  }
}
