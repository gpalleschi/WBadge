import * as Constants from '../constants/Constants';

export const deleteTypeClient = async (id_client, typeClient, setLoaded, toast) => {
   const response = await fetch(Constants.URLCCAPI + '/typeclients', {
            method: 'post',
            headers: {'Content-Type': 'application/json', 'Authorization' : `Bearer ${Constants.CC_TOKEN}`},
            body: JSON.stringify({
              id_oper: 'D', 
              id_client: id_client,
              id_type_client: typeClient.id_type_client,
            })
          });

   await response.json();

   //console.log('response status : ' + response.status);

   if ( response.status === 200 ) {
       setLoaded(false);
       return { error:0, msg : ''};
   }
   else {
       setLoaded(false);
       toast.current.show({ severity: 'error', summary: Constants.getLabel('error'), detail: Constants.getLabel('ErrorDuringDelete'), life: Constants.TIME_TOAST });
       return { error:1, msg : 'Error during delete'};
   }

}   

export const insertTypeClient = async (id_client, typeClient, setLoaded, toast) => {

   // console.log('Before api update');

   const response = await fetch(Constants.URLCCAPI + '/typeclients', {
            method: 'post',
            headers: {'Content-Type': 'application/json', 'Authorization' : `Bearer ${Constants.CC_TOKEN}`},
            body: JSON.stringify({
              id_oper: 'I', 
              id_client: id_client,
              type_client: typeClient.type_client,
              desc_type_client: typeClient.desc_type_client
            })
          });

   await response.json();

   //console.log('response status : ' + response.status);

   if ( response.status === 200 ) {
       setLoaded(false);
       return { error:0, msg : ''};
   }
   else {
       setLoaded(false);
       toast.current.show({ severity: 'error', summary: Constants.getLabel('error'), detail: Constants.getLabel('ErrorDuringInsert'), life: Constants.TIME_TOAST });
       return { error:1, msg : 'Error during insert'};
   }
}

export const updateTypeClient = async (id_client, typeClient, setLoaded, toast) => {

   // console.log('Before api update');

   const response = await fetch(Constants.URLCCAPI + '/typeclients', {
            method: 'post',
            headers: {'Content-Type': 'application/json', 'Authorization' : `Bearer ${Constants.CC_TOKEN}`},
            body: JSON.stringify({
              id_oper: 'U', 
              id_client: id_client,
              id_type_client: typeClient.id_type_client,
              type_client: typeClient.type_client,
              desc_type_client: typeClient.desc_type_client
            })
          });

   await response.json();

   //console.log('response status : ' + response.status);

   if ( response.status === 200 ) {
       setLoaded(false);
       return { error:0, msg : ''};
   }
   else {
       setLoaded(false);
       toast.current.show({ severity: 'error', summary: Constants.getLabel('error'), detail: Constants.getLabel('ErrorDuringUpdate'), life: Constants.TIME_TOAST });
       return { error:1, msg : 'Error during update'};
   }
}


export const getTypeClients = async (id_client, setDataToShow, setLoaded, toast) => {

  //console.log('DEBUG in getTypeClients.');
  setDataToShow([]);

  const response = await fetch(Constants.URLCCAPI + '/typeclients', {
            method: 'post',
            headers: {'Content-Type': 'application/json', 'Authorization' : `Bearer ${Constants.CC_TOKEN}`},
            body: JSON.stringify({
              id_oper: 'S', 
              id_client: id_client,
            })
          });

   const json = await response.json();

   if ( response.status === 200 ) {

      let type_clients = [];
      let ep = {};
      let beforeCodInvoiceFather = 'xxxx';

      //console.log('DEBUG json : ' + JSON.stringify(json));

      Object.keys(json).map((keyI,x,value) => {
                       type_clients.push({
                          id_type_client : json[keyI].ID_TYPE_CLIENT,
                          type_client : json[keyI].TYPE_CLIENT,
                          desc_type_client : json[keyI].DESC_TYPE_CLIENT,
                       });
      setDataToShow(type_clients); 
      // console.log('Energy Points : ' +  JSON.stringify(energy_poins));
      });
   } 
   else {
      setLoaded(false);
      toast.current.show({ severity: 'error', summary: Constants.getLabel('error'), detail: Constants.getLabel('ErrorDuringFetch'), life: Constants.TIME_TOAST });
      return { error:1, msg : 'Error in fetch'};
   }

   // console.log('DEBUG : exit from getTypeClients');
   setLoaded(false);
   return { error:0, msg : ''};
}

export const getReportsDataTC = async (id_client, setYears, setYear, setTypesClient, setLoaded, setDataToShow, setTypesClientSelected) => {

  let retSelLabelYears = [];
  let retTypesClient = [];
  let retTypesClientSelected = [];

  const response = await fetch(Constants.URLCCAPI + '/typeclients', {
            method: 'post',
            headers: {'Content-Type': 'application/json', 'Authorization' : `Bearer ${Constants.CC_TOKEN}`},
            body: JSON.stringify({
              id_oper: 'S', 
              id_client: id_client,
            })
          });
   const json = await response.json();

   if ( response.status == 200 ) {
      Object.keys(json).map((keyI,value) => {
                       retTypesClient.push(json[keyI].TYPE_CLIENT);
                       retTypesClientSelected.push(json[keyI].TYPE_CLIENT);
                      });
      retTypesClient.push(Constants.getLabel('undefined'));
      setTypesClient(retTypesClient);
      retTypesClientSelected.push(Constants.getLabel('undefined'));
      setTypesClientSelected(retTypesClientSelected);

      // console.log('In typeClients retTypesClient : ' + retTypesClient);
      // console.log('In typeClients retTypesClientSelected : ' + retTypesClientSelected);
      const response = await fetch(Constants.URLCCAPI + '/typeclients', {
                method: 'post',
                headers: {'Content-Type': 'application/json', 'Authorization' : `Bearer ${Constants.CC_TOKEN}`},
                body: JSON.stringify({
                  id_oper: 'Y', 
                  id_client: id_client,
            })
      });
      const json2 = await response.json();

      if ( response.status == 200 ) {

         Object.keys(json2).map((keyI,value) => {
            retSelLabelYears.push({label : json2[keyI].year, value : json2[keyI].year});
         });
         setYears(retSelLabelYears);
         setYear(retSelLabelYears[0].value);

         getReportsTCDataYear(id_client, retSelLabelYears[0].value, retTypesClientSelected, setDataToShow);
//         getReportsEPYear(id_client, type_invoice, retSelLabelYears[0].value, retCodInvoices.slice(0,Constants.CCMAX_ELEM_SHOW_GRAPH+1), setDataToShowEP);

      } 
      else {
         setLoaded(false);
         return { error:1, msg : Constants.getLabel('ErrorDuringFetch')};
      }

   } 
   else {
      setLoaded(false);
      return { error:1, msg : Constants.getLabel('ErrorDuringFetch')};
   }

   setLoaded(false);
   return { error:0, msg : ''};
}

export const getReportsTCDataYear = async (id_client, year, list_type_client, setDataToShow) => {

   let data = [];

   let arrayToSearch = [...list_type_client];

   const index = arrayToSearch.indexOf(Constants.getLabel('undefined')); // 👉️  0

   if ( index >= 0 ) {
      arrayToSearch[index] = 'NULL';
   }

   const response = await fetch(Constants.URLCCAPI + '/typeclients', {
               method: 'post',
                headers: {'Content-Type': 'application/json', 'Authorization' : `Bearer ${Constants.CC_TOKEN}`},
                body: JSON.stringify({
                  id_oper: 'TC', 
                  id_client: id_client,
                  year: year,
                  list_type_client : arrayToSearch
            })
   });

   const json = await response.json();

   if ( response.status == 200 ) {
      Object.keys(json).map((keyI,value) => {
                       data.push(
                        {year : json[keyI].YEAR, 
                         type_client : json[keyI].TYPE_CLIENT.replace("NULL",Constants.getLabel('undefined')),
                         m01 : json[keyI].M01,
                         v01 : json[keyI].V01,
                         m02 : json[keyI].M02,
                         v02 : json[keyI].V02,
                         m03 : json[keyI].M03,
                         v03 : json[keyI].V03,
                         m04 : json[keyI].M04,
                         v04 : json[keyI].V04,
                         m05 : json[keyI].M05,
                         v05 : json[keyI].V05,
                         m06 : json[keyI].M06,
                         v06 : json[keyI].V06,
                         m07 : json[keyI].M07,
                         v07 : json[keyI].V07,
                         m08 : json[keyI].M08,
                         v08 : json[keyI].V08,
                         m09 : json[keyI].M09,
                         v09 : json[keyI].V09,
                         m10 : json[keyI].M10,
                         v10 : json[keyI].V10,
                         m11 : json[keyI].M11,
                         v11 : json[keyI].V11,
                         m12 : json[keyI].M12,
                         v12 : json[keyI].V12,
                         })});
       setDataToShow(data);
   } else {
       // TODO: Error Managment
       console.log('ERROR in fetch D');
       return { error:1, msg : 'Error in fetch'};
   }  
   return { error:0, msg : ''};
}
