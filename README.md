# Configuration files for Radioberry based controller board

## Related repositories

* [My PiHPSDR fork](https://github.com/vu3rdd/pihpsdr)
* [Radioberry controller firmware](https://github.com/vu3rdd/rb_controller)

## IMPORTANT

If you encounter any error, copy the error and paste it into your
favourite search engine and try to understand the problem. Ham radio
is all about experimentation and self education.

## Step 1

Clone the repository

```
git clone https://github.com/vu3rdd/radioberry-controller-pi-config.git pi-config
cd pi-config
```

## Step 2

Copy `boot/config.txt` into `/boot/config.txt`

```
sudo cp boot/config.txt /boot/config.txt
```

## Step 3

To autostart pihpsdr, copy the autostart file.

```
mkdir -p ~/.config/autostart
cp .config/autostart/pihpsdr.desktop ~/.config/autostart/pihpsdr.desktop
```

## Step 4

Fix the touch input calibration, since we rotated the screen in step 2.

```
sudo cp etc/X11/xorg.conf.d/*input.conf /etc/X11/xorg.conf.d/
```

## Step 5

Install the modified version of pihpsdr

```
./pihpsdr_install.sh
```
