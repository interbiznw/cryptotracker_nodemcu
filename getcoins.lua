function getnextcoin() 
    if(coinflag == 0) then
        -- Bitmaps stored as strings for logos/symbols. Created using GIMP saving as XBM.
        coinlogo = string.char(0x80, 0x01, 0xc0, 0x03, 0xe0, 0x07, 0xf0, 0x0f, 0xf8, 0x1f, 0xf8, 0x1f, 0xb4, 0x2d, 0xce, 0x73, 0xff, 0xff, 0xfe, 0x7f, 0xfc, 0x3f, 0xf8, 0x1f,0xf0, 0x0f, 0xe0, 0x07, 0xc0, 0x03, 0x80, 0x01);
        coinname = "WAVES"
        coinflag = 1
        
        getcoin("https://api.coinmarketcap.com/v1/ticker/waves/?convert=USD")
        
    elseif(coinflag == 1) then
        -- Bitmaps stored as strings for logos/symbols. Created using GIMP saving as XBM.
        coinlogo = string.char(0xe0, 0x07, 0xf8, 0x1f, 0x7c, 0x3c, 0x1e, 0x30, 0xfe, 0x07, 0xff, 0x07, 0x87, 0x03, 0x83, 0x83, 0xc3, 0x81, 0xc7, 0x01, 0xe7, 0x3f, 0xe6, 0x3f, 0x0e, 0x30, 0x3c, 0x3c, 0xf8, 0x1f, 0xe0, 0x07);
        coinname = "ZCL"
        coinflag = 0
        
        getcoin("https://api.coinmarketcap.com/v1/ticker/zclassic/?convert=USD")
         
    end

    
end


function getcoin(url)
http.get(url, nil, function(code, coindata)
    if (code < 0) then
      print("HTTP request failed")
    else
      t = cjson.decode(coindata)
      coinrate = string.format("%.2f", t[1]["price_usd"]);
      coinchange = "24h " .. t[1]["percent_change_24h"] .. "% 1h " .. t[1]["percent_change_1h"] .. "%"
      coinbtcprice = "BTC: " .. t[1]["price_btc"] --.. "Vol" .. string.format("%.2f", t[1]["24h_volume_usd"]) 
      dofile('displaycoin.lua')
      end
  end)
end


node.task.post(getnextcoin);
