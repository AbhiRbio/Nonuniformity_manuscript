% Figure 1C -- x-z view of run 0013, frame 111 (11 s). x to the right, z DOWN (membrane at top, as in poster0111.png).
% Field at zoom 2: 500 x 308 nm (width = view_size/zoom; height = width*800/1300). Ruler major tick = 100 nm.
% Focus z = -0.266 puts the top edge at z = -0.42 (membrane z = -0.4 is 20 nm below it) and the bottom edge at z = -0.11.
% Bud centre at 11 s is (-0.014, 0.022, -0.356).
% Palette matches the 1B schematic in Figure1_BiophysJ.svg (bud grey, Arp2/3 #47a0f8, Hip1R #8065a4).
% Background: back_color black (was Cytosim default #161616) so 1C matches the 1D panels and the rose plots;
% the membrane marker stays grey so the membrane band is visible.
% Render from the run folder:
%   ~/Desktop/cytosim/bin/play <path>/style_1C_bar.cyp image frame=111 size=1300,800 magnify=4
% Filaments: style 0 = line segments (eLife 2020 look), line_width 5 px (x magnify 4 = 20 px = 0.22 mm = 0.6 pt at the
% 56.875 mm 1C placement). No model points. Plus end = cylinder stub (end_style 3), 7 px; minus end unmarked.
% Arp2/3 (12 px) now stands above the 20 px line, so branch-point complexes are visible.
set internalize display
{
 zoom                 = 2;
 view_size            = 1;
 auto_scale           = 0;
 focus                = -0.014 0.022 -0.266;
 rotation             = 0.7071068 0.7071068 0 0;
 perspective          = 0;
 window_size          = 1300, 800;
 back_color           = 0x000000FF;
 scale_bar            = 10, 0xFFFF88AA, 0;
 point_size           = 12;
}

set fiber:display actin
{
 style                = 0;
 color                = 0xFFFFFFFF, 0x7F7F7FFF, 0xFFFFFF00;
 line_width           = 5;
 points               = 12, 0, 1;
 end_style            = 3, 0;
 end_size             = 7, 7;
}

set hand:display binder
{
 color                = 0x47A0F8FF;
 size                 = 12;
 width                = 8;
}

set hand:display boundNucleator
{
 visible              = 0;
}

set hand:display strongbinder
{
 color                = 0x8065A4FF;
 size                 = 10;
 width                = 6.66667;
}

set hand:display nucleator
{
 visible              = 0;
}

set solid:display bud
{
 color                = 0x999999FF;
 size                 = 12;
 style                = 5;
}

set space:display cell
{
 color                = 0x00000044;
 size                 = 12;
}

set space:display insidecell
{
 color                = 0xFFFFFFFF;
 size                 = 12;
}

set space:display membraneMarker
{
 visible              = 2;
 color                = 0x505050FF;
 size                 = 12;
}
