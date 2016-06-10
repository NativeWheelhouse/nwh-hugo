# Native Wheelhouse

---

### Hugo Static Site Generator
This repo uses [Hugo](http://gohugo.io/overview/introduction/) to generate the static [podcast site](https://github.com/NativeWheelhouse/nativewheelhouse.github.io). It's a Go-based framework that converts markdown content into HTML. Site and metadata configurations can be done in `toml`, `yaml`, or `json`. This repo uses `yaml`, though it's all technically interchangeable. 

## Getting Started
Install Hugo via Homebrew: 
```shell
brew update && brew install hugo
```

Clone this amazing repository.

**Run Hugo locally**
Go into the repo directory and run:
```shell
hugo server -t Lanyon
```

This will start a website at `http://localhost:1313`

_PROTIP_: Run `hugo help` for additional information

## Contributing

>Under Construction

## Deploying
After adding content or making other changes to the root directory, you need to deploy those changes to the GH-Pages repo (https://github.com/NativeWheelhouse/nativewheelhouse.github.io).

Simply run 
```shell 
deploy.sh [commit message]
```

 from the root directory. This script will build the site, commit the submodule changes and push to `origin master`.