window.onload = function() {
    // suche in html dokument
    let h1 = document.querySelector("h1"); // hier funktionieren die selben selektoren wie in css, like
        // h1, #id, .class, main h1, main > h1, usw.
    console.log(h1);

    // querySelector nimmt das erste element den der selektor erfüllt, immer nur eines davon
    // querySelectorAll() selektiert alle Elemente und gibt eine NodeList zurück


    let p0 = document.querySelector("p");
    p0.textContent="Hello World";
    //p0.innerHTML="";
    h1.style.backgroundColor = "yellow";
    let p1 = document.querySelectorAll("p"); // selektiert alle die zutreffen, returned liste
    for (let p of p1) {
        p.style.backgroundColor = "yellow";
        // Klassen hinzufügen:
        p.classList.add("highlight", "border");
    }

    // es gibt auch getElementsById, getElementsByClassname usw aber der querySelector funktioniert allgemein so wie in css

    let m = document.querySelector("main");
    m.onclick = function() {
        alert("Hallo");
    }
    console.log(m.firstChild); // gibt ersten Textknoten! d.h. wenn hier nach dem main ein Zeilenumbruch kommt, bekommt man "\n     "
    console.log(m.firstElementChild); // gibt das erste kindELEMENT :)

    

}