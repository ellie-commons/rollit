/*
 * Copyright (C) 2020-2021 Patrick Csikos (https://zelikos.github.io)
 * Copyright (c) 2025 Stella, Charlie, (teamcons on GitHub) and the Ellie_Commons community
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA
 */

public class Rollit.Application : Gtk.Application {

    public static GLib.Settings settings;


    public Application () {
        Object (
            application_id: "io.github.ellie_commons.rollit",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    static construct {
        settings = new GLib.Settings ("io.github.ellie_commons.rollit");
    }

    construct {

        Intl.setlocale (LocaleCategory.ALL, "");
        Intl.bindtextdomain (GETTEXT_PACKAGE, LOCALEDIR);
        Intl.bind_textdomain_codeset (GETTEXT_PACKAGE, "UTF-8");
        Intl.textdomain (GETTEXT_PACKAGE);

        var quit_action = new SimpleAction ("quit", null);
        add_action (quit_action);
        set_accels_for_action ("app.quit", {"<Control>q"});
        quit_action.activate.connect (quit);

        var toggle_history = new SimpleAction ("toggle_history", null);
        add_action (toggle_history);
        set_accels_for_action ("app.toggle_history", { "<Control>h", null });
        toggle_history.activate.connect (() => {
            var if_hist_visible = Application.settings.get_boolean ("show-history");
            Application.settings.set_boolean ("show-history", (! if_hist_visible));
        });
    }

    protected override void activate () {
        var gtk_settings = Gtk.Settings.get_default ();
        var granite_settings = Granite.Settings.get_default ();

        // gtk_settings.gtk_application_prefer_dark_theme = settings.get_boolean ("dark-style");

        gtk_settings.gtk_application_prefer_dark_theme = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;

        granite_settings.notify["prefers-color-scheme"].connect (() => {
            gtk_settings.gtk_application_prefer_dark_theme = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;
        });

        var provider = new Gtk.CssProvider ();
        provider.load_from_resource ("/io/github/ellie_commons/rollit/Application.css");
        Gtk.StyleContext.add_provider_for_display (
            Gdk.Display.get_default (),
            provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        );

        var window = new Rollit.MainWindow (this);

        add_window (window);

        window.show ();
    }

    public static int main (string[] args) {
        var app = new Application ();

        return app.run (args);
    }
}
