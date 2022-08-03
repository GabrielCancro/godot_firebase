extends Button

func _ready():
	connect("button_down",self,"_on_Button_pressed")
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	_on_Button_pressed()

func _on_Button_pressed():
	text = "loading time.."
	$HTTPRequest.request("http://worldclockapi.com/api/json/est/now")

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	var time = floor( (json.result.currentFileTime - 133040205110000000 ) / 10000000 )
	text = "TIME: "+str(time)
