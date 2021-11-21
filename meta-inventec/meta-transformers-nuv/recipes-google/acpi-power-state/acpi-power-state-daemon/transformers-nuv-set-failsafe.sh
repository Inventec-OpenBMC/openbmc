#check if args exists
if [ $# -ne 2 ]; then
  echo "Wrong number of arguments" >&2
  exit 1
fi

current_state="$1"
set_pwm="$2"

FAN_MAX=8
RETRIES=3

result=0

service_status="$( systemctl is-active phosphor-pid-control.service )"

if [[ $current_state -eq 0 ]]; then
  echo "Detect power state s0"
  if [[ "${service_status}" == "inactive" ]]; then
    echo "start pid service..."
    systemctl start phosphor-pid-control.service
    sleep 1
  fi

elif [[ $current_state -eq 5 ]]; then

  echo "Detect power state s5"
  if [[ "${service_status}" == "active" ]]; then
    echo "Stop pid service..."
    systemctl stop phosphor-pid-control.service
    sleep 1
  fi

  for (( i = 1; i <= ${FAN_MAX}; i++ )); do
    
    rv=-1
    tried=0

    while [[ rv -ne 0 && tried -lt RETRIES ]]; do

      busctl set-property xyz.openbmc_project.FanSensor /xyz/openbmc_project/control/fanpwm/FAN_PWM_${i} xyz.openbmc_project.Control.FanPwm Target t "${set_pwm}"
      
      rv=$?
      tried=$((tried+1))

      if [[ $rv -ne 0 ]]; then
        sleep 1
      fi

    done

    if [[ $rv -eq 0 ]]; then
      echo "Setting FAN_PWM_${i} to ${set_pwm}"
    else
      echo "Failed to set FAN_PWM_${i} to ${set_pwm}" >&2
      result=$rv
    fi
  done
fi

exit $result
