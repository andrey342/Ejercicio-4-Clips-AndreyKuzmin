
(defglobal ?*maxCajas* = 3)

(deffacts reglas
    ; robot tiene 0 naranjas 0 0 0 y si esta lleno de cajas 0 o 1 para dejar las cajas en la lineaPedidos y otro 0 para num de cajas
	(robot 0 0 0 0 0 0)
    (pedido 0 0 0 0)
	(lineaPedidos 0 0 0 0)
	(paletNaranjas 4)
	(paletManzanas 4)
	(paletCaquis 4)
	(paletUvas 4)
	
)

(defrule coger_naranjas

    (robot ?naranjas ?manzanas ?caquis ?uvas ?sobrecarga ?numCajas)
    (paletNaranjas ?numNaranjas)
    (pedido ?naranjasPedido ?manzanasPedido ?caquisPedido ?uvasPedido)

    (test (= ?sobrecarga 0))
    (test (<> ?naranjas naranjasPedido) )
    (test (> ?numNaranjas 0))
    (test (< ?numCajas ?*maxCajas*))
    =>
    (assert (robot (+ ?naranjas 1) 0 0 0 0 (+ ?numCajas 1)))
    (assert (paletNaranjas (- ?numNaranjas 1)))
)
(defrule coger_manzanas

    (robot ?naranjas ?manzanas ?caquis ?uvas ?sobrecarga ?numCajas)
    (paletManzanas ?numManzanas)
    (pedido ?naranjasPedido ?manzanasPedido ?caquisPedido ?uvasPedido)

    (test (= ?sobrecarga 0))
    (test (<> ?manzanas manzanasPedido) )
    (test (> ?numManzanas 0))
    =>
    (assert (robot 0 (+ ?manzanas 1) 0 0 0 (+ ?numCajas 1)))
    (assert (paletManzanas (- ?numManzanas 1)))
)

(defrule comprobar_sobrecarga
    (robot ?naranjas ?manzanas ?caquis ?uvas ?sobrecarga ?numCajas)


)


(defrule llevar_linea_pedidos
    (robot ?naranjas ?manzanas ?caquis ?uvas ?sobrecarga ?numCajas)
    (test(> ?sobrecarga 0))
    =>
    (assert (lineaPedidos (+ ?naranjasNew ?naranjas) (+ ?manzanasNew ?manzanas) (+ ?caquisNew ?caquis) (+ ?uvasNew ?uvas) ) )
    (assert (robot 0 0 0 0 0 0))
)