/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2020-2021 Patrick Csikos (https://zelikos.github.io)
 *                          2025 Stella & Charlie (teamcons.carrd.co)
 *                          2025 Contributions from the ellie_Commons community (github.com/ellie-commons/)
 */

public class Rollit.RollHistory : Gtk.Box {

    private GLib.List<PreviousRoll> previous_rolls_list;
    private Gtk.ScrolledWindow scroll_box;
    private Gtk.ListBox previous_rolls_box;
    private Gtk.Button clear_button;

    construct {

        orientation = Gtk.Orientation.VERTICAL;
        spacing = 0;
        vexpand = true;

        previous_rolls_box = new Gtk.ListBox () {
            activate_on_single_click = true,
            visible = true
        };

        scroll_box = new Gtk.ScrolledWindow () {
            hscrollbar_policy = NEVER,
            propagate_natural_height = true,
            hexpand = true,
            vexpand = true
        };
        scroll_box.child = previous_rolls_box;

        var clear_text = new Gtk.Label (_("Clear"));
        var clear_icon = new Gtk.Image.from_icon_name ("edit-clear-all-symbolic");

        var bottom_row = new Gtk.Box (HORIZONTAL, 6) {
            margin_top = margin_bottom = 6,
            valign = Gtk.Align.END
        };
        bottom_row.append (clear_text);
        bottom_row.append (clear_icon);

        clear_button = new Gtk.Button () {
            tooltip_markup = Granite.markup_accel_tooltip ({"<Ctrl>L", "L"}, _("Clear history")),
            sensitive = false
        };
        clear_button.add_css_class (Granite.STYLE_CLASS_FLAT);
        clear_button.child = bottom_row;

        append (scroll_box);
        append (clear_button);

        clear_button.clicked.connect (clear_rolls);

        show ();
    }

    public void clear_rolls () {
        previous_rolls_box.remove_all ();

        foreach (PreviousRoll item in previous_rolls_list) {
            previous_rolls_list.remove (item);
            item.destroy ();
        }

        clear_button.sensitive = false;
    }

    public void add_roll (int roll, int maxroll) {
        var new_roll = new Rollit.PreviousRoll (roll, maxroll);

        previous_rolls_list.append (new_roll);
        previous_rolls_box.prepend (new_roll);
        previous_rolls_box.show ();

        if (clear_button.sensitive == false) {
            clear_button.sensitive = true;
        }
    }
}
