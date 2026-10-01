% Figure 1C -- x-z view of run 0013, frame 111 (11 s). x to the right, z DOWN (membrane at top, as in poster0111.png).
% Field at zoom 2: 500 x 308 nm (width = view_size/zoom; height = width*800/1300). Ruler major tick = 100 nm.
% Focus z = -0.266 puts the top edge at z = -0.42 (membrane z = -0.4 is 20 nm below it) and the bottom edge at z = -0.11.
% Bud centre at 11 s is (-0.014, 0.022, -0.356).
% Palette matches the 1B schematic in Figure1_BiophysJ.svg (bud grey, Arp2/3 #47a0f8, Hip1R #8065a4).
% Render from the run folder:
%   ~/Desktop/cytosim/bin/play <path>/style_1C_bar.cyp image frame=111 size=1300,800 magnify=4
set internalize display
{
 zoom                 = 2;
 view_size            = 1;
 auto_scale           = 0;
 focus                = -0.014 0.022 -0.266;
 rotation             = 0.7071068 0.7071068 0 0;
 perspective          = 0;
 window_size          = 1300, 800;
 scale_bar            = 10, 0xFFFF88AA, 1;
 point_size           = 12;
}

set fiber:display actin
{
 style                = 2;
 color                = 0xFFFFFFFF, 0x7F7F7FFF, 0xFFFFFF00;
 points               = 12, 0, 1;
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
