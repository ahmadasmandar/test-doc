% this belongs to the infrared_live.m standalone live script

function infrared_adjust(~, event, himage)
    img = (normalize(event.Data) .* 256);
    himage.CData = img;
end

function img = normalize(img)
    img = double(img);
    minv = min(img(:));
    maxv = max(img(:));
    diff = maxv - minv;
    if(diff ~= 0)
        img = (img - minv) ./ diff;    
    end
end
