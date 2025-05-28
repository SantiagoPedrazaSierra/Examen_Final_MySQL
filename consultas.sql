-- ===============================================
-- 📊 CONSULTAS SQL PARA EL SISTEMA DE PIZZERÍA
-- ===============================================

-- 1. Productos más vendidos (por categoría)
-- Muestra la cantidad total de productos vendidos agrupados por su categoría.
SELECT p.categoria, SUM(pp.cantidad) AS total_vendidos
FROM ProductoPedido pp
JOIN Producto p ON pp.Producto_id = p.id
GROUP BY p.categoria
ORDER BY total_vendidos DESC;

-- 2. Total de ingresos generados por cada combo
-- Multiplica la cantidad vendida de cada combo por su precio.
SELECT c.nombre, SUM(cp.cantidad * c.precio) AS total_ingresos
FROM ComboPedidos cp
JOIN Combo c ON cp.Combo_id = c.id
GROUP BY c.nombre;

-- 3. Pedidos realizados para recoger vs. comer en la pizzería
-- Muestra el número de pedidos por modalidad (mesa o domicilio).
SELECT modalidadPedido, COUNT(*) AS total_pedidos
FROM Pedido
GROUP BY modalidadPedido;

-- 4. Adiciones más solicitadas en pedidos personalizados
-- Lista las adiciones más solicitadas con su cantidad total.
SELECT a.nombre, SUM(ap.cantidad) AS total_solicitudes
FROM AdicionalesPedido ap
JOIN Adicionales a ON ap.Adicionales_id1 = a.id
GROUP BY a.nombre
ORDER BY total_solicitudes DESC;

-- 5. Cantidad total de productos vendidos por categoría
-- Suma de todos los productos vendidos, agrupados por categoría.
SELECT p.categoria, SUM(pp.cantidad) AS total_vendidos
FROM ProductoPedido pp
JOIN Producto p ON pp.Producto_id = p.id
GROUP BY p.categoria;

-- 6. Promedio de pizzas pedidas por cliente
-- Calcula el promedio de pizzas pedidas por cliente.
SELECT AVG(pizza_count) AS promedio_pizzas
FROM (
  SELECT Cliente_id, SUM(pp.cantidad) AS pizza_count
  FROM Pedido pe
  JOIN ProductoPedido pp ON pe.id = pp.Pedido_id
  JOIN Producto p ON pp.Producto_id = p.id
  WHERE p.categoria = 'pizza'
  GROUP BY Cliente_id
) AS sub;

-- 7. Total de ventas por día de la semana
-- Muestra la cantidad de pedidos por día de la semana.
SELECT DAYNAME(fecha) AS dia, COUNT(*) AS total_ventas
FROM Pedido
GROUP BY dia
ORDER BY FIELD(dia, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

-- 8. Cantidad de panzarottis vendidos con extra queso
-- Cuenta panzarottis que se vendieron junto con adiciones que incluyan "queso".
SELECT SUM(pp.cantidad) AS total_panzarottis_con_queso
FROM ProductoPedido pp
JOIN Producto p ON pp.Producto_id = p.id
JOIN Pedido pe ON pe.id = pp.Pedido_id
JOIN AdicionalesPedido ap ON pe.id = ap.Pedido_id
JOIN Adicionales a ON ap.Adicionales_id1 = a.id
WHERE p.categoria = 'panzarotti' AND a.nombre LIKE '%queso%';

-- 9. Pedidos que incluyen bebidas como parte de un combo
-- Cuenta los pedidos que tienen productos de categoría bebida dentro de un combo.
SELECT COUNT(DISTINCT cp.Pedido_id) AS total_pedidos_con_bebida_en_combo
FROM ComboPedidos cp
JOIN CombosProductos cpr ON cp.Combo_id = cpr.Combo_id
JOIN Producto p ON cpr.Producto_id = p.id
WHERE p.categoria = 'bebidas';

-- 10. Clientes que han realizado más de 5 pedidos en el último mes
-- Lista los clientes más frecuentes en los últimos 30 días.
SELECT c.nombre, COUNT(*) AS total_pedidos
FROM Pedido p
JOIN Cliente c ON p.Cliente_id = c.id
WHERE p.fecha >= NOW() - INTERVAL 1 MONTH
GROUP BY c.id
HAVING total_pedidos > 5;

-- 11. Ingresos totales generados por productos no elaborados
-- Suma de ingresos por productos como bebidas o postres.
SELECT SUM(pp.cantidad * CAST(p.precio AS UNSIGNED)) AS total_ingresos
FROM ProductoPedido pp
JOIN Producto p ON pp.Producto_id = p.id
WHERE p.elaborado = 'no';

-- 12. Promedio de adiciones por pedido
-- Calcula el promedio de adiciones por cada pedido.
SELECT AVG(adiciones) AS promedio_adiciones
FROM (
  SELECT Pedido_id, SUM(cantidad) AS adiciones
  FROM AdicionalesPedido
  GROUP BY Pedido_id
) AS sub;

-- 13. Total de combos vendidos en el último mes
-- Suma de la cantidad de combos vendidos en los últimos 30 días.
SELECT SUM(cantidad) AS total_combos
FROM ComboPedidos
WHERE Pedido_id IN (
  SELECT id FROM Pedido WHERE fecha >= NOW() - INTERVAL 1 MONTH
);

-- 14. Clientes con pedidos tanto para recoger como para consumir en el lugar
-- Muestra los clientes que han hecho pedidos en ambas modalidades.
SELECT Cliente_id
FROM Pedido
GROUP BY Cliente_id
HAVING COUNT(DISTINCT modalidadPedido) = 2;

-- 15. Total de productos personalizados con adiciones
-- Cuenta la cantidad de pedidos que incluyeron adiciones.
SELECT COUNT(DISTINCT Pedido_id) AS pedidos_personalizados
FROM AdicionalesPedido;

-- 16. Pedidos con más de 3 productos diferentes
-- Lista los IDs de pedidos que tienen más de 3 tipos distintos de productos.
SELECT Pedido_id
FROM ProductoPedido
GROUP BY Pedido_id
HAVING COUNT(DISTINCT Producto_id) > 3;

-- 17. Promedio de ingresos generados por día
-- Calcula el ingreso total diario y saca el promedio.
SELECT AVG(ingresos_diarios) AS promedio_diario
FROM (
  SELECT DATE(p.fecha) AS dia, 
         SUM(COALESCE(pp.cantidad * CAST(pr.precio AS UNSIGNED), 0) + 
             COALESCE(cp.cantidad * c.precio, 0)) AS ingresos_diarios
  FROM Pedido p
  LEFT JOIN ProductoPedido pp ON p.id = pp.Pedido_id
  LEFT JOIN Producto pr ON pp.Producto_id = pr.id
  LEFT JOIN ComboPedidos cp ON p.id = cp.Pedido_id
  LEFT JOIN Combo c ON cp.Combo_id = c.id
  GROUP BY dia
) AS sub;

-- 18. Clientes que han pedido pizzas con adiciones en más del 50% de sus pedidos
-- Detecta clientes que piden pizzas con adiciones frecuentemente.
SELECT Cliente_id
FROM Pedido p
JOIN ProductoPedido pp ON p.id = pp.Pedido_id
JOIN Producto pr ON pp.Producto_id = pr.id
JOIN AdicionalesPedido ap ON p.id = ap.Pedido_id
WHERE pr.categoria = 'pizza'
GROUP BY Cliente_id
HAVING COUNT(DISTINCT p.id) > 
       (SELECT COUNT(*) FROM Pedido WHERE Cliente_id = p.Cliente_id) / 2;

-- 19. Porcentaje de ventas provenientes de productos no elaborados
-- Relación de ingresos entre productos no elaborados y el total de productos vendidos.
SELECT 
  ROUND(
    (SELECT SUM(pp.cantidad * CAST(p.precio AS UNSIGNED))
     FROM ProductoPedido pp
     JOIN Producto p ON pp.Producto_id = p.id
     WHERE p.elaborado = 'no') * 100 / 
    (SELECT SUM(pp.cantidad * CAST(p.precio AS UNSIGNED))
     FROM ProductoPedido pp
     JOIN Producto p ON pp.Producto_id = p.id), 2) AS porcentaje_no_elaborados;

-- 20. Día de la semana con mayor número de pedidos para recoger
-- Devuelve el día con más pedidos con modalidad "domicilio".
SELECT DAYNAME(fecha) AS dia, COUNT(*) AS total
FROM Pedido
WHERE modalidadPedido = 'domicilio'
GROUP BY dia
ORDER BY total DESC
LIMIT 1;
