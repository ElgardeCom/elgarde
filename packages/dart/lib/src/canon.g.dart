// GENERATED FILE — DO NOT EDIT.

//

// Written by inspection-core/tools/sync_canon.py from

// inspection-core/data/. Change the canon there and re-run it.

//

// The canon is data, but a pure Dart package cannot ship a runtime

// data file, so it is embedded here as raw JSON strings.

const String checklistCanonJson = r'''
{
  "version": 1,
  "languages": [
    "en",
    "pt",
    "ru",
    "uk",
    "fr"
  ],
  "base": [
    {
      "id": "ext",
      "order": 0,
      "title": {
        "en": "Exterior",
        "pt": "Exterior",
        "ru": "Экстерьер",
        "uk": "Екстерʼєр",
        "fr": "Extérieur"
      },
      "children": [
        {
          "id": "ext.body",
          "order": 0,
          "title": {
            "en": "Body & paint",
            "pt": "Carroçaria e pintura",
            "ru": "Кузов и краска",
            "uk": "Кузов і фарба",
            "fr": "Carrosserie et peinture"
          },
          "items": [
            {
              "id": "ext.body.panels",
              "order": 0,
              "prompt": {
                "en": "Panel gaps even, no misalignment",
                "pt": "Folgas dos painéis uniformes, sem desalinhamento",
                "ru": "Зазоры кузова ровные, без перекосов",
                "uk": "Зазори кузова рівні, без перекосів",
                "fr": "Jeux de carrosserie réguliers, sans désalignement"
              }
            },
            {
              "id": "ext.body.paint",
              "order": 1,
              "prompt": {
                "en": "Paint consistent, no respray/overspray",
                "pt": "Pintura consistente, sem repintura",
                "ru": "Краска однородная, без перекраса",
                "uk": "Фарба однорідна, без перефарбування",
                "fr": "Peinture homogène, sans retouche ni surpulvérisation"
              }
            },
            {
              "id": "ext.body.rust",
              "order": 2,
              "prompt": {
                "en": "No rust or corrosion",
                "pt": "Sem ferrugem ou corrosão",
                "ru": "Нет ржавчины и коррозии",
                "uk": "Немає іржі та корозії",
                "fr": "Ni rouille ni corrosion"
              },
              "critical": true
            }
          ]
        },
        {
          "id": "ext.glass",
          "order": 1,
          "title": {
            "en": "Glass & lights",
            "pt": "Vidros e luzes",
            "ru": "Стёкла и фары",
            "uk": "Скло і фари",
            "fr": "Vitrage et éclairage"
          },
          "items": [
            {
              "id": "ext.glass.windscreen",
              "order": 0,
              "prompt": {
                "en": "Windscreen free of cracks/chips",
                "pt": "Para-brisas sem fissuras/lascas",
                "ru": "Лобовое без трещин и сколов",
                "uk": "Лобове без тріщин і сколів",
                "fr": "Pare-brise sans fissures ni impacts"
              }
            },
            {
              "id": "ext.glass.lights",
              "order": 1,
              "prompt": {
                "en": "All exterior lights work",
                "pt": "Todas as luzes exteriores funcionam",
                "ru": "Вся внешняя оптика работает",
                "uk": "Уся зовнішня оптика працює",
                "fr": "Tous les feux extérieurs fonctionnent"
              }
            }
          ]
        },
        {
          "id": "ext.tyres",
          "order": 2,
          "title": {
            "en": "Tyres & wheels",
            "pt": "Pneus e jantes",
            "ru": "Шины и диски",
            "uk": "Шини і диски",
            "fr": "Pneus et jantes"
          },
          "items": [
            {
              "id": "ext.tyres.tread",
              "order": 0,
              "prompt": {
                "en": "Tread depth adequate (≥1.6 mm; note mm per tyre)",
                "pt": "Profundidade do piso adequada (≥1,6 mm; anote mm por pneu)",
                "ru": "Глубина протектора достаточна (≥1,6 мм; укажите мм по колёсам)",
                "uk": "Глибина протектора достатня (≥1,6 мм; вкажіть мм по колесах)",
                "fr": "Profondeur de sculpture suffisante (≥1,6 mm ; noter les mm par pneu)"
              }
            },
            {
              "id": "ext.tyres.even",
              "order": 1,
              "prompt": {
                "en": "Tread worn evenly (across each tyre and between axles)",
                "pt": "Piso desgastado de forma uniforme (em cada pneu e entre eixos)",
                "ru": "Протектор изношен равномерно (по ширине и между осями)",
                "uk": "Протектор зношений рівномірно (по ширині та між осями)",
                "fr": "Usure régulière (sur chaque pneu et entre les essieux)"
              }
            },
            {
              "id": "ext.tyres.damage",
              "order": 2,
              "prompt": {
                "en": "No kerb/wheel damage, matching tyres",
                "pt": "Sem danos nas jantes, pneus iguais",
                "ru": "Диски без повреждений, шины одинаковые",
                "uk": "Диски без пошкоджень, шини однакові",
                "fr": "Jantes sans dommage, pneus identiques"
              }
            }
          ]
        }
      ]
    },
    {
      "id": "int",
      "order": 1,
      "title": {
        "en": "Interior",
        "pt": "Interior",
        "ru": "Салон",
        "uk": "Салон",
        "fr": "Intérieur"
      },
      "children": [
        {
          "id": "int.ctrl",
          "order": 0,
          "title": {
            "en": "Controls & electronics",
            "pt": "Comandos e eletrónica",
            "ru": "Управление и электроника",
            "uk": "Керування та електроніка",
            "fr": "Commandes et électronique"
          },
          "items": [
            {
              "id": "int.ctrl.warn",
              "order": 0,
              "prompt": {
                "en": "No dashboard warning lights",
                "pt": "Sem luzes de aviso no painel",
                "ru": "Нет ошибок на панели",
                "uk": "Немає помилок на панелі",
                "fr": "Aucun témoin d’alerte au tableau de bord"
              },
              "critical": true
            },
            {
              "id": "int.ctrl.ac",
              "order": 1,
              "prompt": {
                "en": "A/C, infotainment, windows work",
                "pt": "A/C, multimédia, vidros funcionam",
                "ru": "Климат, мультимедиа, стёкла работают",
                "uk": "Клімат, мультимедіа, скло працюють",
                "fr": "Clim, multimédia et vitres fonctionnent"
              }
            }
          ]
        },
        {
          "id": "int.seats",
          "order": 1,
          "title": {
            "en": "Seats & belts",
            "pt": "Bancos e cintos",
            "ru": "Сиденья и ремни",
            "uk": "Сидіння та ремені",
            "fr": "Sièges et ceintures"
          },
          "items": [
            {
              "id": "int.seats.wear",
              "order": 0,
              "prompt": {
                "en": "Wear consistent with mileage",
                "pt": "Desgaste consistente com a quilometragem",
                "ru": "Износ соответствует пробегу",
                "uk": "Знос відповідає пробігу",
                "fr": "Usure cohérente avec le kilométrage"
              }
            },
            {
              "id": "int.seats.belts",
              "order": 1,
              "prompt": {
                "en": "All seatbelts function",
                "pt": "Todos os cintos funcionam",
                "ru": "Все ремни работают",
                "uk": "Усі ремені працюють",
                "fr": "Toutes les ceintures fonctionnent"
              },
              "critical": true
            }
          ]
        }
      ]
    },
    {
      "id": "eng",
      "order": 2,
      "title": {
        "en": "Under the hood",
        "pt": "Compartimento do motor",
        "ru": "Под капотом",
        "uk": "Під капотом",
        "fr": "Sous le capot"
      },
      "children": [
        {
          "id": "eng.fluids",
          "order": 0,
          "title": {
            "en": "Fluids & leaks",
            "pt": "Fluidos e fugas",
            "ru": "Жидкости и потёки",
            "uk": "Рідини та підтікання",
            "fr": "Fluides et fuites"
          },
          "items": [
            {
              "id": "eng.fluids.oil",
              "order": 0,
              "prompt": {
                "en": "Oil level and condition ok",
                "pt": "Nível e estado do óleo ok",
                "ru": "Уровень и состояние масла ок",
                "uk": "Рівень і стан оливи ок",
                "fr": "Niveau et état de l’huile corrects"
              }
            },
            {
              "id": "eng.fluids.leaks",
              "order": 1,
              "prompt": {
                "en": "No visible leaks",
                "pt": "Sem fugas visíveis",
                "ru": "Нет видимых потёков",
                "uk": "Немає видимих підтікань",
                "fr": "Aucune fuite visible"
              },
              "critical": true
            }
          ]
        },
        {
          "id": "eng.belts",
          "order": 1,
          "title": {
            "en": "Belts & mounts",
            "pt": "Correias e apoios",
            "ru": "Ремни и опоры",
            "uk": "Ремені та опори",
            "fr": "Courroies et supports"
          },
          "items": [
            {
              "id": "eng.belts.aux",
              "order": 0,
              "prompt": {
                "en": "Auxiliary belt in good condition",
                "pt": "Correia auxiliar em bom estado",
                "ru": "Приводной ремень в норме",
                "uk": "Привідний ремінь у нормі",
                "fr": "Courroie accessoire en bon état"
              }
            },
            {
              "id": "eng.belts.mounts",
              "order": 1,
              "prompt": {
                "en": "No excess vibration (engine mounts)",
                "pt": "Sem vibração excessiva (apoios do motor)",
                "ru": "Нет лишней вибрации (опоры двигателя)",
                "uk": "Немає зайвої вібрації (опори двигуна)",
                "fr": "Pas de vibration excessive (supports moteur)"
              }
            }
          ]
        }
      ]
    },
    {
      "id": "road",
      "order": 3,
      "title": {
        "en": "Road test",
        "pt": "Teste de estrada",
        "ru": "Тест-драйв",
        "uk": "Тест-драйв",
        "fr": "Essai routier"
      },
      "children": [
        {
          "id": "road.drive",
          "order": 0,
          "title": {
            "en": "Engine & gearbox",
            "pt": "Motor e caixa",
            "ru": "Двигатель и коробка",
            "uk": "Двигун і коробка",
            "fr": "Moteur et boîte"
          },
          "items": [
            {
              "id": "road.drive.start",
              "order": 0,
              "prompt": {
                "en": "Clean cold start, no smoke",
                "pt": "Arranque a frio limpo, sem fumo",
                "ru": "Холодный пуск чистый, без дыма",
                "uk": "Холодний пуск чистий, без диму",
                "fr": "Démarrage à froid net, sans fumée"
              }
            },
            {
              "id": "road.drive.gears",
              "order": 1,
              "prompt": {
                "en": "Smooth gear changes / clutch",
                "pt": "Mudanças suaves / embraiagem",
                "ru": "Переключения плавные / сцепление",
                "uk": "Перемикання плавні / зчеплення",
                "fr": "Passages de vitesses souples / embrayage"
              }
            },
            {
              "id": "road.drive.noise",
              "order": 2,
              "prompt": {
                "en": "No unusual noises",
                "pt": "Sem ruídos anormais",
                "ru": "Нет посторонних шумов",
                "uk": "Немає сторонніх шумів",
                "fr": "Aucun bruit anormal"
              }
            }
          ]
        },
        {
          "id": "road.brakes",
          "order": 1,
          "title": {
            "en": "Brakes & steering",
            "pt": "Travões e direção",
            "ru": "Тормоза и руль",
            "uk": "Гальма та кермо",
            "fr": "Freins et direction"
          },
          "items": [
            {
              "id": "road.brakes.stop",
              "order": 0,
              "prompt": {
                "en": "Brakes straight, no pull/vibration",
                "pt": "Travagem a direito, sem puxar/vibrar",
                "ru": "Тормозит ровно, без увода/вибрации",
                "uk": "Гальмує рівно, без відведення/вібрації",
                "fr": "Freinage rectiligne, sans tirer ni vibrer"
              },
              "critical": true
            },
            {
              "id": "road.brakes.steer",
              "order": 1,
              "prompt": {
                "en": "Steering aligned, no play",
                "pt": "Direção alinhada, sem folga",
                "ru": "Руль без увода и люфта",
                "uk": "Кермо без відведення і люфту",
                "fr": "Direction alignée, sans jeu"
              },
              "critical": true
            }
          ]
        }
      ]
    },
    {
      "id": "docs",
      "order": 4,
      "title": {
        "en": "Documents & history",
        "pt": "Documentos e histórico",
        "ru": "Документы и история",
        "uk": "Документи та історія",
        "fr": "Documents et historique"
      },
      "children": [
        {
          "id": "docs.all",
          "order": 0,
          "title": {
            "en": "Records",
            "pt": "Registos",
            "ru": "Записи",
            "uk": "Записи",
            "fr": "Justificatifs"
          },
          "items": [
            {
              "id": "docs.all.service",
              "order": 0,
              "prompt": {
                "en": "Service history complete (stamps/invoices)",
                "pt": "Histórico de manutenção completo (carimbos/faturas)",
                "ru": "История обслуживания полная (отметки/чеки)",
                "uk": "Історія обслуговування повна (відмітки/чеки)",
                "fr": "Historique d’entretien complet (tampons/factures)"
              }
            },
            {
              "id": "docs.all.keys",
              "order": 1,
              "prompt": {
                "en": "Second/spare key present",
                "pt": "Segunda chave presente",
                "ru": "Второй (запасной) ключ в наличии",
                "uk": "Другий (запасний) ключ у наявності",
                "fr": "Deuxième clé présente"
              }
            },
            {
              "id": "docs.all.mileage",
              "order": 2,
              "prompt": {
                "en": "Mileage matches records",
                "pt": "Quilometragem coincide com registos",
                "ru": "Пробег совпадает с записями",
                "uk": "Пробіг збігається із записами",
                "fr": "Kilométrage cohérent avec les documents"
              },
              "critical": true
            },
            {
              "id": "docs.all.finance",
              "order": 3,
              "prompt": {
                "en": "No outstanding finance/liens",
                "pt": "Sem financiamento/ónus pendentes",
                "ru": "Нет залогов/кредитов",
                "uk": "Немає застав/кредитів",
                "fr": "Aucun financement ni gage en cours"
              },
              "critical": true
            }
          ]
        }
      ]
    }
  ],
  "modules": {
    "fuel": {
      "diesel": {
        "id": "fuel.diesel",
        "order": 5,
        "title": {
          "en": "Diesel system",
          "pt": "Sistema diesel",
          "ru": "Дизельная система",
          "uk": "Дизельна система",
          "fr": "Système diesel"
        },
        "children": [
          {
            "id": "fuel.diesel.g",
            "order": 0,
            "title": {
              "en": "Diesel-specific",
              "pt": "Específico diesel",
              "ru": "По дизелю",
              "uk": "По дизелю",
              "fr": "Spécifique diesel"
            },
            "items": [
              {
                "id": "fuel.diesel.dpf",
                "order": 0,
                "prompt": {
                  "en": "DPF healthy, no regen warnings",
                  "pt": "FAP saudável, sem avisos de regeneração",
                  "ru": "Сажевый фильтр в норме, без ошибок регенерации",
                  "uk": "Сажовий фільтр у нормі, без помилок регенерації",
                  "fr": "FAP en bon état, sans alerte de régénération"
                }
              },
              {
                "id": "fuel.diesel.turbo",
                "order": 1,
                "prompt": {
                  "en": "Turbo — no smoke, no whistle",
                  "pt": "Turbo — sem fumo, sem assobio",
                  "ru": "Турбина — без дыма и свиста",
                  "uk": "Турбіна — без диму і свисту",
                  "fr": "Turbo — sans fumée ni sifflement"
                }
              },
              {
                "id": "fuel.diesel.cold",
                "order": 2,
                "prompt": {
                  "en": "Glow plugs / cold start ok",
                  "pt": "Velas de incandescência / arranque a frio ok",
                  "ru": "Свечи накала / холодный пуск ок",
                  "uk": "Свічки розжарення / холодний пуск ок",
                  "fr": "Bougies de préchauffage / démarrage à froid ok"
                }
              }
            ]
          }
        ]
      },
      "petrol": {
        "id": "fuel.petrol",
        "order": 5,
        "title": {
          "en": "Petrol engine",
          "pt": "Motor a gasolina",
          "ru": "Бензиновый двигатель",
          "uk": "Бензиновий двигун",
          "fr": "Moteur essence"
        },
        "children": [
          {
            "id": "fuel.petrol.g",
            "order": 0,
            "title": {
              "en": "Petrol-specific",
              "pt": "Específico gasolina",
              "ru": "По бензину",
              "uk": "По бензину",
              "fr": "Spécifique essence"
            },
            "items": [
              {
                "id": "fuel.petrol.timing",
                "order": 0,
                "prompt": {
                  "en": "Timing belt/chain within interval",
                  "pt": "Correia/corrente de distribuição dentro do intervalo",
                  "ru": "Ремень/цепь ГРМ в интервале",
                  "uk": "Ремінь/ланцюг ГРМ в інтервалі",
                  "fr": "Courroie/chaîne de distribution dans l’intervalle"
                }
              },
              {
                "id": "fuel.petrol.misfire",
                "order": 1,
                "prompt": {
                  "en": "Smooth idle, no misfire",
                  "pt": "Ralenti suave, sem falhas",
                  "ru": "Ровный холостой, без пропусков",
                  "uk": "Рівний холостий, без пропусків",
                  "fr": "Ralenti régulier, sans raté"
                }
              }
            ]
          }
        ]
      },
      "hybrid": {
        "id": "fuel.hybrid",
        "order": 5,
        "title": {
          "en": "Hybrid system",
          "pt": "Sistema híbrido",
          "ru": "Гибридная система",
          "uk": "Гібридна система",
          "fr": "Système hybride"
        },
        "children": [
          {
            "id": "fuel.hybrid.g",
            "order": 0,
            "title": {
              "en": "Hybrid-specific",
              "pt": "Específico híbrido",
              "ru": "По гибриду",
              "uk": "По гібриду",
              "fr": "Spécifique hybride"
            },
            "items": [
              {
                "id": "fuel.hybrid.batt",
                "order": 0,
                "prompt": {
                  "en": "HV battery healthy, no warnings",
                  "pt": "Bateria HV saudável, sem avisos",
                  "ru": "ВВ-батарея в норме, без ошибок",
                  "uk": "ВВ-батарея в нормі, без помилок",
                  "fr": "Batterie HT en bon état, sans alerte"
                },
                "critical": true
              },
              {
                "id": "fuel.hybrid.regen",
                "order": 1,
                "prompt": {
                  "en": "Regenerative braking works",
                  "pt": "Travagem regenerativa funciona",
                  "ru": "Рекуперация работает",
                  "uk": "Рекуперація працює",
                  "fr": "Freinage régénératif fonctionnel"
                }
              }
            ]
          }
        ]
      },
      "ev": {
        "id": "fuel.ev",
        "order": 5,
        "title": {
          "en": "EV system",
          "pt": "Sistema elétrico",
          "ru": "Электросистема",
          "uk": "Електросистема",
          "fr": "Système électrique"
        },
        "children": [
          {
            "id": "fuel.ev.g",
            "order": 0,
            "title": {
              "en": "EV-specific",
              "pt": "Específico elétrico",
              "ru": "По электро",
              "uk": "По електро",
              "fr": "Spécifique électrique"
            },
            "items": [
              {
                "id": "fuel.ev.soh",
                "order": 0,
                "prompt": {
                  "en": "HV battery state-of-health acceptable",
                  "pt": "Estado de saúde da bateria HV aceitável",
                  "ru": "SOH батареи приемлемый",
                  "uk": "SOH батареї прийнятний",
                  "fr": "État de santé de la batterie HT acceptable"
                },
                "critical": true
              },
              {
                "id": "fuel.ev.charge",
                "order": 1,
                "prompt": {
                  "en": "Charges on AC and DC",
                  "pt": "Carrega em AC e DC",
                  "ru": "Заряжается на AC и DC",
                  "uk": "Заряджається на AC і DC",
                  "fr": "Charge en AC et en DC"
                }
              },
              {
                "id": "fuel.ev.range",
                "order": 2,
                "prompt": {
                  "en": "Real range close to rated",
                  "pt": "Autonomia real próxima da nominal",
                  "ru": "Реальный запас хода близок к заявленному",
                  "uk": "Реальний запас ходу близький до заявленого",
                  "fr": "Autonomie réelle proche de l’annoncée"
                }
              }
            ]
          }
        ]
      }
    }
  }
}
''';

const String defectsCanonJson = r'''
{
  "version": 1,
  "languages": [
    "en",
    "pt"
  ],
  "rules": [
    {
      "id": "vag-known-issues",
      "label": {
        "en": "VAG known issues",
        "pt": "Problemas conhecidos VAG"
      },
      "match": [
        {
          "makeAny": [
            "volkswagen",
            "vw",
            "audi",
            "seat",
            "skoda",
            "škoda"
          ],
          "modelAny": [
            "golf",
            "passat",
            "polo",
            "leon",
            "ibiza",
            "octavia",
            "fabia",
            "a3",
            "a1"
          ]
        }
      ],
      "defects": [
        {
          "id": "dsg.dq200",
          "text": {
            "en": "DSG (DQ200 dry-clutch) — jerky/shuddering shifts, mechatronic faults",
            "pt": "DSG (DQ200 embraiagem seca) — trancos, falhas do mecatrónico"
          }
        },
        {
          "id": "tsi.chain",
          "text": {
            "en": "1.2/1.4 TSI timing chain tensioner — rattle on cold start",
            "pt": "Corrente de distribuição 1.2/1.4 TSI — ruído no arranque a frio"
          }
        },
        {
          "id": "tdi.egr",
          "text": {
            "en": "TDI EGR/DPF — clogging, warning lights, short-trip use",
            "pt": "EGR/FAP TDI — entupimento, luzes, uso urbano"
          }
        },
        {
          "id": "tsi.oil",
          "text": {
            "en": "1.8/2.0 TSI oil consumption (piston rings)",
            "pt": "Consumo de óleo 1.8/2.0 TSI (segmentos)"
          }
        },
        {
          "id": "waterpump",
          "text": {
            "en": "Plastic water pump / thermostat leaks",
            "pt": "Bomba de água / termóstato de plástico com fugas"
          }
        }
      ]
    },
    {
      "id": "bmw-known-issues",
      "label": {
        "en": "BMW known issues",
        "pt": "Problemas conhecidos BMW"
      },
      "match": [
        {
          "makeAny": [
            "bmw"
          ]
        }
      ],
      "defects": [
        {
          "id": "n47.chain",
          "text": {
            "en": "N47 diesel timing chain (rear of engine) — stretch/rattle, costly",
            "pt": "Corrente N47 diesel (traseira do motor) — desgaste, dispendiosa"
          },
          "critical": true
        },
        {
          "id": "oil.leaks",
          "text": {
            "en": "Valve cover + oil filter housing gasket leaks",
            "pt": "Fugas da tampa de válvulas e do suporte do filtro de óleo"
          }
        },
        {
          "id": "vanos",
          "text": {
            "en": "VANOS rattle / rough idle",
            "pt": "VANOS com ruído / ralenti irregular"
          }
        },
        {
          "id": "rust.arches",
          "text": {
            "en": "E90: rust on rear wheel arches",
            "pt": "E90: ferrugem nos guarda-lamas traseiros"
          }
        }
      ]
    },
    {
      "id": "psa-known-issues",
      "label": {
        "en": "PSA known issues",
        "pt": "Problemas conhecidos PSA"
      },
      "match": [
        {
          "makeAny": [
            "peugeot",
            "citro",
            "ds "
          ]
        }
      ],
      "defects": [
        {
          "id": "puretech.wetbelt",
          "text": {
            "en": "PureTech 1.2 wet timing belt — degrades into the oil pump (check belt/oil)",
            "pt": "Correia em banho de óleo 1.2 PureTech — degrada-se (verificar correia/óleo)"
          },
          "critical": true
        },
        {
          "id": "ep6.chain",
          "text": {
            "en": "1.6 THP (EP6) timing chain + carbon build-up on valves",
            "pt": "Corrente 1.6 THP (EP6) + acumulação de carbono nas válvulas"
          }
        },
        {
          "id": "hdi.turbo",
          "text": {
            "en": "1.6 HDi turbo oil-feed / EGR / DPF issues",
            "pt": "Turbo 1.6 HDi (alimentação de óleo) / EGR / FAP"
          }
        }
      ]
    },
    {
      "id": "ford-known-issues",
      "label": {
        "en": "Ford known issues",
        "pt": "Problemas conhecidos Ford"
      },
      "match": [
        {
          "makeAny": [
            "ford"
          ],
          "modelAny": [
            "focus",
            "fiesta",
            "ecosport",
            "puma"
          ]
        }
      ],
      "defects": [
        {
          "id": "ecoboost.coolant",
          "text": {
            "en": "1.0 EcoBoost coolant/overheating (degas hose, head) — check history",
            "pt": "1.0 EcoBoost sobreaquecimento/líquido — verificar histórico"
          },
          "critical": true
        },
        {
          "id": "ecoboost.wetbelt",
          "text": {
            "en": "1.0 EcoBoost wet timing belt service due",
            "pt": "Correia em óleo 1.0 EcoBoost — revisão em dia"
          }
        },
        {
          "id": "powershift",
          "text": {
            "en": "Powershift (DPS6) dual-clutch — shudder/jerk on petrol autos",
            "pt": "Powershift (DPS6) — trancos nas automáticas a gasolina"
          }
        }
      ]
    },
    {
      "id": "renault-nissan-1-5-dci-known-issues",
      "label": {
        "en": "Renault/Nissan 1.5 dCi known issues",
        "pt": "Problemas conhecidos Renault/Nissan"
      },
      "match": [
        {
          "makeAny": [
            "renault",
            "dacia"
          ]
        },
        {
          "makeAny": [
            "nissan"
          ],
          "modelAny": [
            "qashqai",
            "juke",
            "micra"
          ]
        }
      ],
      "defects": [
        {
          "id": "dci.injectors",
          "text": {
            "en": "1.5 dCi injectors + DPF/EGR — clogging, injector wear",
            "pt": "Injetores 1.5 dCi + FAP/EGR — entupimento, desgaste"
          }
        },
        {
          "id": "cvt.xtronic",
          "text": {
            "en": "Nissan Xtronic CVT — overheating/jerky (check fluid + behaviour)",
            "pt": "CVT Xtronic Nissan — sobreaquece/trancos (verificar óleo)"
          }
        },
        {
          "id": "electrics",
          "text": {
            "en": "Electrical gremlins (windows, sensors, injector wiring)",
            "pt": "Problemas elétricos (vidros, sensores, cablagem dos injetores)"
          }
        }
      ]
    },
    {
      "id": "opel-known-issues",
      "label": {
        "en": "Opel known issues",
        "pt": "Problemas conhecidos Opel"
      },
      "match": [
        {
          "makeAny": [
            "opel",
            "vauxhall"
          ],
          "modelAny": [
            "astra",
            "corsa",
            "insignia"
          ]
        }
      ],
      "defects": [
        {
          "id": "opel.chain",
          "text": {
            "en": "1.4 Turbo timing chain wear",
            "pt": "Desgaste da corrente 1.4 Turbo"
          }
        },
        {
          "id": "opel.waterpump",
          "text": {
            "en": "Water pump / thermostat failures",
            "pt": "Falhas da bomba de água / termóstato"
          }
        }
      ]
    },
    {
      "id": "mercedes-known-issues",
      "label": {
        "en": "Mercedes known issues",
        "pt": "Problemas conhecidos Mercedes"
      },
      "match": [
        {
          "makeAny": [
            "mercedes"
          ]
        }
      ],
      "defects": [
        {
          "id": "om651.injectors",
          "text": {
            "en": "OM651 diesel injector wear / leaks",
            "pt": "Desgaste/fugas dos injetores OM651 diesel"
          }
        },
        {
          "id": "m271.balanceshaft",
          "text": {
            "en": "M271 petrol (pre-2011) balance-shaft/timing gear wear",
            "pt": "M271 gasolina (pré-2011) — desgaste da árvore de balanceamento"
          }
        },
        {
          "id": "rust",
          "text": {
            "en": "Older models: rust (arches, jacking points)",
            "pt": "Modelos antigos: ferrugem (guarda-lamas, apoios de macaco)"
          }
        }
      ]
    },
    {
      "id": "fiat-known-issues",
      "label": {
        "en": "Fiat known issues",
        "pt": "Problemas conhecidos Fiat"
      },
      "match": [
        {
          "makeAny": [
            "fiat"
          ],
          "modelAny": [
            "500",
            "panda",
            "punto"
          ]
        }
      ],
      "defects": [
        {
          "id": "multijet.dpf",
          "text": {
            "en": "1.3 MultiJet diesel DPF (city use)",
            "pt": "FAP 1.3 MultiJet diesel (uso urbano)"
          }
        },
        {
          "id": "twinair.oil",
          "text": {
            "en": "0.9 TwinAir oil consumption",
            "pt": "Consumo de óleo 0.9 TwinAir"
          }
        }
      ]
    }
  ]
}
''';

