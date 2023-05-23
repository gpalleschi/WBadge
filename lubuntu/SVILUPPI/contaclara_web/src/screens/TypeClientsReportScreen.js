import React, {useEffect, useContext, useState} from 'react';
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
import "primeflex/primeflex.css";
import { getReportsDataTC, getReportsTCDataYear } from '../api_calls/typeClients';
import { ReportGraph } from '../component/Graphs/ReportGraph';

export const TypeClientsReportScreen = () => {

  const [loaded, setLoaded] = useState(true);
  const [reload, setReload] = useState(false);

  const [typesClient, setTypesClient] = useState([]);
  const [typesClientSelected, setTypesClientSelected] = useState([]);

  const [years, setYears] = useState([]);
  const [year, setYear] = useState(null);
  const [metric, setMetric] = useState(Constants.METRICS[1])
  const [metrics, setMetrics] = useState(Constants.METRICS)

  const [dataToShow, setDataToShow] = useState([]);
  const { user } = useContext(AppContext);

  console.log('DEBUG : In TypeClientsReportScreen loaded : ' + loaded);

  const handleChangeMetric = (event) => {
    setMetric(event.target.value);
  };

  const handleTypesClient = (e) => {
    console.log('DEBUG CodInvoice Selected : ' + JSON.stringify(e.value));
    setTypesClientSelected(e.value);
    setLoaded(true);
    getReportsTCDataYear(user.id_client, year, e.value, setDataToShow );
    setLoaded(false);
  }

  const handleChangeYear = (event) => {
    // console.log('DEBUG: Change Year');
    setYear(event.target.value);
    setLoaded(true);
    // TODO: Error managment and when don't return nothing
    getReportsTCDataYear(user.id_client, event.target.value, typesClientSelected, setDataToShow );
    setLoaded(false);
    //setReload(!reload);
  };

  useEffect(() => {
      // TODO: Error Managment
      // console.log('In Use Effect before getReportsDataTC');
      getReportsDataTC(user.id_client, setYears, setYear, setTypesClient, setLoaded, setDataToShow, setTypesClientSelected );
      // console.log('In Use Effect After getReportsDataTC');
      setLoaded(false);
      // console.log('typesClient : ' + typesClient);
      // console.log('typesClientSelected : ' + typesClientSelected);
  }, [reload]);

  return ( 
    <>
    { loaded ?
    <LoadingScreen isActive={loaded} />
    :
    <div className="card">
      <div className="flex justify-content-around flex-row flex-wrap card-container">
          <h1 style={{textAlign: "center",  color: "green" }}>{ Constants.getLabel('titleReportTypeClients')}</h1>
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
                    <label className="mr-2" style={{color: Constants.COLOR_LABELS}}>{ Constants.getLabel('selTypeClients')}</label>
                    <MultiSelect style={{color: Constants.COLOR_LABELS, backgroundColor: Constants.BGCOLOR, borderColor: Constants.COLOR_LABELS  }} 
                                  maxSelectedLabels={0} 
                                  tooltip={ Constants.getLabel('selTypeClients')}
                                  value={typesClientSelected} 
                                  options={typesClient} 
                                  onChange={handleTypesClient} 
                                  selectedItemsLabel= { typesClientSelected.length + ' ' + Constants.getLabel('typesClientSelected')}
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
                      <DataReport dataToShow={ dataToShow } metric={metric} type={'TC'}/>
              </TabPanel>
              <TabPanel header={ Constants.getLabel('titleYearGraph')}>
                      <ReportGraph dataToShow={ dataToShow } metric= { metric } isSumTETUSD= {false} type={'TC'}/>
              </TabPanel>
              {/*
              <TabPanel header={ Constants.getLabel('titleEPGraph')}>
                      <EnergyPointsGraph dataToShow={ dataToShowEP } metric= { metric } isSumTETUSD= {isSumTETUSD}/>
              </TabPanel>
              */}
      </TabView>
      </div>
      </div>
    </div> 
    }
    </>
  );
}
