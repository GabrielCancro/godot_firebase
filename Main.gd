extends Control

var db:FirebaseDatabase
var ref:FirebaseReference

var firebase_config = {
	"apiKey": "AIzaSyDwl2xTkoIky9w0mPXkkFheppcVskrPzZU",  # set somewhere only if using auth
	"authDomain": "moledata-74872.firebaseapp.com",
	"databaseURL": "https://moledata-74872-default-rtdb.firebaseio.com",
	"projectId": "moledata-74872",
	"storageBucket": "moledata-74872.appspot.com",
	"messagingSenderId": "491701428697",
	"appId": "1:491701428697:web:25b0320595e6191d8e39c8"
}

func _ready():
	$btn_refresh.connect("button_down",self,"_refresh")
	$Panel/btn_set.connect("button_down",self,"_panel_set")
	firebase.initialize_app(firebase_config)
	db = firebase.database()
	ref = db.get_reference_lite("juego1/jugadores")
#	var result = yield(ref.update({"carlitos":250}), "completed")
#	print(result)
	
func _refresh():
	ref.fetch()
	$lb_data.text = "loading.."
	var val = yield( ref, "complete_fetch" )
	$lb_data.text = str(val)

func _panel_set():
	var k = $Panel/le_key.text
	var v = $Panel/le_value.text
	$lb_data.text = "loading.."
	var result = yield(ref.update({k:v}), "completed")
	_refresh()
