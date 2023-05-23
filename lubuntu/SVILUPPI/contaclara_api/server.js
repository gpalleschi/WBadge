import express from 'express';
import https from 'https';
import fileupload from 'express-fileupload';
import cors from 'cors';
import bodyParser from 'body-parser';
import * as Invoices from './controllers/invoices.js';
import * as Constants from './controllers/constants.js';
import * as EnergyPoints from './controllers/energypoints.js';
import * as Users from './controllers/users.js';
import * as Clients from './controllers/clients.js';
import * as TypeClients from './controllers/typeclients.js';
import * as fs from 'fs';
import * as uploadPdf from './controllers/uploadpdf.js';
import * as signin from './controllers/signin.js';
import bcrypt from 'bcrypt';
import knex from 'knex';
import path from 'path';
import { fileURLToPath } from 'url';
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();

app.use(cors());
const port = Constants.DEFAULT_PORT;

const db = knex({
      client: 'mysql',
      connection: {
      host : Constants.DB_HOST,
      port : Constants.DB_PORT,
      user : Constants.DB_USER,
      password : Constants.DB_PWD,
      database : Constants.DB_NAME
    }
});

db.raw('select 1+1 as result').catch(err => {
  console.log('Db Connection Problem : ' + err);
  process.exit(1);
}).then(console.log('Db Connection OK.'));
 
app.use(cors());
app.use(fileupload());
app.use(express.static("files"));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.get('/',(req,res)=>{
	res.send('Server ' + Constants.name + ' version ' + Constants.version + ' is running on port ' + port);
})

// Upload file
app.post('/upload', (req, res) => {
  const path = __dirname + "/files/";
  uploadPdf.handleUploadPdf(req, res, path, db);
});

app.delete('/revert', (req, res) => {
  console.log('revert : ' + req);
  res.status(200).send({ message: "File Uploaded", code: 200 });
});

// Get Invoices
app.post('/invoices', (req,res) => {
  Invoices.handleInvoices(req, res, db);
});

app.post('/energypoints', (req,res) => {
  EnergyPoints.handleEnergypoints(req, res, db);
});

app.post('/users', (req,res) => {
  Users.handleUsers(req, res, db, bcrypt);
});

app.post('/typeclients', (req,res) => {
  TypeClients.handleTypeClients(req, res, db);
});

app.post('/clients', (req,res) => {
  Clients.handleClients(req, res, db);
});

// Signin
app.post('/signin', (req, res) => {signin.handleSignin(req, res, db, bcrypt)});

// console.log('Constants CC_KEY : ' + Constants.CC_KEY);

const httpsServer = https.createServer({
  key: fs.readFileSync(Constants.CC_KEY),
  cert: fs.readFileSync(Constants.CC_CERT),
}, app);

// app.listen(port, () => {
//   console.log('Server ' + pjson.name + ' version ' + pjson.version + ' is running on port ' + port);
// });

httpsServer.listen(port, () => {
    console.log('Server ' + Constants.name + ' version ' + Constants.version + ' is running on port ' + port);
});
