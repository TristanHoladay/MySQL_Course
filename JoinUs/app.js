var express = require('express');
var faker = require('faker');
var mysql = require('mysql');
var bodyParser = require('body-parser')
var app = express();

app.set('view engine', 'ejs');
app.use(bodyParser.urlencoded({extended:true}));
app.use(express.static(__dirname + '/public'));

var connection = mysql.createConnection({
	host : 'localhost',
	user : 'root',
	database: 'join_us'
});

app.get('/', function(req, res) {
	//Find count of users
	//respond with that count
	var q = "SELECT COUNT(*) AS count FROM users";
	connection.query(q, function(err, results) {
		console.log(results[0].count);
		var count = results[0].count;
		//res.send("We have " + count + " users in our database.");
		res.render('home', {data: count});
	});
});

app.post('/register', function(req, res) {
	var person = {
		email: req.body.email
	}
	
	connection.query("INSERT INTO users SET ?", person, function(err, result) {
		console.log(result);
		res.redirect('/');
	});
});

app.get('/joke', function(req, res) {
	res.send("You're a joke bud");
});

app.get('/random_num', function(req, res) {
	var num = Math.floor(Math.random() * 10) + 1;
	res.send("Yo num is " + num);
});

app.listen(3000, function() {
		console.log("Wassup World!")
});


// connection.query(q, [data], function(error, result) {
// 	if (error) throw error;
// 	console.log(result);
// });

// connection.end();

