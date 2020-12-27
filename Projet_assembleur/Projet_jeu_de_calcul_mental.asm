	.data
intro:	.asciiz "Bienvenue sur le jeu de calcul mental !\n"
choice: .asciiz "CHOIX DU NIVEAU"
easy:	.asciiz  "Vous avez choisi le niveau facile"
moyen:	.asciiz "Vous avez choisi le niveau moyen"
hard:	.asciiz "Vous avez choisi le niveau difficile"
sortie:	.asciiz "Vous allez sortir du programme"
niv:	.asciiz "\nTapez 1 pour le niveau facile\nTapez 2 pour le niveau moyen\nTapez 3 pour le niveau difficile\nTapez 4 pour sortir du programme et afficher votre résultat\n"
score:	.asciiz "\nTon score est de "
score_f:.asciiz "Ton score final est de "
com_1: 	.asciiz "Excellent!"
com_2:	.asciiz "Très Bien!"
com_3:	.asciiz "Bien!"
com_4:	.asciiz "Vous pouvez mieux faire!"
com_5: 	.asciiz "Exercez vous à nouveau!"
calc:	.asciiz "Calculer "
plus:	.asciiz " + "
moins:	.asciiz " - "
fois:	.asciiz " x "
rt:	.asciiz "\n"
slash:	.asciiz "/"
vrai:	.asciiz "Bonne réponse"
faux:	.asciiz "Mauvaise réponse"
text_1:	.asciiz "La bonne réponse est : "
mess_mauvais_choix:
	.asciiz "Vous avez fait un mauvais choix, veuillez faire un choix valide"
mess_nb_calc:
	.asciiz "Indiquer le nombre d'opération que vous voulez faire"
mess_affiche_score:
	.asciiz "Ton score final est de "
parenthese_ouvrante:
	.asciiz "("
parenthese_fermante:
	.asciiz ")"
clear:	.asciiz "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
press_enter:
	.asciiz "Appuyer sur la touche Entrée pour voir la suite du calcule"
tapez_resultat:
	.asciiz "Tapez votre résulat"

	.text
main:	
	#Allocation du bloc de pile de la fonction main()
	addiu $sp, $sp, -64
	sw $fp, 60($sp)
	addiu $fp, $sp, 64
	
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	
	
	#affichage du message d'intro
	la $a0, intro
	ori $v0, $zero, 4
	syscall
	
	#Appel de la fonction Choix du niveau	
	jal FctChoixDuNiveau

	lw $fp, 60($sp)		#FIN
	lw $t0, 0($sp)		#

	or $t0, $zero, $v0		# $t0 contient le choix de l'utilisateur
	ori $t1, $zero, 4
	beq $t0, $t1, fin
while:	

	#demande à l'utilisateur le nombre d'opération il veut faut
	la $a0, mess_nb_calc
	ori $v0, $zero, 4
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	ori $v0, $zero, 5
	syscall
	or $t4, $zero, $v0		# $t4 contient le nombre d'opération que l'utilisateur va effectuer
	#affiche un retour à la ligne
	la $a0, clear
	ori $v0, $zero, 4
	syscall 
	
	ori, $t5, $zero, 0		# $t5 = compteur de la boucle for
	#Appel a la fonction Niveau
	or $a0, $zero, $t0
	or $a1, $zero, $t4
	jal FctNiveau
	lw $fp, 60($sp)		#FIN
	lw $t0, 0($sp)		#
	
	
	
suite:	
	#Appel de la fonction Choix du niveau	
	jal FctChoixDuNiveau

	lw $fp, 60($sp)		#FIN
	lw $t0, 0($sp)		#
	or $t0, $zero, $v0		# $t0 contient le choix de l'utilisateur
	
	ori $t5, $zero, 4
	bne $t0, $t5, while

fin:	
	# calcule du résultat
	or $a0, $zero, $t1
	or $a1, $zero, $t2
	jal Fct_calcule_score
	lw $fp, 60($sp)		#FIN
	or $t0, $zero, $v0	# $t0 contient le choix de l'utilisateur
	
	or $a0, $zero, $t0
	jal Ftc_affiche_score
	lw $fp, 60($sp)
	
	
	
	ori $v0, $zero, 10
	syscall
	
	
	


Fctaddition:
	addiu $sp, $sp, -8
	sw $ra, 0($sp)	
	sw $fp, 4($sp)
	addiu $fp, $sp, 8
	
	add $v0, $a0, $a1
	
	lw $ra, 0($sp)		#Epilogue : restitution fr $ra
	lw $fp, 4($sp)		# restitution de $sp
	addiu $sp, $sp, 8	# déplilement
	jr $ra	
	
	
Fctsoustraction:
	addiu $sp, $sp, -8
	sw $ra, 0($sp)	
	sw $fp, 4($sp)
	addiu $fp, $sp, 8
	
	sub $v0, $a0, $a1
	
	lw $ra, 0($sp)		#Epilogue : restitution fr $ra
	lw $fp, 4($sp)		# restitution de $sp
	addiu $sp, $sp, 8	# déplilement
	jr $ra	

		
Fctmultiplication:
	addiu $sp, $sp, -8
	sw $ra, 0($sp)	
	sw $fp, 4($sp)
	addiu $fp, $sp, 8
	
	mult $a0, $a1
	
	mflo  $v0
	lw $ra, 0($sp)		#Epilogue : restitution fr $ra
	lw $fp, 4($sp)		# restitution de $sp
	addiu $sp, $sp, 8	# déplilement
	jr $ra		
	
	
FctChoixDuNiveau:
	addiu $sp, $sp, -8	#PRO
	sw $ra, 0($sp)		#
	sw $fp, 4($sp)		#
	addiu $fp, $sp, 8	#
	
	#affichage du menu des choix
	la $a0, choice
	ori $v0, $zero, 4
	syscall
	
	la $a0, niv
	ori $v0, $zero, 4
	syscall

	#demande à l'utilisateur de choisir un niveau
	ori $v0, $zero, 5
	syscall
	or $t0, $zero, $v0 # sauvegarde du choix dans $t0
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	
	ori $t1, $zero, 1
	ori $t2, $zero, 2
	ori $t3, $zero, 3
	ori $t4, $zero, 4
mauvais_choix:
	beq $t0, $t1, choix_1
	beq $t0, $t2, choix_2
	beq $t0, $t3, choix_3
	beq $t0, $t4, choix_4
	la $a0, mess_mauvais_choix
	ori $v0, $zero, 4
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	ori $v0, $zero, 5
	syscall
	or $t0, $zero, $v0 # sauvegarde du choix dans $t0
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	j mauvais_choix
choix_1:	
	la $a0, easy
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	j suite_choix
choix_2:	
	la $a0, moyen
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	j suite_choix
choix_3:
	la $a0, hard
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	j suite_choix
choix_4:
	la $a0, sortie
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	j suite_choix

suite_choix:
	or $v0, $zero, $t0
	lw $ra, 0($sp)		#Epilogue : restitution fr $ra
	lw $fp, 4($sp)		# restitution de $sp
	addiu $sp, $sp, 8	# déplilement
	jr $ra	


FctRandom: #fonction qui génère des nombres aléatoires

	addiu $sp, $sp, -8  	#Prologue 
	sw $ra, 0($sp)	
	sw $fp, 4($sp)
	addiu $fp, $sp, 8

	li $v0, 42 		# 42 est l'appel système pour générer un random int
	or $a1, $zero, $a0		# $a1 stocke la limite superieure
	syscall     		# $a0 stocke le nombre aléatoire
	or $v0, $zero, $a0
	
	lw $ra, 0($sp)		#Epilogue : restitution fr $ra
	lw $fp, 4($sp)		# restitution de $sp
	addiu $sp, $sp, 8	# déplilement
	jr $ra	
	
	
FctNiveau:
	addiu $sp, $sp, -32	#PRO
	sw $fp, 4($sp)		#
	sw $ra, 0($sp)		#
	addiu $fp, $sp, 32	#
	or $t0, $zero, $a0
	or $t1, $zero, $a1
	addi $a2, $zero, 0	
	
for_Niveau:
	#Appel a la fonction random		random pour le choix de l'opération
	ori $a0, $zero, 3	# plafond du random
	jal FctRandom
	lw $fp, 4($sp)		#FIN
	or $t2, $zero, $v0	# $t2 contient l'opération à faire
	
	ori $t3, $zero, 1
	ori $t4, $zero, 2
	ori $t5, $zero, 3
	beq $t0, $t3, facile_Niveau
	beq $t0, $t4, moyen_Niveau
	beq $t0, $t5, difficile_Niveau
	
facile_Niveau:
	beq $t2, $zero, addition_facile
	beq $t2, $t3, soustraction_facile
	beq $t2, $t4, multiplication_facile
addition_facile:
	#Appel a la fonction random
	ori $a0, $zero, 21	# plafond du random
	jal FctRandom
	lw $fp, 4($sp)		#FIN
	or $t2, $zero, $v0	# $t2 contient le premier random
	
	#Appel a la fonction random
	ori $a0, $zero, 21	# plafond du random
	jal FctRandom
	lw $fp, 4($sp)		#FIN
	or $t3, $zero, $v0	# $t3 contient le deuxième random
	
	#Appel à la fonction d'addition
	or $a0, $zero, $t2	#OUV
	or $a1, $zero, $t3	#
	jal Fctaddition
	lw $fp, 4($sp)		#FIN
	addu $sp, $sp, 32	#
	or $t4, $zero, $v0	# On enregistre la valeur de l'addition dans $t4
	
	
	addi $t6, $t6, 1
	# printf("calculer %d + %d", $t1, $t2)
	la $a0, calc
	ori $v0, $zero, 4
	syscall
	or $a0, $zero, $t2
	ori $v0, $zero, 1
	syscall
	la $a0, plus
	ori $v0, $zero, 4
	syscall
	or $a0, $zero, $t3
	ori $v0, $zero, 1
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	syscall
	#"tapez votre résultat"
	la $a0, tapez_resultat
	ori $v0, $zero, 4
	syscall
	#on récupère le résultat de l'utilisateur
	ori $v0, $zero, 5
	syscall
	or $t5, $zero, $v0
	
	#On vérifie son résultat	
	beq $t5, $t4, Good_addition_facile
	j Bad_addition_facile
Good_addition_facile:	
	la $a0, vrai
	ori, $v0, $zero, 4
	syscall
	addi, $t7, $t7, 1
	j suite_Niveau

Bad_addition_facile:
	la $a0, faux
	ori $v0, $zero, 4
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	#On affiche le bon résultat
	la $a0, text_1
	ori $v0, $zero, 4
	syscall
	ori $v0, $zero, 1
	or $a0, $zero, $t4
	syscall
	j suite_Niveau
	
soustraction_facile:
	#Appel a la fonction random
	ori $a0, $zero, 11	# plafond du random
	jal FctRandom
	lw $fp, 4($sp)		#FIN
	or $t2, $zero, $v0	# $t2 contient le premier random
	
	#Appel a la fonction random
	ori $a0, $zero, 11	# plafond du random
	jal FctRandom
	lw $fp, 4($sp)		#FIN
	or $t3, $zero, $v0	# $t3 contient le deuxième random
	
	#Appel à la fonction de soustraction
	or $a0, $zero, $t2	#OUV
	or $a1, $zero, $t3	#
	jal Fctsoustraction
	lw $fp, 4($sp)		#FIN
	addu $sp, $sp, 32	#
	or $t4, $zero, $v0	# On enregistre la valeur de l'addition dans $t4
	addi $t6, $t6, 1
	# printf("calculer %d - %d", $t1, $t2)
	la $a0, calc
	ori $v0, $zero, 4
	syscall
	or $a0, $zero, $t2
	ori $v0, $zero, 1
	syscall
	la $a0, moins
	ori $v0, $zero, 4
	syscall
	or $a0, $zero, $t3
	ori $v0, $zero, 1
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	syscall 
	#"tapez votre résultat"
	la $a0, tapez_resultat
	ori $v0, $zero, 4
	syscall
	#on récupère le résultat de l'utilisateur
	ori $v0, $zero, 5
	syscall
	or $t5, $zero, $v0
	
	#On vérifie son résultat	
	beq $t5, $t4, Good_soustraction_facile
	j Bad_soustraction_facile
Good_soustraction_facile:	
	la $a0, vrai
	ori, $v0, $zero, 4
	syscall
	addi, $t7, $t7, 1
	j suite_Niveau

Bad_soustraction_facile:
	la $a0, faux
	ori $v0, $zero, 4
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	#On affiche le bon résultat
	la $a0, text_1
	ori $v0, $zero, 4
	syscall
	ori $v0, $zero, 1
	or $a0, $zero, $t4
	syscall
	j suite_Niveau
	
multiplication_facile:
	#Appel a la fonction random
	ori $a0, $zero, 3	# plafond du random
	jal FctRandom
	lw $fp, 4($sp)		#FIN
	or $t2, $zero, $v0	# $t2 contient le premier random
	
	#Appel a la fonction random
	ori $a0, $zero, 3	# plafond du random
	jal FctRandom
	lw $fp, 4($sp)		#FIN
	or $t3, $zero, $v0	# $t3 contient le deuxième random
	
	#Appel à la fonction de soustraction
	or $a0, $zero, $t2	#OUV
	or $a1, $zero, $t3	#
	jal Fctmultiplication
	lw $fp, 4($sp)		#FIN
	addu $sp, $sp, 32	#
	or $t4, $zero, $v0	# On enregistre la valeur de l'addition dans $t4
	
	addi $t6, $t6, 1
	# printf("calculer %d + %d", $t1, $t2)
	la $a0, calc
	ori $v0, $zero, 4
	syscall
	or $a0, $zero, $t2
	ori $v0, $zero, 1
	syscall
	la $a0, fois
	ori $v0, $zero, 4
	syscall
	or $a0, $zero, $t3
	ori $v0, $zero, 1
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	syscall 
	#"tapez votre résultat"
	la $a0, tapez_resultat
	ori $v0, $zero, 4
	syscall
	#on récupère le résultat de l'utilisateur
	ori $v0, $zero, 5
	syscall
	or $t5, $zero, $v0
	
	#On vérifie son résultat	
	beq $t5, $t4, Good_multiplication_facile
	j Bad_multiplication_facile
Good_multiplication_facile:	
	la $a0, vrai
	ori, $v0, $zero, 4
	syscall
	addi, $t7, $t7, 1
	j suite_Niveau

Bad_multiplication_facile:
	la $a0, faux
	ori $v0, $zero, 4
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	#On affiche le bon résultat
	la $a0, text_1
	ori $v0, $zero, 4
	syscall
	ori $v0, $zero, 1
	or $a0, $zero, $t4
	syscall
	j suite_Niveau


moyen_Niveau:
	beq $t2, $zero, addition_moyen
	beq $t2, $t3, soustraction_moyen
	beq $t2, $t4, multiplication_moyen
addition_moyen:
	#Appel a la fonction random
	ori $a0, $zero, 101	# plafond du random
	jal FctRandom
	lw $fp, 4($sp)		#FIN
	or $t2, $zero, $v0	# $t2 contient le premier random
	
	#Appel a la fonction random
	ori $a0, $zero, 101	# plafond du random
	jal FctRandom
	lw $fp, 4($sp)		#FIN
	or $t3, $zero, $v0	# $t3 contient le deuxième random
	
	#Appel à la fonction d'addition
	or $a0, $zero, $t2	#OUV
	or $a1, $zero, $t3	#
	jal Fctaddition
	lw $fp, 4($sp)		#FIN
	addu $sp, $sp, 32	#
	or $t4, $zero, $v0	# On enregistre la valeur de l'addition dans $t4
	
	
	addi $t6, $t6, 1
	# printf("calculer %d + %d", $t1, $t2)
	la $a0, calc
	ori $v0, $zero, 4
	syscall
	or $a0, $zero, $t2
	ori $v0, $zero, 1
	syscall
	la $a0, plus
	ori $v0, $zero, 4
	syscall
	or $a0, $zero, $t3
	ori $v0, $zero, 1
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	syscall
	#"tapez votre résultat"
	la $a0, tapez_resultat
	ori $v0, $zero, 4
	syscall
	#on récupère le résultat de l'utilisateur
	ori $v0, $zero, 5
	syscall
	or $t5, $zero, $v0
	
	#On vérifie son résultat	
	beq $t5, $t4, Good_addition_moyen
	j Bad_addition_moyen
Good_addition_moyen:	
	la $a0, vrai
	ori, $v0, $zero, 4
	syscall
	addi, $t7, $t7, 1
	j suite_Niveau

Bad_addition_moyen:
	la $a0, faux
	ori $v0, $zero, 4
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	#On affiche le bon résultat
	la $a0, text_1
	ori $v0, $zero, 4
	syscall
	ori $v0, $zero, 1
	or $a0, $zero, $t4
	syscall
	j suite_Niveau
soustraction_moyen:
	#Appel a la fonction random
	ori $a0, $zero, 101	# plafond du random
	jal FctRandom
	lw $fp, 4($sp)		#FIN
	or $t2, $zero, $v0	# $t2 contient le premier random
	
	#Appel a la fonction random
	ori $a0, $zero, 101	# plafond du random
	jal FctRandom
	lw $fp, 4($sp)		#FIN
	or $t3, $zero, $v0	# $t3 contient le deuxième random
	
	#Appel à la fonction de soustraction
	or $a0, $zero, $t2	#OUV
	or $a1, $zero, $t3	#
	jal Fctsoustraction
	lw $fp, 4($sp)		#FIN
	addu $sp, $sp, 32	#
	or $t4, $zero, $v0	# On enregistre la valeur de l'addition dans $t4
	addi $t6, $t6, 1
	# printf("calculer %d - %d", $t1, $t2)
	la $a0, calc
	ori $v0, $zero, 4
	syscall
	or $a0, $zero, $t2
	ori $v0, $zero, 1
	syscall
	la $a0, moins
	ori $v0, $zero, 4
	syscall
	or $a0, $zero, $t3
	ori $v0, $zero, 1
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	syscall
	#"tapez votre résultat"
	la $a0, tapez_resultat
	ori $v0, $zero, 4
	syscall
	#on récupère le résultat de l'utilisateur
	ori $v0, $zero, 5
	syscall
	or $t5, $zero, $v0
	
	#On vérifie son résultat	
	beq $t5, $t4, Good_soustraction_moyen
	j Bad_soustraction_moyen
Good_soustraction_moyen:	
	la $a0, vrai
	ori, $v0, $zero, 4
	syscall
	addi, $t7, $t7, 1
	j suite_Niveau

Bad_soustraction_moyen:
	la $a0, faux
	ori $v0, $zero, 4
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	#On affiche le bon résultat
	la $a0, text_1
	ori $v0, $zero, 4
	syscall
	ori $v0, $zero, 1
	or $a0, $zero, $t4
	syscall
	j suite_Niveau
multiplication_moyen:
	#Appel a la fonction random
	ori $a0, $zero, 11	# plafond du random
	jal FctRandom
	lw $fp, 4($sp)		#FIN
	or $t2, $zero, $v0	# $t2 contient le premier random
	
	#Appel a la fonction random
	ori $a0, $zero, 11	# plafond du random
	jal FctRandom
	lw $fp, 4($sp)		#FIN
	or $t3, $zero, $v0	# $t3 contient le deuxième random
	
	#Appel à la fonction de soustraction
	or $a0, $zero, $t2	#OUV
	or $a1, $zero, $t3	#
	jal Fctmultiplication
	lw $fp, 4($sp)		#FIN
	addu $sp, $sp, 32	#
	or $t4, $zero, $v0	# On enregistre la valeur de l'addition dans $t4
	
	addi $t6, $t6, 1
	# printf("calculer %d + %d", $t1, $t2)
	la $a0, calc
	ori $v0, $zero, 4
	syscall
	or $a0, $zero, $t2
	ori $v0, $zero, 1
	syscall
	la $a0, fois
	ori $v0, $zero, 4
	syscall
	or $a0, $zero, $t3
	ori $v0, $zero, 1
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	syscall
	#"tapez votre résultat"
	la $a0, tapez_resultat
	ori $v0, $zero, 4
	syscall
	#on récupère le résultat de l'utilisateur
	ori $v0, $zero, 5
	syscall
	or $t5, $zero, $v0
	
	#On vérifie son résultat	
	beq $t5, $t4, Good_multiplication_moyen
	j Bad_multiplication_moyen
Good_multiplication_moyen:	
	la $a0, vrai
	ori, $v0, $zero, 4
	syscall
	addi, $t7, $t7, 1
	j suite_Niveau

Bad_multiplication_moyen:
	la $a0, faux
	ori $v0, $zero, 4
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	#On affiche le bon résultat
	la $a0, text_1
	ori $v0, $zero, 4
	syscall
	ori $v0, $zero, 1
	or $a0, $zero, $t4
	syscall
	j suite_Niveau


difficile_Niveau:
	#affiche "calculer "
	la $a0, calc
	ori $v0, $zero, 4
	syscall
	#Appel a la fonction random
	ori $a0, $zero, 13	# plafond du random
	jal FctRandom
	lw $fp, 4($sp)		#FIN
	or $t4, $zero, $v0	# $t8 contient un opérande
	#on affiche le nombre
	or $a0, $zero, $t4
	ori $v0, $zero, 1
	syscall
	
	#random pour connaitre le nombre d'opérande
while_nb_operande:
	#Appel a la fonction random
	ori $a0, $zero, 11	# plafond du random
	jal FctRandom
	lw $fp, 4($sp)		#FIN
	or $s1, $zero, $v0	# $t8 contient un opérande
	
	ori $t5, $zero, 5
	slt $t3, $s1, $t5
	bne $t3, $zero, while_nb_operande
	
for_difficile:
	beq $s0, $s1, suite_operation
	#Appel a la fonction random
	ori $a0, $zero, 3	# plafond du random
	jal FctRandom
	lw $fp, 4($sp)		#FIN
	or $t2, $zero, $v0	# $t2 contient l'opération
	
	ori $t5, $zero, 1
	ori $t3, $zero, 2
	beq $t2, $zero, affichage_addition_difficile
	beq $t2, $t5, affichage_soustraction_difficile
	beq $t2, $t3, affichage_multiplication_difficile
	
	
affichage_addition_difficile:
	# printf(" + ")
	la $a0, plus
	ori $v0, $zero, 4
	syscall
	j suite_affichage
affichage_soustraction_difficile:
	la $a0, moins
	ori $v0, $zero, 4
	syscall
	j suite_affichage
affichage_multiplication_difficile:
	la $a0, fois
	ori $v0, $zero, 4
	syscall


suite_affichage:	
	#Appel a la fonction random
	ori $a0, $zero, 12	# plafond du random
	jal FctRandom
	lw $fp, 4($sp)		#FIN
	or $t9, $zero, $v0	# $t9 contient un opérande
	#on affiche le nombre
	or $a0, $zero, $t9
	ori $v0, $zero, 1
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall 
	syscall
	#"pressez enter pour voir la suite"
	la $a0, press_enter
	ori $v0, $zero, 4
	syscall
	ori $v0, $zero, 8
	syscall
	#On efface le terminal
	la $a0, clear
	ori $v0, $zero, 4
	syscall
	beq $t2, $zero, addition_difficile
	beq $t2, $t5, soustraction_difficile
	beq $t2, $t3, multiplication_difficile
addition_difficile:
	#Appel à la fonction de addition
	or $a0, $zero, $t4	#OUV
	or $a1, $zero, $t9	#
	jal Fctaddition
	lw $fp, 4($sp)		#FIN
	addu $sp, $sp, 32	#
	or $t4, $zero, $v0	# On enregistre la valeur de l'addition dans $t4
	j suite_operation_boucle
soustraction_difficile:
	#Appel à la fonction de soustraction
	or $a0, $zero, $t4	#OUV
	or $a1, $zero, $t9	#
	jal Fctsoustraction
	lw $fp, 4($sp)		#FIN
	addu $sp, $sp, 32	#
	or $t4, $zero, $v0	# On enregistre la valeur de l'addition dans $t4	
	j suite_operation_boucle
multiplication_difficile:
	#Appel à la fonction de multiplication
	or $a0, $zero, $t4	#OUV
	or $a1, $zero, $t9	#
	jal Fctmultiplication
	lw $fp, 4($sp)		#FIN
	addu $sp, $sp, 32	#
	or $t4, $zero, $v0	# On enregistre la valeur de l'addition dans $t4
	
suite_operation_boucle:
	addi $s0, $s0, 1
	j for_difficile
	
	
suite_operation:
	#affiche un retour à la ligne
	la $a0, clear
	ori $v0, $zero, 4
	syscall 
	
	addi $t6, $t6, 1
	#"tapez votre résultat"
	la $a0, tapez_resultat
	ori $v0, $zero, 4
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall 
	#on récupère le résultat de l'utilisateur
	ori $v0, $zero, 5
	syscall
	or $t5, $zero, $v0
	beq $t5, $t4, Good_difficile
	j Bad_difficile
Good_difficile:	
	la $a0, vrai
	ori, $v0, $zero, 4
	syscall
	addi, $t7, $t7, 1
	j suite_Niveau

Bad_difficile:
	la $a0, faux
	ori $v0, $zero, 4
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	#On affiche le bon résultat
	la $a0, text_1
	ori $v0, $zero, 4
	syscall
	ori $v0, $zero, 1
	or $a0, $zero, $t4
	syscall
	j suite_Niveau	


suite_Niveau:
	# affiche le score
	la $a0, score
	ori $v0, $zero, 4
	syscall
	or $a0, $zero, $t7
	ori $v0, $zero, 1
	syscall
	la $a0, slash
	ori $v0, $zero, 4
	syscall
	or $a0, $zero, $t6
	ori $v0, $zero, 1
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall

	addi $a2, $a2, 1
	bne $a2, $t1, for_Niveau
	or $v0, $zero, $t6
	or $v1, $zero, $t7
	lw $fp, 4($sp)		# restitution de $sp
	lw $ra, 0($sp)		#Epilogue : restitution fr $ra
	addiu $sp, $sp, 32	# déplilement
	jr $ra	
	
Fct_calcule_score:
	# $a0 contient le nombre de calcul
	# $a1 contient le nombre de calcul correcte
	addiu $sp, $sp, -8
	sw $ra, 0($sp)	
	sw $fp, 4($sp)
	addiu $fp, $sp, 8
	
	or $t0, $zero, $a0
	mtc1  $t0, $f12
	cvt.s.w $f12, $f12
	or $t1, $zero, $a1
	mtc1 $t1, $f13
	cvt.s.w $f13, $f13
	div.s $f11, $f13, $f12
	ori $t0, $zero, 100
	mtc1  $t0, $f13
	cvt.s.w $f13, $f13
	mul.s $f12, $f11, $f13
	cvt.w.s $f12, $f12
	mfc1 $t0, $f12
	or $a0, $zero, $t0
	la $a0, mess_affiche_score
	ori $v0, $zero, 4
	syscall
	or $a0, $zero, $t0
	ori $v0, $zero, 1
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	
	or $v0, $zero, $t0
	lw $fp, 4($sp)		# restitution de $sp
	lw $ra, 0($sp)		#Epilogue : restitution fr $ra
	addiu $sp, $sp, 8	# déplilement
	jr $ra
	


Fct_affiche_score:
	# $a1 contient le score final
	addiu $sp, $sp, -8
	sw $ra, 0($sp)	
	sw $fp, 4($sp)
	addiu $fp, $sp, 8
	


	or $t0, $zero, $a0
	ori $t1, $zero, 99
	slt $t0, $t1, $a1
	bne $t0, $zero, affiche_score_com_1
	ori $t2, $zero, 75
	slt $t0, $a1, $t1
	bne $t0, $zero, affiche_score_com_2_test
test_1:	
	ori $t1, $zero, 50
	slt $t0, $a1, $t2
	bne $t0, $zero, affiche_score_com_3_test
test_2:
	ori $t2, $zero, 25
	slt $t0, $a1, $t1
	bne $t0, $zero, affiche_score_com_4_test

affiche_score_com_2_test:	# Pour mettre une deuxième condition
	slt $t0, $t2, $a1
	bne $t0, $zero, affiche_score_com_2
	j test_1
affiche_score_com_3_test:
	slt $t0, $t1, $a1
	bne $t0, $zero, affiche_score_com_3
	j test_2
affiche_score_com_4_test:
	slt $t0, $t2, $a1
	bne $t0, $zero, affiche_score_com_4
	j affiche_score_com_5
affiche_score_com_1:
	la $a0, com_1
	ori $v0, $zero, 4
	syscall
	j suite_affiche_score
affiche_score_com_2:
	la $a0, com_2
	ori $v0, $zero, 4
	syscall
	j suite_affiche_score
affiche_score_com_3:
	la $a0, com_3
	ori $v0, $zero, 4
	syscall
	j suite_affiche_score
affiche_score_com_4:
	la $a0, com_4
	ori $v0, $zero, 4
	syscall
	j suite_affiche_score
affiche_score_com_5:
	la $a0, com_5
	ori $v0, $zero, 4
	syscall

suite_affiche_score:	
	lw $fp, 4($sp)		# restitution de $sp
	lw $ra, 0($sp)		#Epilogue : restitution fr $ra
	addiu $sp, $sp, 8	# déplilement
	jr $ra
	
	
	
	
	
	
