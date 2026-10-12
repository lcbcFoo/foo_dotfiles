#!/bin/sh

MAC="C8:24:78:4E:AC:1E"
SINK="bluez_output.C8_24_78_4E_AC_1E.1"
bluetooth_audio_ready=false

sink_exists() {
  pactl list short sinks 2>/dev/null |
    awk -v sink="$SINK" '$2 == sink { found = 1 } END { exit !found }'
}

bluetoothctl power on >/dev/null 2>&1 || true

# Make BlueZ discover the speaker before connecting
timeout 8s bluetoothctl scan on >/dev/null 2>&1 || true
sleep 1

if bluetoothctl connect "$MAC" >/dev/null 2>&1; then
  # Wait for WirePlumber/PipeWire to publish the Bluetooth sink. If it never
  # appears, keep the existing default sink and launch the bar normally.
  for _ in $(seq 1 15); do
    if sink_exists; then
      if pactl set-default-sink "$SINK"; then
        pactl list short sink-inputs | cut -f1 | while read -r input; do
          pactl move-sink-input "$input" "$SINK" 2>/dev/null || true
        done
        bluetooth_audio_ready=true
      fi
      break
    fi
    sleep 1
  done
fi

if [ "$bluetooth_audio_ready" = true ]; then
  easyeffects --gapplication-service >/dev/null 2>&1 &
fi
exec ironbar
