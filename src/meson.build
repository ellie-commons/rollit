sources = files(
    'Application.vala',
    'MainWindow.vala',
    'Widgets' / 'Menu.vala',
    'Widgets'/ 'NumDisplay.vala',
    'Widgets' / 'RollHistory.vala',
    'Widgets' / 'Buttons/PreviousRoll.vala',
    'Widgets' / 'Buttons/MenuItem.vala'
)

#================================
# Let's define our executable
executable(
    meson.project_name(),
    gresource,
    config_file,
    sources,
    dependencies: dependencies,
    install : true
)