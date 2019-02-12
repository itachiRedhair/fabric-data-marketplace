import { readFileSync } from 'fs';
import { resolve } from 'path';

const certsPath = resolve(__dirname, '../certs');
const readCryptoFile = filename => readFileSync(resolve(certsPath, filename)).toString();
const config = {
  channelName: 'main',
  channelConfig: readFileSync(resolve(__dirname, '../channelTrasactions/channel.tx')),
  orderer: {
    hostname: 'orderer',
    url: 'grpcs://orderer:7050',
    pem: readCryptoFile('ordererOrg.pem')
  },
  customerAOrg: {
    peer: {
      hostname: 'customer-a-peer',
      url: 'grpcs://customer-a-peer:7051',
      eventHubUrl: 'grpcs://customer-a-peer:7053',
      pem: readCryptoFile('customerAOrg.pem')
    },
    ca: {
      hostname: 'cusotmer-a-ca',
      url: 'https://cusotmer-a-ca:7054',
      mspId: 'CustomerAMSP'
    },
    admin: {
      key: readCryptoFile('Admin@cusotmer-a-org-key.pem'),
      cert: readCryptoFile('Admin@cusotmer-a-org-cert.pem')
    }
  },
  customerBOrg: {
    peer: {
      hostname: 'customer-b-peer',
      url: 'grpcs://customer-b-peer:7051',
      eventHubUrl: 'grpcs://customer-b-peer:7053',
      pem: readCryptoFile('customerBOrg.pem')
    },
    ca: {
      hostname: 'customer-b-ca',
      url: 'https://customer-b-ca:7054',
      mspId: 'CustomerBMSP'
    },
    admin: {
      key: readCryptoFile('Admin@customer-b-org-key.pem'),
      cert: readCryptoFile('Admin@customer-b-org-cert.pem')
    }
  },
  customerCOrg: {
    peer: {
      hostname: 'customer-c-peer',
      url: 'grpcs://customer-c-peer:7051',
      eventHubUrl: 'grpcs://customer-c-peer:7053',
      pem: readCryptoFile('customerCOrg.pem')
    },
    ca: {
      hostname: 'customer-c-ca',
      url: 'https://customer-c-ca:7054',
      mspId: 'CustomerCMSP'
    },
    admin: {
      key: readCryptoFile('Admin@customer-c-org-key.pem'),
      cert: readCryptoFile('Admin@customer-c-org-cert.pem')
    }
  },
  customerDOrg: {
    peer: {
      hostname: 'customer-d-peer',
      url: 'grpcs://customer-d-peer:7051',
      pem: readCryptoFile('customerDOrg.pem'),
      eventHubUrl: 'grpcs://customer-d-peer:7053'
    },
    ca: {
      hostname: 'customer-d-ca',
      url: 'https://customer-d-ca:7054',
      mspId: 'CustomerDMSP'
    },
    admin: {
      key: readCryptoFile('Admin@customer-d-org-key.pem'),
      cert: readCryptoFile('Admin@customer-d-org-cert.pem')
    }
  },
  mpBrokerOrg: {
    peer: {
      hostname: 'mp-broker-peer',
      url: 'grpcs://mp-broker-peer:7051',
      pem: readCryptoFile('mpBrokerOrg.pem'),
      eventHubUrl: 'grpcs://mp-broker-peer:7053'
    },
    ca: {
      hostname: 'mp-broker-ca',
      url: 'https://mp-broker-ca:7054',
      mspId: 'MPBrokerMSP'
    },
    admin: {
      key: readCryptoFile('Admin@mp-broker-org-key.pem'),
      cert: readCryptoFile('Admin@mp-broker-org-cert.pem')
    }
  }
};

// if (process.env.LOCALCONFIG) {
//   config.orderer.url = 'grpcs://localhost:7050';

//   config.insuranceOrg.peer.url = 'grpcs://localhost:7051';
//   config.shopOrg.peer.url = 'grpcs://localhost:8051';
//   config.repairShopOrg.peer.url = 'grpcs://localhost:9051';
//   config.policeOrg.peer.url = 'grpcs://localhost:10051';

//   config.insuranceOrg.peer.eventHubUrl = 'grpcs://localhost:7053';
//   config.shopOrg.peer.eventHubUrl = 'grpcs://localhost:8053';
//   config.repairShopOrg.peer.eventHubUrl = 'grpcs://localhost:9053';
//   config.policeOrg.peer.eventHubUrl = 'grpcs://localhost:10053';

//   config.insuranceOrg.ca.url = 'https://localhost:7054';
//   config.shopOrg.ca.url = 'https://localhost:8054';
//   config.repairShopOrg.ca.url = 'https://localhost:9054';
//   config.policeOrg.ca.url = 'https://localhost:10054';
// }

export default config;
