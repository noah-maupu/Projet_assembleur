	.data
intro:	.asciiz "Bienvenue sur le jeu de calcul mental !\n"
choice: .asciiz "CHOIX DU NIVEAU"
easy:	.asciiz  "Vous avez choisi le niveau facile"
moyen:	.asciiz "Vous avez choisi le niveau moyen"
hard:	.asciiz "Vous avez choisi le niveau difficile"
niv_1:	.asciiz "Tapez 1 pour le niveau facile"
niv_2:	.asciiz "Tapez 2 pour le niveau moyen"
niv_3:	.asciiz "Tapez 3 pour le niveau difficile"
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
	.asciiz "Vous avez un mauvais choix, veuillez faire un choix valide"


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

	or $a0, $zero, $v0
	ori $v0, $zero, 1
	syscall
	
	
	#Appel a la fonction random
	#jal FctRandom
	
	#lw $fp, 60($sp)		#FIN
	#lw $t0, 0($sp)		#
	#lw $t1, 4($sp)		#
	
	
	 
	
	#demande à l'utilisateur deux nombres
	#ori $v0, $zero, 5
	#syscall
	#or $t0, $zero, $v0 # sauvegarde du nombre dans $t0

	#ori $v0, $zero, 5
	#syscall
	#or $t1, $zero, $v0 # sauvegarde du nombre dans $t1
	
	
	
	
	#Appel à la fonction d'addition
	or $a0, $zero, $t0	#OUV
	or $a1, $zero, $t1	#
	sw $a0, 0($sp)		#
	sw $a1, 4($sp)		#
	jal Fctaddition
	
	lw $fp, 60($sp)		#FIN
	lw $t0, 0($sp)		#
	lw $t1, 4($sp)		#
	addu $sp, $sp, 64	#
	or $t2, $zero, $v0	# On enregistre la valeur de retour dans $t2
	
	
	# printf("calculer l'addition entre %d et %d", $t0, $t1)
	la $a0, calc
	ori $v0, $zero, 4
	syscall
	or $a0, $zero, $t0
	ori $v0, $zero, 1
	syscall
	la $a0, et
	ori $v0, $zero, 4
	syscall
	or $a0, $zero, $t1
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
	beq $t0, $t2, Good
	j Bad
	
	
Good:	
	la $a0, vrai
	ori, $v0, $zero, 4
	syscall
	j Suite

Bad:
	la $a0, faux
	ori $v0, $zero, 4
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	
	la $a0, text_1
	ori $v0, $zero, 4
	syscall
	ori $v0, $zero, 1
	or $a0, $zero, $t2
	syscall
	
	
Suite:	ori $v0, $zero, 10
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
	
     	la $t0, choice # on récupeère l'adresse de ChoixDuNiveau
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
mauvais_choix:
	beq $t0, $t1, choix_1
	beq $t0, $t2, choix_2
	beq $t0, $t3, choix_3
	la $a0, mess_mauvais_choix
	ori $v0, $zero, 4
	syscall
	j mauvais_choix
choix_1:	
	la $a0, easy
	syscall
	j suite_choix
choix_2:	
	la $a0, moyen
	syscall
	j suite_choix
choix_3:
	la $a0, hard
	syscall
	j suite_choix

suite_choix:
	or $v0, $zero, $t0
	lw $ra, 0($sp)		#Epilogue : restitution fr $ra
	lw $fp, 4($sp)		# restitution de $sp
	addiu $sp, $sp, 8	# déplilement
	jr $ra	
	
	
	
FctRandom: #fonction qui génère des nombres aléatoires

	addiu $sp, $sp, -8  #Prologue 
	sw $ra, 0($sp)	
	sw $fp, 4($sp)
	addiu $fp, $sp, 8

	li $v0, 42  # 42 est l'appel système pour générer un random int
	li $a1, 100 # $a1 stocke la limite superieure
	syscall     # $a0 stocke le nombre aléatoire

	or $t0, $zero, $a0
	syscall
	or $t1, $zero, $a0
	ori $v0, $zero, 1
	or $a0, $zero, $t0
	syscall
	
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	
	ori $v0, $zero, 1
	or $a0,$zero, $t1
	syscall
	
	lw $ra, 0($sp)		#Epilogue : restitution fr $ra
	lw $fp, 4($sp)		# restitution de $sp
	addiu $sp, $sp, 8	# déplilement
	jr $ra	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
Suite:	ori $v0, $zero, 10
	syscall






	#On vérifie son résultat	
	beq $t0, $t3, Goodsdfg
	j Badsdfgs
Goodsdfdsfds:	
	la $a0, vrai
	ori, $v0, $zero, 4
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	addi $t5, $t5, 1
	beq $t5, $t4, suite_Niveaudfghd
	j fordfhhsfg

Badsdfsdf:
	la $a0, faux
	ori $v0, $zero, 4
	syscall
	#affiche un retour à la ligne
	la $a0, rt
	ori $v0, $zero, 4
	syscall
	
	la $a0, text_1
	ori $v0, $zero, 4
	syscall
	ori $v0, $zero, 1
	or $a0, $zero, $t3
	syscall
	addi $t5, $t5, 1
	beq $t5, $t4, suite_Niveaudfghd
	j fordfgh
	
suite_Niveaufsdfds:
	lw $ra, 0($sp)		#Epilogue : restitution fr $ra
	lw $fp, 4($sp)		# restitution de $sp
	addiu $sp, $sp, 32	# déplilement
	jr $ra	

