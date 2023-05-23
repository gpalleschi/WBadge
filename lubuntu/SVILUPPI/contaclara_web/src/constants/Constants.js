//ProduccionQ
import { createTheme } from '@mui/material/styles';

export const CC_TOKEN = 'i6HOPXnYIQvlJ1t4T&BFUN5V7jha0xKR3WMm9G8gsfe!#yZcodkb%2SrpADzLC?';
//export const URLCCAPI = 'https://15.204.36.74:35907'
export const URLCCAPI = 'https://192.168.56.210:35907';
//export const URLCCAPI = 'https://contaclara.com.br:35907'

// Change this value in package.json too
export const VERSION = '1.6.0';

// Area Init

export const IDLE_TIME = 10; // In Minute
export const NO_RESPONSE_CODE = 0;
export const TIMEOUT = 8000;
export const INIT_APP = { id_client : null,
	                  client_name : null,
			  company : null,
	                  id_user   : null,
	                  user_name : null,
	                  user_type : null,
			  user_email : null,
			  isOpenMenuApp : false,
			  isOpenMenuUser : false,
			  current_menu : null,
	                  loading : false,
		          errorUser : 0,
			  errorMsg : null,			   
	                  logged : false,
			  loaded_clients : false,
			  clients: []};


// Area Parameters 

export const CCMAX_ELEM_SHOW_GRAPH = 10;

// Area Language

// LABEL LANGUAGES
// Change CCLANGUAGE TO CHANGE LABELS

export const CCLANGUAGE = 'pt';
export const CCPAIS = 'pt-BR';
export const CCCURRENCY = 'BRL';

export const MIN_DECIMAL_POS = 2;
export const MAX_DECIMAL_POS = 2;

export const MAX_MONTHS_GRAPH = 4;

export const MIN_PASSWORD_LENGTH = 3;
export const MAX_PASSWORD_LENGTH = 15;

export const LABEL = { filepond_labelIdle  : { en : 'Drag & Drop your pdf invoice file or <span class="filepond--label-action">Browse</span>',
                                               pt : 'Arraste e solte seu arquivo de fatura em pdf ou <span class = "filepond--label-action">Navegue</span>',
					     },
                       title_invoiceUpload : { en : 'UPLOAD INVOICE',
                                               pt : 'UPLOAD FATURA',
					     },
		       idleMessage         : { en : 'Idle time reached',
		                               pt : 'Tempo de inatividade excedido'
		                             },
                       ServerUnavailable   : { en : 'Server unavailable',
                                               pt : 'Servidor indisponível',
					     },
                       ErrorDuringFetch    : { en : 'Error during fetch data',
                                               pt : 'Erro ao buscar dados',
					     },
                       ErrorDuringUpdate   : { en : 'Error during update data',
                                               pt : 'Erro durante a atualização de dados',
					     },
                       ErrorDuringDelete   : { en : 'Error during delete data',
                                               pt : 'Erro ao excluir dados',
					     },
                       ErrorDuringInsert   : { en : 'Error during insert data',
                                               pt : 'Erro ao inserir dados',
					     },
                       ErrorDuringDownload : { en : 'Error during download invoice',
                                               pt : 'Erro durante o download da fatura',
					     },
                       labelInvalidField   : { en : 'Field contains invalid files',
		                               pt : 'O campo contém arquivos inválidos'
		                             },	
                       labelFileWaitingForSize : { en : 'Waiting for size',
		                                   pt : 'Aguardando o tamanho'
		                                 },
                       labelFileSizeNotAvailable : { en : 'Size not available',
		                                     pt : 'Tamanho não disponível'
		                                   },
                       labelFileLoading          : { en : 'Loading',
		                                     pt : 'Carregando'
		                                   },
                       leituraAnterior           : { pt : 'Leitura Anterior',
		                                     en : 'Previous Reading'
		                                   },
                       leituraAtual              : { pt : 'Leitura Atual',
		                                     en : 'Current Reading'
		                                   },
                       NdeDias                   : { en : 'Nº days',
		                                     pt : 'Nº de dias'
		                                   },
                       leituraProxima            : { pt : 'Próxima Leitura',
		                                     en : 'Next Reading'
		                                   },
                       labelFileLoadError        : { en : 'Error during load',
		                                     pt : 'Erro durante o carregamento'
		                                   },
                       labelFileProcessing       : { en : 'Uploading',
		                                     pt : 'Elaborando' 
		                                   },
                       labelFileProcessingComplete : { en : 'Upload complete',
                                                       pt : 'Elaboração completa',
		                                     },
                       labelFileProcessingAborted : { en : 'Upload cancelled',
		                                      pt : 'Elaborazione cancellata' 
						    },
                       labelFileProcessingError : { en : 'Error during upload',
		                                    pt :  'Erro durante a elaboração'
		                                  },
                       labelFileProcessingRevertError : { en : 'Error during revert',
		                                          pt : 'Erro durante a reversão'
		                                        },
                       labelFileRemoveError : { en : 'Error during remove',
		                                pt : 'Erro durante a remoção' 
					      },
                       labelTapToCancel : { en : 'tap to cancel',
		                            pt : 'toque para cancelar'
		                          },
                       labelTapToRetry : { en : 'tap to retry',
		                           pt : 'toque para tentar novamente'
		                         },
                       labelTapToUndo : { en : 'tap to close',
		                          pt : 'toque para fechar'
		                        },
                       labelButtonRemoveItem : { en : 'Remove',
		                                 pt : 'Remover'
		                               },
                       labelButtonAbortItemLoad : { en : 'Abort',
		                                    pt : 'Abortar'
		                                  },
                       labelButtonRetryItemLoad : { en : 'Retry',
		                                    pt : 'Repetir'
		                                  },
                       labelButtonAbortItemProcessing : { en : 'Cancel',
		                                          pt : 'Cancelar'   
		                                        },
                       labelButtonUndoItemProcessing : { en : 'Undo',
		                                         pt : 'Desfazer'
		                                       },
                       labelButtonRetryItemProcessing : { en : 'Retry',
		                                          pt : 'Repetir'
						        },
                       labelButtonProcessItem : { en : 'Upload',
		                                  pt : 'Elaboração' },
		       NoPdfFile              : { en : 'No PDF File',
		                                  pt : 'Arquivos não pdf'
		                                },
		       ErrParsingPdf          : { en : 'Error during Parsing PDF File',
		                                  pt : 'Erro ao analisar arquivo PDF'
		                                },
		       ErrTypeInvoice         : { en : 'Invoice type not recognized',
		                                  pt : 'Tipo de fatura não reconhecido'
		                                },
		       ErrInvoiceNotComplete  : { en : 'Incomplete invoice some customers are missing',
		                                  pt : 'Fatura incompleta faltam alguns clientes'
		                                },
                       GenericError           : { en : 'Generic Error during elaboracion',
                                                  pt : 'Erro genérico durante a elaboração',
		                                },
		       contaVerificada        : { en : 'VERIFIED INVOICE',
                                                  pt : 'CONTA VERIFICADA'
		                                },
		       contaNoVerificada      : { en : 'IDENTIFIED DIFFERENCES',
                                                  pt : 'IDENTIFICADAS DIFERENCIAS'
		                                },
                       formatoEmailErrado     : { en : 'Wrong email format',
			                          pt : 'Formato de email errado'
					        },
		       errAccount1            : { en : 'To change the email you need to enter your password',
			                          pt : 'Para alterar o e-mail você precisa digitar sua password'
		                                },
		       errAccount2            : { en : 'To change the password, the new password must be entered twice',
			                          pt : 'Para alterar a password, a nova password deve ser digitada duas vezes'
		                                },
		       errAccount3            : { en : 'To change the password, the new password must be entered twice with the same value',
			                          pt : 'Para alterar a password, a nova password deve ser digitada duas vezes com o mesmo valor'
		                                },
		       errAccount4            : { en : 'To change the password, you need to enter your old password',
			                          pt : 'Para alterar a password, você precisa digitar sua antiga password'
		                                },
		       errAccount5            : { en : 'Incorrect password values ​​entered',
			                          pt : 'Valores de password inseridos incorretos'
		                                },
		       errAccount6            : { en : 'Enter the same values ​​for password',
			                          pt : 'Digite os mesmos valores para password'
		                                },
		       errAccount7            : { en : 'The length of the new password must be at least ' + MIN_PASSWORD_LENGTH + ' and at most ' + MAX_PASSWORD_LENGTH + ' characters',
			                          pt : 'O comprimento da nova senha deve ter no mínimo ' + MIN_PASSWORD_LENGTH + ' e no máximo ' + MAX_PASSWORD_LENGTH + ' caracteres'
		                                },
		       errAccount8            : { en : 'There are no changes',
			                          pt : 'Não há alterações'
		                                },
		       errAccount9            : { en : 'Update failed',
			                          pt : 'Atualização falhou'
		                                },
		       labelUserName          : { en : 'User name',
			                          pt : 'Nome de usuário'
		                                },
		       labelTypeUser          : { en : 'User type',
			                          pt : 'Tipo de usuário'
					        },  
		       labelEmail             : { en : 'Email',
			                          pt : 'Email'
					        },
		       labelPassword          : { en : 'Password',
			                          pt : 'Password'
					        },
		       labelOldPwd            : { en : 'Old Password',
			                          pt : 'Antiga Password'
					        },
		       labelNewPwd1           : { en : 'New Password',
			                          pt : 'Nova Password'
					        }, 
		       labelNewPwd2           : { en : 'Repeat new password',
			                          pt : 'Repita a nova Password'
					        }, 
		       headerDlgAccount       : { en : 'User Edit',
			                          pt : 'Editar o usuário'
					        }, 
		       errUpdate              : { en : 'Error during update',
			                          pt : 'Erro durante a atualização'
					        }, 
		       errDelete              : { en : 'Error during delete',
			                          pt : 'Erro ao deletar'
					        }, 
		       errInsert              : { en : 'Error during insert',
			                          pt : 'Erro durante a inserção'
					        }, 
		       descUpdated            : { en : 'Description updated',
			                          pt : 'Descrição atualizada'
					        },
		       energyPointUpdated     : { en : 'Energy Point updated',
			                          pt : 'Ponto de energia atualizado'
					        },
		       typeClientUpdated      : { en : 'Type client updated',
			                          pt : 'Tipo de cliente atualizado'
					        },
		       typeClientDeleted      : { en : 'Type client deleted',
			                          pt : 'Tipo de cliente deletado'
					        },
		       typeClientInserted     : { en : 'Type client inserted',
			                          pt : 'Tipo de cliente inserido'
					        },
		       userUpdated            : { en : 'User updated',
			                          pt : 'Usuário atualizado'
					        },
                       contract               : { en : 'Contract',
			                          pt : 'Contrato'
					        },
                       dueDate                : { en : 'Due Date',
			                          pt : 'Vencimento'
					        },
                       descContract           : { en : 'Contract description',
			                          pt : 'Descrição do contrato'
					        },
                       descTypeClient    : { en : 'Type client description',
			                          pt : 'Descrição do tipo de cliente'
					        },
                       subContract            : { en : 'Sub Contract',
			                          pt : 'Contrato Filha'
					        },
                       descSubContract        : { en : 'Sub Contract description',
			                          pt : 'Descrição do contrato filha'
					        },
                       headerEnergyPointsMgmt : { en : 'Power points management',
			                          pt : 'Gestão de pontos de energia'
					        },
                       headerTypeClientsMgmt : { en : 'Type clients management',
			                          pt : 'Gestão de tipos de clientes'
					        },
                       typeInvoice            : { en : 'Type Invoice',
			                          pt : 'Tipo Fatura'
					        },
                       typeClient            : { en : 'Client Type',
			                          pt : 'Tipo Cliente'
					        },
                       invoice                : { en : 'Invoice',
			                          pt : 'Fatura'
					        },
                       value                  : { en : 'Value',
			                          pt : 'Valor'
					        },
                       undefined              : { en : 'Undefined',
			                          pt : 'Indefinido'
					        },
                       unit                    : { en : 'Unit',
			                          pt : 'Unidade'
					        },
                       amount                  : { en : 'Amount',
			                          pt : 'Quantidade'
					        },
                       description            : { en : 'Description',
			                          pt : 'Descriçao'
					        },
                       unitPrice              : { en : 'Unit Price',
			                          pt : 'Preço Unitario'
					        },
                       totMeasured            : { en : 'Total Measured',
			                          pt : 'Total Medido'
					        },
                       measuredValue          : { en : 'Measured Value',
			                          pt : 'Valor Medido'
					        },
                       invoicedAmount         : { en : 'Invoiced Amount',
			                          pt : 'Valor Faturado'
					        },
                       status                 : { en : 'Status',
			                          pt : 'Estado'
					        },
                       headerEditDescContract : { en : 'Edit contract description',
			                          pt : 'Editar descrição contrato'
					        },
                       headerEditTypeClient : { en : 'Edit type client',
			                          pt : 'Editar tipo de cliente'
					        },
                       headerDelTypeClient : { en : 'Delete type client',
			                          pt : 'Limpar tipo de cliente'
					        },
                       headerInsTypeClient : { en : 'Insert new type client',
			                          pt : 'Adicionar novo tipo de cliente'
					        },
                       graphicA               : { en : 'Graph Analysis Active Energy, Group A (Medium Voltage)',
			                          pt : 'Grafico Analise Energia Ativa, Grupo A (Media tensão)'
					        },
                       graphicB               : { en : 'History Consumption Progress Group B (Low Voltage)',
			                          pt : 'Hist. Andamento Consumos Grupo B (Baixa tensão)'
					        },
                       selMetric              : { en : 'Select the metric  ',
			                          pt : 'Selecione a metrica  '
					        },
                       selYear                : { en : 'Select year  ',
			                          pt : 'Selecione o ano  '
					        },
                       selEnergyPoints        : { en : 'Selecting energy points  ',
			                          pt : 'Selecionar pontos fornece energia  '
					        },
                       selTypeClients    : { en : 'Selecting type clients',
			                          pt : 'Selecionar tipos de clientes'
					        },
                       energyPointsSelected   : { en : 'energy points selected',
			                          pt : 'pontos selecionado'
					        },
                       typesClientSelected   : { en : 'types client selected',
			                          pt : 'tipos selecionados'
					        },
                       titleContractBiHoursP  : { en : 'SEASONAL TIME CONTRACTS - Active Energy Consumption Peak',
			                          pt : 'CONTRATOS HORO SAZONAIS - Consumo Energia Ativa Ponta'
					        },
                       titleContractBiHoursFP : { en : 'SEASONAL TIME CONTRACTS - Active Energy Consumption OFF Peak',
			                          pt : 'CONTRATOS HORO SAZONAIS - Consumo Energia Ativa FORA Ponta'
					        },
                       titleContractNoBiHours : { en : 'SEASONAL NON-TIME CONTRACTS - Active Energy Consumption',
			                          pt : 'CONTRATOS NÃO HORO SAZONAIS - Consumo Energia Ativa'
					        },
                       titleUploadInvoice     : { en : 'Upload Invoice',
			                          pt : 'Upload Fatura'
					        },
                       headerContratoMAE      : { en : 'MASTER CONTRACT',
			                          pt : 'CONTRATO MAE'
					        },
                       headerContratoINV      : { en : 'INVOICE',
			                          pt : 'FATURA'
					        },
                       headerContratoGROUP    : { en : 'GROUP',
			                          pt : 'GRUPO'
					        },
                       headerContratoVENC     : { en : 'DUE DATE',
			                          pt : 'VENCIMENTO'
					        },
                       headerContratoVALUE    : { en : 'VALUE',
			                          pt : 'VALOR'
					        },
                       headerContratoFILENAME : { en : 'File Name',
			                          pt : 'File Name'
					        },
                       headerContratoUPLDATE  : { en : 'UPLOAD DATE',
			                          pt : 'DATA DE UPLOAD'
					        },
                       headerDOWNLOAD         : { en : 'DOWNLOAD',
			                          pt : 'DOWNLOAD'
					        },
                       titleAnalysisA         : { en : 'GROUP A ACCOUNT ANALYSIS (MT)',
			                          pt : 'ANALISE CONTA GRUPO A (MT)'
					        },
                       titleAnalysisB         : { en : 'GROUP B ACCOUNT ANALYSIS (BT)',
			                          pt : 'ANALISE CONTA GRUPO B (BT)'
					        },
                       titleControlSubInv     : { en : 'CONTROL OF SUB CONTRACTS',
			                          pt : 'CONTROLE DAS CONTAS FILHAS'
					        },
                       titleControlDetSubInv  : { en : 'CONTROL OF DETAILS OF SUB CONTRACTS',
			                          pt : 'CONTROLE DOS DETALHES DAS CONTAS FILHAS'
					        },
                       totals                 : { en : 'Totals',
			                          pt : 'Totales'
					        },
                       titleReportTypeClients     : { en : 'Detailed report of type clients',
			                          pt : 'Relatório detalhado do tipo Clientes'
					        },
                       titleReportA           : { en : 'Group A Energy Analysis (Medium Voltage)',
			                          pt : 'Analise Energética Grupo A (Media Tensão)'
					        },
                       titleReportB           : { en : 'Group B Energy Analysis (Low Voltage)',
			                          pt : 'Analise Energética Grupo B (Baixa Tensão)'
					        },
                       sumTETUSD              : { en : 'Summarize by TE and TUSD',
			                          pt : 'Sumariza por TE e TUSD'
					        },
                       specification          : { en : 'Specification',
			                          pt : 'Especificação'
					        },
                       m01                    : { en : 'Great. Jan',
			                          pt : 'Grand. Jan'
					        },
                       m02                    : { en : 'Great. Feb',
			                          pt : 'Grand. Fev'
					        },
                       m03                    : { en : 'Great. Mar',
			                          pt : 'Grand. Mar'
					        },
                       m04                    : { en : 'Great. Apr',
			                          pt : 'Grand. Abr'
					        },
                       m05                    : { en : 'Great. May',
			                          pt : 'Grand. Mai'
					        },
                       m06                    : { en : 'Great. Jun',
			                          pt : 'Grand. Jun'
					        },
                       m07                    : { en : 'Great. Jul',
			                          pt : 'Grand. Jul'
					        },
                       m08                    : { en : 'Great. Aug',
			                          pt : 'Grand. Ago'
					        },
                       m09                    : { en : 'Great. Sep',
			                          pt : 'Grand. Set'
					        },
                       m10                    : { en : 'Great. Oct',
			                          pt : 'Grand. Out'
					        },
                       m11                    : { en : 'Great. Nov',
			                          pt : 'Grand. Nov'
					        },
                       m12                    : { en : 'Great. Dec',
			                          pt : 'Grand. Dez'
					        },
                       v01                    : { en : 'Val. Jan',
			                          pt : 'Val. Jan'
					        },
                       v02                    : { en : 'Val. Feb',
			                          pt : 'Val. Fev'
					        },
                       v03                    : { en : 'Val. Mar',
			                          pt : 'Val. Mar'
					        },
                       v04                    : { en : 'Val. Apr',
			                          pt : 'Val. Abr'
					        },
                       v05                    : { en : 'Val. May',
			                          pt : 'Val. Mai'
					        },
                       v06                    : { en : 'Val. Jun',
			                          pt : 'Val. Jun'
					        },
                       v07                    : { en : 'Val. Jul',
			                          pt : 'Val. Jul'
					        },
                       v08                    : { en : 'Val. Aug',
			                          pt : 'Val. Ago'
					        },
                       v09                    : { en : 'Val. Sep',
			                          pt : 'Val. Set'
					        },
                       v10                    : { en : 'Val. Oct',
			                          pt : 'Val. Out'
					        },
                       v11                    : { en : 'Val. Nov',
			                          pt : 'Val. Nov'
					        },
                       v12                    : { en : 'Val. Dec',
			                          pt : 'Val. Dez'
					        },
                       titleYearGraph         : { en : 'Year Graph',
			                          pt : 'Gráfico anual'
					        },
                       titleEPGraph           : { en : 'Energy Points Graph',
			                          pt : 'Gráfico Pontos de Energia'
					        },
                       monthsarray            : { en : ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho','Agosto','Setembro','Outubro','Novembro', 'Dezembro'],
			                          pt : ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho','Agosto','Setembro','Outubro','Novembro', 'Dezembro']
					        },
                       headerUsersManagment   : { en : 'Users Managment',
			                          pt : 'Gerenciamento de usuários'
					        },
                       headerNewAccount       : { en : 'Add new user',
			                          pt : 'Adicionar novo usuário'
					        },
		       errNewUser1            : { en : 'Insert user name',
			                          pt : 'Insira nome de usuário'
		                                },
		       errNewUser2            : { en : 'Insert email',
			                          pt : 'Insira email'
		                                },
		       errNewUser3            : { en : 'Insert password',
			                          pt : 'Insira password'
		                                },
		       errNewUser4            : { en : 'User already present',
			                          pt : 'Usuário já presente'
		                                },
		       errNewUser5            : { en : 'The length of the password must be at least ' + MIN_PASSWORD_LENGTH + ' and at most ' + MAX_PASSWORD_LENGTH + ' characters',
			                          pt : 'O comprimento da senha deve ter no mínimo ' + MIN_PASSWORD_LENGTH + ' e no máximo ' + MAX_PASSWORD_LENGTH + ' caracteres'
		                                },
		       errNewUser6            : { en : 'The length of the user name must be at least ' + MIN_PASSWORD_LENGTH + ' and at most ' + MAX_PASSWORD_LENGTH + ' characters',
			                          pt : 'O comprimento do nome de usuário deve ter no mínimo ' + MIN_PASSWORD_LENGTH + ' e no máximo ' + MAX_PASSWORD_LENGTH + ' caracteres'
		                                },
		       errGetData             : { en : 'Error during get data',
			                          pt : 'Erro ao obter dados'
					        }, 
		       emptyRowUsersMessage   : { en : 'No users found',
			                          pt : 'Usuários não encontrados'
					        }, 
		       userDeleted            : { en : 'User deleted',
			                          pt : 'Usuários deletado'
					        }, 
		       confirmDelete          : { en : 'Are you sure you want to delete',
			                          pt : 'Tem certeza de que deseja deletear'
					        }, 
		       confirm                : { en : 'Confirm',
			                          pt : 'Confirme'
					        }, 
		       no                     : { en : 'No',
			                          pt : 'Não'
					        }, 
		       yes                    : { en : 'Yes',
			                          pt : 'Sim'
					        }, 
		       cancel                 : { en : 'Cancel',
			                          pt : 'Cancelar'
					        }, 
		       save                   : { en : 'Save',
			                          pt : 'Salvar'
					        }, 
		       delete                 : { en : 'Delete',
			                          pt : 'Limpar'
					        }, 
		       userAdded              : { en : 'User added',
			                          pt : 'Usuário adicionado'
					        }, 
		       errAddUser             : { en : 'Error during add user',
			                          pt : 'Erro ao adicionar usuário'
					        }, 
		       errDelUser             : { en : 'Error during delete user',
			                          pt : 'Erro ao deleitar usuário'
					        }, 
		       error                  : { en : 'Error',
			                          pt : 'Erro'
					        }, 
		       success                : { en : 'Success',
			                          pt : 'Sucesso'
					        }, 
		       userNotFound           : { en : 'User Not Found',
			                          pt : 'Usuário não encontrado'
					        }, 
		       wrongPwd               : { en : 'Wrong Password',
			                          pt : 'Senha incorreta'
					        }, 
		       wrongLic               : { en : 'Wrong or Missing License File',
			                          pt : 'Arquivo de Licença Incorreto ou Ausente'
					        }, 
		       expiredLic             : { en : 'Licence Expired',
			                          pt : 'Licença Expirada'
					        }, 
		       wrongTypeLic           : { en : 'Wrong Type of Licence',
			                          pt : 'Tipo de licença incorreto'
					        }, 
		       signIn                 : { en : 'Sign In',
			                          pt : 'Entrar'
					        }, 
		       relatorio              : { en : 'Report',
			                          pt : 'Relatorio'
					        }, 
		       newLabel               : { en : 'New',
			                          pt : 'Novo'
					        }, 
					
					
		     }					    

export const getLabel = (label) => {

	let retLabel = '### NOT FOUND ' + label + '###';

	if ( LABEL.hasOwnProperty(label) ) {

		const labels = LABEL[label];

		if ( labels.hasOwnProperty(CCLANGUAGE) ) {
			retLabel = labels[CCLANGUAGE];
		}
	}
	
	return retLabel;
}

export const TIME_TOAST = 3000;

export const METRICS = ['Consumo (kWh)','Total Faturado (R$)'];

// Area Menu

export const UPLOADINVOICE = 'UploadInvoice';
export const ENERGYPOINTMGMT = 'EnergyPointsMgmt';
export const TYPECLIENTSMGMT = 'TypeClientsMgmt';
export const RELATORIOTC = 'RelatorioTipoCliente';
export const ANALISISCONTA = 'AnaliseContaA';
export const RELATORIOANALISEENEA = 'RelatorioAnaliseEnergeticaA';
export const GRAFICOA = 'GraficoA';
export const ANALISISCONTB = 'AnaliseContaB';
export const RELATORIOANALISEENEB = 'RelatorioAnaliseEnergeticaB';
export const GRAFICOB = 'GraficoB';

export const MENU_APP = [UPLOADINVOICE,ENERGYPOINTMGMT,ANALISISCONTA,RELATORIOANALISEENEA,GRAFICOA,ANALISISCONTB,RELATORIOANALISEENEB,GRAFICOB,TYPECLIENTSMGMT,RELATORIOTC];

export const USERSMNGMT = 'UserManagment';
export const ACCOUNTITEM = 'Account';
export const LOGOUTITEM = 'Logout';

export const MENU_USER = [USERSMNGMT,ACCOUNTITEM,LOGOUTITEM];

// Area Colors

export const COLOR_HEADER_TABLE = '#ff932a';
export const COLOR_ODD_ROW = '#c4e7ca';
export const COLOR_EVEN_ROW = '#75C988';
export const BGCOLOR = '#c4e7ca';
export const COLOR_LABELS = "green";
export const COLOR_TOTAL_ROW = "green";
export const COLOR_SPINNER = "green";

export const CCTheme = createTheme({
  palette: {
    primary: {
      main: BGCOLOR
    },
    background: {
      default: BGCOLOR,
    }
  }	
});

export const GRAPHS_COLORS = ['#8884d8','#82ca9d','#2ca25f','#43a2ca','#bcbddc','#fa9fb5','#feb24c','#ffeda0','#fcbba1','#feb24c','#41b6c4',
                              '#006d2c','#238b45','#41ae76','#66c2a4','#99d8c9','#ccece6','#800026','#bd0026','#e31a1c',
			      '#fc4e2a','#fd8d3c','#fed976','#ffeda0','#980043','#ce1256','#e7298a','#2171b5', '#4292c6',
			      '#6baed6','#9ecae1','#df65b0','#1d91c0','#225ea8','#253494','#9e9ac8',
			      '#870000','#00ff00','#0000ff','#800000','#008000','#000080','#400000','#004000','#000040','#80ffff',
			      '#ff80ff','#ffff80','#ff8080','#80ff80','#8080ff'];


// Area Function 

export const isClient = (listClients, client) => {
	let ret = null;

	for(let i=0;i<listClients.length;i++) {
	   if ( client === listClients[i].client_name ) {
	        ret = listClients[i];	
		break;
	   }
	}
	return ret;
}

// TODO: Export this list in a table
export const itemToDelFromReportEnerg = ['^DMIC.*','Subtotal .*','TOTAL.*'];


