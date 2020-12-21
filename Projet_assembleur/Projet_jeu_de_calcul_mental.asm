	.data
intro:	.asciiz "Bienvenue sur le jeu de calcul mental !\n"
choice: .asciiz "CHOIX DU NIVEAU"
easy:	.asciiz  "Vous avez choisi le niveau facile"
moyen:	.asciiz "Vous avez choisi le niveau moyen"
hard:	.asciiz "Vous avez choisi le niveau difficile"
sortie:	.asciiz "Vous allez sortir du programme"
niv_1:	.asciiz "Tapez 1 pour le niveau facile"
niv_2:	.asciiz "Tapez 2 pour le niveau moyen"
niv_3:	.asciiz "Tapez 3 pour le niveau difficile"
fin_4:	.asciiz "Tapez 4 pour sortir du programme et afficher votre résultat"
score:	.asciiz "Ton score est de"
score_f:.asciiz "Ton score final est de"
com_1: 	.asciiz "Excellent!"
com_2:	.asciiz "Très Bien!"
com_3:	.asciiz "Vous pouvez mieux faire!"
com_4: 	.asciiz "Exercez vous à nouveau!"
calc:	.asciiz "Calculer l'addition entre "
et:	.asciiz " et "
rt:	.asciiz "\n"
vrai:	.asciiz "Bonne réponse"
faux:	.asciiz "Mauvaise réponse"
text_1:	.asciiz "La bonne réponse est : "
mess_mauvais_choix:
	.asciiz "Vous avez fait un mauvais choix, veuillez faire un choix valide"
mess_nb_calc:
	.asciiz "Indiquer le nombre d'opération que vous voulez faire"

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
	# calcule du résultat
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
	
	mult $t0,$t1
	
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
	
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	
	la $a0, niv_1
	ori $v0, $zero, 4
	syscall
	
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	
	la $a0, niv_2
	ori $v0, $zero, 4
	syscall
	
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	
	la $a0, niv_3
	ori $v0, $zero, 4
	syscall
	
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	
	la $a0, fin_4
	ori $v0, $zero, 4
	syscall
	
	#affiche un retour à la ligne
	la $a0, rt
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
	sw $ra, 0($sp)		#
	sw $fp, 4($sp)		#
	addiu $fp, $sp, 32	#
	or $t0, $zero, $a0
	or $t1, $zero, $a1
	
for_Niveau:
	#Appel a la fonction random		random pour le choix de l'opération
	ori $a0, $zero, 2	# plafond du random
	jal FctRandom
	
	lw $fp, 4($sp)		#FIN
	or $t2, $zero, $v0	# $t1 contient l'opération à faire
	
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
	ori $a0, $zero, 20	# plafond du random
	jal FctRandom
	
	lw $fp, 4($sp)		#FIN
	or $t2, $zero, $v0	# $t2 contient le premier random
	#Appel a la fonction random
	ori $a0, $zero, 20	# plafond du random
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
	
	# printf("calculer l'addition entre %d et %d", $t1, $t2)
	la $a0, calc
	ori $v0, $zero, 4
	syscall
	or $a0, $zero, $t2
	ori $v0, $zero, 1
	syscall
	la $a0, et
	ori $v0, $zero, 4
	syscall
	or $a0, $zero, $t3
	ori $v0, $zero, 1
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	
	#on récupère le résultat de l'utilisateur
	ori $v0, $zero, 5
	syscall
	or $t0, $zero, $v0
	
	#On vérifie son résultat	
	beq $t0, $t4, Good
	j Bad
Good:	
	la $a0, vrai
	ori, $v0, $zero, 4
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	#addi $t5, $t5, 1
	#beq $t5, $t4, suite_Niveau
	j suite_Niveau

Bad:
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

multiplication_facile:


moyen_Niveau:
addition_moyen:

soustraction_moyen:

multiplication_moyen:


difficile_Niveau:
addition_difficile:

soustraction_difficle:

multiplication_difficle:

suite_Niveau:
	lw $ra, 0($sp)		#Epilogue : restitution fr $ra
	lw $fp, 4($sp)		# restitution de $sp
	addiu $sp, $sp, 32	# déplilement
	jr $ra	
	
	
	
	
	
	
