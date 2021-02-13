SHELL := /bin/bash

install: install_conf
	@echo "[-] Installing system76-backlight-manager"
	sudo python3 setup.py install
	@echo "[-] Installing system76-backlight-manager.service Service"
	sudo install -m644 service/system76-backlight-manager.service /etc/systemd/system/
	sudo systemctl daemon-reload

install_conf:
	if [[ ! -f /etc/system76-backlight-manager.conf ]]; \
	then \
		sudo cp configs/system76-backlight-manager.conf /etc/; \
	fi

update_config:
	sudo cp configs/battery-backlight.conf /etc/


install_dev: venv
	.venv/bin/pip install -r requirements.test.txt

venv:
	if [[ ! -d .venv/ ]]; \
	then \
		python3 -m venv .venv; \
	fi

tests:
	py.test battery_backlight/tests/
