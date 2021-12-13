#check if args exists
if [ $# -lt 1 ]; then
  echo "Wrong number of arguments" >&2
  exit 1
fi

current_state="$1"

FAN_MAX=8
SET_PWM_RETRIES=100
PID_STATUS_RETRIES=100
result=0

#variables for vhub commands
NETFN_OEM=0x32
CMD_VIRTUAL_USB=0xaa
CONFIG_ENABLE_VHUB=0x00

service_status="$( systemctl is-active phosphor-pid-control.service )"

if [[ $current_state -eq 0 ]]; then
  echo "Detect power state s0"
    #enable vhub
    ipmitool raw ${NETFN_OEM} ${CMD_VIRTUAL_USB} ${CONFIG_ENABLE_VHUB}

elif [[ $current_state -eq 5 ]]; then

  #check if $2 exists
  if [[ -z "$2" ]]; then
    echo "Didn't get required PWM, exit"
    exit -2
  else
    S5_PWM="$2"
  fi

  tried=0
  echo "Detect power state s5"
  while [[ tried -lt $PID_STATUS_RETRIES ]]; do
    echo "Wait for pid control to stop..."
    service_status="$( systemctl is-active phosphor-pid-control.service )"
    if [[ "${service_status}" == "inactive" ]]; then
      break
    fi
    tried=$((tried+1))
    sleep 1
  done

  if [[ tried -ge $PID_STATUS_RETRIES ]]; then
    echo "wait too long, exit"
    exit -1
  fi

  for (( i = 0; i < ${FAN_MAX}; i++ )); do

    rv=-1
    tried=0

    while [[ tried -lt $SET_PWM_RETRIES ]]; do

      echo ${S5_PWM} > "/sys/class/hwmon/hwmon0/pwm${i}"
      rv=$?

      sleep 1

      status=$( cat /sys/class/hwmon/hwmon0/pwm${i} )

      
      tried=$((tried+1))

      if [[ $status -ne ${S5_PWM} ]]; then
        echo "Wrong status: ${status}, retry..."
        sleep 1
      else
        break
      fi

    done

    if [[ $rv -eq 0 ]]; then
      echo "Setting FAN_PWM_${i} to ${S5_PWM}"
    else
      echo "Failed to set FAN_PWM_${i} to ${S5_PWM}" >&2
      result=$rv
    fi
  done
fi

exit $result
