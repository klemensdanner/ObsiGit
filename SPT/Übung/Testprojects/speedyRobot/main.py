# --- TWEAKABLE PARAMETERS FÜR SPEED ---
MAX_SPEED = 400       # Vollgas auf der Geraden
DRIVE_SPEED = 200     # Geschwindigkeit während der Korrektur
TURN_RATE = 250       # Sehr aggressiver Lenkwinkel
# --------------------------------------

while True:
    left_reflection = left_sensor.reflection()
    right_reflection = right_sensor.reflection()
    
    # 1. NOT-AUS / TISCHKANTE (Höchste Priorität)
  #  current_ir_distance = ir_sensor.distance()
  #  if (current_ir_distance - previous_ir_distance) > DROP_THRESHOLD:
  #      robot.stop()
   #     break
    #previous_ir_distance = current_ir_distance

    current_ir_distance = ir_sensor.distance()
    if (current_ir_distance > DROP_THRESHOLD):
        robot.stop()
        break

    # 2. LOGIK: Linien-Erkennung
    left_sees_line = left_reflection < EV3_BLACK_THRESHOLD
    right_sees_line = right_reflection < NXT_BLACK_THRESHOLD

    if left_sees_line:
        # LINKS die Linie berührt -> Sofort hart nach RECHTS korrigieren
        # Wir bleiben in dieser Schleife, bis der Sensor wieder weiß sieht
        # Das verhindert das "Überfahren" der Linie
        while left_sensor.reflection() < (EV3_BLACK_THRESHOLD + 5): # +5 für Puffer
            robot.drive(DRIVE_SPEED / 2, TURN_RATE) # Langsamer vorwärts, schnell drehen
            wait(5)
        
    elif right_sees_line:
        # RECHTS die Linie berührt -> Sofort hart nach LINKS korrigieren
        while right_sensor.reflection() < (NXT_BLACK_THRESHOLD + 5):
            robot.drive(DRIVE_SPEED / 2, -TURN_RATE)
            wait(5)

    else:
        # BEIDE SENSOREN WEISS -> VOLLGAS
        # Hier liegt der Zeitgewinn: Wenn keine Gefahr, dann Max Speed
        robot.drive(MAX_SPEED, 0)

    wait(10)