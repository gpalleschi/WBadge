import * as Constants from './constants.js';

export const handleTypeClients = (req, res, db) => {
    const {
        id_oper,
        id_client,
        id_type_client,
        type_client,
	    desc_type_client,
        list_type_client,
        year
    } = req.body;

    // console.log('DEBUG in handleTypeClients : ' + JSON.stringify(req.body));

    //console.error('DEBUG => id_oper ' + id_oper + ' group_invoice => ' + group_invoice + ' id_invoice => ' + id_invoice + ' id_client => ' + id_client + ' type_invoice => ' + type_invoice + ' cod_invoice => ' + cod_invoice + ' period =>' + period);
    if ( Constants.checkToken(req) ) {

        switch (id_oper) {

            case "S":
                db
                    .select('ID_TYPE_CLIENT', 'TYPE_CLIENT', 'DESC_TYPE_CLIENT')
                    .from('cc_type_clients')
                    .where('ID_CLIENT', '=', id_client)
                    .then(type_clients => {
                        //  console.log('Length : ' + invoices.length);
                        if (type_clients.length) {
                            //console.log('Cod Invoices : ' + JSON.stringify(cod_invoices));
                            res
                                .status(200)
                                .json(Object.assign({}, type_clients));
                        } else {
                            res
                                .status(200)
                                .json(Object.assign({}, type_client));
                        }
                    })
                    .catch(err => {
                        console.log('Error : ' + err);
                        res
                            .status(400)
                            .json(err);
                    });
                break;
            case "I":
                db.transaction(trx => {
                trx('cc_type_clients')
                .insert({id_client : id_client, type_client : type_client.trim(), desc_type_client: desc_type_client})
                .then(trx.commit)
                .then(type_clients => {
                        res.status(200).json('OK');
                })
                .catch(err => {
                        console.log('Error : ' + err);
                        res.status(400).json(err);
                    });
                })
	          .catch(err => {
                    console.log('Error : ' + err);
                    res.status(400).json(err);
              });
              break;
            case "D":
                db.transaction(trx => {
                trx('cc_type_clients')
                    .select('*')
                    .where('ID_CLIENT', '=', id_client)
                    .where('ID_TYPE_CLIENT', '=', id_type_client)
                    .del()
                    .then(trx.commit)
                    .then(type_clients => {
                        res.status(200).json('OK');
                    })
                    .catch(err => {
                        console.log('Error : ' + err);
                        res.status(400).json(err);
                    });
                })
	          .catch(err => {
                    console.log('Error : ' + err);
                    res.status(400).json(err);
              });
              break;
            case "U":
                db('cc_type_clients')
                    .update(
                        {TYPE_CLIENT: type_client.trim(), DESC_TYPE_CLIENT: desc_type_client}
                    )
                    .where('ID_CLIENT', '=', id_client)
                    .where('ID_TYPE_CLIENT', '=', id_type_client)
                    .then(elem => {

                        if (elem) {
                            res
                                .status(200)
                                .json('OK');
                        } else {
                            console.log(
                                'Update Type Client than a description. id_client : ' + id_client + ' ID_TYPE_C' +
                                'LIENT : ' + id_type_client
                            );
                            res.status(400),
                            json('More than one type_client');
                        }

                    })
                    .catch(err => {
                        console.log('Error : ' + err);
                        res
                            .status(400)
                            .json(err);
                    });
                break;	
    	case "TC":
            // DD
            // console.log('list typeclients : ' + JSON.stringify(list_type_client));
    		db.select('YEAR','TYPE_CLIENT',  
                      db.raw('SUM(M01) as M01'),
                      db.raw('SUM(V01) as V01'),
                      db.raw('SUM(M02) as M02'),
                      db.raw('SUM(V02) as V02'),
                      db.raw('SUM(M03) as M03'),
                      db.raw('SUM(V03) as V03'),
                      db.raw('SUM(M04) as M04'),
                      db.raw('SUM(V04) as V04'),
                      db.raw('SUM(M05) as M05'),
                      db.raw('SUM(V05) as V05'),
                      db.raw('SUM(M06) as M06'),
                      db.raw('SUM(V06) as V06'),
                      db.raw('SUM(M07) as M07'),
                      db.raw('SUM(V07) as V07'),
                      db.raw('SUM(M08) as M08'),
                      db.raw('SUM(V08) as V08'),
                      db.raw('SUM(M09) as M09'),
                      db.raw('SUM(V09) as V09'),
                      db.raw('SUM(M10) as M10'),
                      db.raw('SUM(V10) as V10'),
                      db.raw('SUM(M11) as M11'),
                      db.raw('SUM(V11) as V11'),
                      db.raw('SUM(M12) as M12'),
                      db.raw('SUM(V12) as V12'))
                .from('ccv_type_client_report')                         
                .where('ID_CLIENT','=',id_client)
                .where('YEAR','=',year)
                .whereIn('TYPE_CLIENT', list_type_client)
                .groupBy('YEAR', 'TYPE_CLIENT')
                .orderBy('TYPE_CLIENT')
    	        .then( data_rep => {
            //  console.log('Length : ' + invoices.length);
                 if ( data_rep.length ) {  
                    // console.log('Data Rep : ' + JSON.stringify(data_rep));
    		        res.status(200).json(Object.assign({},data_rep));
                 } else {
                    res.status(400).json('Not Found');
                 }   
    		     })
                 .catch(err => {
                        console.log('Error : ' + err);
                        res.status(400).json('NOK');
                 });

    		break;
    	case "Y":
            db('cc_invoices').distinct(db.raw('substr(PERIOD,4) as year'))
            .where('ID_CLIENT','=',id_client)
            .where('GROUP_INVOICE','=','MAE')
            .orderBy('year', 'desc')
    	    .then( years => {
            //  console.log('Length : ' + invoices.length);
                 if ( years.length ) {  
                    //console.log('Years : ' + JSON.stringify(years));
    		        res.status(200).json(Object.assign({},years));
                 } else {
                    res.status(400).json('Not Found');
                 }   
    		     })
                 .catch(err => {
                        console.log('Error : ' + err);
                        res.status(400).json('NOK');
                 });
    		break;

            default:
                    res.status(400).json('error id operation : <' + id_oper + '> not recognized.');
                }
    } else {
    	res.sendStatus(403).JSON('Error Security Code violated.');
    }
}