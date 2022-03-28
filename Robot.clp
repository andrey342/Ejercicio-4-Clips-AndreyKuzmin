
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

    ; comprobar que no hay sobrecarga , que las se recogen las naranjas que te piden , que el numero de cajas no se acabe y
    ; que el numero de cajas que puede llevar sea menor al permitido
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
    (test (< ?numCajas ?*maxCajas*))
    =>
    (assert (robot 0 (+ ?manzanas 1) 0 0 0 (+ ?numCajas 1)))
    (assert (paletManzanas (- ?numManzanas 1)))
)
(defrule coger_caquis

    (robot ?naranjas ?manzanas ?caquis ?uvas ?sobrecarga ?numCajas)
    (paletCaquis ?numCaquis)
    (pedido ?naranjasPedido ?manzanasPedido ?caquisPedido ?uvasPedido)

    (test (= ?sobrecarga 0))
    (test (<> ?caquis caquisPedido) )
    (test (> ?numCaquis 0))
    (test (< ?numCajas ?*maxCajas*))
    =>
    (assert (robot 0 0 (+ ?caquis 1) 0 0 (+ ?numCajas 1)))
    (assert (paletCaquis (- ?numCaquis 1)))
)
(defrule coger_uvas

    (robot ?naranjas ?manzanas ?caquis ?uvas ?sobrecarga ?numCajas)
    (paletUvas ?numUvas)
    (pedido ?naranjasPedido ?manzanasPedido ?caquisPedido ?uvasPedido)

    (test (= ?sobrecarga 0))
    (test (<> ?uvas uvasPedido) )
    (test (> ?numUvas 0))
    (test (< ?numCajas ?*maxCajas*))
    =>
    (assert (robot 0 0 0 (+ ?uvas 1) 0 (+ ?numCajas 1)))
    (assert (paletUvas (- ?numUvas 1)))
)

(defrule comprobar_sobrecarga
    (robot ?naranjas ?manzanas ?caquis ?uvas ?sobrecarga ?numCajas)

    (test (= ?numCajas ?*maxCajas*))
    =>
    ; si numero de cajas es el maximo hay sobrecarga
    (assert (robot ?naranjas ?manzanas ?caquis ?uvas 1 ?numCajas ))

)


(defrule llevar_linea_pedidos
    (robot ?naranjas ?manzanas ?caquis ?uvas ?sobrecarga ?numCajas)
    (test(> ?sobrecarga 0))
    =>
    ; si hay sobrecaarga vaciar el robot e introducir las cajas en la linea
    (assert (lineaPedidos (+ ?naranjasNew ?naranjas) (+ ?manzanasNew ?manzanas) (+ ?caquisNew ?caquis) (+ ?uvasNew ?uvas) ) )
    (assert (robot 0 0 0 0 0 0))
)

(defrule pedido_completado
    (robot ?naranjas ?manzanas ?caquis ?uvas ?sobrecarga ?numCajas)
    (pedido ?naranjasPedido ?manzanasPedido ?caquisPedido ?uvasPedido)
    (lineaPedidos ?naranjasEntregadas ?manzanasEntregadas ?caquisEntregadas ?uvasEntregadas)

    ; comprobamos que las cajas coincidan con las del pedido
    (test (= ?naranjasEntregadas ?naranjasPedido))
    (test (= ?manzanasEntregadas ?manzanasPedido))
    (test (= ?caquisEntregadas ?caquisPedido))
    (test (= ?uvasEntregadas ?uvasPedido))
    =>
    (halt) 
    (printout t "El robot ha entregado el pedido a la linea correctamente" crlf)

)