# GTK+3 does not install x11-related files like gdkx.h for vim, so we have to remove x11 features to build xwayland
PACKAGECONFIG:remove = "x11"
