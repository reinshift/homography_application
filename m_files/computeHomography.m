function H = computeHomography(pts1, pts2)
    % compute homography matrix.
    % use SVD to solve Ax=b.
    A = [];
    for i = 1:size(pts1, 1)
        x = pts1(i, 1); y = pts1(i, 2);
        xp = pts2(i, 1); yp = pts2(i, 2);
        A = [A; x, y, 1, 0, 0, 0, -x*xp, -y*xp, -xp];
        A = [A; 0, 0, 0, x, y, 1, -x*yp, -y*yp, -yp];
    end
    [~, ~, V] = svd(A);
    H = reshape(V(:,end), 3, 3)';
end