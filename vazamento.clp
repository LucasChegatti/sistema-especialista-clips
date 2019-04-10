(deftemplate MAIN::cozinha
    (slot janela)
    (slot status)
    (slot problema)
    (slot agua_de_fora)
    (slot vazamento)
)
(deftemplate MAIN::banheiro (slot status)
    (slot vazamento)
)

(deftemplate MAIN::hall(slot status))

(deftemplate MAIN::clima(slot chuva))

(defrule MAIN::vazamento_no_banheiro
    (cozinha (status seca))
    (hall (status molhado))
    =>
    (printout t "Vazamento no banheiro" crlf)
    (assert(banheiro(vazamento sim)))
    (retract *)
)

(defrule MAIN::problema_na_cozinha
    (hall (status molhado))
    (banheiro (status seco))
    =>
    (printout t "Problema na cozinha" crlf)
    (assert(cozinha(problema sim)))
)

(defrule MAIN::sem_agua_vinda_de_fora
    (cozinha (janela fechada))
    (clima (chuva nao))
    =>
    (printout t "Sem agua vinda de fora" crlf)
    (assert(cozinha(agua_de_fora nao)))
)

(defrule MAIN::vazamento_na_cozinha
    (cozinha(agua_de_fora nao))
    (cozinha(problema sim))
    (banheiro(vazamento ~sim))
    =>
    (printout t "Vazamento na cozinha" crlf)
    (retract *)
)

(defrule entrada_fatos
=>
(printout t " Entre com o status da cozinha : ")
(assert (cozinha (status (read))))
(printout t " Entre com o status do hall : ")
(assert (hall (status (read))))
(printout t " Entre com o status do banheiro : ")
(assert (banheiro (status (read))))
(printout t " Entre com o status da janela da cozinha : ")
(assert (cozinha (janela (read))))
(printout t " Entre com o status da chuva : ")
(assert (clima (chuva (read))))
)

