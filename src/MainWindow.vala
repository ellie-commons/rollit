/*  Copyright (C) 2020-2021 Patrick Csikos (https://zelikos.github.io)
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

public class Rollit.MainWindow : Gtk.Window {

    private Rollit.Menu menu_menu;
    private Gtk.MenuButton menu_button;
    private Rollit.NumDisplay number_display;
    private Rollit.RollHistory roll_history;
    private Gtk.HeaderBar header;
    private Gtk.Button roll_button;
    private Gtk.Button history_button;
    private Gtk.Box action_buttons;
    private Gtk.Box main_view;
    private Gtk.Paned hp;

    private bool history_visible;
    private uint configure_id;


    public MainWindow (Rollit.Application app) {
        Object (
            application: app,
            title: _("Roll-It")
        );
    }

    construct {
        Intl.setlocale ();

        //  var toggle_history_action = new SimpleAction ("toggle_history", null);
        //  application.add_action (toggle_history_action);
        //  application.set_accels_for_action ("app.quit", {"<Control>h"});
        //  toggle_history_action.activate.connect (on_history_toggled);

        restore_state ();

        header = new Gtk.HeaderBar ();

        var label = new Gtk.Label (title);
        label.add_css_class (Granite.STYLE_CLASS_H4_LABEL);

        header.title_widget = label;
        header.add_css_class (Granite.STYLE_CLASS_FLAT);

        history_button = new Gtk.Button.from_icon_name ("document-open-recent-symbolic") {
            tooltip_markup = Granite.markup_accel_tooltip ({"<Ctrl>H"}, _("Roll history"))
        };

        header.pack_end (history_button);


        titlebar = header;


        number_display = new Rollit.NumDisplay ();

        roll_button = new Gtk.Button.with_label (_("Roll"));
        roll_button.tooltip_markup = Granite.markup_accel_tooltip ({"<Ctrl>R"}, roll_button.label);
        roll_button.add_css_class (Granite.STYLE_CLASS_SUGGESTED_ACTION);

        menu_menu = new Rollit.Menu ();
        menu_button = new Gtk.MenuButton () {
            popover = menu_menu,
            direction = Gtk.ArrowType.UP,
        };
        menu_button.set_primary (true);
        menu_button.label = menu_menu.current_choice;

        menu_menu.label_changed.connect (( new_label) => {
            menu_button.label = new_label;
        });

        action_buttons = new Gtk.Box (Gtk.Orientation.HORIZONTAL,6) {
            halign = Gtk.Align.CENTER,
            valign = Gtk.Align.END
        };

        action_buttons.append (roll_button);
        action_buttons.append (menu_button);

        main_view = new Gtk.Box (Gtk.Orientation.VERTICAL, 12) {
            margin_top = 12,
            margin_bottom = 12,
            margin_start = 12,
            margin_end = 12,
        };
        main_view.append (number_display);
        main_view.append (action_buttons);

        roll_history = new Rollit.RollHistory ();

        Application.settings.bind (
            "show-history",
            roll_history, "visible",
            SettingsBindFlags.DEFAULT
        );

        hp = new Gtk.Paned (HORIZONTAL);
        hp.start_child = main_view;
        hp.end_child = roll_history;

        var handle = new Gtk.WindowHandle () {
            child = hp
        };

        child = handle;

        roll_history.visible = history_visible;

        roll_button.clicked.connect (e => {
            roll_history.add_roll (number_display.num_gen (menu_menu.max_roll));
        });

        history_button.clicked.connect (on_history_toggled);


        /*  var accel_group = new Gtk.AccelGroup ();

        accel_group.connect (
            Gdk.Key.@1,
            Gdk.ModifierType.CONTROL_MASK,
            Gtk.AccelFlags.VISIBLE | Gtk.AccelFlags.LOCKED,
            () => {
                menu_button.shortcut_pressed (1);
                return true;
            }
        );

        accel_group.connect (
            Gdk.Key.@2,
            Gdk.ModifierType.CONTROL_MASK,
            Gtk.AccelFlags.VISIBLE | Gtk.AccelFlags.LOCKED,
            () => {
                menu_button.shortcut_pressed (2);
                return true;
            }
        );

        accel_group.connect (
            Gdk.Key.@3,
            Gdk.ModifierType.CONTROL_MASK,
            Gtk.AccelFlags.VISIBLE | Gtk.AccelFlags.LOCKED,
            () => {
                menu_button.shortcut_pressed (3);
                return true;
            }
        );

        accel_group.connect (
            Gdk.Key.@4,
            Gdk.ModifierType.CONTROL_MASK,
            Gtk.AccelFlags.VISIBLE | Gtk.AccelFlags.LOCKED,
            () => {
                menu_button.shortcut_pressed (4);
                return true;
            }
        );

        accel_group.connect (
            Gdk.Key.R,
            Gdk.ModifierType.CONTROL_MASK,
            Gtk.AccelFlags.VISIBLE | Gtk.AccelFlags.LOCKED,
            () => {
                roll_button.clicked ();
                menu_button.close_menu ();
                return true;
            }
        );

        accel_group.connect (
            Gdk.Key.D,
            Gdk.ModifierType.CONTROL_MASK,
            Gtk.AccelFlags.VISIBLE | Gtk.AccelFlags.LOCKED,
            () => {
                menu_button.clicked ();
                return true;
            }
        );

        accel_group.connect (
            Gdk.Key.H,
            Gdk.ModifierType.CONTROL_MASK,
            Gtk.AccelFlags.VISIBLE | Gtk.AccelFlags.LOCKED,
            () => {
                history_button.clicked ();
                return true;
            }
        );

        accel_group.connect (
            Gdk.Key.L,
            Gdk.ModifierType.CONTROL_MASK,
            Gtk.AccelFlags.VISIBLE | Gtk.AccelFlags.LOCKED,
            () => {
                roll_history.clear_button.clicked ();
                return true;
            }
        );

        add_accel_group (accel_group);  */
    }

    private void restore_state () {
        var rect = Gdk.Rectangle ();
        Application.settings.get ("window-size", "(ii)", out rect.width, out rect.height);

        default_width = rect.width;
        default_height = rect.height;

        history_visible = Application.settings.get_boolean ("show-history");
    }

    public void on_history_toggled () {
        Application.settings.set_boolean ("show-history", !roll_history.visible);
    }


}
