# Configuration files for Radioberry based controller board

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
