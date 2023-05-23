import React, {useEffect, useContext, useRef, useState} from 'react';
import { DataTable } from 'primereact/datatable';
import { LoadingScreen } from './LoadingScreen';
import { AppContext } from '../contexts/appContext';
import { Column } from 'primereact/column';
import { Button } from 'primereact/button';
import { Toast } from 'primereact/toast';
import { Dialog } from 'primereact/dialog';
import { InputText } from 'primereact/inputtext';
import { InputTextarea } from 'primereact/inputtextarea';
import * as Constants from '../constants/Constants';
import Grid from '@mui/material/Grid';
import { Toolbar } from 'primereact/toolbar';

import { getTypeClients, updateTypeClient, deleteTypeClient, insertTypeClient } from '../api_calls/typeClients';

export const TypeClientsScreen = (props) => {

    const [loaded, setLoaded] = useState(true);
    const [reload, setReload] = useState(false);
    const [dataToShow, setDataToShow] = useState([]);
    const [changeDialog, setChangeDialog] = useState(false);
    const { user } = useContext(AppContext);
    const [submitted, setSubmitted] = useState(false);
    const [typeClient, setTypeClient] = useState({});
    const [typeOpe,setTypeOpe] = useState(null);

    const toast = useRef(null);

    useEffect(() => {
          setLoaded(true);
          getTypeClients(user.id_client, setDataToShow, setLoaded, toast );
    }, [reload]);

    const leftToolbarTemplate = () => {
        return (
            <div className="flex flex-wrap gap-2">
                <Button label={Constants.getLabel('newLabel')} icon="pi pi-plus" severity="success" onClick={ () => { newTypeClient(); }} />
            </div>
        );
    };

    const onInputChange = (e, name) => {
        const val = (e.target && e.target.value) || '';
        let _typeClients = {...typeClient};
        _typeClients[`${name}`] = val;
        setTypeClient(_typeClients);
    }

    const newTypeClient = () => {
        setTypeClient({
            id_type_client : 999,
            type_client : '',
            desc_type_client : ''
        });

        setTypeOpe('Insert');
        setChangeDialog(true);
    }

    const elabTypeClient = (rowData, currTypeOpe) => {

        setTypeClient({
            id_type_client : rowData.id_type_client,
            type_client : rowData.type_client,
            desc_type_client : rowData.desc_type_client
        });

        setTypeOpe(currTypeOpe);
        setChangeDialog(true);
    }

    const saveTypeClient = async () => {
        var ret;
        var errorMsg;
        var successMsg;
        setSubmitted(true);

        // console.log('TypeClient : <' + JSON.stringify(typeClient) );
        setLoaded(true);
        if ( typeOpe == 'Edit' ) {
           ret = await updateTypeClient(user.id_client, typeClient, setLoaded, toast); 
           errorMsg = Constants.getLabel('errUpdate');
           successMsg = Constants.getLabel('typeClientUpdated');
        } else if ( typeOpe == 'Delete' ) {
        //    console.log('DEBUG entro in Delete');
           ret = await deleteTypeClient(user.id_client, typeClient, setLoaded, toast); 
           errorMsg = Constants.getLabel('errDelete');
           successMsg = Constants.getLabel('typeClientDeleted');
        } else {
           ret = await insertTypeClient(user.id_client, typeClient, setLoaded, toast); 
           errorMsg = Constants.getLabel('errInsert');
           successMsg = Constants.getLabel('typeClientInserted');
        }

        // console.log('ret : ' + JSON.stringify(ret));

        if ( ret.error ) {
           toast.current.show({ severity: 'error', summary: Constants.getLabel('error'), detail: errorMsg, life: Constants.TIME_TOAST });
        } else {
           toast.current.show({ severity: 'success', summary: Constants.getLabel('success'), detail: successMsg, life: Constants.TIME_TOAST });
        }

        setReload(!reload);
        setSubmitted(false);
        setChangeDialog(false);
    }

    const actionBodyTemplateFather = (rowData) => {
        return (
            <React.Fragment>
                <Button icon="pi pi-pencil" className="p-button-rounded p-button-success mr-2" onClick={ () => elabTypeClient(rowData, 'Edit') } />
                <Button icon="pi pi-trash" className="p-button-rounded p-button-danger mr-2" onClick={ () => {elabTypeClient(rowData,'Delete')}} />
            </React.Fragment>
        );
    }

    const hideDialog = () => {
        setSubmitted(false);
        setChangeDialog(false);
    }

    const typeClientsDialogFooter = (
        <React.Fragment>
            {
                (typeOpe != 'Delete') ?
                <Button label={Constants.getLabel('cancel')} icon="pi pi-times" className="p-button-text" onClick={hideDialog} />
                : <></>
            }
            <Button label={typeOpe != 'Delete' ? Constants.getLabel('save') : Constants.getLabel('delete')} icon="pi pi-check" className="p-button-text" onClick={ () => {
                
                if ( typeOpe != 'Delete' && (typeClient.type_client.trim().length == 0 || typeClient.desc_type_client.trim().length == 0) ) {
                  console.log('DEBUG Errore per campi non settati.');
                } else {
                  saveTypeClient(); 
                }
            }} />
        </React.Fragment>
   );

    return (
        <>
        <Toast ref={toast} position="bottom-right"></Toast>
        { loaded ?
            <LoadingScreen isActive={loaded} />
        :
        <>
            <Grid container spacing={0} direction='column' >
                <Grid item sm={12}>
                    <h2 style={{textAlign: "center",  color: "green"}}>{ Constants.getLabel('headerTypeClientsMgmt') }</h2>
                </Grid>
                <Grid container 
                        justifyContent="center"
                        alignItems="center"
                        >

                </Grid>
                <Grid container 
                    justifyContent="left"
                    alignItems="center">
                        <Grid item sm={1} />
                        <Toolbar className="mb-1" left={leftToolbarTemplate} right={<></>}></Toolbar>
                        <Grid item sm={11} />
                </Grid>
                <Grid container 
                    justifyContent="center"
                    alignItems="center">
                        <Grid item sm={1} />
                        <Grid item sm={10} >
                            <div className="card">
                                <DataTable value={dataToShow} responsiveLayout="scroll">
                                    <Column field="type_client" filter="true" header={ Constants.getLabel('typeClient')} />
                                    <Column field="desc_type_client" filter="true" header={ Constants.getLabel('descTypeClient') } />
                                    <Column body={actionBodyTemplateFather} align="center" exportable={false} style={{ minWidth: '1rem' }}></Column>
                                </DataTable>
                            </div>
                        </Grid>
                        <Grid item sm={1} />
                </Grid>
            </Grid>

            <Dialog visible={changeDialog} style={{ width: '50%' }} header={ typeOpe == 'Edit' ? Constants.getLabel('headerEditTypeClient') : ( typeOpe == 'Delete' ? Constants.getLabel('headerDelTypeClient') : Constants.getLabel('headerInsTypeClient')) } modal className="p-fluid" footer={typeClientsDialogFooter} 
                    onHide={hideDialog}>
                <div className="field">
                    <label style={{color: 'green'}} htmlFor="name">{Constants.getLabel('typeClient')}</label>
                    <InputText id="name" value={typeClient.type_client} onChange={(e) => onInputChange(e, 'type_client')} disabled={typeOpe == 'Delete' ? true : false} autoFocus required/>
                    {changeDialog && typeClient.type_client.trim().length == 0 && <small className="p-error">{Constants.getLabel('typeClient')} é obrigatório.</small>}
                </div>
                <div className="field">
                    <label style={{color: 'green'}} htmlFor="description">{Constants.getLabel('descTypeClient')}</label>
                    <InputTextarea id="description" value={typeClient.desc_type_client} onChange={(e) => onInputChange(e, 'desc_type_client')} disabled={typeOpe == 'Delete' ? true : false} required rows={3} cols={20} autoResize/>
                    {changeDialog && typeClient.desc_type_client.trim().length == 0 && <small className="p-error">{Constants.getLabel('descTypeClient')} é obrigatório.</small>}
                </div>
            </Dialog>
        </>
        }
        </>
    )

}