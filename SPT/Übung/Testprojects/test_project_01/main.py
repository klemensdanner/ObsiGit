#!/usr/bin/env pybricks-micropython

# NEU: Wir importieren zusätzlich den LightSensor
from pybricks.ev3devices import Motor, ColorSensor, LightSensor
from pybricks.parameters import Port, Color
from pybricks.robotics import DriveBase
from pybricks.tools import wait

linker_motor = Motor(Port.D)
rechter_motor = Motor(Port.A)

roboter = DriveBase(linker_motor, rechter_motor, wheel_diameter=55.5, axle_track=104)

# Rechter Sensor (Farbe) an Port 1
#farbsensor_rechts = ColorSensor(Port.S1)

# NEU: Linker Sensor (NXT Helligkeitssensor) an Port 4
# helligkeitssensor_links = LightSensor(Port.S4)

#WEISS_SCHWELLE = 80 

while True:
    roboter.drive(200, 0)
    
    #farbe_rechts = farbsensor_rechts.color()
    # helligkeit_links = helligkeitssensor_links.reflection()
    
    if farbe_rechts == Color.WHITE:
        roboter.stop()
        roboter.turn(-90)
        wait(500)


        # or helligkeit_links >= WEISS_SCHWELLE: