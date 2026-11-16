xprevious = x;
yprevious = y;

if (direction == 1) {
    y += move;
    mtime--;

    if (mtime <= 0) {
        direction = -1;
        mtime = mtimemax;
    }
}
else {
    y -= move;
    mtime--;

    if (mtime <= 0) {
        direction = 1;
        mtime = mtimemax;
    }
}

platform_hspd = x - xprevious;
platform_vspd = y - yprevious;