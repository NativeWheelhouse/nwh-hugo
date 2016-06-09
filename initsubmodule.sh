git submodule deinit public || true
rm -rf .git/modules/public
rm -rf public

git submodule add -b master git@github.com:nativewheelhouse/nativewheelhouse.github.io.git public