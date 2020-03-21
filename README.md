Not sure where to start?  Visit https://shauncar.land/projects/everythings-cancelled/ for more information on the *Everything's Cancelled* project.


just as a heads up, the events assessment API is down (:X).  but to you use it, send a POST request to https://event-risk-assessment-api.herokuapp.com/ with a body in the following format:
```
{
	"country": "italy",
	"groupSize": 500
}
```

and you will get a response that looks like this:
`{"risk":0.32138}`

it should be working locally if you want to fire up a localserver.  just download the repo and run `$ruby app.rb` in the main directory.

