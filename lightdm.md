# Install lightdb for login

![login](https://github.com/rhogeranacleto/lightdm-eh8/raw/master/demo.png)

```sh
yay -Sy lightdm-webkit2-greeter
```

Clone https://github.com/rhogeranacleto/lightdm-eh8

```sh
npm i

./install.sh
```

Edit _/etc/lightdm/lightdm.conf_ and set _greeter-session=lightdm-webkit2-greeter_.
Then edit _/etc/lightdm/lightdm-webkit.conf_ and set _theme_ or _webkit-theme_ to **eh8**.

And reboot