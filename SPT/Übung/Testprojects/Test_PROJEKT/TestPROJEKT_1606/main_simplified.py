#!/usr/bin/env pybricks-micropython
from pybricks.hubs import EV3Brick
from pybricks.ev3devices import Motor, ColorSensor, InfraredSensor
from pybricks.nxtdevices import LightSensor
from pybricks.parameters import Port, Button
from pybricks.robotics import DriveBase
from pybricks.tools import wait

ev3 = EV3Brick()

try:
    # ============================================================
    # Hardware-Initialisierung
    # ============================================================
    left_motor   = Motor(Port.A)
    right_motor  = Motor(Port.D)
    left_sensor  = LightSensor(Port.S4)    # NXT Light  -> links
    right_sensor = ColorSensor(Port.S1)    # EV3 Color  -> rechts
    ir_sensor    = InfraredSensor(Port.S3)
    
    robot = DriveBase(left_motor, right_motor, wheel_diameter=56, axle_track=114)

    # ============================================================
    # Parameter & Grenzwerte (basierend auf Ihren Messungen)
    # ============================================================
    # Links (NXT): Boden ca. 50-60, Schwarz ca. 25-40
    LEFT_THRESHOLD = 50  # Wert darunter gilt als Schwarz
    
    # Rechts (EV3): Boden ca. 35-50, Schwarz ca. 5-15
    RIGHT_THRESHOLD = 25 # Wert darunter gilt als Schwarz

    # --- Fahrgeschwindigkeiten ---
    DRIVE_SPEED = 250    # Normale Geschwindigkeit auf hellem Boden (mm/s)
    TURN_SPEED  = -30     # Sehr langsame Vorwärtsbewegung beim Drehen gegen Überschießen
    TURN_RATE   = 220    # Rotationsgeschwindigkeit beim Abbiegen (deg/s) - hoch für schnelle Reaktion


    
    
    # --- Parameter für die Rückwärts-Ausweichkurve ---
    BACKWARD_SPEED     = -180   # Deutlich spürbares Rückwärtstempo (mm/s)
    BACKWARD_TURN_RATE = 220   # Moderate Drehrate für eine schöne Kurve (deg/s)
    BACKWARD_TIME      = 190   # Dauer der Ausweichkurve in Millisekunden







    # --- Motor-Ausrichtung ---
    # Falls der Roboter zur Linie hin lenkt statt weg, diesen Wert auf -1 setzen.
    STEERING_MULTIPLIER = 1 

    # --- Tischkanten-Abbruch ---
    DROP_THRESHOLD     = 15
    EDGE_CONFIRM_COUNT = 2

    # ============================================================
    # Start-Schnittstelle
    # ============================================================
    ev3.screen.clear()
    ev3.screen.draw_text(0,  0, "Bereit.")
    ev3.screen.draw_text(0, 30, "Mitte druecken")
    
    while Button.CENTER not in ev3.buttons.pressed():
        wait(10)
    while Button.CENTER in ev3.buttons.pressed():
        wait(10)

    # ============================================================
    # Hauptschleife
    # ============================================================
    previous_ir_distance = ir_sensor.distance()
    edge_counter = 0
    display_counter = 0

    ev3.screen.clear()

    while True:
        # Sensoren auslesen
        left_val  = left_sensor.reflection()
        right_val = right_sensor.reflection()
        current_ir_distance = ir_sensor.distance()

        # --- Tischkanten-Erkennung (Sicherheit) ---
        distance_change = current_ir_distance - previous_ir_distance
        if distance_change > DROP_THRESHOLD:
            edge_counter += 1
        else:
            edge_counter = 0

        if edge_counter >= EDGE_CONFIRM_COUNT:
            robot.stop()
            ev3.screen.clear()
            ev3.screen.draw_text(0, 30, "KANTE ERKANNT!")
            break

        previous_ir_distance = current_ir_distance

        # --- Linien-Erkennung (Zustände) ---
        left_sees_black  = left_val < LEFT_THRESHOLD
        right_sees_black = right_val < RIGHT_THRESHOLD

        if left_sees_black and right_sees_black:
            # Beide Sensoren auf Schwarz -> Einfach geradeaus zurücksetzen
            current_state = "Beide Schwarz"
            #robot.drive(BACKWARD_SPEED, 0)
            robot.drive(BACKWARD_SPEED, BACKWARD_TURN_RATE * STEERING_MULTIPLIER)
            wait(BACKWARD_TIME)
            
        elif left_sees_black:
            # Links Schwarz -> Kurve nach HINTEN-LINKS fahren 
            # (Nase schwenkt nach rechts weg)
            current_state = "Bogen Hinten-Links"
            robot.drive(BACKWARD_SPEED, BACKWARD_TURN_RATE * STEERING_MULTIPLIER)
            wait(BACKWARD_TIME)
            
        elif right_sees_black:
            # Rechts Schwarz -> Kurve nach HINTEN-RECHTS fahren 
            # (Nase schwenkt nach links weg)
            current_state = "Bogen Hinten-Rechts"
            robot.drive(BACKWARD_SPEED, -BACKWARD_TURN_RATE * STEERING_MULTIPLIER)
            wait(BACKWARD_TIME)
            
        else:
            # Beide im hellen Bereich -> Geradeaus fahren
            current_state = "Geradeaus"
            robot.drive(DRIVE_SPEED, 0)

        # --- Einfaches Debug-Display ---
        display_counter += 1
        if display_counter >= 15:
            display_counter = 0
            ev3.screen.clear()
            ev3.screen.draw_text(0,  0, "Modus: " + current_state)
            ev3.screen.draw_text(0, 25, "L (NXT): {}".format(left_val))
            ev3.screen.draw_text(0, 50, "R (EV3): {}".format(right_val))
            ev3.screen.draw_text(0, 75, "IR-Abst: {}".format(current_ir_distance))

        wait(10)

except Exception as e:
    try:
        robot.stop()
    except NameError:
        pass
    ev3.screen.clear()
    ev3.screen.draw_text(0,  0, "Fehler:")
    ev3.screen.draw_text(0, 20, str(e))
    print("Fehler aufgetreten:", e)
    wait(10000)