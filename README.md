# Applications of Homography Matrix

- ### to embed one image into a specified area of another image
    - `pic_overlap.m`: referenced from [https://github.com/elifnurafsar/Image-Compositing-Using-Homography](https://github.com/elifnurafsar/Image-Compositing-Using-Homography).
    - `put_picture.m`: to test `pic_overlap.m`.

- ### surrounding view system
    - `main.m`: main test file.
    - `computeHomography.m`: use SVD to compute homography matrix of four pairs of coordinates.
    - `applyHomography.m`: two approaches to get transformed image. in `image_src` there're some images for simulation of a simplified surrounding view system.
