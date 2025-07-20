/*  Copyright (C) 2020 Patrick Csikos (https://zelikos.github.io)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 * Authored by Patrick Csikos <zelikos@pm.me>
 */

public class Rollit.NumDisplay : Gtk.Box {

    private Gtk.Label roll_result;
    private Gtk.Stack stack;

    construct {

        orientation = Gtk.Orientation.VERTICAL;
        spacing = 0;

        stack = new Gtk.Stack () {
            transition_type = Gtk.StackTransitionType.SLIDE_UP,
            transition_duration = 200,
        };

        hexpand = true;
        vexpand = true;
        valign = Gtk.Align.CENTER;

        roll_result = new Gtk.Label (null);
        roll_result.add_css_class ("result-label");

        var welcome = new Gtk.Label (null);
        welcome.label = _("Ready to Roll");
        welcome.add_css_class (Granite.STYLE_CLASS_H2_LABEL);

        var blank = new Gtk.Label (null);

        stack.add_named (welcome, "welcome");
        stack.add_named (roll_result, "roll-result");
        stack.add_named (blank, "blank");
        stack.visible_child_name = "welcome";

        append (stack);
    }

    public int num_gen (int max_num) {
        const int MIN_NUM = 1;
        int rnd_num;

        stack.visible_child_name = "blank";

        // max_num + 1 so that max num is included in roll
        rnd_num = Random.int_range (MIN_NUM, (max_num + 1));
        roll_result.label = rnd_num.to_string ();

        stack.visible_child_name = "roll-result";

        return rnd_num;
    }
}
