import React, {useState, useEffect} from 'react';
import { DataGrid, GridToolbarContainer, GridToolbarExport } from '@mui/x-data-grid';
import { CCTablePrime } from "../CCTablePrime";
import * as Constants from '../../constants/Constants';
import { Column } from 'primereact/column';
import { ColumnGroup } from 'primereact/columngroup';
import { Row } from 'primereact/row';

const columnsConsumo = [
  { field: 'item', 
    headerName: Constants.getLabel('specification'), 
    headerClassName: 'super-app-theme--header',
    headerAlign: 'center',
    align:'left',
    sortable: false,
  },
  {
    field: 'm01',
    headerName: Constants.getLabel('m01'),
    headerAlign: 'center',
    align:'right',
    sortable: false,
    type: 'number',
    funcConv : (rowData) => { if ( rowData.m01 ) {
                                return rowData.m01.toLocaleString(Constants.CCPAIS, { style: 'decimal', minimumFractionDigits: 3 });
                              }
                              else {
                                return null;
                              }
                            },
   },
   {
    field: 'm02',
    headerName: Constants.getLabel('m02'),
    headerAlign: 'center',
    align:'right',
    sortable: false,
    type: 'number',
    funcConv : (rowData) => { if ( rowData.m02 ) {
                                return rowData.m02.toLocaleString(Constants.CCPAIS, { style: 'decimal', minimumFractionDigits: 3 });
                              }
                              else {
                                return null;
                              }
                            },
   },
   {
    field: 'm03',
    headerName: Constants.getLabel('m03'),
    headerAlign: 'center',
    align:'right',
    sortable: false,
    type: 'number',
    funcConv : (rowData) => { if ( rowData.m03 ) {
                                return rowData.m03.toLocaleString(Constants.CCPAIS, { style: 'decimal', minimumFractionDigits: 3 });
                              }
                              else {
                                return null;
                              }
                            },
   },
   {
    field: 'm04',
    headerName: Constants.getLabel('m04'),
    headerAlign: 'center',
    align:'right',
    sortable: false,
    type: 'number',
    funcConv : (rowData) => { if ( rowData.m04 ) {
                                return rowData.m04.toLocaleString(Constants.CCPAIS, { style: 'decimal', minimumFractionDigits: 3 });
                              }
                              else {
                                return null;
                              }
                            },
   },
   {
    field: 'm05',
    headerName: Constants.getLabel('m05'),
    headerAlign: 'center',
    align:'right',
    sortable: false,
    type: 'number',
    funcConv : (rowData) => { if ( rowData.m05 ) {
                                return rowData.m05.toLocaleString(Constants.CCPAIS, { style: 'decimal', minimumFractionDigits: 3 });
                              }
                              else {
                                return null;
                              }
                            },
   },
   {
    field: 'm06',
    headerName: Constants.getLabel('m06'),
    headerAlign: 'center',
    align:'right',
    sortable: false,
    type: 'number',
    funcConv : (rowData) => { if ( rowData.m06 ) {
                                return rowData.m06.toLocaleString(Constants.CCPAIS, { style: 'decimal', minimumFractionDigits: 3 });
                              }
                              else {
                                return null;
                              }
                            },
   },
   {
    field: 'm07',
    headerName: Constants.getLabel('m07'),
    headerAlign: 'center',
    align:'right',
    sortable: false,
    type: 'number',
    funcConv : (rowData) => { if ( rowData.m07 ) {
                                return rowData.m07.toLocaleString(Constants.CCPAIS, { style: 'decimal', minimumFractionDigits: 3 });
                              }
                              else {
                                return null;
                              }
                            },
   },
   {
    field: 'm08',
    headerName: Constants.getLabel('m08'),
    headerAlign: 'center',
    align:'right',
    sortable: false,
    type: 'number',
    funcConv : (rowData) => { if ( rowData.m08 ) {
                                return rowData.m08.toLocaleString(Constants.CCPAIS, { style: 'decimal', minimumFractionDigits: 3 });
                              }
                              else {
                                return null;
                              }
                            },
   },
   {
    field: 'm09',
    headerName: Constants.getLabel('m09'),
    headerAlign: 'center',
    align:'right',
    sortable: false,
    type: 'number',
    funcConv : (rowData) => { if ( rowData.m09 ) {
                                return rowData.m09.toLocaleString(Constants.CCPAIS, { style: 'decimal', minimumFractionDigits: 3 });
                              }
                              else {
                                return null;
                              }
                            },
   },
   {
    field: 'm10',
    headerName: Constants.getLabel('m10'),
    headerAlign: 'center',
    align:'right',
    sortable: false,
    type: 'number',
    funcConv : (rowData) => { if ( rowData.m10 ) {
                                return rowData.m10.toLocaleString(Constants.CCPAIS, { style: 'decimal', minimumFractionDigits: 3 });
                              }
                              else {
                                return null;
                              }
                            },
   },
   {
    field: 'm11',
    headerName: Constants.getLabel('m11'),
    headerAlign: 'center',
    align:'right',
    sortable: false,
    type: 'number',
    funcConv : (rowData) => { if ( rowData.m11 ) {
                                return rowData.m11.toLocaleString(Constants.CCPAIS, { style: 'decimal', minimumFractionDigits: 3 });
                              }
                              else {
                                return null;
                              }
                            },
   },
   {
    field: 'm12',
    headerName: Constants.getLabel('m12'),
    headerAlign: 'center',
    align:'right',
    sortable: false,
    type: 'number',
    funcConv : (rowData) => { if ( rowData.m12 ) {
                                return rowData.m12.toLocaleString(Constants.CCPAIS, { style: 'decimal', minimumFractionDigits: 3 });
                              }
                              else {
                                return null;
                              }
                            },
   },
];

const columnsValor = [
  { field: 'item', 
    headerName: 'Especificação', 
    headerClassName: 'super-app-theme--header',
    headerAlign: 'center',
    align:'center',
    sortable: false,
  },
  {
    field: 'v01',
    headerName: Constants.getLabel('v01'),
    headerAlign: 'center',
    align:'right',
    sortable: false,
    type: 'number',
    funcConv : (rowData) => { if ( rowData.v01 ) {
                                return rowData.v01.toLocaleString(Constants.CCPAIS, {style: 'currency', currency: Constants.CCCURRENCY});
                              }
                              else {
                                return null;
                              }
                            },
   },
   {
    field: 'v02',
    headerName: Constants.getLabel('v02'),
    headerAlign: 'center',
    align:'right',
    sortable: false,
    type: 'number',
    funcConv : (rowData) => { if ( rowData.v02 ) {
                                return rowData.v02.toLocaleString(Constants.CCPAIS, {style: 'currency', currency: Constants.CCCURRENCY});
                              }
                              else {
                                return null;
                              }
                            },
   },
   {
    field: 'v03',
    headerName: Constants.getLabel('v03'),
    headerAlign: 'center',
    align:'right',
    sortable: false,
    type: 'number',
    funcConv : (rowData) => { if ( rowData.v03 ) {
                                return rowData.v03.toLocaleString(Constants.CCPAIS, {style: 'currency', currency: Constants.CCCURRENCY});
                              }
                              else {
                                return null;
                              }
                            },
   },
   {
    field: 'v04',
    headerName: Constants.getLabel('v04'),
    headerAlign: 'center',
    align:'right',
    sortable: false,
    type: 'number',
    funcConv : (rowData) => { if ( rowData.v04 ) {
                                return rowData.v04.toLocaleString(Constants.CCPAIS, {style: 'currency', currency: Constants.CCCURRENCY});
                              }
                              else {
                                return null;
                              }
                            },
   },
   {
    field: 'v05',
    headerName: Constants.getLabel('v05'),
    headerAlign: 'center',
    align:'right',
    sortable: false,
    type: 'number',
    funcConv : (rowData) => { if ( rowData.v05 ) {
                                return rowData.v05.toLocaleString(Constants.CCPAIS, {style: 'currency', currency: Constants.CCCURRENCY});
                              }
                              else {
                                return null;
                              }
                            },
   },
   {
    field: 'v06',
    headerName: Constants.getLabel('v06'),
    headerAlign: 'center',
    align:'right',
    sortable: false,
    type: 'number',
    funcConv : (rowData) => { if ( rowData.v06 ) {
                                return rowData.v06.toLocaleString(Constants.CCPAIS, {style: 'currency', currency: Constants.CCCURRENCY});
                              }
                              else {
                                return null;
                              }
                            },
   },
   {
    field: 'v07',
    headerName: Constants.getLabel('v07'),
    headerAlign: 'center',
    align:'right',
    sortable: false,
    type: 'number',
    funcConv : (rowData) => { if ( rowData.v07 ) {
                                return rowData.v07.toLocaleString(Constants.CCPAIS, {style: 'currency', currency: Constants.CCCURRENCY});
                              }
                              else {
                                return null;
                              }
                            },
   },
   {
    field: 'v08',
    headerName: Constants.getLabel('v08'),
    headerAlign: 'center',
    align:'right',
    sortable: false,
    type: 'number',
    funcConv : (rowData) => { if ( rowData.v08 ) {
                                return rowData.v08.toLocaleString(Constants.CCPAIS, {style: 'currency', currency: Constants.CCCURRENCY});
                              }
                              else {
                                return null;
                              }
                            },
   },
   {
    field: 'v09',
    headerName: Constants.getLabel('v09'),
    headerAlign: 'center',
    align:'right',
    sortable: false,
    type: 'number',
    funcConv : (rowData) => { if ( rowData.v09 ) {
                                return rowData.v09.toLocaleString(Constants.CCPAIS, {style: 'currency', currency: Constants.CCCURRENCY});
                              }
                              else {
                                return null;
                              }
                            },
   },
   {
    field: 'v10',
    headerName: Constants.getLabel('v10'),
    headerAlign: 'center',
    align:'right',
    sortable: false,
    type: 'number',
    funcConv : (rowData) => { if ( rowData.v10 ) {
                                return rowData.v10.toLocaleString(Constants.CCPAIS, {style: 'currency', currency: Constants.CCCURRENCY});
                              }
                              else {
                                return null;
                              }
                            },
   },
   {
    field: 'v11',
    headerName: Constants.getLabel('v11'),
    headerAlign: 'center',
    align:'right',
    sortable: false,
    type: 'number',
    funcConv : (rowData) => { if ( rowData.v11 ) {
                                return rowData.v11.toLocaleString(Constants.CCPAIS, {style: 'currency', currency: Constants.CCCURRENCY});
                              }
                              else {
                                return null;
                              }
                            },
   },
   {
    field: 'v12',
    headerName: Constants.getLabel('v12'),
    headerAlign: 'center',
    align:'right',
    sortable: false,
    type: 'number',
    funcConv : (rowData) => { if ( rowData.v12 ) {
                                return rowData.v12.toLocaleString(Constants.CCPAIS, {style: 'currency', currency: Constants.CCCURRENCY});
                              }
                              else {
                                return null;
                              }
                            },
   },
];

function CustomToolbar() {
  return (
    <GridToolbarContainer>
      <GridToolbarExport />
    </GridToolbarContainer>
  );
}

export const DataReport = (props) => {

  const [rows, setRows] = useState([]);


  let footerGroup = <ColumnGroup>
                        <Row>
                            <Column footer={Constants.getLabel('totals') + ':'} colSpan={0} footerStyle={{textAlign: 'right'}}/>
                            <Column align="right" footer={() => { let total = 0;
                                            for(let row of rows) {
                                               if ( props.metric === Constants.METRICS[0] ) {
                                                  total += row.m01;
                                               } else {
                                                  total += row.v01;
                                               }
                                            }
                                            if ( total ) {
                                               if ( props.metric === Constants.METRICS[0] ) {
                                                   return total.toLocaleString(Constants.CCPAIS, { style: 'decimal' });
                                               } else {
                                                   return total.toLocaleString(Constants.CCPAIS, { style: 'currency', currency: Constants.CCCURRENCY });
                                               } 
                                            } else {
                                               return null;
                                            }
                            }} />
                            <Column align="right" footer={() => { let total = 0;
                                            for(let row of rows) {
                                               if ( props.metric === Constants.METRICS[0] ) {
                                                  total += row.m02;
                                               } else {
                                                  total += row.v02;
                                               }
                                            }
                                            if ( total ) {
                                               if ( props.metric === Constants.METRICS[0] ) {
                                                   return total.toLocaleString(Constants.CCPAIS, { style: 'decimal' });
                                               } else {
                                                   return total.toLocaleString(Constants.CCPAIS, { style: 'currency', currency: Constants.CCCURRENCY });
                                               } 
                                            } else {
                                               return null;
                                            }
                            }} />
                            <Column align="right" footer={() => { let total = 0;
                                            for(let row of rows) {
                                               if ( props.metric === Constants.METRICS[0] ) {
                                                  total += row.m03;
                                               } else {
                                                  total += row.v03;
                                               }
                                            }
                                            if ( total ) {
                                               if ( props.metric === Constants.METRICS[0] ) {
                                                   return total.toLocaleString(Constants.CCPAIS, { style: 'decimal' });
                                               } else {
                                                   return total.toLocaleString(Constants.CCPAIS, { style: 'currency', currency: Constants.CCCURRENCY });
                                               } 
                                            } else {
                                               return null;
                                            }
                            }} />
                            <Column align="right" footer={() => { let total = 0;
                                            for(let row of rows) {
                                               if ( props.metric === Constants.METRICS[0] ) {
                                                  total += row.m04;
                                               } else {
                                                  total += row.v04;
                                               }
                                            }
                                            if ( total ) {
                                               if ( props.metric === Constants.METRICS[0] ) {
                                                   return total.toLocaleString(Constants.CCPAIS, { style: 'decimal' });
                                               } else {
                                                   return total.toLocaleString(Constants.CCPAIS, { style: 'currency', currency: Constants.CCCURRENCY });
                                               } 
                                            } else {
                                               return null;
                                            }
                            }} />
                            <Column align="right" footer={() => { let total = 0;
                                            for(let row of rows) {
                                               if ( props.metric === Constants.METRICS[0] ) {
                                                  total += row.m05;
                                               } else {
                                                  total += row.v05;
                                               }
                                            }
                                            if ( total ) {
                                               if ( props.metric === Constants.METRICS[0] ) {
                                                   return total.toLocaleString(Constants.CCPAIS, { style: 'decimal' });
                                               } else {
                                                   return total.toLocaleString(Constants.CCPAIS, { style: 'currency', currency: Constants.CCCURRENCY });
                                               } 
                                            } else {
                                               return null;
                                            }
                            }} />
                            <Column align="right" footer={() => { let total = 0;
                                            for(let row of rows) {
                                               if ( props.metric === Constants.METRICS[0] ) {
                                                  total += row.m06;
                                               } else {
                                                  total += row.v06;
                                               }
                                            }
                                            if ( total ) {
                                               if ( props.metric === Constants.METRICS[0] ) {
                                                   return total.toLocaleString(Constants.CCPAIS, { style: 'decimal' });
                                               } else {
                                                   return total.toLocaleString(Constants.CCPAIS, { style: 'currency', currency: Constants.CCCURRENCY });
                                               } 
                                            } else {
                                               return null;
                                            }
                            }} />
                            <Column align="right" footer={() => { let total = 0;
                                            for(let row of rows) {
                                               if ( props.metric === Constants.METRICS[0] ) {
                                                  total += row.m07;
                                               } else {
                                                  total += row.v07;
                                               }
                                            }
                                            if ( total ) {
                                               if ( props.metric === Constants.METRICS[0] ) {
                                                   return total.toLocaleString(Constants.CCPAIS, { style: 'decimal' });
                                               } else {
                                                   return total.toLocaleString(Constants.CCPAIS, { style: 'currency', currency: Constants.CCCURRENCY });
                                               } 
                                            } else {
                                               return null;
                                            }
                            }} />
                            <Column align="right" footer={() => { let total = 0;
                                            for(let row of rows) {
                                               if ( props.metric === Constants.METRICS[0] ) {
                                                  total += row.m08;
                                               } else {
                                                  total += row.v08;
                                               }
                                            }
                                            if ( total ) {
                                               if ( props.metric === Constants.METRICS[0] ) {
                                                   return total.toLocaleString(Constants.CCPAIS, { style: 'decimal' });
                                               } else {
                                                   return total.toLocaleString(Constants.CCPAIS, { style: 'currency', currency: Constants.CCCURRENCY });
                                               } 
                                            } else {
                                               return null;
                                            }
                            }} />
                            <Column align="right" footer={() => { let total = 0;
                                            for(let row of rows) {
                                               if ( props.metric === Constants.METRICS[0] ) {
                                                  total += row.m09;
                                               } else {
                                                  total += row.v09;
                                               }
                                            }
                                            if ( total ) {
                                               if ( props.metric === Constants.METRICS[0] ) {
                                                   return total.toLocaleString(Constants.CCPAIS, { style: 'decimal' });
                                               } else {
                                                   return total.toLocaleString(Constants.CCPAIS, { style: 'currency', currency: Constants.CCCURRENCY });
                                               } 
                                            } else {
                                               return null;
                                            }
                            }} />
                            <Column align="right" footer={() => { let total = 0;
                                            for(let row of rows) {
                                               if ( props.metric === Constants.METRICS[0] ) {
                                                  total += row.m10;
                                               } else {
                                                  total += row.v10;
                                               }
                                            }
                                            if ( total ) {
                                               if ( props.metric === Constants.METRICS[0] ) {
                                                   return total.toLocaleString(Constants.CCPAIS, { style: 'decimal' });
                                               } else {
                                                   return total.toLocaleString(Constants.CCPAIS, { style: 'currency', currency: Constants.CCCURRENCY });
                                               } 
                                            } else {
                                               return null;
                                            }
                            }} />
                            <Column align="right" footer={() => { let total = 0;
                                            for(let row of rows) {
                                               if ( props.metric === Constants.METRICS[0] ) {
                                                  total += row.m11;
                                               } else {
                                                  total += row.v11;
                                               }
                                            }
                                            if ( total ) {
                                               if ( props.metric === Constants.METRICS[0] ) {
                                                   return total.toLocaleString(Constants.CCPAIS, { style: 'decimal' });
                                               } else {
                                                   return total.toLocaleString(Constants.CCPAIS, { style: 'currency', currency: Constants.CCCURRENCY });
                                               } 
                                            } else {
                                               return null;
                                            }
                            }} />
                            <Column align="right" footer={() => { let total = 0;
                                            for(let row of rows) {
                                               if ( props.metric === Constants.METRICS[0] ) {
                                                  total += row.m12;
                                               } else {
                                                  total += row.v12;
                                               }
                                            }
                                            if ( total ) {
                                               if ( props.metric === Constants.METRICS[0] ) {
                                                   return total.toLocaleString(Constants.CCPAIS, { style: 'decimal' });
                                               } else {
                                                   return total.toLocaleString(Constants.CCPAIS, { style: 'currency', currency: Constants.CCCURRENCY });
                                               } 
                                            } else {
                                               return null;
                                            }
                            }} />
                        </Row>
                    </ColumnGroup>;

  useEffect(() => {

      // Cambio i dati della prima colonna
      if ( props.type == 'TC' ) {
         columnsValor[0].field = 'type_client';
         columnsConsumo[0].field = 'type_client';
         columnsValor[0].headerName = Constants.getLabel('typeClient');
         columnsConsumo[0].headerName = Constants.getLabel('typeClient');

         setRows(props.dataToShow);

      } else {

         columnsValor[0].field = 'item';
         columnsConsumo[0].field = 'item';
         //TODO: Language label mngmt
         columnsValor[0].headerName = 'Especificação';
         columnsConsumo[0].headerName = 'Especificação';

         let rowToShow = [];
         let sumRowTETUSD = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
         let beforeItem = "xxx";
         let currentItem = null;

         let ind = 0;
         setRows([]);
         // OLD
         props.dataToShow.map( (dataDetail,x,row) => {
            let i;
            for(i=0;i<Constants.itemToDelFromReportEnerg.length;i++) {
               if ( dataDetail.item.match(Constants.itemToDelFromReportEnerg[i]) ) break;
            }
            if ( i === Constants.itemToDelFromReportEnerg.length ) {
               
               if ( props.isSumTETUSD ) {
                  currentItem = dataDetail.item.replace(' TE','').replace(' TUSD','');
               } else {
                  currentItem = dataDetail.item;
               }

               if ( currentItem === beforeItem || beforeItem === 'xxx') {
                  sumRowTETUSD[0] = dataDetail.m01; 
                  sumRowTETUSD[1] = sumRowTETUSD[1] + dataDetail.v01; 
                  sumRowTETUSD[2] = dataDetail.m02; 
                  sumRowTETUSD[3] = sumRowTETUSD[3] + dataDetail.v02; 
                  sumRowTETUSD[4] = dataDetail.m03; 
                  sumRowTETUSD[5] = sumRowTETUSD[5] + dataDetail.v03; 
                  sumRowTETUSD[6] = dataDetail.m04; 
                  sumRowTETUSD[7] = sumRowTETUSD[7] + dataDetail.v04; 
                  sumRowTETUSD[8] = dataDetail.m05; 
                  sumRowTETUSD[9] = sumRowTETUSD[9] + dataDetail.v05; 
                  sumRowTETUSD[10] = dataDetail.m06; 
                  sumRowTETUSD[11] = sumRowTETUSD[11] + dataDetail.v06; 
                  sumRowTETUSD[12] = dataDetail.m07; 
                  sumRowTETUSD[13] = sumRowTETUSD[13] + dataDetail.v07; 
                  sumRowTETUSD[14] = dataDetail.m08; 
                  sumRowTETUSD[15] = sumRowTETUSD[15] + dataDetail.v08; 
                  sumRowTETUSD[16] = dataDetail.m09; 
                  sumRowTETUSD[17] = sumRowTETUSD[17] + dataDetail.v09; 
                  sumRowTETUSD[18] = dataDetail.m10; 
                  sumRowTETUSD[19] = sumRowTETUSD[19] + dataDetail.v10; 
                  sumRowTETUSD[20] = dataDetail.m11; 
                  sumRowTETUSD[21] = sumRowTETUSD[21] + dataDetail.v11; 
                  sumRowTETUSD[22] = dataDetail.m12; 
                  sumRowTETUSD[23] = sumRowTETUSD[23] + dataDetail.v12; 

                  beforeItem = currentItem;
               }
               else 
               {
                  for(let i=0;i<sumRowTETUSD.length;i++) {
                     if ( !sumRowTETUSD[i] ) {
                        sumRowTETUSD[i] = null;
                     }
                  }
                  rowToShow.push( { id: ind++,
                                 item: beforeItem,
                                 m01: sumRowTETUSD[0],
                                 v01: sumRowTETUSD[1],
                                 m02: sumRowTETUSD[2],
                                 v02: sumRowTETUSD[3],
                                 m03: sumRowTETUSD[4],
                                 v03: sumRowTETUSD[5],
                                 m04: sumRowTETUSD[6],
                                 v04: sumRowTETUSD[7],
                                 m05: sumRowTETUSD[8],
                                 v05: sumRowTETUSD[9],
                                 m06: sumRowTETUSD[10],
                                 v06: sumRowTETUSD[11],
                                 m07: sumRowTETUSD[12],
                                 v07: sumRowTETUSD[13],
                                 m08: sumRowTETUSD[14],
                                 v08: sumRowTETUSD[15],
                                 m09: sumRowTETUSD[16],
                                 v09: sumRowTETUSD[17],
                                 m10: sumRowTETUSD[18],
                                 v10: sumRowTETUSD[19],
                                 m11: sumRowTETUSD[20],
                                 v11: sumRowTETUSD[21],
                                 m12: sumRowTETUSD[22],
                                 v12: sumRowTETUSD[23],
                                 });

                  sumRowTETUSD = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
                  sumRowTETUSD[0] = dataDetail.m01; 
                  sumRowTETUSD[1] = sumRowTETUSD[1] + dataDetail.v01; 
                  sumRowTETUSD[2] = dataDetail.m02; 
                  sumRowTETUSD[3] = sumRowTETUSD[3] + dataDetail.v02; 
                  sumRowTETUSD[4] = dataDetail.m03; 
                  sumRowTETUSD[5] = sumRowTETUSD[5] + dataDetail.v03; 
                  sumRowTETUSD[6] = dataDetail.m04; 
                  sumRowTETUSD[7] = sumRowTETUSD[7] + dataDetail.v04; 
                  sumRowTETUSD[8] = dataDetail.m05; 
                  sumRowTETUSD[9] = sumRowTETUSD[9] + dataDetail.v05; 
                  sumRowTETUSD[10] = dataDetail.m06; 
                  sumRowTETUSD[11] = sumRowTETUSD[11] + dataDetail.v06; 
                  sumRowTETUSD[12] = dataDetail.m07; 
                  sumRowTETUSD[13] = sumRowTETUSD[13] + dataDetail.v07; 
                  sumRowTETUSD[14] = dataDetail.m08; 
                  sumRowTETUSD[15] = sumRowTETUSD[15] + dataDetail.v08; 
                  sumRowTETUSD[16] = dataDetail.m09; 
                  sumRowTETUSD[17] = sumRowTETUSD[17] + dataDetail.v09; 
                  sumRowTETUSD[18] = dataDetail.m10; 
                  sumRowTETUSD[19] = sumRowTETUSD[19] + dataDetail.v10; 
                  sumRowTETUSD[20] = dataDetail.m11; 
                  sumRowTETUSD[21] = sumRowTETUSD[21] + dataDetail.v11; 
                  sumRowTETUSD[22] = dataDetail.m12; 
                  sumRowTETUSD[23] = sumRowTETUSD[23] + dataDetail.v12; 

                  beforeItem = currentItem;
               }

            } 

            if ( x + 1 === row.length ) {
                  for(let i=0;i<sumRowTETUSD.length;i++) {
                     if ( !sumRowTETUSD[i] ) {
                        sumRowTETUSD[i] = null;
                     }
                  }
                  rowToShow.push( { id: ind++,
                                 item: beforeItem,
                                 m01: sumRowTETUSD[0],
                                 v01: sumRowTETUSD[1],
                                 m02: sumRowTETUSD[2],
                                 v02: sumRowTETUSD[3],
                                 m03: sumRowTETUSD[4],
                                 v03: sumRowTETUSD[5],
                                 m04: sumRowTETUSD[6],
                                 v04: sumRowTETUSD[7],
                                 m05: sumRowTETUSD[8],
                                 v05: sumRowTETUSD[9],
                                 m06: sumRowTETUSD[10],
                                 v06: sumRowTETUSD[11],
                                 m07: sumRowTETUSD[12],
                                 v07: sumRowTETUSD[13],
                                 m08: sumRowTETUSD[14],
                                 v08: sumRowTETUSD[15],
                                 m09: sumRowTETUSD[16],
                                 v09: sumRowTETUSD[17],
                                 m10: sumRowTETUSD[18],
                                 v10: sumRowTETUSD[19],
                                 m11: sumRowTETUSD[20],
                                 v11: sumRowTETUSD[21],
                                 m12: sumRowTETUSD[22],
                                 v12: sumRowTETUSD[23],
                                 });
               }  
         });

         setRows(rowToShow);
      }
  }, [props]);

  return (
   <div className="flex align-items-center justify-content-center">
      <CCTablePrime rows={rows} columns={props.metric === Constants.METRICS[0] ? columnsConsumo : columnsValor} pagesize={1} rowsPerPageOptions={[1]} hideFooter={true} withExport={true} disableColumnMenu={true} fileExport={'Reporte'} footer={props.metric === Constants.METRICS[1] ? footerGroup : null}/>
   </div>
      );
}
