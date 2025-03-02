var express=require('express')
var bodyParser=require('body-parser')
var mysql=require('mysql')
var app=express()
app.use(bodyParser())

app.get("/",function(request,response){
  response.send("hello from express js.... rushikesh")
});


app.get("/date",function(request,response){
  response.send("Date is:.."+new Date().toLocaleString())
});

app.listen(9595,function(err){
  if (err) throw err
  console.log("Server started on port 9595, to shut down hit ctrl+c")
})
