
(defglobal ?*maxCajas* = 3)

(deffacts reglas
    ; robot tiene 0 naranjas 0 0 0 y si esta lleno de cajas 0 o 1 para dejar las cajas en la lineaPedidos
	(robot 0 0 0 0 0)
	(lineaPedidos 0 0 0 0)
	(paletNaranjas 4)
	(paletManzanas 4)
	(paletCaquis 4)
	(paletUvas 4)
	
)


(defrule llevar_linea_pedidos
(numeros $?ini ?x $?mid ?y $?fin usados $?used)
(test(> ?y 0))
=>
(assert (numeros $?ini $?mid $?fin (- ?x ?y) usados $?used ?x "-" ?y "paso")))