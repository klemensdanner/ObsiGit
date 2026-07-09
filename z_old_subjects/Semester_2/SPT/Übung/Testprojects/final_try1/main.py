#!/usr/bin/env pybricks-micropython
from pybricks.hubs import EV3Brick
from pybricks.ev3devices import Motor, ColorSensor, InfraredSensor
from pybricks.nxtdevices import LightSensor
from pybricks.parameters import Port
from pybricks.robotics import DriveBase
from pybricks.tools import wait

ev3 = EV3Brick()

try:
    # 1. Hardware Initialization
    left_motor = Motor(Port.A)
    right_motor = Motor(Port.D)
    left_sensor = ColorSensor(Port.S1)
    right_sensor = LightSensor(Port.S4)
    ir_sensor = InfraredSensor(Port.S3) 
    
    robot = DriveBase(left_motor, right_motor, wheel_diameter=56, axle_track=114)
    
    # ==========================================
    # --- TWEAKABLE PARAMETERS ---
    # ==========================================
    
    BASE_SPEED = 150  
    FAST_SPEED = 250

    # Optimiert für schärferes Abprallen von der Linie:
    CAUTIOUS_SPEED = 10  
    TURN_RATE = 70       
    
    # Toleranz für die Schatten-Erkennung (z.B. unter der Brücke)
    SHADOW_TOLERANCE = 12 
    
    # ==========================================

    EV3_BLACK_THRESHOLD = 8  
    NXT_BLACK_THRESHOLD = 15 
    
    EV3_RAMP_THRESHOLD = 40
    NXT_RAMP_THRESHOLD = 50

    DROP_THRESHOLD = 15 # Schwellenwert für die Delta-Erkennung (Tischkante)

    # 2. State Initialization
    current_state = "Initializing"
    ev3.screen.clear()
    ev3.screen.print(current_state)
    
    # Initiale Distanzmessung für die spätere Delta-Berechnung
    previous_ir_distance = ir_sensor.distance() 

    # 3. Main Execution Loop
    while True:
        left_reflection = left_sensor.reflection()
        right_reflection = right_sensor.reflection()
        
        # Rampenerkennung: Beide Sensoren messen einen Wert im definierten "Graubereich"
        on_ramp = (EV3_BLACK_THRESHOLD <= left_reflection < EV3_RAMP_THRESHOLD) and \
                  (NXT_BLACK_THRESHOLD <= right_reflection < NXT_RAMP_THRESHOLD)

        # ==========================================
        # --- Drop Detection Logic (Höchste Priorität) ---
        # ==========================================
        current_ir_distance = ir_sensor.distance()
        distance_change = current_ir_distance - previous_ir_distance
        
        # Tischkante erkannt
        if distance_change > DROP_THRESHOLD:
            robot.stop() 
            
            # Spezifische Logik: Drop auf der Rampe = Ziellinie
            if on_ramp:
                ev3.screen.clear()
                ev3.screen.print("FINISH LINE REACHED")
                ev3.speaker.beep(frequency=1000, duration=1000)
                break 
            
            # Reguläre Tischkante = Notabschaltung (Full Stop & Abort)
            else:
                ev3.screen.clear()
                ev3.screen.print("TABLE EDGE DETECTED")
                ev3.screen.print("SYSTEM ABORT")
                ev3.speaker.beep(frequency=500, duration=1000)
                break # Bricht die while True-Schleife sofort ab
            
        previous_ir_distance = current_ir_distance
        # ==========================================

        # --- Binary Line Tracking Logic & Shadow Rejection ---
        left_sees_line = left_reflection < EV3_BLACK_THRESHOLD
        right_sees_line = right_reflection < NXT_BLACK_THRESHOLD
        
        # Kontrastprüfung: Ein Schatten dunkelt beide Seiten gleichmäßig ab (geringe Differenz)
        is_shadow = abs(left_reflection - right_reflection) <= SHADOW_TOLERANCE
        
        new_state = ""
        current_speed = FAST_SPEED if on_ramp else BASE_SPEED
        
        # Priorität 1: Querlinie oder Ende der Strecke erreicht (beide Sensoren sehen Schwarz)
        if left_sees_line and right_sees_line:
            new_state = "HALT: Both Lines"
            robot.stop()
            
        # Priorität 2: Brücken-Schatten erkannt -> Verdunkelung ignorieren und Spur halten
        elif is_shadow and (left_reflection < 40 or right_reflection < 40):
            new_state = "Shadow (Ignored)"
            robot.drive(current_speed, 0)
            
        # Priorität 3: Linker Sensor sieht Begrenzung -> Drastisch abbremsen und nach rechts ausweichen
        elif left_sees_line and not right_sees_line:
            new_state = "Cautious Right"
            robot.drive(CAUTIOUS_SPEED, -TURN_RATE)
            
        # Priorität 4: Rechter Sensor sieht Begrenzung -> Drastisch abbremsen und nach links ausweichen
        elif right_sees_line and not left_sees_line:
            new_state = "Cautious Left"
            robot.drive(CAUTIOUS_SPEED, TURN_RATE)
            
        # Priorität 5: Keine Linie in Sicht -> Roboter ist sicher in der Spur
        else:
            new_state = "Driving Fast (Ramp)" if on_ramp else "Driving Straight"
            robot.drive(current_speed, 0)
            
        # --- Screen Update Optimization ---
        if new_state != current_state:
            ev3.screen.clear()
            ev3.screen.print("State:")
            ev3.screen.print(new_state)
            ev3.screen.print("L:", left_reflection, " R:", right_reflection)
            current_state = new_state
            
        wait(10)

except Exception as e:
    # 4. Error Handling
    try:
        robot.stop()
    except NameError:
        pass 
        
    ev3.screen.clear()
    ev3.screen.print("FATAL ERROR:")
    ev3.screen.print(e)
    print("Exception caught:", e)
    wait(15000)