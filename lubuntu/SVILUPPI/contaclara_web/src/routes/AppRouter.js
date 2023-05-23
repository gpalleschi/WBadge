import { Routes, Route } from "react-router-dom";
import React, {useState, useContext, useEffect} from 'react'
import { LoginScreen } from "../screens/LoginScreen";
import { BrowserRouter } from "react-router-dom";
import { PrivateRoute } from "./PrivateRoute";
import { PublicRoute } from "./PublicRoute";
import CCAppBar from "../component/CCAppBar";
import CCMenu from "../component/CCMenu";
import CCMenuUser from "../component/CCMenuUser";
import { UploadScreen } from "../screens/UploadScreen";
import * as Constants from '../constants/Constants';
import { AppContext } from '../contexts/appContext';
import { GetClient } from '../api_calls/clients';
import { AnalysisInvoiceScreen } from '../screens/AnalysisInvoiceScreen';
import { types } from "../types/types";
import { EnergyReportScreen } from "../screens/EnergyReportScreen";
import { GraphicEnergyScreen } from "../screens/GraphicEnergyScreen";
import { StartPageScreen } from "../screens/StartPageScreen";
import { EnergyPointScreen } from "../screens/EnergyPointScreen";
import { AccountScreen } from "../screens/AccountScreen";
import { UsersMngmtScreen } from "../screens/UsersMngmtScreen";
import { LoadingScreen } from "../screens/LoadingScreen";
import { TypeClientsScreen } from "../screens/TypeClientsScreen";
import { TypeClientsReportScreen } from "../screens/TypeClientsReportScreen";

export const AppRouter = () => {

  const checkUser = (user, dispatch) => {

    const current_client_name = window.location.pathname.split('/')[1];

    console.log('In AppRouter current client name : ' + current_client_name);

    if ( ( user.logged && current_client_name !== null && current_client_name !== user.client_name ) ) {
          console.log('DEBUG logout');
          dispatch({type: types.logout
          });
    }

    if ( user.client_name === null || !user.logged ) {

      const current_client = Constants.isClient(user.clients, current_client_name);

     //  console.log('Current client : ' + JSON.stringify(current_client));

      if ( current_client !== null ) {
           user.id_client = current_client.id_client;
           user.client_name = current_client.client_name;
           user.company = current_client.company;
           dispatch(user);
           console.log('Not null');
      } else {
           user.id_client = null;
           user.client_name = null;
           user.company = null;
           dispatch(user);
           console.log('Null');
      }
    } 
  }

  const {user, dispatch } = useContext(AppContext);
  const [loaded, setLoaded] = useState(false)
  const [req, setReq] = useState(false);
  const [reqUser, setReqUser] = useState(false);

  useEffect(() => {

     async function fetchData() {
          await GetClient(user, dispatch, setLoaded);
          checkUser(user, dispatch);
    }
    fetchData();
  }, [user,dispatch]);

//  checkUser(user, dispatch);

  return (
    <>
    { loaded ?
    <BrowserRouter>
      <Routes>

        <Route path="/:clientName/login" element={
             <PublicRoute>
                 <LoginScreen />
             </PublicRoute>
        } />

  	   <Route path="/:clientName/users" element={
             <PrivateRoute>
                  <CCAppBar setReq={setReq} setReqUser={setReqUser}/>
                  <CCMenu req={req} setReq={setReq}/>
                  <CCMenuUser reqUser={reqUser} setReqUser={setReqUser}/>
                  <UsersMngmtScreen />
             </PrivateRoute>
        } />

  	   <Route path="/:clientName/account" element={
             <PrivateRoute>
                  <CCAppBar setReq={setReq} setReqUser={setReqUser}/>
                  <CCMenu req={req} setReq={setReq}/>
                  <CCMenuUser reqUser={reqUser} setReqUser={setReqUser}/>
                  <AccountScreen />
             </PrivateRoute>
        } />

  	   <Route path="/:clientName/home" element={
             <PrivateRoute>
                  <CCAppBar setReq={setReq} setReqUser={setReqUser}/>
                  <CCMenu req={req} setReq={setReq}/>
                  <CCMenuUser reqUser={reqUser} setReqUser={setReqUser}/>
                  <StartPageScreen />
             </PrivateRoute>
        } />

        <Route path="/:clientName/upload" element={
             <PrivateRoute>
                  <CCAppBar setReq={setReq} setReqUser={setReqUser}/>
                  <CCMenu req={req} setReq={setReq}/>
                  <CCMenuUser reqUser={reqUser} setReqUser={setReqUser}/>
                  <UploadScreen />
             </PrivateRoute>
        } />

        <Route path="/:clientName/epmgmt" element={
             <PrivateRoute>
                  <CCAppBar setReq={setReq} setReqUser={setReqUser}/>
                  <CCMenu req={req} setReq={setReq}/>
                  <CCMenuUser reqUser={reqUser} setReqUser={setReqUser}/>
                  <EnergyPointScreen />
             </PrivateRoute>
        } />

        <Route path="/:clientName/tcmgmt" element={
             <PrivateRoute>
                  <CCAppBar setReq={setReq} setReqUser={setReqUser}/>
                  <CCMenu req={req} setReq={setReq}/>
                  <CCMenuUser reqUser={reqUser} setReqUser={setReqUser}/>
                  <TypeClientsScreen />
             </PrivateRoute>
        } />

        <Route path="/:clientName/reporttc" element={
             <PrivateRoute>
                  <CCAppBar setReq={setReq} setReqUser={setReqUser}/>
                  <CCMenu req={req} setReq={setReq}/>
                  <CCMenuUser reqUser={reqUser} setReqUser={setReqUser}/>
                  <TypeClientsReportScreen/>
             </PrivateRoute>
        } />

        <Route path="/:clientName/analysisa" element={
             <PrivateRoute>
                  <CCAppBar setReq={setReq} setReqUser={setReqUser}/>
                  <CCMenu req={req} setReq={setReq}/>
                  <CCMenuUser reqUser={reqUser} setReqUser={setReqUser}/>
                  <AnalysisInvoiceScreen type_invoice={'A'}/>
             </PrivateRoute>
        } />

        <Route path="/:clientName/reporta" element={
             <PrivateRoute>
                  <CCAppBar setReq={setReq} setReqUser={setReqUser}/>
                  <CCMenu req={req} setReq={setReq}/>
                  <CCMenuUser reqUser={reqUser} setReqUser={setReqUser}/>
                  <EnergyReportScreen type_invoice={'A'}/>
             </PrivateRoute>
        } />

	      <Route path="/:clientName/graficoa" element={
             <PrivateRoute>
                  <CCAppBar setReq={setReq} setReqUser={setReqUser}/>
                  <CCMenu req={req} setReq={setReq}/>
                  <CCMenuUser reqUser={reqUser} setReqUser={setReqUser}/>
                  <GraphicEnergyScreen type_invoice={'A'} />
             </PrivateRoute>
        } />

	      <Route path="/:clientName/analysisb" element={
             <PrivateRoute>
                  <CCAppBar setReq={setReq} setReqUser={setReqUser}/>
                  <CCMenu req={req} setReq={setReq}/>
                  <CCMenuUser reqUser={reqUser} setReqUser={setReqUser}/>
                  <AnalysisInvoiceScreen type_invoice={'B'}/>
             </PrivateRoute>
        } />

	      <Route path="/:clientName/reportb" element={
             <PrivateRoute>
                  <CCAppBar setReq={setReq} setReqUser={setReqUser}/>
                  <CCMenu req={req} setReq={setReq}/>
                  <CCMenuUser reqUser={reqUser} setReqUser={setReqUser}/>
                  <EnergyReportScreen type_invoice={'B'}/>
             </PrivateRoute>
        } />

	      <Route path="/:clientName/graficob" element={
             <PrivateRoute>
                  <CCAppBar setReq={setReq} setReqUser={setReqUser}/>
                  <CCMenu req={req} setReq={setReq}/>
                  <CCMenuUser reqUser={reqUser} setReqUser={setReqUser}/>
                  <GraphicEnergyScreen type_invoice={'B'} />
             </PrivateRoute>
        } />

        <Route path="/*" element={
             <PrivateRoute>
             {/* TODO: Make 404 not found page */}
                  <CCAppBar setReq={setReq} setReqUser={setReqUser}/>
                  <CCMenu req={req} setReq={setReq}/>
                  <CCMenuUser reqUser={reqUser} setReqUser={setReqUser}/>
             </PrivateRoute>
        } />
      </Routes>
    </BrowserRouter> 
    : <LoadingScreen isActive={loaded}/>   
    }
    </> 
  );
}
