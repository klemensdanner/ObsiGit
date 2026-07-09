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
    # Hardware
    # ============================================================
    left_motor = Motor(Port.A)
    right_motor = Motor(Port.D)

    left_sensor = LightSensor(Port.S4)      # NXT Light Sensor, physisch links
    right_sensor = ColorSensor(Port.S1)     # EV3 Color Sensor, physisch rechts
    ir_sensor = InfraredSensor(Port.S3)

    robot = DriveBase(
        left_motor,
        right_motor,
        wheel_diameter=56,
        axle_track=114
    )

    # ============================================================
    # TUNING-PARAMETER
    # ============================================================

    # ------------------------------------------------------------
    # 1. Geschwindigkeit
    # ------------------------------------------------------------
    BASE_SPEED = 190
    # Vorher: 175 mm/s.
    # Etwas schneller auf freier Flaeche.
    # Sinnvoller Bereich: 175 bis 210.

    RECOVER_SPEED = 155
    # Nach einer Korrektur kurze, kontrollierte Geradeausfahrt.
    # Vorher: 130 mm/s.

    RECOVER_DISTANCE = 8
    # Vorher: 14 mm.
    # Der Roboter kehrt schneller zu BASE_SPEED zurueck.

    # ------------------------------------------------------------
    # 2. Sanfte Korrektur
    # ------------------------------------------------------------
    GENTLE_TURN_RATE = 95
    # Pivot am Stand: speed = 0, nur Drehung.
    # Sinnvoller Bereich: 80 bis 110 Grad/s.

    GENTLE_MIN_ANGLE = 2
    # Eine leichte Kurve darf sehr frueh beendet werden.

    GENTLE_ESCALATE_ANGLE = 5
    # Bleibt der ausloesende Sensor nach 5 Grad Schwarz,
    # wird auf STRONG eskaliert.

    GENTLE_PERSIST_CYCLES = 6
    # Bleibt Schwarz ueber mehrere Messungen bestehen,
    # ist die Situation vermutlich keine leichte Kurve.

    DEEP_BLACK_LEVEL = 0.76
    # Ein einzelner tiefer Schwarzkontakt eskaliert nicht sofort,
    # weil auch eine normale Begrenzung voll getroffen werden kann.
    # Bleibt er jedoch bestehen, wird schnell auf STRONG gewechselt.

    DEEP_BLACK_PERSIST_CYCLES = 3

    DARKENING_STEP = 1
    DARKENING_CONFIRM_CYCLES = 2
    # Wird der ausloesende Sensor wiederholt dunkler, wird eskaliert.

    # ------------------------------------------------------------
    # 3. Erkennung einer Linie fast direkt voraus
    # ------------------------------------------------------------
    # Ein direkter Kontakt wird nicht nur ueber "beide Sensoren Schwarz"
    # erkannt. Es reicht auch, wenn beide Sensoren deutlich dunkler werden
    # und mindestens einer davon stark dunkel ist.
    HEAD_ON_BOTH_MIN_LEVEL = 0.28
    HEAD_ON_ONE_STRONG_LEVEL = 0.60

    # ------------------------------------------------------------
    # 4. Starke Korrektur
    # ------------------------------------------------------------
    STRONG_TURN_RATE = 215
    # Schneller Pivot am Stand.
    # Sinnvoller Bereich: 190 bis 240 Grad/s.

    STRONG_HEAD_ON_MIN_ANGLE = 28
    # Fuer eine Linie fast direkt voraus wird bewusst deutlich gedreht.
    # Weiss allein darf diese Korrektur vorher nicht beenden.

    STRONG_DEEP_MIN_ANGLE = 11
    # Mindestwinkel bei anhaltend tiefem Schwarz / dunkler werdendem Sensor.

    STRONG_ESCALATED_MIN_ANGLE = 9
    # Mindestwinkel, wenn eine sanfte Korrektur wegen Persistenz eskaliert.

    STRONG_RECHECK_MIN_ANGLE = 8
    # Taucht direkt nach einer starken Korrektur wieder Schwarz auf,
    # wird ohne erneute sanfte Probe nochmals deutlich korrigiert.

    STRONG_NO_TRANSITION_MIN_ANGLE = 34
    # Bei einem direkten Kontakt sollte waehrend der Drehung normalerweise
    # kurz genau EIN Sensor Schwarz sehen. Falls dieser Uebergang nicht
    # beobachtet wurde, wird Weiss erst nach diesem Winkel akzeptiert.

    STRONG_MAX_ANGLE = 100
    # Harte Sicherheitsobergrenze.

    # ------------------------------------------------------------
    # 5. Ende einer Korrektur
    # ------------------------------------------------------------
    GENTLE_WHITE_CONFIRM_CYCLES = 2
    # Leichte Kurven: frueh und effizient beenden.

    STRONG_WHITE_CONFIRM_CYCLES = 3
    # Scharfe Situationen: Weiss etwas strenger bestaetigen.

    # ------------------------------------------------------------
    # 6. Feste Schwarzwerte
    # ------------------------------------------------------------
    LEFT_BLACK_VALUE = 50
    RIGHT_BLACK_VALUE = 20

    # ------------------------------------------------------------
    # 7. Dynamische Erkennungsschwellen
    # ------------------------------------------------------------
    DETECT_FRACTION = 0.40
    # Vorher: 0.35.
    # Hoeher = fruehere Erkennung in Richtung Weiss.
    #
    # Beispiel bei Weiss L=70 / R=50:
    #   links:  50 + 20*0.40 = 58
    #   rechts: 20 + 30*0.40 = 32

    GENTLE_SAFE_WHITE_FRACTION = 0.50
    # Leichte Korrektur darf relativ frueh enden.

    STRONG_SAFE_WHITE_FRACTION = 0.65
    # Eine starke Korrektur verlangt deutlich hellere Messwerte,
    # bevor das Ende akzeptiert wird.

    # ------------------------------------------------------------
    # 8. Lenkrichtung
    # ------------------------------------------------------------
    TURN_SIGN = -1
    # Dreht der Roboter zur Linie statt von ihr weg:
    # TURN_SIGN auf +1 setzen.

    DEFAULT_BOTH_BLACK_DIRECTION = -1

    # ------------------------------------------------------------
    # 9. Standard-Weisswerte
    # ------------------------------------------------------------
    DEFAULT_WHITE_LEFT = 70
    DEFAULT_WHITE_RIGHT = 50

    # ------------------------------------------------------------
    # 10. Tischkante
    # ------------------------------------------------------------
    DROP_THRESHOLD = 15
    EDGE_CONFIRM_COUNT = 2

    # ------------------------------------------------------------
    # 11. Regelzyklus und Anzeige
    # ------------------------------------------------------------
    LOOP_WAIT_MS = 3
    # Vorher: 5 ms.
    # Weniger kuenstliche Wartezeit zwischen Messungen.

    ENABLE_LIVE_DISPLAY = False
    # Fuer die finale Fahrt deaktiviert, weil Display-Zeichnen den
    # Regelzyklus unregelmaessig verlangsamen kann.
    # Fuer Debugging auf True setzen.

    DISPLAY_INTERVAL = 60

    # ============================================================
    # Hilfsfunktionen
    # ============================================================
    def wait_center():
        while Button.CENTER not in ev3.buttons.pressed():
            wait(10)

        while Button.CENTER in ev3.buttons.pressed():
            wait(10)

    def measure_white(samples=30):
        for _ in range(5):
            left_sensor.reflection()
            right_sensor.reflection()
            wait(10)

        sum_left = 0
        sum_right = 0

        for _ in range(samples):
            sum_left += left_sensor.reflection()
            sum_right += right_sensor.reflection()
            wait(10)

        return sum_left / samples, sum_right / samples

    def clamp(value, minimum, maximum):
        if value < minimum:
            return minimum

        if value > maximum:
            return maximum

        return value

    def calculate_threshold(black_value, white_value, fraction):
        """
        Grenzwert zwischen festem Schwarz und kalibriertem Weiss.

        fraction = 0.0 -> Schwarz
        fraction = 1.0 -> Weiss
        """
        span = white_value - black_value

        if span < 1:
            span = 1

        return black_value + span * fraction

    def darkness_level(reflection, white_value, black_value):
        """
        Normalisierte Dunkelheit:
            0.0 = kalibriertes Weiss
            1.0 = festes Schwarz
        """
        span = white_value - black_value

        if span < 1:
            span = 1

        return clamp(
            (white_value - reflection) / span,
            0.0,
            1.5
        )

    def choose_direction(
        left_black,
        right_black,
        left_darkness,
        right_darkness,
        previous_direction
    ):
        """
        Richtung vor TURN_SIGN:
            -1 = linke Begrenzung erkannt
            +1 = rechte Begrenzung erkannt
        """
        if left_black and not right_black:
            return -1

        if right_black and not left_black:
            return 1

        difference = left_darkness - right_darkness

        if difference > 0.05:
            return -1

        if difference < -0.05:
            return 1

        if previous_direction != 0:
            return previous_direction

        return DEFAULT_BOTH_BLACK_DIRECTION

    def reset_state_measurement():
        return robot.angle(), robot.distance()

    # ============================================================
    # Weiss-Kalibrierung
    # ============================================================
    # Schwarz bleibt fix: links 50, rechts 20.
    white_left = DEFAULT_WHITE_LEFT
    white_right = DEFAULT_WHITE_RIGHT

    ev3.screen.clear()
    ev3.screen.draw_text(0, 0, "Weiss kalibrieren?")
    ev3.screen.draw_text(0, 25, "MITTE = ja")
    ev3.screen.draw_text(0, 50, "UNTEN = Defaults")

    calibrate_white = False

    while True:
        pressed = ev3.buttons.pressed()

        if Button.CENTER in pressed:
            calibrate_white = True
            break

        if Button.DOWN in pressed:
            calibrate_white = False
            break

        wait(10)

    while ev3.buttons.pressed():
        wait(10)

    if calibrate_white:
        ev3.screen.clear()
        ev3.screen.draw_text(0, 0, "Auf WEISS stellen")
        ev3.screen.draw_text(0, 25, "MITTE = messen")
        wait_center()

        white_left, white_right = measure_white()

    if white_left <= LEFT_BLACK_VALUE:
        white_left = LEFT_BLACK_VALUE + 1

    if white_right <= RIGHT_BLACK_VALUE:
        white_right = RIGHT_BLACK_VALUE + 1

    # Schwellen erst NACH der Weiss-Kalibrierung berechnen.
    left_line_threshold = calculate_threshold(
        LEFT_BLACK_VALUE,
        white_left,
        DETECT_FRACTION
    )

    right_line_threshold = calculate_threshold(
        RIGHT_BLACK_VALUE,
        white_right,
        DETECT_FRACTION
    )

    left_gentle_white_threshold = calculate_threshold(
        LEFT_BLACK_VALUE,
        white_left,
        GENTLE_SAFE_WHITE_FRACTION
    )

    right_gentle_white_threshold = calculate_threshold(
        RIGHT_BLACK_VALUE,
        white_right,
        GENTLE_SAFE_WHITE_FRACTION
    )

    left_strong_white_threshold = calculate_threshold(
        LEFT_BLACK_VALUE,
        white_left,
        STRONG_SAFE_WHITE_FRACTION
    )

    right_strong_white_threshold = calculate_threshold(
        RIGHT_BLACK_VALUE,
        white_right,
        STRONG_SAFE_WHITE_FRACTION
    )

    ev3.screen.clear()
    ev3.screen.draw_text(
        0,
        0,
        "Weiss L:{} R:{}".format(
            int(white_left),
            int(white_right)
        )
    )
    ev3.screen.draw_text(
        0,
        24,
        "Trigger L:{} R:{}".format(
            int(left_line_threshold),
            int(right_line_threshold)
        )
    )
    ev3.screen.draw_text(
        0,
        48,
        "GentW L:{} R:{}".format(
            int(left_gentle_white_threshold),
            int(right_gentle_white_threshold)
        )
    )
    ev3.screen.draw_text(
        0,
        72,
        "StrW L:{} R:{}".format(
            int(left_strong_white_threshold),
            int(right_strong_white_threshold)
        )
    )
    ev3.screen.draw_text(0, 105, "MITTE = weiter")
    wait_center()

    # ============================================================
    # Start
    # ============================================================
    ev3.screen.clear()
    ev3.screen.draw_text(0, 0, "Adaptive Pivot V2")
    ev3.screen.draw_text(
        0,
        22,
        "Speed:{}".format(BASE_SPEED)
    )
    ev3.screen.draw_text(
        0,
        44,
        "Gentle:{}".format(GENTLE_TURN_RATE)
    )
    ev3.screen.draw_text(
        0,
        66,
        "Strong:{}".format(STRONG_TURN_RATE)
    )
    ev3.screen.draw_text(
        0,
        88,
        "HeadMin:{}".format(STRONG_HEAD_ON_MIN_ANGLE)
    )
    ev3.screen.draw_text(0, 110, "MITTE = Start")
    wait_center()

    # ============================================================
    # Zustaende
    # ============================================================
    STRAIGHT = "STRAIGHT"
    GENTLE = "GENTLE"
    STRONG = "STRONG"
    RECOVER = "RECOVER"

    state = STRAIGHT

    correction_dir = 0
    last_correction_dir = 0

    state_start_angle, state_start_distance = reset_state_measurement()
    state_angle = 0.0
    state_distance = 0.0

    white_counter = 0
    gentle_cycle_counter = 0
    deep_black_counter = 0
    darkening_counter = 0
    previous_trigger_reflection = 0

    strong_required_angle = STRONG_ESCALATED_MIN_ANGLE
    strong_saw_single_black = False

    recovery_from_strong = False

    previous_ir_distance = ir_sensor.distance()
    edge_counter = 0
    display_counter = 0

    current_speed = 0
    turn_rate = 0

    # ============================================================
    # Hauptschleife
    # ============================================================
    while True:
        # --------------------------------------------------------
        # Sensorwerte
        # --------------------------------------------------------
        left_reflection = left_sensor.reflection()
        right_reflection = right_sensor.reflection()
        current_ir_distance = ir_sensor.distance()

        left_darkness = darkness_level(
            left_reflection,
            white_left,
            LEFT_BLACK_VALUE
        )

        right_darkness = darkness_level(
            right_reflection,
            white_right,
            RIGHT_BLACK_VALUE
        )

        left_sees_line = (
            left_reflection <= left_line_threshold
        )

        right_sees_line = (
            right_reflection <= right_line_threshold
        )

        sees_line = left_sees_line or right_sees_line
        both_see_line = left_sees_line and right_sees_line
        exactly_one_sees_line = (
            left_sees_line != right_sees_line
        )

        left_gentle_white = (
            left_reflection > left_gentle_white_threshold
        )

        right_gentle_white = (
            right_reflection > right_gentle_white_threshold
        )

        both_gentle_white = (
            left_gentle_white and right_gentle_white
        )

        left_strong_white = (
            left_reflection > left_strong_white_threshold
        )

        right_strong_white = (
            right_reflection > right_strong_white_threshold
        )

        both_strong_white = (
            left_strong_white and right_strong_white
        )

        maximum_darkness = max(
            left_darkness,
            right_darkness
        )

        minimum_darkness = min(
            left_darkness,
            right_darkness
        )

        deep_black = (
            maximum_darkness >= DEEP_BLACK_LEVEL
        )

        head_on_contact = (
            both_see_line
            or (
                minimum_darkness >= HEAD_ON_BOTH_MIN_LEVEL
                and maximum_darkness >= HEAD_ON_ONE_STRONG_LEVEL
            )
        )

        # --------------------------------------------------------
        # Tischkante
        # --------------------------------------------------------
        distance_change = (
            current_ir_distance - previous_ir_distance
        )

        if distance_change > DROP_THRESHOLD:
            edge_counter += 1
        else:
            edge_counter = 0

        if edge_counter >= EDGE_CONFIRM_COUNT:
            robot.stop()
            ev3.screen.clear()
            ev3.screen.draw_text(0, 30, "TABLE EDGE!")
            ev3.screen.draw_text(0, 60, "SYSTEM ABORT")
            ev3.speaker.beep(
                frequency=500,
                duration=1000
            )
            break

        previous_ir_distance = current_ir_distance

        state_angle = abs(
            robot.angle() - state_start_angle
        )

        state_distance = abs(
            robot.distance() - state_start_distance
        )

        # ========================================================
        # STRAIGHT
        # ========================================================
        if state == STRAIGHT:
            if sees_line:
                correction_dir = choose_direction(
                    left_sees_line,
                    right_sees_line,
                    left_darkness,
                    right_darkness,
                    last_correction_dir
                )

                last_correction_dir = correction_dir

                white_counter = 0
                gentle_cycle_counter = 0
                deep_black_counter = 0
                darkening_counter = 0

                if head_on_contact:
                    # Kein separater BRAKE-Zustand:
                    # Noch im selben Regeldurchlauf wird speed=0 und
                    # STRONG_TURN_RATE ausgegeben.
                    state = STRONG
                    strong_required_angle = STRONG_HEAD_ON_MIN_ANGLE
                    strong_saw_single_black = exactly_one_sees_line
                    recovery_from_strong = False
                else:
                    state = GENTLE

                    if correction_dir == -1:
                        previous_trigger_reflection = left_reflection
                    else:
                        previous_trigger_reflection = right_reflection

                state_start_angle, state_start_distance = (
                    reset_state_measurement()
                )

        # ========================================================
        # GENTLE
        # ========================================================
        elif state == GENTLE:
            gentle_cycle_counter += 1

            if correction_dir == -1:
                trigger_black = left_sees_line
                opposite_black = right_sees_line
                trigger_reflection = left_reflection
                opposite_darkness = right_darkness
            else:
                trigger_black = right_sees_line
                opposite_black = left_sees_line
                trigger_reflection = right_reflection
                opposite_darkness = left_darkness

            reflection_change = (
                trigger_reflection - previous_trigger_reflection
            )

            if reflection_change <= -DARKENING_STEP:
                darkening_counter += 1
            elif reflection_change > 0:
                darkening_counter = 0

            previous_trigger_reflection = trigger_reflection

            if deep_black and trigger_black:
                deep_black_counter += 1
            else:
                deep_black_counter = 0

            escalate_head_on = (
                head_on_contact
                or opposite_black
                or opposite_darkness >= HEAD_ON_BOTH_MIN_LEVEL
            )

            escalate_deep = (
                deep_black_counter >= DEEP_BLACK_PERSIST_CYCLES
                or darkening_counter >= DARKENING_CONFIRM_CYCLES
            )

            escalate_persistent = (
                trigger_black
                and (
                    state_angle >= GENTLE_ESCALATE_ANGLE
                    or gentle_cycle_counter >= GENTLE_PERSIST_CYCLES
                )
            )

            if (
                escalate_head_on
                or escalate_deep
                or escalate_persistent
            ):
                state = STRONG
                white_counter = 0
                strong_saw_single_black = exactly_one_sees_line

                if escalate_head_on:
                    strong_required_angle = STRONG_HEAD_ON_MIN_ANGLE
                elif escalate_deep:
                    strong_required_angle = STRONG_DEEP_MIN_ANGLE
                else:
                    strong_required_angle = STRONG_ESCALATED_MIN_ANGLE

                recovery_from_strong = False

                state_start_angle, state_start_distance = (
                    reset_state_measurement()
                )

            else:
                # Leichte Kurve:
                # Nach minimaler Drehung sofort beenden, sobald normales
                # sicheres Weiss stabil erreicht wurde.
                if (
                    state_angle >= GENTLE_MIN_ANGLE
                    and both_gentle_white
                ):
                    white_counter += 1
                else:
                    white_counter = 0

                if (
                    white_counter
                    >= GENTLE_WHITE_CONFIRM_CYCLES
                ):
                    state = RECOVER
                    recovery_from_strong = False
                    white_counter = 0

                    state_start_angle, state_start_distance = (
                        reset_state_measurement()
                    )

        # ========================================================
        # STRONG
        # ========================================================
        elif state == STRONG:
            # Ein beobachteter Uebergang von "beide Schwarz" zu
            # "genau einer Schwarz" ist ein gutes Indiz, dass die Linie
            # tatsaechlich seitlich verlassen wird.
            if exactly_one_sees_line:
                strong_saw_single_black = True

            credible_exit = (
                strong_saw_single_black
                or state_angle >= STRONG_NO_TRANSITION_MIN_ANGLE
            )

            can_release_strong = (
                state_angle >= strong_required_angle
                and both_strong_white
                and credible_exit
            )

            if can_release_strong:
                white_counter += 1
            else:
                white_counter = 0

            if (
                white_counter
                >= STRONG_WHITE_CONFIRM_CYCLES
            ):
                state = RECOVER
                recovery_from_strong = True
                white_counter = 0

                state_start_angle, state_start_distance = (
                    reset_state_measurement()
                )

            elif state_angle >= STRONG_MAX_ANGLE:
                # Sicherheitsausstieg.
                state = RECOVER
                recovery_from_strong = True
                white_counter = 0

                state_start_angle, state_start_distance = (
                    reset_state_measurement()
                )

        # ========================================================
        # RECOVER
        # ========================================================
        elif state == RECOVER:
            if sees_line:
                correction_dir = choose_direction(
                    left_sees_line,
                    right_sees_line,
                    left_darkness,
                    right_darkness,
                    last_correction_dir
                )

                last_correction_dir = correction_dir
                white_counter = 0
                gentle_cycle_counter = 0
                deep_black_counter = 0
                darkening_counter = 0

                # Wenn unmittelbar nach einer starken Korrektur erneut
                # Schwarz auftaucht, war der Roboter noch nicht sicher.
                # Dann keine erneute sanfte Probe verschwenden.
                if recovery_from_strong:
                    state = STRONG

                    if head_on_contact:
                        strong_required_angle = (
                            STRONG_HEAD_ON_MIN_ANGLE
                        )
                    else:
                        strong_required_angle = (
                            STRONG_RECHECK_MIN_ANGLE
                        )

                    strong_saw_single_black = (
                        exactly_one_sees_line
                    )

                elif head_on_contact:
                    state = STRONG
                    strong_required_angle = (
                        STRONG_HEAD_ON_MIN_ANGLE
                    )
                    strong_saw_single_black = (
                        exactly_one_sees_line
                    )

                else:
                    state = GENTLE

                    if correction_dir == -1:
                        previous_trigger_reflection = (
                            left_reflection
                        )
                    else:
                        previous_trigger_reflection = (
                            right_reflection
                        )

                state_start_angle, state_start_distance = (
                    reset_state_measurement()
                )

            elif state_distance >= RECOVER_DISTANCE:
                state = STRAIGHT
                recovery_from_strong = False

                state_start_angle, state_start_distance = (
                    reset_state_measurement()
                )

        # ========================================================
        # Fahrbefehl
        # ========================================================
        if state == STRAIGHT:
            current_speed = BASE_SPEED
            turn_rate = 0

        elif state == GENTLE:
            # Sofort keine Vorwaertsbewegung mehr.
            current_speed = 0
            turn_rate = (
                GENTLE_TURN_RATE * correction_dir
            )

        elif state == STRONG:
            # Starker Pivot ebenfalls am Stand.
            current_speed = 0
            turn_rate = (
                STRONG_TURN_RATE * correction_dir
            )

        else:  # RECOVER
            current_speed = RECOVER_SPEED
            turn_rate = 0

        robot.drive(
            current_speed,
            TURN_SIGN * turn_rate
        )

        # ========================================================
        # Optionale Live-Anzeige
        # ========================================================
        display_counter += 1

        if (
            ENABLE_LIVE_DISPLAY
            and display_counter >= DISPLAY_INTERVAL
        ):
            display_counter = 0
            ev3.screen.clear()

            ev3.screen.draw_text(0, 0, state)

            ev3.screen.draw_text(
                0,
                18,
                "L:{} R:{}".format(
                    left_reflection,
                    right_reflection
                )
            )

            ev3.screen.draw_text(
                0,
                36,
                "DL:{} DR:{}".format(
                    int(left_darkness * 100),
                    int(right_darkness * 100)
                )
            )

            ev3.screen.draw_text(
                0,
                54,
                "Spd:{} Trn:{}".format(
                    int(current_speed),
                    int(turn_rate)
                )
            )

            ev3.screen.draw_text(
                0,
                72,
                "Ang:{} Req:{}".format(
                    int(state_angle),
                    int(strong_required_angle)
                )
            )

            ev3.screen.draw_text(
                0,
                90,
                "W:{} One:{}".format(
                    white_counter,
                    1 if strong_saw_single_black else 0
                )
            )

            ev3.screen.draw_text(
                0,
                108,
                "IR:{} Edg:{}".format(
                    current_ir_distance,
                    edge_counter
                )
            )

        wait(LOOP_WAIT_MS)

except Exception as e:
    try:
        robot.stop()
    except NameError:
        pass

    ev3.screen.clear()
    ev3.screen.draw_text(0, 0, "FATAL ERROR:")
    ev3.screen.draw_text(0, 20, str(e))
    print("Exception caught:", e)
    wait(15000)