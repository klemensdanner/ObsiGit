package swj3.gui;

import javafx.application.Application;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.geometry.Insets;
import javafx.geometry.Point2D;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.skin.TextInputControlSkin;
import javafx.scene.input.KeyEvent;
import javafx.scene.layout.*;
import javafx.stage.Stage;

public class ScribbleFX extends Application {

    private Button leftButton;
    private Button rightButton;
    private Button upButton;
    private Button downButton;
    private ColorPicker colorPicker;

    // Hier soll reagiert werden auf die buttons - geschrieben was gedrückt worden ist
    private ListView<String> messageList;
    private ObservableList<String> messages = FXCollections.observableArrayList();


    private ScribbleCanvas canvas;
    private final Preferences preferences = new Preferences();


    private ScribbleCanvas createCanvas() {
        final ScribbleCanvas canvas = new ScribbleCanvas(preferences);
        canvas.setId("canvas");
        VBox.setVgrow(canvas, Priority.ALWAYS); // wächst in die Höhe
        VBox.setMargin(canvas, new Insets(0,10,10,10)); // margin setzen


        canvas.setOnMouseClicked(event -> {
            Point2D p = new Point2D(event.getX(), event.getY());
            appendMessage("Mouse clicked at %s.".formatted(p));
            canvas.addLineSegment(p);
        });

        return canvas;
    }



    private ListView<String> createMessageList() {
        messageList = new ListView<>();
        messageList.setItems(messages);

        messageList.setId("message-list");
        HBox
                .setHgrow(messageList, Priority.ALWAYS); // messageList will get remaining space in
        // HBox.

        // styling:
        // messageList.setPrefHeight(190);
        // messageList.setBorder(DEFAULT_BORDER);

        return messageList;
    }




    private Pane createControlPane() {
        leftButton = createButton("left-button", "Left");
        rightButton = createButton("right-button", "Right");
        upButton = createButton("up-button", "Up");
        downButton = createButton("down-button", "Down");

        ButtonEventHandler handler = new ButtonEventHandler();
        leftButton.addEventHandler(ActionEvent.ACTION, handler);
        rightButton.addEventHandler(ActionEvent.ACTION, (event) -> ScribbleFX.this.handleButtonEvent(event));
        // gleichwertig mit:
        upButton.addEventHandler(ActionEvent.ACTION, this::handleButtonEvent);
        // gleichwertig mit:
        downButton.addEventHandler(ActionEvent.ACTION, new EventHandler<ActionEvent>() {
            @Override
            public void handle(ActionEvent event) {
                ScribbleFX.this.handleButtonEvent(event);
            }
        });


        final GridPane buttonPane = new GridPane();
        buttonPane.setId("button-pane");

        buttonPane.add(leftButton, 0, 1);
        buttonPane.add(upButton, 1, 0);
        buttonPane.add(rightButton, 2, 1);
        buttonPane.add(downButton, 1, 2);

        colorPicker = new ColorPicker();
        colorPicker.setOnAction(
                event -> appendMessage("Color '%s' selected".formatted(colorPicker.getValue()))
        );

        final HBox colorPane = new HBox(new Label("Color:"), colorPicker);
        colorPane.setId("color-pane");

        final VBox controlPane = new VBox(buttonPane, colorPane);
        return controlPane;
    }

    // variant 1
    @SuppressWarnings("unused")
    private Button createButton(String id, String caption) {
        Button button = new Button(caption);
        button.setId(id);

        button.setPadding(new Insets(5));
        button.setPrefSize(50, 40);

        return button;
    }

    // variant 2
    private Button createButton(String id) {
        Button button = new Button();
        button.setId(id);

        return button;
    }

    @Override
    public void start(Stage stage) throws Exception {
        final Pane controlPane = createControlPane();
        canvas = createCanvas();
        messageList = createMessageList();

        final HBox topPane = new HBox(controlPane, messageList);
        topPane.setId("top-pane");

        final VBox rootPane = new VBox(topPane, canvas);
        rootPane.setId("root-pane");
        rootPane.addEventFilter(KeyEvent.KEY_PRESSED, new KeyEventHandler());

        final Scene scene = new Scene(rootPane, 500, 500);

        stage.setScene(scene);
        stage.setTitle("ScribbleFX");
        stage.setMinWidth(400);
        stage.setMinHeight(400);


        scene.getStylesheets().add(getClass().getResource("css/scribble-fx.css").toExternalForm());

        stage.show();

    }


    public static void main(final String[] args) {
        Application.launch(args);
    }


    void appendMessage(String msg) {
        messages.add(msg);
        messageList.scrollTo(messages.size());
    }


    public void handleButtonEvent(ActionEvent event) {
        if (event.getTarget() instanceof Button button) {
            appendMessage("Button '%s' pressed.".formatted(button.getId()));

            switch (button.getId()) {
                case "up-button" -> canvas.addLineSegment(Direction.UP);
                case "left-button" -> canvas.addLineSegment(Direction.LEFT);
                case "right-button" -> canvas.addLineSegment(Direction.RIGHT);
                case "down-button" -> canvas.addLineSegment(Direction.DOWN);

            }
        }

    }


    private class ButtonEventHandler implements EventHandler<ActionEvent> {

        @Override
        public void handle(ActionEvent event) {
            ScribbleFX.this.handleButtonEvent(event); // this von der äußeren Instanz
        }
    }

    private class KeyEventHandler implements EventHandler<KeyEvent> {

        @Override
        public void handle(KeyEvent event) {
            appendMessage("Key '%s' pressed.".formatted(event.getCode()));
            boolean consume = true;
            switch (event.getCode()) {
                    case LEFT -> canvas.addLineSegment(Direction.LEFT);
                    case RIGHT -> canvas.addLineSegment(Direction.RIGHT);
                    case UP -> canvas.addLineSegment(Direction.UP);
                    case DOWN -> canvas.addLineSegment(Direction.DOWN);
                    default -> consume = false;
            }

            if (consume) {
                event.consume();
            }
        }
    }



//    private MenuBar createMenuBar(Stage stage) {
//        PreferencesDialog dialog = new PreferencesDialog(stage, preferences);
//        MenuItem item = new MenuItem("Preferences ...");
//        item.setOnAction(event -> dialog.show);
//
//        Menu menu = new Menu("Settings", null, item);
//        return new MenuBar(menu);
//    }

















}