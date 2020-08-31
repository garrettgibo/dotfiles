#!/bin/bash
#
# Pseudo-graphical multioption select.
# Inspired by: https://stackoverflow.com/a/54261882


#######################################
# Create multioption select
# Controls:
#   Navigation - up/down arrows or k/j
#   Toggle     - space
#   Finish     - enter
# Arguments:
#   Options to select
# Outputs:
#   Returns selected options
#######################################
multiselect() {
    # little helpers for terminal print control and key input
    ESC=$( printf "\033")
    cursor_blink_on()   { printf "%s[?25h" "$ESC"; }
    cursor_blink_off()  { printf "%s[?25l" "$ESC"; }
    cursor_to()         { printf "%s[%s;${2:-1}H" "$ESC" "$1"; }
    print_inactive()    { printf " %s  %s " "$2" "$1"; }
    print_active()      { printf " %s  %s[7m %s %s[27m" "$2" "$ESC" "$1" "$ESC"; }
    get_cursor_row()    { IFS=';' read -rsdR -p $'\E[6n' ROW _; echo "${ROW#*[}"; }
    key_input()         {
      key=""
      IFS= read -rsn1 key 2>/dev/null >&2
      if [[ $key = ""      ]]; then echo enter; fi;
      if [[ $key = $'\x20' ]]; then echo space; fi;
      if [[ $key = $'\x1b' ]]; then
        read -rsn2 key
        if [[ $key = [A ]]; then echo up;    fi;
        if [[ $key = [B ]]; then echo down;  fi;
      fi
      if [[ $key = "k" ]]; then echo "k"; fi;
      if [[ $key = "j" ]]; then echo "j"; fi;
    }
    toggle_option()    {
      arr_name=$1
      eval "arr=(\"\${${arr_name}[@]}\")"
      option=$2
      if [[ ${arr[option]} == true ]]; then
        arr[option]=
      else
        arr[option]=true
      fi
      eval "$arr_name"='("${arr[@]}")'
    }

    retval=$1
    options=""
    defaults=""

    IFS=';' read -r -a options <<< "$2"
    if [[ -z $3 ]]; then
      defaults=()
    else
      IFS=';' read -r -a defaults <<< "$3"
    fi
    selected=()

    for ((i=0; i<${#options[@]}; i++)); do
      selected+=("${defaults[i]}")
      printf "\n"
    done

    # determine current screen position for overwriting the options
    lastrow=$(get_cursor_row)
    startrow=$((lastrow - ${#options[@]}))

    # ensure cursor and input echoing back on upon a ctrl+c during read -s
    trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
    cursor_blink_off

    active=0
    while true; do
        # print options by overwriting the last lines
        idx=0
        for option in "${options[@]}"; do
            prefix="[ ]"
            if [[ ${selected[idx]} == true ]]; then
              prefix="[x]"
            fi

            cursor_to $((startrow + idx))
            if [ "$idx" -eq "$active" ]; then
                print_active "$option" "$prefix"
            else
                print_inactive "$option" "$prefix"
            fi
            ((idx++))
        done

        # user key control
        case $(key_input) in
            space)  toggle_option selected $active;;
            enter)  break;;
            up)     ((active--));
                    if [ "$active" -lt 0 ]; then active=$((${#options[@]} - 1)); fi;;
            down)   ((active++));
                    if [ "$active" -ge ${#options[@]} ]; then active=0; fi;;
            k)     ((active--));
                    if [ "$active" -lt 0 ]; then active=$((${#options[@]} - 1)); fi;;
            j)   ((active++));
                    if [ "$active" -ge ${#options[@]} ]; then active=0; fi;;
        esac
    done

    # cursor position back to normal
    cursor_to "$lastrow"
    cursor_blink_on

    eval "$retval"='("${selected[@]}")'
}
