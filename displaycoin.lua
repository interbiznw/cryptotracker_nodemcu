function init_i2c_display()
     sda = 3 -- NodeMCU D3
     scl = 4 -- NodeMCU D4
     sla = 0x3c
     i2c.setup(0, sda, scl, i2c.SLOW)
     disp = u8g.ssd1306_128x64_i2c(sla)
end

-- Change the display every 25 updates to reduce burn-in
if (counter == 25) then
    offset = -3
elseif (counter == 26) then
    offset = 3
elseif (counter == 27) then
    counter = 0
    offset = 0
end

-- Bitmaps stored as strings for logos/symbols. Created using GIMP saving as XBM.
usdsym = string.char(0x80, 0x01, 0x80, 0x01, 0xe0, 0x0f, 0xf0, 0x0f, 0x70, 0x00, 0x70, 0x00, 0xf0, 0x01, 0xe0, 0x07, 0xc0, 0x0f, 0x00, 0x0f, 0x00, 0x0e, 0x00, 0x0e, 0xf0, 0x0f, 0xf0, 0x07, 0x80, 0x01, 0x80, 0x01);

function drawscreen()
     disp:setFont(u8g.font_fub17)
     disp:drawStr( 24+offset, 16, coinname)
     disp:drawStr( 24+offset, 48, coinrate)
     disp:setFont(u8g.font_6x10)
     disp:drawStr( 3+offset, 28, coinbtcprice)
     disp:drawStr( 3+offset, 60, coinchange)
     disp:drawXBM(offset, 33, 16, 16, usdsym)
     disp:drawXBM(offset, 0, 16, 16, coinlogo)
end

if (firstrun ~= 1) then
    init_i2c_display()
    firstrun = 1
end

function update_screen(delay)
      disp:firstPage()
      repeat
           drawscreen()
      until disp:nextPage() == false
      tmr.wdclr()
end

update_screen()
counter= counter + 1;
