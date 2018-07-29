# mean-and-clean

WIP!



MEAN, MERN, MEVN

- http://mern.io
- http://mean.io

MongoDB(M), Express(E), React(R), NodeJS(N).


----


Pre-requisites
You need to have a basic understanding of all the four technologies that make up the MERN stack. You should also have npm (Node Package Manager) installed. This is NOT a tutorial on MongoDB, Express, React or NodeJS.

---



Make sure MongoDB service is running.



- axios will be used to send requests to server to fetch or insert data.
- body-parser parses the request bodies. We can get access to the information inside the request via req.body.
- babel-cli will be used to compile files from the command line.
- express is a web application framework for NodeJS.
- mongoose is an ODM framework for MongoDB.
- nodemon automatically restarts the server whenever the code changes.
- react-bootstrap lets us use bootstrap components with React.
- react-modal lets us create a modal dialog in React.
- react-router-dom lets us use React router.





## Mongo DB

- <https://www.mongodb.com/what-is-mongodb>
- <https://docs.mongodb.com/manual/tutorial/getting-started/>


## Mongoose.js

http://mongoosejs.com/docs/index.html


## MongoDB GUI

The best MongoDB GUI for Mac OS X



- mongobooster (https://nosqlbooster.com/)
- Robomonger (https://robomongo.org/)


<https://nodejs.org/>


Step 00:

<https://docs.mongodb.com/manual/tutorial/install-mongodb-on-os-x/>
- <https://treehouse.github.io/installation-guides/mac/mongo-mac.html>



```
brew install mongodb
brew install nodejs
```

```
brew install mongodb
sudo chown -R `id -un` /data/db
# Enter your password
```


### Step 01

Intialize npm package

```
npm init
# if you don't want to answer all the questions from a stranger (NPM) use:
npm init -y
```

And install Mongoose

```
npm install mongoose
```


### step 02

-

```
mongod
# open other terminal
mongo
# or
mongo --host 127.0.0.1:27017
```

```
brew install homebrew/cask/mongobooster
```

Create db



## Sources

mongoose.js

- <https://scotch.io/tutorials/using-mongoosejs-in-node-js-and-mongodb-applications>
- <https://github.com/madhums/node-express-mongoose-demo>
- CRUD <https://coursework.vschool.io/mongoose-crud/>

mern

- <https://github.com/cefjoeii/mern-crud>
- <https://github.com/rfdickerson/mern-example>
- <https://github.com/keithweaver/MERN-boilerplate>
- <https://blog.cloudboost.io/creating-your-first-mern-stack-application-b6604d12e4d3>
- <https://medium.com/@Keithweaver_/getting-started-with-mern-mongodb-express-js-react-js-node-js-94197841bdf4>
- <https://medium.com/@bryantheastronaut/ok-here-we-go-b9f683c5a00c>
- <https://dzone.com/articles/two-methods-for-building-your-first-mern-stack-app>


mevn

- <https://medium.com/@anaida07/mevn-stack-application-part-1-3a27b61dcae0>
- <https://www.mongodb.com/blog/post/the-modern-application-stack-part-1-introducing-the-mean-stack>
- <https://www.djamware.com/post/5a1b779f80aca75eadc12d6e/mongo-express-vue-nodejs-mevn-stack-crud-web-application>
- <https://www.djamware.com/post/5ac8338780aca714d19d5b9e/securing-mevn-stack-vuejs-2-web-application-using-passport>



