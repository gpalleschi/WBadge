import React, {useEffect, useContext, useRef, useState} from 'react';
import Grid from '@mui/material/Grid';
import { getEnergyPoints, updateEnergyPoints } from '../api_calls/energyPoints';
import { LoadingScreen } from './LoadingScreen';
import { AppContext } from '../contexts/appContext';
import { DataTable } from 'primereact/datatable';
import { Column } from 'primereact/column';
import { Button } from 'primereact/button';
import { Toast } from 'primereact/toast';
import { Dialog } from 'primereact/dialog';
import { InputText } from 'primereact/inputtext';
import { InputTextarea } from 'primereact/inputtextarea';
import * as Constants from '../constants/Constants';
import './EnergyPointScreen.module.css';
import { getTypeClients } from '../api_calls/typeClients';
import { Dropdown } from 'primereact/dropdown';

export const EnergyPointScreen = (props) => {

  const [loaded, setLoaded] = useState(true);
  const [reload, setReload] = useState(false);
  const [changeDialog, setChangeDialog] = useState(false);
  const [invoice, setInvoice] = useState({});
  const [dataToShow, setDataToShow] = useState([]);
  const [typeClients, setTypeClients] = useState([]);
  const [selectedTypeClient,setSelectedTypeClient] = useState(null);
  const [expandedRows, setExpandedRows] = useState(null);
  const { user } = useContext(AppContext);
  const toast = useRef(null);
  const [submitted, setSubmitted] = useState(false);

  useEffect(() => {
      setLoaded(true);
      // TODO: Error Managment
      getEnergyPoints(user.id_client, setDataToShow, setLoaded, toast);
      // Get Type Clients
      setLoaded(true);
      getTypeClients(user.id_client, setTypeClients, setLoaded, toast);
     
  }, [reload]);

  const onRowCollapse = (event) => {
	console.log('Collapsed');
  }

  const onRowExpand = (event) => {
	console.log('Expanded');
  }

  const rowExpansionTemplate = (data) => {
        return (
            <div className="cod_invoices_filha">
                <h5>Contratos Filha de {data.cod_invoice_father}</h5>
                <DataTable value={data.cod_invoices_filha} responsiveLayout="scroll">
                    <Column field="cod_invoice" header="Contrato Filha" filter="true" sortable></Column>
                    <Column field="desc_cod_invoice" header="Descrição do contrato filha" filter="true" sortable></Column>
                    <Column field="type_client" header={Constants.getLabel('typeClient')} filter="true" sortable></Column>
		                <Column body={actionBodyTemplate} align="center" exportable={false} style={{ minWidth: '8rem' }}></Column>
                </DataTable>
            </div>
        );
  }

  const hideDialog = () => {
        setSubmitted(false);
        setChangeDialog(false);
  }

  const onInputChange = (e, name) => {
        const val = (e.target && e.target.value) || '';
        let _invoice = {...invoice};
        _invoice[`${name}`] = val;
        setInvoice(_invoice);
    }

  const saveInvoice = async () => {
    setSubmitted(true);

    console.log('Invoice : <' + JSON.stringify(invoice) );
    setLoaded(true);
    const ret = await updateEnergyPoints(user.id_client, invoice, setLoaded, toast); 

    console.log('ret : ' + JSON.stringify(ret));

    if ( ret.error ) {
      toast.current.show({ severity: 'error', summary: Constants.getLabel('error'), detail: Constants.getLabel('errUpdate'), life: Constants.TIME_TOAST });
     } else {
      toast.current.show({ severity: 'success', summary: Constants.getLabel('success'), detail: Constants.getLabel('descUpdated'), life: Constants.TIME_TOAST });
    }

    setReload(!reload);
    setSubmitted(false);
    setChangeDialog(false);

  }

  const energyPointsDialogFooter = (
        <React.Fragment>
            <Button label={Constants.getLabel('cancel')} icon="pi pi-times" className="p-button-text" onClick={hideDialog} />
            <Button label={Constants.getLabel('save')} icon="pi pi-check" className="p-button-text" onClick={saveInvoice} />
        </React.Fragment>
  );

  const editInvoice = (rowData, type) => {

    if ( type === 'MAE' ) {
      setInvoice({ group_invoice: "MAE", 
                   type_invoice: rowData.type_invoice,
                   cod_invoice_father: rowData.cod_invoice_father,
                   desc_label_cod_invoice: Constants.getLabel('contract'),
                   cod_invoice: rowData.cod_invoice_father, 
                   desc_label_desc_cod_invoice: Constants.getLabel('descContract'),
                   desc_cod_invoice: rowData.desc_cod_invoice_father});

    } else {
      setInvoice({ group_invoice: "FILHA", 
                   type_invoice: rowData.type_invoice,
                   cod_invoice_father: rowData.cod_invoice_father,
                   desc_label_cod_invoice: Constants.getLabel('subContract'),
                   cod_invoice: rowData.cod_invoice, 
                   desc_label_desc_cod_invoice: Constants.getLabel('descSubContract'),
                   desc_cod_invoice: rowData.desc_cod_invoice,
                   type_client: rowData.type_client});
      setSelectedTypeClient(rowData.type_client);

    }
    setChangeDialog(true);

  }

  const actionBodyTemplate = (rowData) => {
        return (
            <React.Fragment>
                <Button icon="pi pi-pencil" className="p-button-rounded p-button-success mr-2" onClick={ () => editInvoice(rowData,'FILHA') } />
            </React.Fragment>
        );
  }

  const actionBodyTemplateFather = (rowData) => {
        return (
            <React.Fragment>
                <Button icon="pi pi-pencil" className="p-button-rounded p-button-success mr-2" onClick={ () => editInvoice(rowData,'MAE') } />
            </React.Fragment>
        );
  }


  return (
    <>
    <Toast ref={toast} position="bottom-right"></Toast>
    { loaded ?
    <LoadingScreen isActive={loaded} />
    :
    <>
    <Grid container spacing={0} direction='column' >
      <Grid item sm={12}>
          <h2 style={{textAlign: "center",  color: "green"}}>{ Constants.getLabel('headerEnergyPointsMgmt') }</h2>
      </Grid>
      <Grid container 
            justifyContent="center"
            alignItems="center"
            >
		
      <Grid item sm={1} />
      <Grid item sm={10} >
            <div className="card">
                <DataTable value={dataToShow} expandedRows={expandedRows} onRowToggle={(e) => setExpandedRows(e.data)}
                    onRowExpand={onRowExpand} onRowCollapse={onRowCollapse} responsiveLayout="scroll"
                    rowExpansionTemplate={rowExpansionTemplate} dataKey="cod_invoice_father" >
                    <Column expander style={{ width: '3em' }} />
                    <Column field="type_invoice" filter="true" header={ Constants.getLabel('typeInvoice')} />
                    <Column field="cod_invoice_father" filter="true" header={ Constants.getLabel('contract') } />
                    <Column field="desc_cod_invoice_father" filter="true" header={ Constants.getLabel('descContract') } />
		                <Column body={actionBodyTemplateFather} align="center" exportable={false} style={{ minWidth: '8rem' }}></Column>
                </DataTable>
            </div>
      </Grid>
      <Grid item sm={1} />
    </Grid>
    </Grid>

{/* Dialog Modify */}

            <Dialog visible={changeDialog} style={{ width: '50%' }} header={ Constants.getLabel('headerEditDescContract')} modal className="p-fluid" footer={energyPointsDialogFooter} 
                    onHide={hideDialog}>
                <div className="field">
                    <label style={{color: 'green'}} htmlFor="name">{invoice.desc_label_cod_invoice}</label>
                    <InputText id="name" value={invoice.cod_invoice} disabled={true} />
                </div>
                <div className="field">
                    <label style={{color: 'green'}} htmlFor="description">{invoice.desc_label_desc_cod_invoice}</label>
                    <InputTextarea id="description" value={invoice.desc_cod_invoice} onChange={(e) => onInputChange(e, 'desc_cod_invoice')} autoFocus required rows={3} cols={20} autoResize/>
                    {/* TODO: Aggiungi Combo Box solo per figlia con type_client */
                      
                       changeDialog && invoice.hasOwnProperty('type_client') ?
                       <>
                       <label style={{color: 'green'}} htmlFor="typeClient">{Constants.getLabel('typeClient')}</label>
                       <Dropdown value={selectedTypeClient} onChange={(e) => setSelectedTypeClient(e.value)} options={typeClients} optionLabel="type_client" placeholder="Select a Type Client" />
                       </>
                       : <></>
                    }
                    {changeDialog && invoice.desc_cod_invoice.trim().length == 0 && <small className="p-error">{invoice.desc_label_desc_cod_invoice} é obrigatório.</small>}
                </div>
            </Dialog>
    </>
    }
    </>
  )
}
