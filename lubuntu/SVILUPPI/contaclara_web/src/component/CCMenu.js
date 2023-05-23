import React, {useContext, useState} from 'react';
import { styled } from '@mui/material/styles';
import List from '@mui/material/List';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import Collapse from '@mui/material/Collapse';
import Divider from '@mui/material/Divider';
import InboxIcon from '@mui/icons-material/MoveToInbox';
import DraftsIcon from '@mui/icons-material/Drafts';
import ExpandLess from '@mui/icons-material/ExpandLess';
import ExpandMore from '@mui/icons-material/ExpandMore';
import StarBorder from '@mui/icons-material/StarBorder';
import IconButton from '@mui/material/IconButton';
import BoltIcon from '@mui/icons-material/Bolt';
import ChevronLeftIcon from '@mui/icons-material/ChevronLeft';
import AssignmentTurnedInIcon from '@mui/icons-material/AssignmentTurnedIn';

import UploadFileIcon from '@mui/icons-material/UploadFile';
import ManageSearchIcon from '@mui/icons-material/ManageSearch';
import BarChartIcon from '@mui/icons-material/BarChart';
import SummarizeIcon from '@mui/icons-material/Summarize';
import FactCheckIcon from '@mui/icons-material/FactCheck';
import SwipeableDrawer from '@mui/material/SwipeableDrawer';
import * as Constants from '../constants/Constants';
import { AppContext } from '../contexts/appContext';
import { useNavigate } from 'react-router-dom';

const DrawerHeader = styled('div')(({ theme }) => ({
  display: 'flex',
  alignItems: 'center',
  padding: theme.spacing(0, 1),
  // necessary for content to be below app bar
  ...theme.mixins.toolbar,
  justifyContent: 'flex-end',
}));

const CCMenu = (props) => {

  const [open, setOpen] = useState(true);
  const [openB, setOpenB] = useState(true);
  const { user, dispatch } = useContext(AppContext);
  const navigate = useNavigate();

  const handleClick = () => {
    setOpen(!open);
  };

  const handleClickB = () => {
    setOpenB(!openB);
  };

  const handleClickDrawer = () => {
    console.log('Entro in handleClickDrawer');
    user.isOpenMenuApp = false;
    props.setReq(false);
    dispatch(user);
  }

  const handleClickItem = (event, id) => {
    console.log('event cliccato : ' + id);
    user.isOpenMenuApp = false;
    props.setReq(false);
    user.current_menu = Constants.MENU_APP[id];
    dispatch(user);
    console.log('DEBUG : In HangleClickItem ' + JSON.stringify(user));
    switch (Constants.MENU_APP[id]) {
      case Constants.UPLOADINVOICE:
        navigate('/' + user.client_name + '/upload', { replace : true});
        break;
      case Constants.ENERGYPOINTMGMT:
        navigate('/' + user.client_name + '/epmgmt', { replace : true});
        break;
      case Constants.TYPECLIENTSMGMT:
        navigate('/' + user.client_name + '/tcmgmt', {replace : true});
        break;
      case Constants.RELATORIOTC:
        navigate('/' + user.client_name + '/reporttc', {replace : true});
        break;
      case Constants.ANALISISCONTA:
        navigate('/' + user.client_name + '/analysisa', {replace : true});
        break;
      case Constants.RELATORIOANALISEENEA:
        navigate('/' + user.client_name + '/reporta', {replace : true});
        break;
      case Constants.GRAFICOA:
        navigate('/' + user.client_name + '/graficoa', {replace : true});
        break;
      case Constants.ANALISISCONTB:
        navigate('/' + user.client_name + '/analysisb', {replace : true});
        break;
      case Constants.RELATORIOANALISEENEB:
        navigate('/' + user.client_name + '/reportb', {replace : true});
        break;
      case Constants.GRAFICOB:
        navigate('/' + user.client_name + '/graficob', {replace : true});
        break;
      default:
        navigate('/' + user.client_name + '/home', {replace : true} );
    }
  };


  return (
     <SwipeableDrawer PaperProps={{ sx: { backgroundColor: "#75C988", } }}
            anchor={'left'}
            open={props.req}
            // sx={{ zIndex: Constants.CCTheme.zIndex.appBar - 1, bgcolor: 'primary'}}
            sx={{ bgcolor: 'primary'}}
            onClose={ () => {} }
            onOpen={ () => {} }
            onClick={ handleClickDrawer }
     >
     <DrawerHeader>
     <IconButton />
     <IconButton onClick={handleClickDrawer}>
          <ChevronLeftIcon />
     </IconButton>
     </DrawerHeader>
     <Divider />
    <List
      // sx={{ height: '100%',  width: '100%', maxWidth: '20%', bgcolor: 'primary', border: 1 }}
      component="nav"
      aria-labelledby="nested-list-subheader"
      sx={{ mt: "1%" }}
    >
      <ListItemButton onClick={(event) => handleClickItem(event,0)}>
        <ListItemIcon>
          <UploadFileIcon />
        </ListItemIcon>
        {/* FIXME: Improve language for item menu on Constants */}
        <ListItemText primary="Upload Fatura" />
      </ListItemButton>
      <ListItemButton onClick={(event) => handleClickItem(event,1)}>
        <ListItemIcon>
          <BoltIcon />
        </ListItemIcon>
        {/* FIXME: Improve language for item menu on Constants */}
        <ListItemText primary="Gestão de pontos de energia" />
      </ListItemButton>
      <ListItemButton onClick={(event) => handleClickItem(event,8)}>
        <ListItemIcon>
          <AssignmentTurnedInIcon />
        </ListItemIcon>
        {/* FIXME: Improve language for item menu on Constants */}
        <ListItemText primary="Gestão de tipos de clientes" />
      </ListItemButton>
      <ListItemButton onClick={(event) => handleClickItem(event,9)}>
        <ListItemIcon>
          <SummarizeIcon />
        </ListItemIcon>
        {/* FIXME: Improve language for item menu on Constants */}
        <ListItemText primary="Relatório Detalhado de Clientes" />
      </ListItemButton>
      <ListItemButton onClick={handleClick}>
        <ListItemIcon>
          <ManageSearchIcon />
        </ListItemIcon>
        <ListItemText primary="Analise Conta Grupo A (MT)" />
        {open ? <ExpandLess /> : <ExpandMore />}
      </ListItemButton>
      <Collapse in={open} timeout="auto" unmountOnExit>
        <List component="div" disablePadding>
          <ListItemButton onClick={(event) => handleClickItem(event,2)} sx={{ pl: 4 }}>
            <ListItemIcon>
              <FactCheckIcon />
            </ListItemIcon>
            <ListItemText primary="Analise Conta" />
          </ListItemButton>
          <ListItemButton onClick={(event) => handleClickItem(event,3)} sx={{ pl: 4 }}>
            <ListItemIcon>
              <SummarizeIcon />
            </ListItemIcon>
            <ListItemText primary="Relatorio Analise Energetica" />
          </ListItemButton>
          <ListItemButton onClick={(event) => handleClickItem(event,4)} sx={{ pl: 4 }}>
            <ListItemIcon>
              <BarChartIcon />
            </ListItemIcon>
            <ListItemText primary="Grafico Energia Ativa" />
          </ListItemButton>
        </List>
      </Collapse>
      <ListItemButton onClick={handleClickB}>
        <ListItemIcon>
          <ManageSearchIcon />
        </ListItemIcon>
        <ListItemText primary="Analise Conta Grupo B (BT)" />
        {openB ? <ExpandLess /> : <ExpandMore />}
      </ListItemButton>
      <Collapse in={openB} timeout="auto" unmountOnExit>
        <List component="div" disablePadding>
          <ListItemButton onClick={(event) => handleClickItem(event,5)} sx={{ pl: 4 }}>
            <ListItemIcon>
              <FactCheckIcon />
            </ListItemIcon>
            <ListItemText primary="Analise Conta" />
          </ListItemButton>
          <ListItemButton onClick={(event) => handleClickItem(event,6)} sx={{ pl: 4 }}>
            <ListItemIcon>
              <SummarizeIcon />
            </ListItemIcon>
            <ListItemText primary="Relatorio Analise Energetica" />
          </ListItemButton>
          <ListItemButton onClick={(event) => handleClickItem(event,7)} sx={{ pl: 4 }}>
            <ListItemIcon>
              <BarChartIcon />
            </ListItemIcon>
            <ListItemText primary="Historico Andamento Consumo" />
          </ListItemButton>
        </List>
      </Collapse>
    </List>
    </SwipeableDrawer>
  );
}

export default CCMenu;