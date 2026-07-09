#!/usr/bin/env pybricks-micropython

from pybricks.hubs import EV3Brick
from pybricks.ev3devices import Motor, ColorSensor
from pybricks.nxtdevices import LightSensor
from pybricks.parameters import Port, Button
from pybricks.robotics import DriveBase
from pybricks.tools import wait, StopWatch


# ================================================================
# Hardware
# ================================================================

ev3 = EV3Brick()

left_motor = Motor(Port.A)
right_motor = Motor(Port.D)

# Physische Sensorpositionen:
#   NXT-Lichtsensor = links
#   EV3-Farbsensor  = rechts
left_sensor = LightSensor(Port.S4)
right_sensor = ColorSensor(Port.S1)

robot = DriveBase(
    left_motor,
    right_motor,
    wheel_diameter=56,
    axle_track=114,
)


# ================================================================
# 1. MESS- UND KALIBRIERWERTE
#
# Alle Werte, die durch Messungen oder Streckentests entstehen,
# stehen bewusst gesammelt am Anfang des Programms.
# ================================================================

# Feste Schwarzwerte. Diese werden beim Start NICHT neu gemessen.
# Werte aus den bisherigen Messungen:
#   links / NXT = ungefähr 30 auf Schwarz
#   rechts / EV3 = ungefähr 15 auf Schwarz
LEFT_BLACK_VALUE = 50.0
RIGHT_BLACK_VALUE = 20.0

# Ersatz-Weißwerte, falls die Kalibrierung mit UNTEN übersprungen wird.
# Nach verlässlichen Testmessungen bei Bedarf hier aktualisieren.
DEFAULT_LEFT_WHITE = 65.0
DEFAULT_RIGHT_WHITE = 46.0

# Einstellungen für die Weißmessung.
WHITE_WARMUP_SAMPLES = 5
WHITE_MEASUREMENT_SAMPLES = 30
WHITE_SAMPLE_WAIT_MS = 10

# Mindestabstand zwischen Weiß- und Schwarzwert.
# Bei einem kleineren Abstand wird die Kalibrierung abgebrochen.
MIN_CALIBRATION_RANGE = 8.0


# ================================================================
# 2. LINIENERKENNUNG
#
# Beide Sensoren werden auf dieselbe Dunkelheitsskala normiert:
#   0.0 = kalibriertes Weiß
#   1.0 = fester Schwarzwert
#
# LINE_TRIGGER startet eine Korrektur.
# LINE_RELEASE liegt bewusst niedriger und beendet die Erkennung
# erst wieder bei deutlich hellerem Untergrund. Das ist Hysterese.
# ================================================================

LINE_TRIGGER = 0.40
LINE_RELEASE = 0.18

# Anzahl sicherer Weißmessungen in Folge, bevor die starke
# Fluchtphase beendet werden darf.
RELEASE_CONFIRM_SAMPLES = 3

# Falls beide Sensoren gleichzeitig auslösen, gilt eine Seite erst
# ab dieser Differenz als eindeutig dunkler.
BOTH_SENSOR_MARGIN = 0.08


# ================================================================
# 3. FAHRVERHALTEN
#
# Bei robot.drive(speed, turn_rate) gilt:
#   positiver turn_rate = Rechtskurve
#   negativer turn_rate = Linkskurve
# ================================================================

# Normales Geradeausfahren zwischen den Linien.
CRUISE_SPEED = 145                 # mm/s

# Phase 1: starke Flucht von der Linie.
# Niedrige Vorwärtsgeschwindigkeit und hohe Drehrate ergeben fast
# eine Drehung auf der Stelle und reduzieren das Überfahren.
ESCAPE_SPEED = 40                  # mm/s
ESCAPE_TURN_RATE = 260             # Grad/s

# Die Fluchtphase endet frühestens nach diesem Winkel UND nachdem
# der auslösende Sensor wieder sicher Weiß sieht.
ESCAPE_MIN_ANGLE = 30              # Grad

# Sicherheitsgrenze. Ist der Sensor danach noch immer nicht frei,
# wird gestoppt statt endlos weiterzudrehen.
ESCAPE_MAX_ANGLE = 80              # Grad

# Phase 2: sanfte Nachkorrektur in dieselbe Richtung.
RECOVERY_SPEED = 85                # mm/s
RECOVERY_TURN_RATE = 115           # Grad/s
RECOVERY_ANGLE = 12                # zusätzliche Grad

# Zeitlicher Failsafe für eine Fluchtphase, etwa bei blockierten Rädern.
MAX_ESCAPE_TIME_MS = 2000


# ================================================================
# 4. SCHLEIFE UND DEBUGGING
# ================================================================

LOOP_WAIT_MS = 8

# Displayausgaben verlangsamen die Regelschleife deutlich.
# Für normale Testfahrten daher False lassen.
ENABLE_LIVE_DISPLAY = False
DISPLAY_INTERVAL = 25


# ================================================================
# Zustände und Seiten
# ================================================================

CRUISE = 0
ESCAPE_LEFT = 1
ESCAPE_RIGHT = 2
RECOVER_LEFT = 3
RECOVER_RIGHT = 4

NO_SIDE = 0
LEFT_SIDE = -1
RIGHT_SIDE = 1


# ================================================================
# Hilfsfunktionen
# ================================================================

def wait_for_center():
    """Wartet auf einen vollständigen Druck der mittleren Taste."""

    while Button.CENTER not in ev3.buttons.pressed():
        wait(10)

    while Button.CENTER in ev3.buttons.pressed():
        wait(10)


def clamp(value, minimum, maximum):
    """Begrenzt value auf den Bereich minimum bis maximum."""

    if value < minimum:
        return minimum

    if value > maximum:
        return maximum

    return value


def measure_white():
    """
    Misst beide Sensoren auf Weiß und gibt deren Mittelwerte zurück.

    Der Roboter muss dabei in normaler Fahrposition stehen. Die
    Sensorhöhe darf während der Messung nicht verändert werden.
    """

    # Erste Werte verwerfen, damit Sensoren und LEDs stabil sind.
    for _ in range(WHITE_WARMUP_SAMPLES):
        left_sensor.reflection()
        right_sensor.reflection()
        wait(WHITE_SAMPLE_WAIT_MS)

    left_sum = 0
    right_sum = 0

    for _ in range(WHITE_MEASUREMENT_SAMPLES):
        left_sum += left_sensor.reflection()
        right_sum += right_sensor.reflection()
        wait(WHITE_SAMPLE_WAIT_MS)

    left_average = left_sum / WHITE_MEASUREMENT_SAMPLES
    right_average = right_sum / WHITE_MEASUREMENT_SAMPLES

    return left_average, right_average


def normalized_darkness(reflection, white_value, black_value):
    """
    Wandelt einen Rohwert in eine gemeinsame Dunkelheitsskala um.

    Ergebnis:
        0.0 = kalibriertes Weiß oder heller
        1.0 = fester Schwarzwert oder dunkler

    Dadurch können NXT- und EV3-Sensor trotz unterschiedlicher
    Rohwertbereiche gleich behandelt werden.
    """

    measurement_range = white_value - black_value

    if measurement_range < MIN_CALIBRATION_RANGE:
        raise ValueError("Sensor calibration range too small")

    darkness = (white_value - reflection) / measurement_range

    return clamp(darkness, 0.0, 1.0)


def state_name(state):
    """Kurzer Zustandsname für die optionale Debug-Anzeige."""

    if state == CRUISE:
        return "CRUISE"
    if state == ESCAPE_LEFT:
        return "ESC LEFT"
    if state == ESCAPE_RIGHT:
        return "ESC RIGHT"
    if state == RECOVER_LEFT:
        return "REC LEFT"
    if state == RECOVER_RIGHT:
        return "REC RIGHT"

    return "UNKNOWN"


def choose_trigger_side(left_dark, right_dark, last_side):
    """
    Entscheidet, welche Linie vermieden werden soll.

    Rückgabewerte:
        NO_SIDE    = keine Linie
        LEFT_SIDE  = linke Linie vermeiden
        RIGHT_SIDE = rechte Linie vermeiden

    Falls beide Sensoren gleichzeitig auslösen, wird zuerst die
    deutlich dunklere Seite gewählt. Sind beide fast gleich, wird
    die zuletzt vermiedene Seite verwendet. Ohne Historie wird
    standardmäßig die linke Linie vermieden.
    """

    left_triggered = left_dark >= LINE_TRIGGER
    right_triggered = right_dark >= LINE_TRIGGER

    if not left_triggered and not right_triggered:
        return NO_SIDE

    if left_triggered and not right_triggered:
        return LEFT_SIDE

    if right_triggered and not left_triggered:
        return RIGHT_SIDE

    # Beide Sensoren erkennen gleichzeitig starke Dunkelheit.
    if left_dark > right_dark + BOTH_SENSOR_MARGIN:
        return LEFT_SIDE

    if right_dark > left_dark + BOTH_SENSOR_MARGIN:
        return RIGHT_SIDE

    if last_side != NO_SIDE:
        return last_side

    return LEFT_SIDE


def escape_state_for_side(side):
    """Liefert den passenden starken Fluchtzustand."""

    if side == LEFT_SIDE:
        return ESCAPE_LEFT

    return ESCAPE_RIGHT


def recovery_state_for_side(side):
    """Liefert den passenden sanften Erholungszustand."""

    if side == LEFT_SIDE:
        return RECOVER_LEFT

    return RECOVER_RIGHT


def side_for_state(state):
    """Liefert die zur Korrektur gehörende Linienseite."""

    if state == ESCAPE_LEFT or state == RECOVER_LEFT:
        return LEFT_SIDE

    if state == ESCAPE_RIGHT or state == RECOVER_RIGHT:
        return RIGHT_SIDE

    return NO_SIDE


def turn_rate_away_from(side, magnitude):
    """
    Liefert die Drehrate weg von der angegebenen Linie.

    Linke Linie  -> nach rechts -> positive Drehrate
    Rechte Linie -> nach links  -> negative Drehrate
    """

    if side == LEFT_SIDE:
        return magnitude

    return -magnitude


# ================================================================
# Hauptprogramm
# ================================================================

try:
    # ------------------------------------------------------------
    # Weißkalibrierung
    # ------------------------------------------------------------

    ev3.screen.clear()
    ev3.screen.draw_text(0, 0, "Weiss kalibrieren?")
    ev3.screen.draw_text(0, 25, "MITTE = messen")
    ev3.screen.draw_text(0, 50, "UNTEN = Defaults")

    calibrate_white = True

    while True:
        pressed = ev3.buttons.pressed()

        if Button.CENTER in pressed:
            calibrate_white = True
            break

        if Button.DOWN in pressed:
            calibrate_white = False
            break

        wait(10)

    # Taste vollständig loslassen.
    while ev3.buttons.pressed():
        wait(10)

    if calibrate_white:
        ev3.screen.clear()
        ev3.screen.draw_text(0, 0, "Beide auf WEISS")
        ev3.screen.draw_text(0, 25, "in Fahrhoehe")
        ev3.screen.draw_text(0, 50, "MITTE = messen")

        wait_for_center()

        left_white, right_white = measure_white()
    else:
        left_white = DEFAULT_LEFT_WHITE
        right_white = DEFAULT_RIGHT_WHITE

    # Kalibrierung gegen die festen Schwarzwerte prüfen.
    if left_white - LEFT_BLACK_VALUE < MIN_CALIBRATION_RANGE:
        raise ValueError("Left white/black range invalid")

    if right_white - RIGHT_BLACK_VALUE < MIN_CALIBRATION_RANGE:
        raise ValueError("Right white/black range invalid")

    # Verwendete Messwerte anzeigen.
    ev3.screen.clear()
    ev3.screen.draw_text(
        0,
        0,
        "White L:{} R:{}".format(
            int(left_white),
            int(right_white),
        ),
    )
    ev3.screen.draw_text(
        0,
        25,
        "Black L:{} R:{}".format(
            int(LEFT_BLACK_VALUE),
            int(RIGHT_BLACK_VALUE),
        ),
    )
    ev3.screen.draw_text(0, 55, "MITTE = Start")

    wait_for_center()

    # ------------------------------------------------------------
    # Laufzeitvariablen
    # ------------------------------------------------------------

    state = CRUISE
    last_side = NO_SIDE

    # Winkel beim Beginn der aktuellen Phase.
    phase_start_angle = robot.angle()

    clock = StopWatch()
    escape_start_time = clock.time()

    release_counter = 0
    display_counter = 0

    current_speed = 0
    current_turn_rate = 0

    # ------------------------------------------------------------
    # Regelschleife
    # ------------------------------------------------------------

    while True:
        # Manueller Not-Aus mit der UNTEN-Taste.
        if Button.DOWN in ev3.buttons.pressed():
            robot.stop()

            ev3.screen.clear()
            ev3.screen.draw_text(0, 40, "MANUAL STOP")
            break

        # Sensoren genau einmal pro Schleife lesen.
        left_reflection = left_sensor.reflection()
        right_reflection = right_sensor.reflection()

        left_dark = normalized_darkness(
            left_reflection,
            left_white,
            LEFT_BLACK_VALUE,
        )

        right_dark = normalized_darkness(
            right_reflection,
            right_white,
            RIGHT_BLACK_VALUE,
        )

        current_angle = robot.angle()
        angle_in_phase = abs(current_angle - phase_start_angle)

        # ========================================================
        # Geradeausfahrt
        # ========================================================

        if state == CRUISE:
            current_speed = CRUISE_SPEED
            current_turn_rate = 0

            triggered_side = choose_trigger_side(
                left_dark,
                right_dark,
                last_side,
            )

            if triggered_side != NO_SIDE:
                # Eine Linie wurde erkannt. Die starke Korrektur wird
                # ab jetzt verriegelt und nicht beim ersten Weißwert
                # wieder beendet.
                state = escape_state_for_side(triggered_side)
                last_side = triggered_side
                phase_start_angle = current_angle
                escape_start_time = clock.time()
                release_counter = 0

                current_speed = ESCAPE_SPEED
                current_turn_rate = turn_rate_away_from(
                    triggered_side,
                    ESCAPE_TURN_RATE,
                )

        # ========================================================
        # Starke Fluchtphase
        # ========================================================

        elif state == ESCAPE_LEFT or state == ESCAPE_RIGHT:
            active_side = side_for_state(state)

            current_speed = ESCAPE_SPEED
            current_turn_rate = turn_rate_away_from(
                active_side,
                ESCAPE_TURN_RATE,
            )

            # Nur der Sensor, der die Korrektur ausgelöst hat,
            # entscheidet über das sichere Verlassen der Linie.
            if active_side == LEFT_SIDE:
                active_darkness = left_dark
            else:
                active_darkness = right_dark

            if active_darkness <= LINE_RELEASE:
                release_counter += 1
            else:
                release_counter = 0

            # Die Korrektur darf erst enden, wenn sowohl der
            # Mindestwinkel als auch mehrere sichere Weißmessungen
            # erreicht wurden.
            if (
                angle_in_phase >= ESCAPE_MIN_ANGLE
                and release_counter >= RELEASE_CONFIRM_SAMPLES
            ):
                state = recovery_state_for_side(active_side)
                phase_start_angle = current_angle
                release_counter = 0

                current_speed = RECOVERY_SPEED
                current_turn_rate = turn_rate_away_from(
                    active_side,
                    RECOVERY_TURN_RATE,
                )

            # Ist nach dem maximalen Winkel noch immer keine sichere
            # Freigabe erfolgt, stoppen wir kontrolliert.
            elif (
                angle_in_phase >= ESCAPE_MAX_ANGLE
                and active_darkness > LINE_RELEASE
            ):
                robot.stop()
                raise RuntimeError("Line not released")

            elif clock.time() - escape_start_time >= MAX_ESCAPE_TIME_MS:
                robot.stop()
                raise RuntimeError("Escape timeout")

        # ========================================================
        # Sanfte Erholungsphase
        # ========================================================

        elif state == RECOVER_LEFT or state == RECOVER_RIGHT:
            active_side = side_for_state(state)

            current_speed = RECOVERY_SPEED
            current_turn_rate = turn_rate_away_from(
                active_side,
                RECOVERY_TURN_RATE,
            )

            # Während der Erholung haben neue Linienereignisse
            # Vorrang. Dadurch kann auch in einem engen Korridor
            # sofort auf die gegenüberliegende Linie reagiert werden.
            triggered_side = choose_trigger_side(
                left_dark,
                right_dark,
                last_side,
            )

            if triggered_side != NO_SIDE:
                state = escape_state_for_side(triggered_side)
                last_side = triggered_side
                phase_start_angle = current_angle
                escape_start_time = clock.time()
                release_counter = 0

                current_speed = ESCAPE_SPEED
                current_turn_rate = turn_rate_away_from(
                    triggered_side,
                    ESCAPE_TURN_RATE,
                )

            elif angle_in_phase >= RECOVERY_ANGLE:
                state = CRUISE
                phase_start_angle = current_angle

                current_speed = CRUISE_SPEED
                current_turn_rate = 0

        # Fahrbefehl für diese Schleife ausführen.
        robot.drive(
            current_speed,
            current_turn_rate,
        )

        # --------------------------------------------------------
        # Optionale Live-Anzeige
        # --------------------------------------------------------

        if ENABLE_LIVE_DISPLAY:
            display_counter += 1

            if display_counter >= DISPLAY_INTERVAL:
                display_counter = 0

                ev3.screen.clear()
                ev3.screen.draw_text(0, 0, state_name(state))
                ev3.screen.draw_text(
                    0,
                    20,
                    "Raw L:{} R:{}".format(
                        left_reflection,
                        right_reflection,
                    ),
                )
                ev3.screen.draw_text(
                    0,
                    40,
                    "Dark L:{} R:{}".format(
                        int(left_dark * 100),
                        int(right_dark * 100),
                    ),
                )
                ev3.screen.draw_text(
                    0,
                    60,
                    "Angle:{}".format(
                        int(angle_in_phase),
                    ),
                )
                ev3.screen.draw_text(
                    0,
                    80,
                    "Spd:{} Trn:{}".format(
                        int(current_speed),
                        int(current_turn_rate),
                    ),
                )
                ev3.screen.draw_text(
                    0,
                    100,
                    "Release:{}".format(
                        release_counter,
                    ),
                )

        wait(LOOP_WAIT_MS)


# ================================================================
# Fehlerbehandlung
# ================================================================

except Exception as error:
    try:
        robot.stop()
    except Exception:
        pass

    ev3.screen.clear()
    ev3.screen.draw_text(0, 0, "FATAL ERROR")
    ev3.screen.draw_text(0, 25, str(error))

    print("Exception caught:", error)

    ev3.speaker.beep(
        frequency=400,
        duration=800,
    )

    wait(15000)