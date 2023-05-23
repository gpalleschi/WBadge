import React, {useEffect, useContext, useState} from 'react';
import { getReportsData, getReportsDataYear, getReportsEPYear } from '../api_calls/invoices';
import { LoadingScreen } from './LoadingScreen';
import { AppContext } from '../contexts/appContext';
import { DataReport } from '../component/Reports/DataReport';
import { TabView, TabPanel } from 'primereact/tabview';

import "primereact/resources/themes/saga-green/theme.css";
import { MultiSelect } from "primereact/multiselect";
import "primereact/resources/primereact.css";
import './EnergyReportScreen.css';
import { Dropdown } from 'primereact/dropdown';
import * as Constants from '../constants/Constants';
import { ReportGraph } from '../component/Graphs/ReportGraph';
import "primeflex/primeflex.css";
import { EnergyPointsGraph } from '../component/Graphs/EnergyPointsGraph';

const setError = () => {
  console.log('errore');
}

export const EnergyReportScreen = (props) => {

  const [loaded, setLoaded] = useState(true);
  const [codInvoicesSelected, setCodInvoicesSelected] = useState([]);
  const [labelInvoices, setLabelInvoices] = useState([]);
  const [dataToShow, setDataToShow] = useState([]);
  const [dataToShowEP, setDataToShowEP] = useState([]);
  const { user } = useContext(AppContext);

  const [years, setYears] = useState([]);
  const [year, setYear] = useState(null);
  const [codeInvoices, setCodeInvoices] = useState([]);
  const [isSumTETUSD, setIsSumTETUSD] = useState(false);

  const [metric, setMetric] = useState(Constants.METRICS[1])
  const [metrics, setMetrics] = useState(Constants.METRICS)

  console.log('DEBUG : In EnergyReportScreen loaded : ' + loaded);

  const handleChangeMetric = (event) => {
    setMetric(event.target.value);
  };

  const getCodInvoicesToSelect = (valueInvoceToSelect) => {
    const codInvoceToSelect = [];
    for ( let i=0;i<valueInvoceToSelect.length;i++) {
        codInvoceToSelect.push(valueInvoceToSelect[i].split(' - ')[0]);
    }

    return codInvoceToSelect;
  }

  const handleCodInvoice = (e) => {
    console.log('DEBUG CodInvoice Selected : ' + JSON.stringify(e.value));
    setCodInvoicesSelected(e.value);
    setLoaded(true);
    getReportsDataYear(user.id_client, props.type_invoice, year, e.value, setDataToShow );
    getReportsEPYear(user.id_client, props.type_invoice, year, e.value, setDataToShowEP );
    setLoaded(false);
  }

  const handleChangeYear = (event) => {
    setYear(event.target.value);

    setLoaded(true);
    const codInvToSel = getCodInvoicesToSelect(codInvoicesSelected);
    // TODO: Error managment and when don't return nothing
    getReportsDataYear(user.id_client, props.type_invoice, event.target.value, codInvToSel, setDataToShow );
    getReportsEPYear(user.id_client, props.type_invoice, event.target.value, codInvToSel.slice(0,Constants.CCMAX_ELEM_SHOW_GRAPH+1), setDataToShowEP );
    setLoaded(false);
  };

  useEffect(() => {
      console.log('In useEffect of EnergyReportScreen');
      setIsSumTETUSD(false);
      // TODO: Error Managment
      getReportsData(user.id_client, props.type_invoice, setYears, setYear, setCodeInvoices, setLoaded, setDataToShow, setCodInvoicesSelected, setLabelInvoices, setDataToShowEP );
      setLoaded(true);
     
      // console.log('Periods : ' + periods);
  }, [props]);

  return ( 
    <>
    { loaded ?
    <LoadingScreen isActive={loaded} />
    :
    <div className="card">
      <div className="flex justify-content-around flex-row flex-wrap card-container">
          <h1 style={{textAlign: "center",  color: "green" }}>{ props.type_invoice === 'A' ? Constants.getLabel('titleReportA') : Constants.getLabel('titleReportB')}</h1>
      </div>
      <div className="flex justify-content-around flex-row flex-wrap card-container blue-container mb-5">
          <div className="flex align-items-center justify-content-center ">
              <div className="justify-content-between">
                  <label style={{color: Constants.COLOR_LABELS}}>{ Constants.getLabel('selYear')}</label>
                  <Dropdown style={{fontColor: Constants.COLOR_LABELS, backgroundColor: Constants.BGCOLOR, borderColor: Constants.COLOR_LABELS   }} inputId="dy" tooltip={ Constants.getLabel('selYear')} value={year} options={years} onChange={handleChangeYear} placeholder={ Constants.getLabel('selYear')}/>
              </div>
          </div>
          <div className="flex align-items-center justify-content-center">
              <div className="flex align-items-center justify-content-center">
              {/* TODO: Change label items selected */}
                  <div className="justify-content-between">
                    <label style={{color: Constants.COLOR_LABELS}}>{ Constants.getLabel('selEnergyPoints')}</label>
                    <MultiSelect style={{color: Constants.COLOR_LABELS, backgroundColor: Constants.BGCOLOR, borderColor: Constants.COLOR_LABELS  }} 
                                  maxSelectedLabels={0} 
                                  tooltip={ Constants.getLabel('selEnergyPoints')}
                                  value={codInvoicesSelected} 
                                  options={labelInvoices} 
                                  onChange={handleCodInvoice} 
                                  selectedItemsLabel= { codInvoicesSelected.length + ' ' + Constants.getLabel('energyPointsSelected')}
                                  filter={true} />
                  </div>
              </div>            
          </div>
          <div className="flex align-items-center justify-content-center">
                  <div className="justify-content-between">
                    <label style={{color: Constants.COLOR_LABELS}}>{ Constants.getLabel('selMetric')}</label>
                    <Dropdown style={{fontColor: Constants.COLOR_LABELS, backgroundColor: Constants.BGCOLOR, borderColor: Constants.COLOR_LABELS   }} inputId="dm" tooltip={ Constants.getLabel('selMetric')} value={metric} options={metrics} onChange={handleChangeMetric} placeholder={ Constants.getLabel('selMetric')} />
                  </div>
          </div>
      </div>
      <div className="flex justify-content-around flex-row flex-wrap card-container blue-container">
      <div className="flex align-items-center justify-content-center">
      <TabView>
              <TabPanel header={ Constants.getLabel('relatorio')}>
                      <DataReport dataToShow={ dataToShow } isSumTETUSD= {isSumTETUSD} metric={metric} type={'ER'}/>
              </TabPanel>
              <TabPanel header={ Constants.getLabel('titleYearGraph')}>
                      <ReportGraph dataToShow={ dataToShow } metric= { metric } isSumTETUSD= {isSumTETUSD} type={'ER'}/>
              </TabPanel>
              <TabPanel header={ Constants.getLabel('titleEPGraph')}>
                      <EnergyPointsGraph dataToShow={ dataToShowEP } metric= { metric } isSumTETUSD= {isSumTETUSD}/>
              </TabPanel>
      </TabView>
      </div>
      </div>
    </div> 
    }
    </>
  );
}
