export const DEFAULT_PORT = 35907; 
export const DEFAULT_LANGUAGE = 'en';

// Token da mettere nel server come variabile d'ambiente
// TODO: Mettere su environment server
export const CC_TOKEN = 'i6HOPXnYIQvlJ1t4T&BFUN5V7jha0xKR3WMm9G8gsfe!#yZcodkb%2SrpADzLC?';

export const MAXPOS_X = 100;
export const MAXPOS_Y = 100;


export const name = "contaclara_api";
export const version = "2.7.0";

export const CC_KEY1_LIC = "K1EvhetXcVSlAa0Tqf74NnFrgIjmbyL";
export const CC_KEY2_LIC = "HL9O8jVagl52oKqUCi4ztQrxm1YAwPJ";
export const CC_LIC_TYPE_BASIC = "basic";
export const CC_LIC_DIR = "./licence";
export const CC_LIC_FILE = "licence.lic";

// PRODUCION
// const CC_CERT = '/etc/letsencrypt/live/contaclara.com.br/fullchain.pem'
// const CC_KEY =  '/etc/letsencrypt/live/contaclara.com.br/privkey.pem'

export const CC_CERT = './KEY/fullchain.pem';
export const CC_KEY =  './KEY/privkey.pem';


export const NEW_POINT_ENERGY = 'Novo Ponto De Energia';

// DB Connection

// const DB_HOST = '15.204.36.74'
// const DB_PORT = 7730
// const DB_USER = 'Utlocale1933'
// const DB_PWD = 'Egmint@2005'
// const DB_NAME = 'contaclaradb'

export const DB_HOST = '127.0.0.1'
export const DB_PORT = 3306
export const DB_USER = 'contaclara'
export const DB_PWD = 'contaclara'
export const DB_NAME = 'contaclaradb'

// Errors Code 
export const ERROR_CODES = { 
      ERROR_UPLOAD_FILE: {
        cod_error : 1,
        desc_error : {
            en : 'Error in upload file',
            // Add more languages
        }
      },
      ERROR_DB_INS_FILE: {
        cod_error : 2,
        desc_error : {
            en : 'Error in insert file on db',
            // Add more languages
        }
      },

};

export const getIdClient = (req) => {
     let ret = null;
     const bearerHeader = req.headers['authorization'];
     if (bearerHeader) {
        const tokens = bearerHeader.split(' ');
        if ( tokens.length >= 4 ) {
           ret = tokens[3];
        }
     } 
     return ret
}

export const getCompany = (req) => {
     let ret = null;
     const bearerHeader = req.headers['authorization'];
     if (bearerHeader) {
        const tokens = bearerHeader.split(' ');
        if ( tokens.length >= 6 ) {
           ret = tokens[5];
        }
     } 
     return ret
}

// Function to check Token
export const checkToken = (req) => {
     let ret = false;
     const bearerHeader = req.headers['authorization'];
     if (bearerHeader) {
        const bearer = bearerHeader.split(' ');
        const bearerToken = bearer[1];
        if ( bearerToken != CC_TOKEN ) {
          ret = false;
        } else {
          ret = true;
        }
      } else {
        ret = false;
      }   
      return ret;
}
