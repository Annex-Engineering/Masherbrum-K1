# This file contains common pin mappings for the Fysetc S6 board.
# This is for a version 2.0 layout of the board
# This config was built by RentableSocks on the Annex Engineering Discord
# To use this config, the firmware should be compiled for the STM32F446.
# When calling "menuconfig", enable "extra low-level configuration setup"
# and select the "12MHz crystal" as clock reference
# For flashing, write the compiled klipper.bin to memory location 0x8000000

#config is for Fysetc S6 + BTT EXP_MOT board, single MCU.
#BTT 2209 drivers on the S6 board require jumper between stepper pins 4 and 5, these are poking out the top on the left side

########################################
# EXP1 / EXP2 (display) pins
########################################

# These must be turned 180° when compared to the default RAMPS layout.
# The aliases below are 180° turned from what Fysetc considers pin 1,
# but visually correspond to the plugs on the board.

[board_pins]
aliases:
    # EXP1 header
    EXP1_1=PC9, EXP1_2=PA8,
    EXP1_3=PC11, EXP1_4=PD2,
    EXP1_5=PC10, EXP1_6=PC12,    # Slot in the socket on this side
    EXP1_7=PD0, EXP1_8=PD1,
    EXP1_9=<GND>, EXP1_10=<5V>,

    # EXP2 header
    EXP2_1=PA6, EXP2_2=PA5,
    EXP2_3=PC6, EXP2_4=PA4,
    EXP2_5=PC7, EXP2_6=PA7,      # Slot in the socket on this side
    EXP2_7=PB10, EXP2_8=<RST>,
    EXP2_9=<GND>, EXP2_10=<5V>


# See the example.cfg file for a description of available parameters.
[printer]
kinematics: cartesian
max_velocity: 400
max_accel: 6000
max_z_velocity: 30
max_z_accel: 500
square_corner_velocity: 5.0

[idle_timeout]
timeout: 90000

#Gcode G2/G3 Arc Support
[gcode_arcs]
resolution: 0.1

#Input Shaper Settings
[input_shaper]
shaper_freq_x: 36.6
shaper_freq_y: 32.5
shaper_type: mzv

[stepper_x]  #X-mot
step_pin: PE11
dir_pin: PE10
enable_pin: !PE9
step_distance: .00625
position_endstop: 405
position_max: 405
homing_speed: 50
endstop_pin: tmc2209_stepper_x:virtual_endstop

[stepper_x1] #EXP-Mot 1
step_pin: EXP2_6
dir_pin: EXP2_5
enable_pin: !EXP2_7
step_distance: .00625
endstop_pin: tmc2209_stepper_x1:virtual_endstop

[stepper_y]
step_pin: EXP2_3 #EXP-Mot 2
dir_pin: EXP2_4
enable_pin: !EXP1_8
step_distance: .00625
position_endstop: 405
position_max: 405
homing_speed: 50
endstop_pin: tmc2209_stepper_y:virtual_endstop

[stepper_y1] #EXP-Mot 3
step_pin: EXP2_1
dir_pin: !EXP2_2
enable_pin: !EXP1_7
step_distance: .00625
endstop_pin: tmc2209_stepper_y1:virtual_endstop

[stepper_z] #E2
step_pin: PE2
dir_pin: PE4
enable_pin: !PE3
step_distance: .005
endstop_pin: ^!PA3  #Connected to Z+ switch on S6 -- must be a MAX port for enough voltage to compensate for drop and not be slow
position_max: 600

# offset for nozzle to bed off z switch
#position_endstop: 0.34	#microswitch Height - sheet 1
position_endstop: 1.235	#microswitch Height - sheet 2
position_min: -2
homing_speed: 10
second_homing_speed: 3.0
homing_retract_dist: 10.0
homing_positive_dir: false

[stepper_z1] #E1
step_pin: PE6
dir_pin: PC13
enable_pin: !PE5
step_distance: .005

[stepper_z2] #E0
step_pin: PD5
dir_pin: PD6
enable_pin: !PD4
step_distance: .005

[stepper_z3] #Z mot
step_pin: PD14
dir_pin: PD13
enable_pin: !PD15
step_distance: .005




[extruder] #Y-Mot
step_pin: PD8
dir_pin: PB12
enable_pin: !PD9
step_distance: 0.000755  #Folded_Ascender_KHK
nozzle_diameter: 0.600
pressure_advance: 0.01
pressure_advance_smooth_time: 0.075
filament_diameter: 1.750
heater_pin: PB3 #PB4
max_power: 1.0
sensor_type: EPCOS 100K B57560G104F #SliceEngineering 450
sensor_pin: PC0
smooth_time: 3.0
control: pid
pid_kp = 26.036
pid_ki = 1.669
pid_kd = 101.542
min_temp: 0
max_temp: 300
max_extrude_only_distance: 1400.0
max_extrude_only_velocity: 120.0
max_extrude_only_accel: 700.0
max_extrude_cross_section: 20000.0

[verify_heater extruder]
hysteresis: 10
check_gain_time: 40
heating_gain: 2
max_error: 500


[heater_bed]
heater_pin: PC8
sensor_type: EPCOS 100K B57560G104F
sensor_pin: PC3
control: pid  
pid_kp = 48.808
pid_ki = 0.174
pid_kd = 3418.990  #19mm bed, thermistor embedded in back right corner
#id_deriv_time: 2.0
#   A time value (in seconds) over which the derivative in the pid
#   will be smoothed to reduce the impact of measurement noise. The
#   default is 2 seconds.
#pid_integral_max:
#   The maximum "windup" the integral term may accumulate. The default
#   is to use the same value as max_power.

min_temp: 0
max_temp: 130
max_power: 0.75
smooth_time: 3.0

[verify_heater heater_bed]
hysteresis: 2.5
check_gain_time: 240

# Fans  
#	thermally controlled hotend fan
[heater_fan my_nozzle_fan]
# connected to Fan0 on S6 #1 - 12v Fan
pin: PB0
max_power: 1.0
kick_start_time: 0.500
heater: extruder
heater_temp: 75.0
fan_speed: 1.00

# print cooling fan
[fan]
# connected to Fan1 on S6 #1 - 12v Fan
pin: PB1
max_power: 1.0
kick_start_time: 0.500

#	thermally controlled electronics bay fan
[heater_fan electronics_fan_1]
# connected to Fan0 on S6 #2 - 24v Fan
pin: PB2
max_power: 1.0
kick_start_time: 0.500
heater: extruder
heater_temp: 75.0
fan_speed: 1.00

[mcu]
serial: /dev/serial/by-id/usb-Klipper_stm32f446xx_4F0029000851363131363530-if00

########################################
# TMC UART configuration
########################################

# For TMC UART
#   1) Remove all jumpers below the stepper drivers.
#   2) Place a jumper on the "PDN-EN" two-pin header.

# For TMC Sensorless homing / DIAG1
#   1) Place a jumper on the two pin header near the endstop.

[tmc2209 stepper_x] #X-Mot
uart_pin: PE8
#tx_pin: PE9
microsteps: 16
interpolate: True
run_current: 1.0
sense_resistor: 0.110
 # Place a jumper on the two pin header near the endstop for sensorless homing
diag_pin: PB14
driver_SGTHRS: 150
#TMC driver custom tuning for LDO Motor
driver_IHOLDDELAY: 8
driver_TPOWERDOWN: 20
driver_TBL: 2
driver_TOFF: 3
driver_HEND: 5
driver_HSTRT: 3
driver_PWM_AUTOGRAD: True
driver_PWM_AUTOSCALE: True
driver_PWM_LIM: 12
driver_PWM_REG: 8
driver_PWM_FREQ: 1
driver_PWM_GRAD: 14
driver_PWM_OFS: 36


[tmc2209 stepper_x1] #EXP-Mot 1
uart_pin: EXP1_6
microsteps: 16
interpolate: True
run_current: 1.0
sense_resistor: 0.110
# Place a jumper on the two pin header near the endstop for sensorless homing
diag_pin: EXP1_5
driver_SGTHRS: 150
# TMC driver custom tuning for LDO Motor
driver_IHOLDDELAY: 8
driver_TPOWERDOWN: 20
driver_TBL: 2
driver_TOFF: 3
driver_HEND: 5
driver_HSTRT: 3
driver_PWM_AUTOGRAD: True
driver_PWM_AUTOSCALE: True
driver_PWM_LIM: 12
driver_PWM_REG: 8
driver_PWM_FREQ: 1
driver_PWM_GRAD: 14
driver_PWM_OFS: 36

[tmc2209 stepper_y] #EXP-Mot 2
uart_pin: EXP1_4
microsteps: 16
interpolate: True
run_current: 1.0
sense_resistor: 0.110
# Place a jumper on the two pin header near the endstop for sensorless homing
diag_pin: EXP1_3
driver_SGTHRS: 150
# TMC driver custom tuning for LDO Motor
driver_IHOLDDELAY: 8
driver_TPOWERDOWN: 20
driver_TBL: 2
driver_TOFF: 3
driver_HEND: 5
driver_HSTRT: 3
driver_PWM_AUTOGRAD: True
driver_PWM_AUTOSCALE: True
driver_PWM_LIM: 12
driver_PWM_REG: 8
driver_PWM_FREQ: 1
driver_PWM_GRAD: 14
driver_PWM_OFS: 36

[tmc2209 stepper_y1] #EXP-Mot 3
uart_pin: EXP1_2
microsteps: 16
interpolate: True
run_current: 1.0
sense_resistor: 0.110
# Place a jumper on the two pin header near the endstop for sensorless homing
diag_pin: EXP1_1
driver_SGTHRS: 150
# TMC driver custom tuning for LDO Motor
driver_IHOLDDELAY: 8
driver_TPOWERDOWN: 20
driver_TBL: 2
driver_TOFF: 3
driver_HEND: 5
driver_HSTRT: 3
driver_PWM_AUTOGRAD: True
driver_PWM_AUTOSCALE: True
driver_PWM_LIM: 12
driver_PWM_REG: 8
driver_PWM_FREQ: 1
driver_PWM_GRAD: 14
driver_PWM_OFS: 36

[tmc2209 stepper_z] #E2
uart_pin: PE0
#tx_pin: PE1
microsteps: 4
interpolate: True
run_current: 0.9
sense_resistor: 0.110

[tmc2209 stepper_z1] #E1
uart_pin: PC5
#tx_pin: PC4
microsteps: 4
interpolate: True
run_current: 0.9
sense_resistor: 0.110

[tmc2209 stepper_z2] #E0
uart_pin: PA15
#tx_pin: PD3
microsteps: 4
interpolate: True
run_current: 0.9
sense_resistor: 0.110

[tmc2209 stepper_z3] #Z mot
uart_pin: PD12
#tx_pin: PD11
microsteps: 4
interpolate: True
run_current: 0.9
sense_resistor: 0.110


[tmc2209 extruder] #Y mot
uart_pin: PC4
#tx_pin: PE14
microsteps: 4
run_current: 0.3
hold_current: 0.3
sense_resistor: 0.110

# Force Move
#	used to force a single stepper to move.  not used once setup
[force_move]
enable_force_move: true

# Enable Pause/Resume Functionality
#[pause_resume]

# Probe
[probe]
# connected to Y+ Endstop on S6 -- must be a MAX port for enough voltage to compensate for drop and not be slow
pin: ^!PA2
x_offset: 21.3 # offset for microswitch x direction off nozzle
y_offset: 21.3 # offset for microswitch y direction off nozzle
z_offset: 9.00 # offset for microswitch in z height
samples: 3
sample_retract_dist: 5.0
samples_result: average
samples_tolerance: 0.075
samples_tolerance_retries: 3
speed: 10
lift_speed: 15
activate_gcode:
deactivate_gcode:

# Safe Z Home
# this allows you to home only z when the XY is already homed
[safe_z_home]
home_xy_position: 40,405 #Z endstop position (x,y)
speed: 200.00
z_hop: 20.0
z_hop_speed: 15.0
move_to_previous: False

# Mesh Bed Settings
[bed_mesh]
speed: 300
horizontal_move_z: 15
mesh_min: 25,25
mesh_max: 350,325
probe_count: 5,5
fade_start: 1
fade_end: 10
split_delta_z: .010
move_check_distance: 5.0
mesh_pps: 2,2
algorithm: bicubic
bicubic_tension: 0.10
relative_reference_index: 12  
# ^^^because were measuring the offset from the nozzle switch to the bed using the center of the bed, the equation to find the location = (probe point count)/2-1

# Ztilt settings, not QGL
[quad_gantry_level]
gantry_corners:
			 -65,-30
			 #-65,505
			 480,505
			 #480,-30
points: 25,25
		25,325
		350,325
		350, 25
speed: 300
max_adjust:6
horizontal_move_z: 20.0
retries: 5
retry_tolerance: 0.1

#	 Macros
#	macro to level the gantry.  use G32 in the terminal to call
[gcode_macro g32]
gcode:
		G28 Z
		M401
		BED_MESH_CLEAR
		QUAD_GANTRY_LEVEL
		G28 Z
		M402
	
#	Macro to Deploy Mesh Bed Leveling Probe
[gcode_macro M401]
gcode:
	G90                       ;absolute position
	G1 Z20 F1800              ;drop Z to Z20
	G1 X322.5 Y405 F12000        ;move toolhead to above probe dock
	G1 Z5.5 F600             ;lower z axis ontop of probe
	G1 X400 F1200             ;remove probe from dock
	G1 Z20 F1800              ;drop Z to Z20
	G1 X175 Y50 F12000         ;move toolhead to front center of bed


#	Macro to Stow Mesh Bed Leveling Probe
[gcode_macro M402]
gcode:
	G90                       ;absolute position
	G1 Z20 F1800              ;drop Z to Z20
	G1 X400 Y405 F12000        ;move toolhead near entrance of probe dock
	G1 Z5.5 F1800            ;lower z axis to match height of entrance to probe dock
	G1 X300 F1000             ;insert probe into dock
	G1 Z20 F1800              ;drop Z to Z20
	G1 X200 Y50 F12000         ;move toolhead to front center of bed


# #	macro to level bed to the gantry
[gcode_macro square_bed_to_machine]
gcode:
		G32

#	mesh bed level the machine
[gcode_macro mesh_bed_level_machine]
gcode:
		M401
		BED_MESH_CALIBRATE	;Run Bed Mesh
		G28 Z
		M402


#	Macro to execute when pausing printer
[gcode_macro print_pause]
gcode:
	PAUSE			#issue pause command
	M83				#relative extruder moves
	G1 E-5 F3600	#retract 5mm of filament
	G91 			#relative positioning
	G1 Z10 F3000 	#lift Z by 10mm
	G90				#absolute positioning

#	Macro to execute when resuming printer
[gcode_macro print_resume]
gcode:
	M83				#relative extruder moves
	G1 E5 F3600	#extrude 5mm of filament
	G91 			#relative positioning
	G1 Z-10 F3000 	#lower Z by 10mm
	G90				#absolute positioning
	RESUME			#move toolhead back to pause position

#	Macro to turn bed heater off during probing
[gcode_macro bed_off_probe]
variable_bed_temp: 0
gcode:

#	Macro to Babystep Up 0.01mm
[gcode_macro babystep_up3]
gcode:
	SET_GCODE_OFFSET Z_ADJUST=0.01 MOVE=1

#	Macro to Babystep Down 0.01mm
[gcode_macro babystep_down3]
gcode:
	SET_GCODE_OFFSET Z_ADJUST=-0.01 MOVE=1
	
#	Macro to Babystep Up 0.02mm
[gcode_macro babystep_up]
gcode:
	SET_GCODE_OFFSET Z_ADJUST=0.02 MOVE=1

#	Macro to Babystep Down 0.02mm
[gcode_macro babystep_down]
gcode:
	SET_GCODE_OFFSET Z_ADJUST=-0.02 MOVE=1
	
#	Macro to Babystep Up 0.05mm
[gcode_macro babystep_up2]
gcode:
	SET_GCODE_OFFSET Z_ADJUST=0.05 MOVE=1

#	Macro to Babystep Down 0.05mm
[gcode_macro babystep_down2]
gcode:
	SET_GCODE_OFFSET Z_ADJUST=-0.05 MOVE=1

# # Filament Switch Sensor.  
# #	support for filament insert and runout detection using a switch sensor, such as an endstop switch.
# [filament_switch_sensor my_sensor]
# pause_on_runout: True
# runout_gcode:
# 	M117 Runout Detected
# 	M600
# 	M400
# event_delay: 3.0
# pause_delay: 0.5
# # connected to Z- Endstop on S6 #1
# switch_pin: !PA0




# See the sample-lcd.cfg file for definitions of common LCD displays.

########################################
# RGB header
########################################

# See the example-extras.cfg file for more information.

#[output_pin blue]
#pin: PB7

#[output_pin red]
#pin: PB6

#[output_pin green]
#pin: PB5

########################################
# Servo
########################################

# See the example-extras.cfg file for more information.

#[servo my_servo1]
#pin: PA3  # shared with ZMAX

########################################
# AUX-3 / SPI header
########################################

# <CD>, <MOSI>, SS, <RESET>
# <5V>  , MISO  , SCK, <GND>

############################
##### CREATED BY KIAUH #####
############################
[virtual_sdcard]
path: ~/sdcard

