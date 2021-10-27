#!/bin/bash

case "$(xset -q|grep LED| awk '{ print $10 }')" in
	  "00000000") KBD="US" ;;
	  "00000002") KBD="US" ;;
	  "00000003") KBD="US" ;;
		"00001002") KBD="CZ" ;;
		"00001003") KBD="CZ" ;;
		"00001000") KBD="CZ" ;;
			  *) KBD="unknown" ;;
			esac
echo $KBD
