% CALIBRATION version with Cytosim's default ruler (major tick = 100 nm at zoom 2). Identical otherwise.
% Figure 1D, row 1 -- x-z SIDE view (x right, z down, membrane at top), same rotation, zoom and palette as 1C.
% Run 0001 (run-endocytosis2_baseline_zero_diffusion0000-0001), frames for 4 s, 10 s, 15 s.
% Field at zoom 2: 500 x 308 nm. Focus x,y = run 0001 bud centre (drifts < 10 nm over 4-15 s); focus z = -0.266 puts
% the top edge at z = -0.42 (membrane 20 nm below) and the bottom edge at z = -0.11. All Hip1R-bound points fit at all three times.
% Background: back_color black so the field matches the rose plots; the membrane band stays grey (0x505050).
% Render from the run folder (check the time stamp at bottom-left reads 4.000s / 10.000s / 15.000s):
%   ~/Desktop/cytosim/bin/play <path>/style_1D_side_bar.cyp image frame=41 size=1300,800 magnify=4
% Filaments: style 0 = line segments (eLife 2020 look), line_width 10 px (x magnify 4 = 40 px = 0.20 mm = 0.57 pt at the
% 26 mm 1D placement). No model points. Plus end = cylinder stub (end_style 3), 14 px; minus end unmarked.
% Arp2/3 (12 px) now stands above the line, so branch-point complexes are visible.
set internalize display
{
 zoom                 = 2;
 view_size            = 1;
 auto_scale           = 0;
 focus                = 0.015 0.007 -0.266;
 rotation             = 0.7071068 0.7071068 0 0;
 perspective          = 0;
 window_size          = 1300, 800;
 back_color           = 0x000000FF;
 scale_bar            = 10, 0xFFFF88AA, 1;
 point_size           = 12;
}

set fiber:display actin
{
 style                = 0;
 color                = 0xFFFFFFFF, 0x7F7F7FFF, 0xFFFFFF00;
 line_width           = 10;
 points               = 12, 0, 1;
 end_style            = 3, 0;
 end_size             = 14, 14;
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
