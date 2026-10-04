% CALIBRATION version with Cytosim's default ruler (major tick = 100 nm at zoom 2). Identical otherwise.
% Figure 1D, row 2 -- x-y TOP view (x right, y up), looking from inside the cell toward the membrane; same orientation
% as the rose plots in row 3 (angle = arctan2(y, x)). Same zoom and palette as 1C and the side view.
% rotation = 1 0 0 0 is Cytosim's identity view: screen x = model x, screen y = model y, viewer on the +z side.
% Field at zoom 2: 500 x 308 nm, centred on the run 0001 bud. Focus z = bud centre so the (perspective) scale is exact at the
% membrane-proximal network. Crops one filament tip at 4 s and 1-2% of bound points at 10 and 15 s (run 0001).
% Background: back_color black. The membrane marker is HIDDEN in this view: its face at z = -0.4 is coplanar with the
% unbound Arp2/3 complexes and occluded them (zero blue pixels in the first renders). The side view keeps the marker.
% Render from the run folder:
%   ~/Desktop/cytosim/bin/play <path>/style_1D_top_bar.cyp image frame=41 size=1300,800 magnify=4
% Filaments: style 0 = line segments (eLife 2020 look), line_width 10 px (x magnify 4 = 40 px = 0.20 mm = 0.57 pt at the
% 26 mm 1D placement). No model points. Plus end = cylinder stub (end_style 3), 14 px; minus end unmarked.
% Arp2/3 (12 px) now stands above the line, so branch-point complexes are visible.
set internalize display
{
 zoom                 = 2;
 view_size            = 1;
 auto_scale           = 0;
 focus                = 0.015 0.007 -0.360;
 rotation             = 1 0 0 0;
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
 visible              = 0;
 color                = 0x000000FF;
 size                 = 12;
}
