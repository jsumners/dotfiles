```sh
$ git clone <url> .dotfiles
$ cd .dotfiles
$ git submodule init
$ git submodule update
$ ./install
```

To install requested ports, after having installed MacPorts:

```sh
$ \cat ports.requested | xargs sudo port install
```

Note that the `\` is important on a fresh install where the ports have
not yet been added. This is due to the aliasing of `cat` to `bat`.

