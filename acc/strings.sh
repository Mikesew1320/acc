print_already_running() {
  echo "(i) accd is already running"
}

print_started() {
  echo "(i) accd started"
}

print_stopped() {
  echo "(i) accd stopped"
}

print_not_running() {
  echo "(i) accd is not running"
}

print_restarted() {
  echo "(i) accd restarted"
}

print_is_running() {
  echo "(i) accd is running"
}

print_invalid_var() {
  echo "(!) Invalid variable, [$var]"
}

print_config_reset() {
  echo "(i) Config reset"
}

print_cs_reset() {
  echo "(i) Charging switch set to \"automatic\""
}

print_supported_cs() {
  echo "(i) supported charging switches"
}

print_cs_fails() {
  echo "(!) [$(get_value chargingSwitch)] doesn't work"
}

print_invalid_cs() {
  echo "(!) Invalid charging switch, [$(get_value chargingSwitch)]"
}

print_ch_disabled_until() {
  echo "(i) Charging disabled until battery capacity <= $1"
}

print_ch_disabled_for() {
  echo "(i) Charging disabled for $1"
}

print_ch_disabled() {
  echo "(i) Charging disabled"
}

print_ch_enabled_until() {
  echo "(i) Charging enabled until battery capacity <= $1"
}

print_ch_enabled_for() {
  echo "(i) Charging enabled for $1"
}

print_ch_enabled() {
  echo "(i) Charging enabled"
}


print_dvolt_restored() {
  echo "(i) Default voltage ($(grep -o '^....' $file)mV) was successfully restored."
}

print_dvolt_already_set() {
  echo "(i) Default voltage is already set."
}

print_invalid_input() {
  echo "(!) Invalid input, [$@]"
}

print_accepted_volt() {
  echo "- Recall that the accepted voltage range is 3920-4349mV."
}

print_cvolt_set() {
  echo "(i) Charging voltage set to $(grep -o '^....' $file)mV"
}

print_cvolt_unsupported() {
  echo "(!) Either [$(echo -n $file)] is not the right file or your kernel doesn't support custom charging voltage."
}

print_no_such_file() {
  echo "(!) No such file, [$file]"
}

print_supported_cvolt_files() {
  echo "(i) supported charging voltage ctrl files"
}

print_cvolt_limit_set() {
  echo "(i) chargingVoltageLimit=$file:$1 --> config.txt"
}

print_unplugged() {
  echo "(!) Battery must be charging"
}

print_file_works() {
  echo "(i) [$file $on $off] works"
}

print_file_fails() {
  echo "(!) [$file $on $off] doesn't work"
}

print_supported() {
  echo "(i) Supported device"
}

print_unsupported() {
  echo "(!) Unsupported device"
}

print_not_root() {
  echo "(!) Must run as root (su)"
}

print_no_modpath() {
  echo "(!) modPath not found"
}

print_help() {
  cat <<HELP
Advanced Charging Controller
Copyright (C) 2017-2019, VR25 @ xda-developers
License: GPLv3+
Version code: $(sed -n 's/versionCode=//p' $modPath/module.prop)

Usage: acc <option(s)> <arg(s)>

-c|--config <editor [opts]>   Edit config w/ <editor [opts]> (default: vim|vi)
  e.g., acc -c

-d|--disable <#%, #s, #m or #h (optional)>   Disable charging (with or without <condition>)
  e.g.,
    acc -d 70% (do not recharge until capacity drops to 70%)
    acc -d 1h (do not recharge until 1 hour has passed)

-D|--daemon   Show current acc daemon (accd) state
  e.g., acc -D

-D|--daemon <start|stop|restart>   Manage accd state
  e.g., acc -D restart

-e|--enable <#%, #s, #m or #h (optional)>   Enable charging or enable charging with <condition>
  e.g., acc -e 30m (recharge for 30 minutes)

-f|--force|--full <capacity>   Charge to a given capacity (fallback: 100) once and uninterrupted
  e.g., acc -f 95

-i|--info   Show power supply info
  e.g., acc -i

-l|--log -e|--export   Export all logs to /sdcard/acc-logs-<device>.tar.bz2
  e.g., acc -l -e

-l|--log <editor [opts]>   Open <acc-daemon-deviceName.log> w/ <editor [opts]> (default: vim|vi)
  e.g., acc -l grep ': ' (show explicit errors only)

-L|--logwatch   Monitor log
  e.g., acc -L

-r|--readme   Open <README.md> w/ <editor [opts]> (default: vim|vi)
  e.g., acc -r

-R|--resetbs   Reset battery stats
  e.g., acc -R

-s|--set   Show current config
  e.g., acc -s

-s|--set <var> <value>   Set config parameters
  e.g., acc -s capacity 5,60,80-85 (5: shutdown (default), 60: cool down (default), 80: resume, 85: pause)

-s|--set <resume-stop preset>   Can be 4041|endurance+, 5960|endurance, 7080|default, 8090|lite 9095|travel
  e.g., acc -s endurance+ (a.k.a, "the li-ion sweet spot"; best for GPS navigation and other long operations), acc -s travel (for when you need extra juice), acc -s 7080 (restore default capacity settings (5,60,70-80))

-s|--set <s|chargingSwitch>   Set a different charging switch from the database
  e.g., acc -s s

-s|--set <s:|chargingSwitch:>   List supported charging switches
  e.g., acc -s s:

-s|--set <s-|chargingSwitch->   Unset charging switch
  e.g., acc -s s-

-t|--test   Test currently set charging ctrl file
  e.g., acc -t
  Return codes: 0 (works), 1 (doesn't work) or 2 (battery must be charging)

-t|--test <file on off>   Test custom charging ctrl file
  e.g., acc -t battery/charging_enabled 1 0
  Return codes: 0 (works), 1 (doesn't work) or 2 (battery must be charging)

-v|--voltage <millivolts|file:millivolts>   Set charging voltage (3920-4349mV)
  e.g., acc -v 3920, acc -v /sys/class/power_supply/battery/voltage_max:4100

-v|--voltage   Show current voltage
  e.g., acc -v

-v|--voltage :   List supported charging voltage ctrl files
  e.g., acc -v :

-v|--voltage -   Restore default voltage
  e.g., acc -v -

-v|--voltage :millivolts   Evaluate and set charging voltage ctrl files
  e.g., acc -v :4100

-x|--xtrace <other option(s)>   Run under set -x (debugging)
  acc -x -i

Tips

  Commands can be chained for extended functionality. Note that accd must be stopped first.
    e.g., acc -D stop && acc -e 30m && acc -d 6h && acc -e 85 && accd (recharge for 30 minutes, halt charging for 6 hours, recharge to 85% capacity and restart daemon)

  Pause and resume capacities can also be set with acc <pause%> <resume%>.
    e.g., acc 85 80

  That last command can be used for programming charging before bed. In this case, the daemon must be running.
     e.g., acc 45 44 && acc --set applyOnPlug usb/current_max:500000 && sleep $((60*60*7)) && acc 80 70 && acc --set applyOnPlug usb/current_max:2000000
     - "Keep battery capacity at ~45% and limit charging current to 500mA for 7 hours. Restore regular charging settings afterwards."
     - You can write this to a file and run as "sh <file>".

Run acc --readme to see the full documentation.
HELP
}

print_exit() {
  echo Exit
}

print_choice_prompt() {
  echo "(?) Choice, [Enter]: "
}

print_auto() {
  echo Automatic
}

print_default() {
 echo Default
}