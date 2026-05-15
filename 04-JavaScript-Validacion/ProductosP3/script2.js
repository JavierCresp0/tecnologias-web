
var total = 0;

function addToCart(btn) {

    // buscar el contenedor del producto
    var cont = btn.closest('.producto, .productoPrem');

    // nombre
    var nombreEl = (cont.getElementsByClassName && cont.getElementsByClassName('Nombre')[0]);
    var productoSeleccionadoNombre =  nombreEl.textContent.trim() ;

    // precio
    var precioEl = cont.querySelector('.precio .precio-nuevo') || cont.querySelector('p');

    var productoSeleccionadoPrecio = precioEl.textContent.trim();

    // limpiar y convertir a número 
    productoSeleccionadoPrecio = Number(productoSeleccionadoPrecio.replace('$', '') .replace(',', '.')) ;

    // actualizar total acumulado
    total = total + productoSeleccionadoPrecio;

    var cuerpoTabla = document.getElementById("cuerpoTabla");

    // añadir la fila 
    cuerpoTabla.innerHTML += "<tr><td>" + productoSeleccionadoNombre + "</td><td>" + productoSeleccionadoPrecio + "</td></tr>";

    // actualizar total 
    document.getElementById("total").innerText = total;
}
