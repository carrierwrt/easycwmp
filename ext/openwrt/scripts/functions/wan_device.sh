#!/bin/sh
# Copyright (C) 2012-2014 PIVA Software <www.pivasoftware.com>
# 	Author: MOHAMED Kallel <mohamed.kallel@pivasoftware.com>
# 	Author: AHMED Zribi <ahmed.zribi@pivasoftware.com>
# Copyright (C) 2011-2012 Luka Perkov <freecwmp@lukaperkov.net>

get_wan_device_mng_status() {
# TODO: Unconfigured ; Connecting ; Connected ; PendingDisconnect ; Disconneting ; Disconnected 
local nl="$1"
local val=""
local parm="InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.ConnectionStatus"
local permissions="0"
case "$action" in
	get_value)
	val="Connected"
	;;
	get_name)
	[ "$nl" = "1" ] &&  return $E_INVALID_ARGUMENTS 
	;;
	get_notification)
	easycwmp_get_parameter_notification "val" "$parm"
	;;
esac
easycwmp_output "$parm" "$val" "$permissions"
return 0
}

get_wan_device_mng_interface_ip() {
local nl="$1"
local val=""
local parm="InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.ExternalIPAddress"
local permissions="0"
case "$action" in
	get_value)
	if [ -z "$default_wan_device_mng_interface_ip" ]; then
		val=`ifconfig "$(uci get easycwmp.@local[0].interface)" | grep -o -E '([[:digit:]]{1,3}\.){3}[[:digit:]]{1,3}' | head -1`
	else
		val=$default_wan_device_mng_interface_ip
	fi
	;;
	get_name)
	[ "$nl" = "1" ] &&  return $E_INVALID_ARGUMENTS 
	;;
	get_notification)
	easycwmp_get_parameter_notification "val" "$parm"
	;;
esac
easycwmp_output "$parm" "$val" "$permissions"
return 0
}

get_wan_device_mng_interface_mac() {
local nl="$1"
local val=""
local parm="InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.MACAddress"
local permissions="0"
case "$action" in
	get_value)
	if [ -z "$default_wan_device_mng_interface_mac" ]; then
		val=`ifconfig "$(uci get easycwmp.@local[0].interface)" | grep -o -E '([[:xdigit:]]{2}:){5}[[:xdigit:]]{2}'`
	else
		val=$default_wan_device_mng_interface_mac
	fi
	;;
	get_name)
	[ "$nl" = "1" ] &&  return $E_INVALID_ARGUMENTS 
	;;
	get_notification)
	easycwmp_get_parameter_notification "val" "$parm"
	;;
esac
easycwmp_output "$parm" "$val" "$permissions"
return 0
}

get_wan_device_wan_ppp_enable() {
local nl="$1"
local val=""
local type="xsd:boolean"
local parm="InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.1.Enable"
local permissions="1"
case "$action" in
	get_value)
	proto=`$UCI_GET network.wan.proto 2> /dev/null`
	if [ "$proto" = "ppp" -o "$proto" = "pppoe" -o "$proto" = "pppoa" ]; then
		val="true"
	else
		val="false"
	fi
	;;
	get_name)
	[ "$nl" = "1" ] &&  return $E_INVALID_ARGUMENTS 
	;;
	get_notification)
	easycwmp_get_parameter_notification "val" "$parm"
	;;
esac
easycwmp_output "$parm" "$val" "$permissions" "$type"
return 0
}

set_wan_device_wan_ppp_enable() {
local val=$1
local parm="InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.1.Enable"
case $action in
	set_value)
	# TODO: How do we switch on PPP...?
	return $E_INTERNAL_ERROR
	;;
	set_notification)
	easycwmp_set_parameter_notification "$parm" "$val"
	;;
esac
}

get_wan_device_wan_ppp_username() {
local nl="$1"
local val=""
local parm="InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.1.Username"
local permissions="1"
case "$action" in
	get_value)
	val=`$UCI_GET network.wan.username 2> /dev/null`
	;;
	get_name)
	[ "$nl" = "1" ] &&  return $E_INVALID_ARGUMENTS 
	;;
	get_notification)
	easycwmp_get_parameter_notification "val" "$parm"
	;;
esac
easycwmp_output "$parm" "$val" "$permissions"
return 0
}

set_wan_device_wan_ppp_username() {
local val=$1
local parm="InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.1.Username"
case $action in
	set_value)
	$UCI_SET network.wan.username="$val"
	;;
	set_notification)
	easycwmp_set_parameter_notification "$parm" "$val"
	;;
esac
}

get_wan_device_wan_ppp_password() {
local nl="$1"
local val=""
local parm="InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.1.Password"
local permissions="1"
case "$action" in
	get_value)
	val=`$UCI_GET network.wan.password 2> /dev/null`
	;;
	get_name)
	[ "$nl" = "1" ] &&  return $E_INVALID_ARGUMENTS 
	;;
	get_notification)
	easycwmp_get_parameter_notification "val" "$parm"
	;;
esac
easycwmp_output "$parm" "$val" "$permissions"
return 0
}

set_wan_device_wan_ppp_password() {
local val=$1
local parm="InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.1.Password"
case $action in
	set_value)
	$UCI_SET network.wan.password="$1"
	;;
	set_notification)
	easycwmp_set_parameter_notification "$parm" "$val"
	;;
esac
}

get_wan_device_object() {
nl="$1"
case "$action" in
	get_name)
	[ "$nl" = "0" ] && easycwmp_output "InternetGatewayDevice.WANDevice." "" "0"
	;;
esac
}

get_wan_device_instance() {
nl="$1"
case "$action" in
	get_name)
	[ "$nl" = "0" ] && easycwmp_output "InternetGatewayDevice.WANDevice.1." "" "0"
	;;
esac
}

get_wan_device_wan_connection_device_object() {
nl="$1"
case "$action" in
	get_name)
	[ "$nl" = "0" ] && easycwmp_output "InternetGatewayDevice.WANDevice.1.WANConnectionDevice." "" "0"
	;;
esac
}

get_wan_device_wan_connection_device_instance() {
nl="$1"
case "$action" in
	get_name)
	if [ "$nl" = "0" ]; then
		[ "$2" != "2" ] && easycwmp_output "InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1." "" "0"
		[ "$2" != "1" ] && easycwmp_output "InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2." "" "0"
	fi
	;;
esac
}

get_wan_device_wan_connection_device_wan_ip_connection_object() {
nl="$1"
case "$action" in
	get_name)
	[ "$nl" = "0" ] && easycwmp_output "InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection." "" "0"
	;;
esac
}

get_wan_device_wan_connection_device_wan_ip_connection_instance() {
nl="$1"
case "$action" in
	get_name)
	[ "$nl" = "0" ] && easycwmp_output "InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1." "" "0"
	;;
esac
}

get_wan_device_wan_connection_device_wan_ppp_connection_object() {
nl="$1"
case "$action" in
	get_name)
	[ "$nl" = "0" ] && easycwmp_output "InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection." "" "0"
	;;
esac
}

get_wan_device_wan_connection_device_wan_ppp_connection_instance() {
nl="$1"
case "$action" in
	get_name)
	[ "$nl" = "0" ] && easycwmp_output "InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.1." "" "0"
	;;
esac
}


get_wan_device() {
case "$1" in
	InternetGatewayDevice.)
	get_wan_device_object 0
	get_wan_device_instance "$2"
	get_wan_device_wan_connection_device_object "$2"
	get_wan_device_wan_connection_device_instance "$2"
	get_wan_device_wan_connection_device_wan_ip_connection_object "$2"
	get_wan_device_wan_connection_device_wan_ip_connection_instance "$2"
	get_wan_device_wan_connection_device_wan_ppp_connection_object "$2"
	get_wan_device_wan_connection_device_wan_ppp_connection_instance "$2"
	get_wan_device_mng_status "$2"
	get_wan_device_mng_interface_ip "$2"
	get_wan_device_mng_interface_mac "$2"
	get_wan_device_wan_ppp_enable "$2"
	get_wan_device_wan_ppp_username "$2"
	get_wan_device_wan_ppp_password "$2"
	return 0
	;;
	InternetGatewayDevice.WANDevice.)
	get_wan_device_object "$2"
	get_wan_device_instance 0
	get_wan_device_wan_connection_device_object "$2"
	get_wan_device_wan_connection_device_instance "$2"
	get_wan_device_wan_connection_device_wan_ip_connection_object "$2"
	get_wan_device_wan_connection_device_wan_ip_connection_instance "$2"
	get_wan_device_wan_connection_device_wan_ppp_connection_object "$2"
	get_wan_device_wan_connection_device_wan_ppp_connection_instance "$2"
	get_wan_device_mng_status "$2"
	get_wan_device_mng_interface_ip "$2"
	get_wan_device_mng_interface_mac "$2"
	get_wan_device_wan_ppp_enable "$2"
	get_wan_device_wan_ppp_username "$2"
	get_wan_device_wan_ppp_password "$2"
	return 0
	;;
	InternetGatewayDevice.WANDevice.1.)
	get_wan_device_instance "$2"
	get_wan_device_wan_connection_device_object 0
	get_wan_device_wan_connection_device_instance "$2"
	get_wan_device_wan_connection_device_wan_ip_connection_object "$2"
	get_wan_device_wan_connection_device_wan_ip_connection_instance "$2"
	get_wan_device_wan_connection_device_wan_ppp_connection_object "$2"
	get_wan_device_wan_connection_device_wan_ppp_connection_instance "$2"
	get_wan_device_mng_status "$2"
	get_wan_device_mng_interface_ip "$2"
	get_wan_device_mng_interface_mac "$2"
	get_wan_device_wan_ppp_enable "$2"
	get_wan_device_wan_ppp_username "$2"
	get_wan_device_wan_ppp_password "$2"
	return 0
	;;
	InternetGatewayDevice.WANDevice.1.WANConnectionDevice.)
	get_wan_device_wan_connection_device_object "$2"
	get_wan_device_wan_connection_device_instance 0
	get_wan_device_wan_connection_device_wan_ip_connection_object "$2"
	get_wan_device_wan_connection_device_wan_ip_connection_instance "$2"
	get_wan_device_wan_connection_device_wan_ppp_connection_object "$2"
	get_wan_device_wan_connection_device_wan_ppp_connection_instance "$2"
	get_wan_device_mng_status "$2"
	get_wan_device_mng_interface_ip "$2"
	get_wan_device_mng_interface_mac "$2"
	get_wan_device_wan_ppp_enable "$2"
	get_wan_device_wan_ppp_username "$2"
	get_wan_device_wan_ppp_password "$2"
	return 0
	;;
	InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.)
	get_wan_device_wan_connection_device_instance "$2" "1"
	get_wan_device_wan_connection_device_wan_ip_connection_object 0
	get_wan_device_wan_connection_device_wan_ip_connection_instance "$2"
	get_wan_device_mng_status "$2"
	get_wan_device_mng_interface_ip "$2"
	get_wan_device_mng_interface_mac "$2"
	return 0
	;;
	InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.)
	get_wan_device_wan_connection_device_instance "$2" "2"
	get_wan_device_wan_connection_device_wan_ppp_connection_object 0
	get_wan_device_wan_connection_device_wan_ppp_connection_instance "$2"
	get_wan_device_wan_ppp_enable "$2"
	get_wan_device_wan_ppp_username "$2"
	get_wan_device_wan_ppp_password "$2"
	return 0
	;;
	InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.)
	get_wan_device_wan_connection_device_wan_ip_connection_object "$2"
	get_wan_device_wan_connection_device_wan_ip_connection_instance 0
	get_wan_device_mng_status "$2"
	get_wan_device_mng_interface_ip "$2"
	get_wan_device_mng_interface_mac "$2"
	return 0
	;;
	InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.)
	get_wan_device_wan_connection_device_wan_ip_connection_instance "$2"
	get_wan_device_mng_status 0
	get_wan_device_mng_interface_ip 0
	get_wan_device_mng_interface_mac 0
	return 0
	;;
	InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.)
	get_wan_device_wan_connection_device_wan_ppp_connection_object "$2"
	get_wan_device_wan_connection_device_wan_ppp_connection_instance 0
	get_wan_device_wan_ppp_enable "$2"
	get_wan_device_wan_ppp_username "$2"
	get_wan_device_wan_ppp_password "$2"
	return 0
	;;
	InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.1.)
	get_wan_device_wan_connection_device_wan_ppp_connection_instance "$2"
	get_wan_device_wan_ppp_enable 0
	get_wan_device_wan_ppp_username 0
	get_wan_device_wan_ppp_password 0
	return 0
	;;
	InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.ConnectionStatus)
	get_wan_device_mng_status "$2"
	return $?
	;;
	InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.ExternalIPAddress)
	get_wan_device_mng_interface_ip "$2"
	return $?
	;;
	InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.MACAddress)
	get_wan_device_mng_interface_mac "$2"
	return $?
	;;
	InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.1.Enable)
	get_wan_device_wan_ppp_enable "$2"
	return $?
	;;
	InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.1.Username)
	get_wan_device_wan_ppp_username "$2"
	return $?
	;;
	InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.1.Password)
	get_wan_device_wan_ppp_password "$2"
	return $?
	;;
esac
return $E_INVALID_PARAMETER_NAME
}

set_wan_device() {
case "$1" in
	InternetGatewayDevice.WANDevice.|\
	InternetGatewayDevice.WANDevice.1.|\
	InternetGatewayDevice.WANDevice.1.WANConnectionDevice.|\
	InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.|\
	InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.|\
	InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.|\
	InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.|\
	InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.|\
	InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.1.)
	[ "$action" = "set_value" ] && return $E_INVALID_PARAMETER_NAME
	easycwmp_set_parameter_notification "$1" "$2"
	return 0
	;;
	InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.MACAddress|\
	InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.ConnectionStatus|\
	InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.ExternalIPAddress)
	[ "$action" = "set_value" ] && return $E_NON_WRITABLE_PARAMETER
	easycwmp_set_parameter_notification "$1" "$2"
	return 0
	;;
	InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.1.Enable)
	set_wan_device_wan_ppp_enable "$2"
	return $?
	;;
	InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.1.Username)
	set_wan_device_wan_ppp_username "$2"
	return 0
	;;
	InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.1.Password)
	set_wan_device_wan_ppp_password "$2"
	return 0
	;;
esac
return $E_INVALID_PARAMETER_NAME
}

build_instances_wan_device() { return 0; }

add_object_wan_device() { return $E_INVALID_PARAMETER_NAME; }

delete_object_wan_device() { return $E_INVALID_PARAMETER_NAME; }

register_function wan_device
