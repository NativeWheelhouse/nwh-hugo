git submodule deinit public || true
git rm public
rm -rf .git/modules/public

git submodule add -b master https://github.com/NativeWheelhouse/nativewheelhouse.github.io.git public