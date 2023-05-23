import * as Constants from './constants.js';

export const handleEnergypoints = (req, res, db) => {
    const {
        id_oper,
        id_client,
	type_invoice,
	group_invoice,
	cod_invoice,
	desc_cod_invoice,
	cod_invoice_father,
    type_client
    } = req.body;

    //console.error('DEBUG => id_oper ' + id_oper + ' group_invoice => ' + group_invoice + ' id_invoice => ' + id_invoice + ' id_client => ' + id_client + ' type_invoice => ' + type_invoice + ' cod_invoice => ' + cod_invoice + ' period =>' + period);

    if ( Constants.checkToken(req) ) {

        switch (id_oper) {

            case "S":
            	db.select('TYPE_INVOICE','COD_INVOICE_FATHER','DESC_COD_INVOICE_FATHER','COD_INVOICE','TYPE_CLIENT','DESC_COD_INVOICE')
           	.from('ccv_cod_invoice')
            	.where('ID_CLIENT','=',id_client)
            	.where('GROUP_INVOICE','=','FILHA')
            	.orderBy('TYPE_INVOICE')
            	.orderBy('COD_INVOICE_FATHER')
            	.orderBy('COD_INVOICE')
    	    	.then( energy_points => {
            //  console.log('Length : ' + invoices.length);
         	        if ( energy_points.length ) {  
                    //console.log('Cod Invoices : ' + JSON.stringify(cod_invoices));
    		   	     res.status(200).json(Object.assign({},energy_points));
      	 	        } else {
                	    res.status(400).json('Not Found');
                	}   
    		     })
                 .catch(err => {
                        console.log('Error : ' + err);
                        res.status(400).json(err);
                 });
    		break;
            case "U":
                db('cc_cod_invoice')
                .update({  DESC_COD_INVOICE: desc_cod_invoice, TYPE_CLIENT: type_client })
                .where('ID_CLIENT', '=', id_client)
                // .where('TYPE_INVOICE', '=', type_invoice)
                .where('GROUP_INVOICE', '=', group_invoice)
                .where('COD_INVOICE', '=', cod_invoice)
                .where('COD_INVOICE_FATHER', '=', cod_invoice_father)
    	    	.then( elem => {

		    if ( elem ) {
    		       res.status(200).json('OK');
		    } else {
                       console.log('Update Energy Point more than a description. id_client : ' + id_client + ' COD_INVOICE : ' + cod_invoice + ' COD_INVOICE_FATHER : ' + cod_invoice_father);
                       res.status(400),json('More than one cod invoice');
		    }

		})	
                 .catch(err => {
                        console.log('Error : ' + err);
                        res.status(400).json(err);
                 });
    		break;		
            default:
            res.status(400).json('error id operation : <' + id_oper + '> not recognized.');
        }
    } else {
    	res.sendStatus(403).JSON('Error Security Code violated.');
    }
}