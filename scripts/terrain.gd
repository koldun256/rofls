extends TileMap

var HEIGHT = 13
var WIGTH = 26
var r
var cnt
var zeros = 0
var arr = []
var arrZeroI = [[6,13]]
var probability = 0.20


func _ready():
	for i in range(HEIGHT):
		var arr1 = []
		for y in range(WIGTH):
			arr1.append(1)
		arr.append(arr1)
	
	for i in range(0,5):
		arr[int(randf()*(HEIGHT-6)+3)][int(randf()*(WIGTH-6)+3)]=0
	
	while zeros<30:
		var choice = arrZeroI[randi() % arrZeroI.size()]
		r = randf()
		if r >= probability:
			if r > (1-probability)/2:
				arr[choice[0]][choice[1]+1]=0
			else:
				arr[choice[0]][choice[1]-1]=0
		elif r >= probability/4:
			if r > (1-probability/4)/2:
				arr[choice[0]+1][choice[1]]=0
			else:
				arr[choice[0]-1][choice[1]]=0
		cnt = 0
		arrZeroI = []
		for i in range(len(arr)):
			for j in range(len(arr[i])):
				if arr[i][j] == 0:
					arrZeroI.append([i, j])
					cnt+=1
		zeros = cnt
	for y in range(0 ,HEIGHT-1):
		for x in range(0, WIGTH-1):
			if arr[y][x] == 0:
				if arr[y-1][x] == 1:
					set_cell(0,Vector2i(x,y),1,Vector2i(2,3))
				else:
					set_cell(1,Vector2i(x,y),1,Vector2i(2,6))
