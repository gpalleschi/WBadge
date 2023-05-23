import React, {useEffect, useState} from 'react';
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend,
} from 'chart.js';
import { Line } from 'react-chartjs-2';
import ChartDataLabels from 'chartjs-plugin-datalabels';
import * as Constants from '../../constants/Constants';


const labels = Constants.getLabel('monthsarray');
// const labels = ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho','Agosto','Setembro','Outubro','Novembro', 'Dezembro'];

export const ReportGraph = (props) => {
  console.log('DEBUG EnergyGraph');	
  const [dataG, setDataG] = useState({labels: [], datasets: []});
  const [codInvoiceG, setCodInvoiceG] = useState([]);

  ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend
);

ChartJS.register(ChartDataLabels);

const funSizeLabel = (context) => {
                var width = context.chart.width;
                var size = Math.round(width / 96);
                return { size: size, };
          }
const funOffset = (context) => {
                var width = context.chart.width;
                var offset = Math.round(width / 64);
                return -offset;
          }

const options = {
  responsive: true,
  steppedLine: true,
  scales: {
          y: {
            beginAtZero: true,
          },
        },
     datalabels: {
          display: true,
          color: "green",
          font: funSizeLabel,
          // fontSize: "25px",
          anchor: "end",
          offset: funOffset,
          align: "start",
          formatter: function(value, context) {
              const valor = context.chart.data.datasets[context.datasetIndex].data[context.chart.data.labels[context.dataIndex]];
              if ( props.metric === Constants.METRICS[0]) {
                 return valor.toLocaleString(Constants.CCPAIS, { style: 'decimal',  minimumFractionDigits: Constants.MIN_DECIMAL_POS, maximumFractionDigits: Constants.MAX_DECIMAL_POS}); 
              } else {
                 return valor.toLocaleString(Constants.CCPAIS, { style: 'decimal', currency: Constants.CCCURRENCY,  minimumFractionDigits: Constants.MIN_DECIMAL_POS, maximumFractionDigits: Constants.MAX_DECIMAL_POS});

              }
        }
      //           formatter: (ctx, data) => {
      //   return `${data.chart.data.labels[ext.dataIndex]}`;
      // }
        },
  scales: {
      y: {
        beginAtZero: true,
        ticks: {
            color: "green",
            font: funSizeLabel,
            // callback: function(value, index, ticks) {
            //             return '$' + value;
            //         }
          },
        grace: '3%',
        beginAtZero: true,
        title: {
          display: true,
          color: "green",
          text: props.metric,
          font: funSizeLabel
        }
      },
      x: {
        ticks: {
            color: "green",
            font: funSizeLabel
        },
        beginAtZero: true,
        title: {
          display: true,
          text: 'Meses',
          color: "green",
          font: funSizeLabel
        }
      }

    },
  plugins: {
    legend: {
      position: 'top',
    },
    title: {
      display: false,
      text: 'Chart.js Line Chart',
    },
  },
};

const data = {
  labels,
  datasets: [
    {
      label: 'Adicional Band. Vermelha',
      data: { 'Maio' : 4807.78, 'Junho' : 5012.34},
      borderColor: 'rgb(255, 99, 132)',
      backgroundColor: 'rgba(255, 99, 132, 0.5)',
    },
    {
      label: 'Beneficio Tarifario Bruto',
      data: { 'Maio' : 3407.78, 'Junho' : 3690.34},
      borderColor: 'rgb(53, 162, 235)',
      backgroundColor: 'rgba(53, 162, 235, 0.5)',
    },
  ],
};


useEffect(() => {
      let datasetsToLoad = [];
      let objectToLoad;
      let dataToLoad = {};

      console.log('Datos Received : >' + JSON.stringify(props.dataToShow) + '<');
      props.dataToShow.map( (dataDetail,x,row) => {
         let i;
         if ( props.type == 'ER' ) {
            for(i=0;i<Constants.itemToDelFromReportEnerg.length;i++) {
                if ( dataDetail.item.match(Constants.itemToDelFromReportEnerg[i]) ) break;
            }
         } else {
            i = Constants.itemToDelFromReportEnerg.length;
         }

         if ( i === Constants.itemToDelFromReportEnerg.length ) {
            dataToLoad = {};
            if ( props.metric === Constants.METRICS[0] ) {
               dataToLoad[labels[0]] = dataDetail.m01;
               dataToLoad[labels[1]] = dataDetail.m02;
               dataToLoad[labels[2]] = dataDetail.m03;
               dataToLoad[labels[3]] = dataDetail.m04;
               dataToLoad[labels[4]] = dataDetail.m05;
               dataToLoad[labels[5]] = dataDetail.m06;
               dataToLoad[labels[6]] = dataDetail.m07;
               dataToLoad[labels[7]] = dataDetail.m08;
               dataToLoad[labels[8]] = dataDetail.m09;
               dataToLoad[labels[9]] = dataDetail.m10;
               dataToLoad[labels[10]] = dataDetail.m11;
               dataToLoad[labels[11]] = dataDetail.m12;
            } else {
               dataToLoad[labels[0]] = dataDetail.v01;
               dataToLoad[labels[1]] = dataDetail.v02;
               dataToLoad[labels[2]] = dataDetail.v03;
               dataToLoad[labels[3]] = dataDetail.v04;
               dataToLoad[labels[4]] = dataDetail.v05;
               dataToLoad[labels[5]] = dataDetail.v06;
               dataToLoad[labels[6]] = dataDetail.v07;
               dataToLoad[labels[7]] = dataDetail.v08;
               dataToLoad[labels[8]] = dataDetail.v09;
               dataToLoad[labels[9]] = dataDetail.v10;
               dataToLoad[labels[10]] = dataDetail.v11;
               dataToLoad[labels[11]] = dataDetail.v12;
            }
            if ( props.type == 'ER' ) {
                datasetsToLoad.push({ label: dataDetail.item, 
                                    data : dataToLoad,
                                    borderColor: Constants.GRAPHS_COLORS[x],
                                    backgroundColor: Constants.GRAPHS_COLORS[x],
                                    fill: false,
                                    spanGaps: true
                                  });
            } else {
                datasetsToLoad.push({ label: dataDetail.type_client, 
                                    data : dataToLoad,
                                    borderColor: Constants.GRAPHS_COLORS[x],
                                    backgroundColor: Constants.GRAPHS_COLORS[x],
                                    fill: false,
                                    spanGaps: true
                                  });
            }
         }
         });
         objectToLoad = { labels : labels, datasets : datasetsToLoad};
         setDataG(objectToLoad);

  }, [props]);

  return (
  <div id="canvas-container">
       <Line options={options} data={dataG} />  
  </div>
  )
}
