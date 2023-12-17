% function outputImage = applyHomography(inputImage, H)
%     % this is approach_1, which use H to transform original image.
%     % but it will cause some misses of information.
%     [height, width, ~] = size(inputImage);
%     outputImage = zeros(height, width, 3, 'uint8');
% 
%     x_min = 1;
%     y_min = 1;
% 
%     for x = 1:width
%         for y = 1:height
%             newCoord = H * [x; y; 1];
%             newCoord = newCoord ./ newCoord(3);
% 
%             newX = round(newCoord(1));
%             newY = round(newCoord(2));
% 
%             if newX >= 1 && newX <= width && newY >= 1 && newY <= height
%                 outputImage(newY, newX, :) = inputImage(y, x, :);
%             end
%         end
%     end
% end
%%-----------------------------------------------------------------------%%
function outputImage = applyHomography(inputImage, H)
    % this is approach_2, which use H^(-1) to seek points in original
    % image, with bilinear interpolation.
    [height, width, dim] = size(inputImage);
    outputImage = zeros(height, width, dim, 'uint8');
    H_inv = inv(H);

    for x = 1:width
        for y = 1:height
            newCoord = H_inv * [x; y; 1];
            newCoord = newCoord ./ newCoord(3);

            newX = newCoord(1);
            newY = newCoord(2);

            % compute four points nearest to the original coordinate.
            x1 = floor(newX);
            x2 = ceil(newX);
            y1 = floor(newY);
            y2 = ceil(newY);

            if x1 >= 1 && x2 <= width && y1 >= 1 && y2 <= height
                % compute weight.
                wa = (x2 - newX) * (y2 - newY);
                wb = (newX - x1) * (y2 - newY);
                wc = (x2 - newX) * (newY - y1);
                wd = (newX - x1) * (newY - y1);

                % bilinear interpolation.
                for c = 1:dim
                    val = wa * double(inputImage(y1, x1, c)) + ...
                          wb * double(inputImage(y1, x2, c)) + ...
                          wc * double(inputImage(y2, x1, c)) + ...
                          wd * double(inputImage(y2, x2, c));
                    outputImage(y, x, c) = uint8(val);
                end
            end
        end
    end
end


