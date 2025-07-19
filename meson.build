project('io.github.ellie_commons.rollit',
    'vala', 'c',
    version: '3.0.0')

gnome = import('gnome')
i18n = import('i18n')

add_project_arguments(
    '-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()),
    language: 'c'
)

subdir('src')

asresources = gnome.compile_resources(
    'as-resources',
'data/rollit.gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

dependencies = [
    dependency('gtk4'),
    dependency('granite-7')
]

executable(
    meson.project_name(),
    sources,
    asresources,
    dependencies: dependencies,
    install: true
)

subdir('data')
subdir('po')

gnome.post_install(
  glib_compile_schemas: true,
  gtk_update_icon_cache: true,
  update_desktop_database: true
  )