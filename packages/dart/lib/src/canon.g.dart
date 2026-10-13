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
  "version": 2,
  "languages": [
    "en",
    "pt",
    "ru",
    "uk",
    "fr"
  ],
  "rules": [
    {
      "id": "vag-known-issues",
      "label": {
        "en": "VAG known issues",
        "pt": "Problemas conhecidos VAG",
        "ru": "Известные проблемы VAG",
        "uk": "Відомі проблеми VAG",
        "fr": "Problèmes connus VAG"
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
            "pt": "DSG (DQ200 embraiagem seca) — trancos, falhas do mecatrónico",
            "ru": "DSG (DQ200, сухое сцепление) — рывки и вибрации при переключении, отказы мехатроника",
            "uk": "DSG (DQ200, сухе зчеплення) — ривки та вібрації при перемиканні, відмови мехатроніка",
            "fr": "DSG (DQ200 à embrayage à sec) — à-coups et broutements aux passages, pannes du mécatronique"
          }
        },
        {
          "id": "tsi.chain",
          "text": {
            "en": "1.2/1.4 TSI timing chain tensioner — rattle on cold start",
            "pt": "Corrente de distribuição 1.2/1.4 TSI — ruído no arranque a frio",
            "ru": "Натяжитель цепи ГРМ 1.2/1.4 TSI — стук на холодном пуске",
            "uk": "Натягувач ланцюга ГРМ 1.2/1.4 TSI — стукіт на холодному пуску",
            "fr": "Tendeur de chaîne de distribution 1.2/1.4 TSI — cliquetis au démarrage à froid"
          }
        },
        {
          "id": "tdi.egr",
          "text": {
            "en": "TDI EGR/DPF — clogging, warning lights, short-trip use",
            "pt": "EGR/FAP TDI — entupimento, luzes, uso urbano",
            "ru": "EGR и сажевый фильтр TDI — закоксовка, ошибки на панели, частые короткие поездки",
            "uk": "EGR і сажовий фільтр TDI — закоксування, помилки на панелі, часті короткі поїздки",
            "fr": "EGR/FAP TDI — encrassement, voyants, usage sur trajets courts"
          }
        },
        {
          "id": "tsi.oil",
          "text": {
            "en": "1.8/2.0 TSI oil consumption (piston rings)",
            "pt": "Consumo de óleo 1.8/2.0 TSI (segmentos)",
            "ru": "Расход масла на 1.8/2.0 TSI (поршневые кольца)",
            "uk": "Витрата оливи на 1.8/2.0 TSI (поршневі кільця)",
            "fr": "Consommation d'huile 1.8/2.0 TSI (segments)"
          }
        },
        {
          "id": "waterpump",
          "text": {
            "en": "Plastic water pump / thermostat leaks",
            "pt": "Bomba de água / termóstato de plástico com fugas",
            "ru": "Пластиковая помпа и термостат — течи",
            "uk": "Пластикова помпа і термостат — течі",
            "fr": "Pompe à eau / thermostat en plastique — fuites"
          }
        }
      ]
    },
    {
      "id": "bmw-known-issues",
      "label": {
        "en": "BMW known issues",
        "pt": "Problemas conhecidos BMW",
        "ru": "Известные проблемы BMW",
        "uk": "Відомі проблеми BMW",
        "fr": "Problèmes connus BMW"
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
            "pt": "Corrente N47 diesel (traseira do motor) — desgaste, dispendiosa",
            "ru": "Цепь ГРМ дизеля N47 (со стороны маховика) — вытягивается и гремит, ремонт дорогой",
            "uk": "Ланцюг ГРМ дизеля N47 (з боку маховика) — витягується і гримить, ремонт дорогий",
            "fr": "Chaîne de distribution du diesel N47 (côté volant moteur) — détente et cliquetis, réparation coûteuse"
          },
          "critical": true
        },
        {
          "id": "oil.leaks",
          "text": {
            "en": "Valve cover + oil filter housing gasket leaks",
            "pt": "Fugas da tampa de válvulas e do suporte do filtro de óleo",
            "ru": "Течи прокладок клапанной крышки и корпуса масляного фильтра",
            "uk": "Течі прокладок кришки клапанів і корпусу масляного фільтра",
            "fr": "Fuites des joints de couvre-culasse et de support de filtre à huile"
          }
        },
        {
          "id": "vanos",
          "text": {
            "en": "VANOS rattle / rough idle",
            "pt": "VANOS com ruído / ralenti irregular",
            "ru": "Стук VANOS, неровный холостой ход",
            "uk": "Стукіт VANOS, нерівний холостий хід",
            "fr": "Cliquetis VANOS, ralenti irrégulier"
          }
        },
        {
          "id": "rust.arches",
          "text": {
            "en": "E90: rust on rear wheel arches",
            "pt": "E90: ferrugem nos guarda-lamas traseiros",
            "ru": "E90: ржавчина на задних арках",
            "uk": "E90: іржа на задніх арках",
            "fr": "E90 : rouille sur les passages de roue arrière"
          }
        }
      ]
    },
    {
      "id": "psa-known-issues",
      "label": {
        "en": "PSA known issues",
        "pt": "Problemas conhecidos PSA",
        "ru": "Известные проблемы PSA",
        "uk": "Відомі проблеми PSA",
        "fr": "Problèmes connus PSA"
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
            "pt": "Correia em banho de óleo 1.2 PureTech — degrada-se (verificar correia/óleo)",
            "ru": "«Мокрый» ремень ГРМ PureTech 1.2 — крошится и забивает масляный насос (проверить ремень и масло)",
            "uk": "«Мокрий» ремінь ГРМ PureTech 1.2 — кришиться і забиває масляний насос (перевірити ремінь і оливу)",
            "fr": "Courroie de distribution humide PureTech 1.2 — se délite et obstrue la pompe à huile (vérifier courroie et huile)"
          },
          "critical": true
        },
        {
          "id": "ep6.chain",
          "text": {
            "en": "1.6 THP (EP6) timing chain + carbon build-up on valves",
            "pt": "Corrente 1.6 THP (EP6) + acumulação de carbono nas válvulas",
            "ru": "Цепь ГРМ 1.6 THP (EP6) и нагар на клапанах",
            "uk": "Ланцюг ГРМ 1.6 THP (EP6) і нагар на клапанах",
            "fr": "Chaîne de distribution 1.6 THP (EP6) et calamine sur les soupapes"
          }
        },
        {
          "id": "hdi.turbo",
          "text": {
            "en": "1.6 HDi turbo oil-feed / EGR / DPF issues",
            "pt": "Turbo 1.6 HDi (alimentação de óleo) / EGR / FAP",
            "ru": "1.6 HDi — маслоподача турбины, EGR, сажевый фильтр",
            "uk": "1.6 HDi — оливоподача турбіни, EGR, сажовий фільтр",
            "fr": "1.6 HDi — alimentation en huile du turbo, EGR, FAP"
          }
        }
      ]
    },
    {
      "id": "ford-known-issues",
      "label": {
        "en": "Ford known issues",
        "pt": "Problemas conhecidos Ford",
        "ru": "Известные проблемы Ford",
        "uk": "Відомі проблеми Ford",
        "fr": "Problèmes connus Ford"
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
            "pt": "1.0 EcoBoost sobreaquecimento/líquido — verificar histórico",
            "ru": "1.0 EcoBoost — перегрев и потеря охлаждающей жидкости (патрубок дегазации, головка) — проверить историю",
            "uk": "1.0 EcoBoost — перегрів і втрата охолоджувальної рідини (патрубок дегазації, головка) — перевірити історію",
            "fr": "1.0 EcoBoost — surchauffe et perte de liquide de refroidissement (durite de dégazage, culasse) — vérifier l'historique"
          },
          "critical": true
        },
        {
          "id": "ecoboost.wetbelt",
          "text": {
            "en": "1.0 EcoBoost wet timing belt service due",
            "pt": "Correia em óleo 1.0 EcoBoost — revisão em dia",
            "ru": "«Мокрый» ремень ГРМ 1.0 EcoBoost — замена по регламенту",
            "uk": "«Мокрий» ремінь ГРМ 1.0 EcoBoost — заміна за регламентом",
            "fr": "Courroie de distribution humide 1.0 EcoBoost — remplacement à jour"
          }
        },
        {
          "id": "powershift",
          "text": {
            "en": "Powershift (DPS6) dual-clutch — shudder/jerk on petrol autos",
            "pt": "Powershift (DPS6) — trancos nas automáticas a gasolina",
            "ru": "Робот Powershift (DPS6) — вибрации и рывки на бензиновых автоматах",
            "uk": "Робот Powershift (DPS6) — вібрації та ривки на бензинових автоматах",
            "fr": "Boîte Powershift (DPS6) à double embrayage — broutements et à-coups sur les automatiques essence"
          }
        }
      ]
    },
    {
      "id": "renault-nissan-1-5-dci-known-issues",
      "label": {
        "en": "Renault/Nissan 1.5 dCi known issues",
        "pt": "Problemas conhecidos Renault/Nissan",
        "ru": "Известные проблемы Renault/Nissan (1.5 dCi)",
        "uk": "Відомі проблеми Renault/Nissan (1.5 dCi)",
        "fr": "Problèmes connus Renault/Nissan (1.5 dCi)"
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
            "pt": "Injetores 1.5 dCi + FAP/EGR — entupimento, desgaste",
            "ru": "Форсунки 1.5 dCi, сажевый фильтр и EGR — закоксовка, износ форсунок",
            "uk": "Форсунки 1.5 dCi, сажовий фільтр і EGR — закоксування, знос форсунок",
            "fr": "Injecteurs 1.5 dCi, FAP et EGR — encrassement, usure des injecteurs"
          }
        },
        {
          "id": "cvt.xtronic",
          "text": {
            "en": "Nissan Xtronic CVT — overheating/jerky (check fluid + behaviour)",
            "pt": "CVT Xtronic Nissan — sobreaquece/trancos (verificar óleo)",
            "ru": "Вариатор Nissan Xtronic — перегрев и рывки (проверить масло и поведение)",
            "uk": "Варіатор Nissan Xtronic — перегрів і ривки (перевірити оливу та поведінку)",
            "fr": "CVT Xtronic Nissan — surchauffe et à-coups (vérifier l'huile et le comportement)"
          }
        },
        {
          "id": "electrics",
          "text": {
            "en": "Electrical gremlins (windows, sensors, injector wiring)",
            "pt": "Problemas elétricos (vidros, sensores, cablagem dos injetores)",
            "ru": "Электрика: стеклоподъёмники, датчики, проводка форсунок",
            "uk": "Електрика: склопідйомники, датчики, проводка форсунок",
            "fr": "Aléas électriques : lève-vitres, capteurs, faisceau des injecteurs"
          }
        }
      ]
    },
    {
      "id": "opel-known-issues",
      "label": {
        "en": "Opel known issues",
        "pt": "Problemas conhecidos Opel",
        "ru": "Известные проблемы Opel",
        "uk": "Відомі проблеми Opel",
        "fr": "Problèmes connus Opel"
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
            "pt": "Desgaste da corrente 1.4 Turbo",
            "ru": "Износ цепи ГРМ 1.4 Turbo",
            "uk": "Знос ланцюга ГРМ 1.4 Turbo",
            "fr": "Usure de la chaîne de distribution 1.4 Turbo"
          }
        },
        {
          "id": "opel.waterpump",
          "text": {
            "en": "Water pump / thermostat failures",
            "pt": "Falhas da bomba de água / termóstato",
            "ru": "Отказы помпы и термостата",
            "uk": "Відмови помпи і термостата",
            "fr": "Défaillances de la pompe à eau et du thermostat"
          }
        }
      ]
    },
    {
      "id": "mercedes-known-issues",
      "label": {
        "en": "Mercedes known issues",
        "pt": "Problemas conhecidos Mercedes",
        "ru": "Известные проблемы Mercedes",
        "uk": "Відомі проблеми Mercedes",
        "fr": "Problèmes connus Mercedes"
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
            "pt": "Desgaste/fugas dos injetores OM651 diesel",
            "ru": "Износ и течи форсунок дизеля OM651",
            "uk": "Знос і течі форсунок дизеля OM651",
            "fr": "Usure et fuites des injecteurs du diesel OM651"
          }
        },
        {
          "id": "m271.balanceshaft",
          "text": {
            "en": "M271 petrol (pre-2011) balance-shaft/timing gear wear",
            "pt": "M271 gasolina (pré-2011) — desgaste da árvore de balanceamento",
            "ru": "M271 бензин (до 2011): износ балансирного вала и шестерён ГРМ",
            "uk": "M271 бензин (до 2011): знос балансирного вала і шестерень ГРМ",
            "fr": "M271 essence (avant 2011) : usure de l'arbre d'équilibrage et des pignons de distribution"
          }
        },
        {
          "id": "rust",
          "text": {
            "en": "Older models: rust (arches, jacking points)",
            "pt": "Modelos antigos: ferrugem (guarda-lamas, apoios de macaco)",
            "ru": "Старые модели: ржавчина (арки, точки домкрата)",
            "uk": "Старі моделі: іржа (арки, точки домкрата)",
            "fr": "Modèles anciens : rouille (passages de roue, points de levage)"
          }
        }
      ]
    },
    {
      "id": "fiat-known-issues",
      "label": {
        "en": "Fiat known issues",
        "pt": "Problemas conhecidos Fiat",
        "ru": "Известные проблемы Fiat",
        "uk": "Відомі проблеми Fiat",
        "fr": "Problèmes connus Fiat"
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
            "pt": "FAP 1.3 MultiJet diesel (uso urbano)",
            "ru": "Сажевый фильтр дизеля 1.3 MultiJet (городская езда)",
            "uk": "Сажовий фільтр дизеля 1.3 MultiJet (міська їзда)",
            "fr": "FAP du diesel 1.3 MultiJet (usage urbain)"
          }
        },
        {
          "id": "twinair.oil",
          "text": {
            "en": "0.9 TwinAir oil consumption",
            "pt": "Consumo de óleo 0.9 TwinAir",
            "ru": "Расход масла на 0.9 TwinAir",
            "uk": "Витрата оливи на 0.9 TwinAir",
            "fr": "Consommation d'huile 0.9 TwinAir"
          }
        }
      ]
    }
  ]
}
''';

const String vehiclesV3CanonJson = r'''
{
  "format": 3,
  "makes": [
    {
      "id": "volkswagen",
      "label": "Volkswagen",
      "names": [
        "volkswagen",
        "vw"
      ],
      "group": "vag",
      "wmi": [
        "WVW",
        "WV1",
        "WV2"
      ]
    },
    {
      "id": "audi",
      "label": "Audi",
      "names": [
        "audi"
      ],
      "group": "vag",
      "wmi": [
        "WAU"
      ]
    },
    {
      "id": "seat",
      "label": "SEAT",
      "names": [
        "seat",
        "cupra"
      ],
      "group": "vag",
      "wmi": [
        "VSS"
      ]
    },
    {
      "id": "skoda",
      "label": "Škoda",
      "names": [
        "skoda"
      ],
      "group": "vag",
      "wmi": [
        "TMB"
      ]
    },
    {
      "id": "bmw",
      "label": "BMW",
      "names": [
        "bmw"
      ],
      "group": "bmw",
      "wmi": [
        "WBA"
      ]
    },
    {
      "id": "peugeot",
      "label": "Peugeot",
      "names": [
        "peugeot"
      ],
      "group": "stellantis",
      "wmi": [
        "VF3"
      ]
    },
    {
      "id": "citroen",
      "label": "Citroën",
      "names": [
        "citroen"
      ],
      "group": "stellantis",
      "wmi": [
        "VF7"
      ]
    },
    {
      "id": "ds",
      "label": "DS",
      "names": [
        "ds automobiles",
        "ds"
      ],
      "group": "stellantis",
      "wmi": []
    },
    {
      "id": "mercedes",
      "label": "Mercedes-Benz",
      "names": [
        "mercedes",
        "mercedes-benz",
        "mercedes benz"
      ],
      "group": "mercedes",
      "wmi": [
        "WDB",
        "WDC",
        "WDD",
        "W1K"
      ]
    },
    {
      "id": "ford",
      "label": "Ford",
      "names": [
        "ford"
      ],
      "group": "ford",
      "wmi": [
        "WF0",
        "1FA",
        "3FA"
      ]
    },
    {
      "id": "nissan",
      "label": "Nissan",
      "names": [
        "nissan"
      ],
      "group": "renault-nissan",
      "wmi": []
    }
  ],
  "models": [
    {
      "id": "volkswagen.golf",
      "make": "volkswagen",
      "label": "Volkswagen Golf",
      "names": [
        "golf"
      ]
    },
    {
      "id": "volkswagen.polo",
      "make": "volkswagen",
      "label": "Volkswagen Polo",
      "names": [
        "polo"
      ]
    },
    {
      "id": "volkswagen.passat",
      "make": "volkswagen",
      "label": "Volkswagen Passat",
      "names": [
        "passat"
      ]
    },
    {
      "id": "volkswagen.caddy",
      "make": "volkswagen",
      "label": "Volkswagen Caddy",
      "names": [
        "caddy"
      ]
    },
    {
      "id": "volkswagen.jetta",
      "make": "volkswagen",
      "label": "Volkswagen Jetta",
      "names": [
        "jetta"
      ]
    },
    {
      "id": "volkswagen.scirocco",
      "make": "volkswagen",
      "label": "Volkswagen Scirocco",
      "names": [
        "scirocco"
      ]
    },
    {
      "id": "volkswagen.touran",
      "make": "volkswagen",
      "label": "Volkswagen Touran",
      "names": [
        "touran"
      ]
    },
    {
      "id": "audi.a1",
      "make": "audi",
      "label": "Audi A1",
      "names": [
        "a1"
      ]
    },
    {
      "id": "audi.a3",
      "make": "audi",
      "label": "Audi A3",
      "names": [
        "a3"
      ]
    },
    {
      "id": "seat.ibiza",
      "make": "seat",
      "label": "SEAT Ibiza",
      "names": [
        "ibiza"
      ]
    },
    {
      "id": "seat.leon",
      "make": "seat",
      "label": "SEAT Leon",
      "names": [
        "leon"
      ]
    },
    {
      "id": "skoda.fabia",
      "make": "skoda",
      "label": "Škoda Fabia",
      "names": [
        "fabia"
      ]
    },
    {
      "id": "skoda.octavia",
      "make": "skoda",
      "label": "Škoda Octavia",
      "names": [
        "octavia"
      ]
    },
    {
      "id": "bmw.1series",
      "make": "bmw",
      "label": "BMW 1 Series",
      "names": [
        "1 series",
        "1er",
        "serie 1",
        "116d",
        "118d",
        "120d",
        "123d",
        "125d",
        "114i",
        "116i",
        "118i",
        "120i",
        "125i",
        "128i",
        "130i",
        "135i"
      ]
    },
    {
      "id": "bmw.2series",
      "make": "bmw",
      "label": "BMW 2 Series",
      "names": [
        "2 series",
        "2er",
        "serie 2",
        "216d",
        "218d",
        "220d",
        "225d",
        "218i",
        "220i",
        "228i",
        "230i"
      ]
    },
    {
      "id": "bmw.3series",
      "make": "bmw",
      "label": "BMW 3 Series",
      "names": [
        "3 series",
        "3er",
        "serie 3",
        "316d",
        "318d",
        "320d",
        "325d",
        "330d",
        "335d",
        "316i",
        "318i",
        "320i",
        "325i",
        "328i",
        "330i",
        "335i",
        "340i"
      ]
    },
    {
      "id": "bmw.5series",
      "make": "bmw",
      "label": "BMW 5 Series",
      "names": [
        "5 series",
        "5er",
        "serie 5",
        "518d",
        "520d",
        "525d",
        "530d",
        "535d",
        "520i",
        "523i",
        "525i",
        "528i",
        "530i",
        "535i",
        "540i",
        "550i"
      ]
    },
    {
      "id": "bmw.x1",
      "make": "bmw",
      "label": "BMW X1",
      "names": [
        "x1"
      ]
    },
    {
      "id": "bmw.x3",
      "make": "bmw",
      "label": "BMW X3",
      "names": [
        "x3"
      ]
    },
    {
      "id": "peugeot.208",
      "make": "peugeot",
      "label": "Peugeot 208",
      "names": [
        "208"
      ]
    },
    {
      "id": "peugeot.2008",
      "make": "peugeot",
      "label": "Peugeot 2008",
      "names": [
        "2008"
      ]
    },
    {
      "id": "peugeot.308",
      "make": "peugeot",
      "label": "Peugeot 308",
      "names": [
        "308"
      ]
    },
    {
      "id": "peugeot.3008",
      "make": "peugeot",
      "label": "Peugeot 3008",
      "names": [
        "3008"
      ]
    },
    {
      "id": "peugeot.5008",
      "make": "peugeot",
      "label": "Peugeot 5008",
      "names": [
        "5008"
      ]
    },
    {
      "id": "peugeot.partner",
      "make": "peugeot",
      "label": "Peugeot Partner",
      "names": [
        "partner"
      ]
    },
    {
      "id": "citroen.c3",
      "make": "citroen",
      "label": "Citroën C3",
      "names": [
        "c3"
      ],
      "excludeNames": [
        "c3 picasso",
        "c3 aircross"
      ]
    },
    {
      "id": "citroen.c3_picasso",
      "make": "citroen",
      "label": "Citroën C3 Picasso",
      "names": [
        "c3 picasso"
      ]
    },
    {
      "id": "citroen.c4",
      "make": "citroen",
      "label": "Citroën C4",
      "names": [
        "c4"
      ],
      "excludeNames": [
        "c4 cactus",
        "c4 picasso",
        "c4 grand picasso",
        "c4 spacetourer",
        "c4 grand spacetourer"
      ]
    },
    {
      "id": "citroen.c4_cactus",
      "make": "citroen",
      "label": "Citroën C4 Cactus",
      "names": [
        "c4 cactus"
      ]
    },
    {
      "id": "citroen.c4_picasso",
      "make": "citroen",
      "label": "Citroën C4 Picasso",
      "names": [
        "c4 picasso",
        "c4 grand picasso",
        "grand c4 picasso",
        "c4 spacetourer",
        "c4 grand spacetourer"
      ]
    },
    {
      "id": "citroen.berlingo",
      "make": "citroen",
      "label": "Citroën Berlingo",
      "names": [
        "berlingo"
      ]
    },
    {
      "id": "citroen.ds3",
      "make": "citroen",
      "label": "Citroën DS3",
      "names": [
        "ds3",
        "ds 3"
      ]
    },
    {
      "id": "citroen.ds4",
      "make": "citroen",
      "label": "Citroën DS4",
      "names": [
        "ds4",
        "ds 4"
      ]
    },
    {
      "id": "ds.ds3",
      "make": "ds",
      "label": "DS 3",
      "names": [
        "ds3",
        "ds 3",
        "3"
      ],
      "excludeNames": [
        "ds 3 crossback",
        "ds3 crossback",
        "3 crossback"
      ]
    },
    {
      "id": "ds.ds4",
      "make": "ds",
      "label": "DS 4",
      "names": [
        "ds4",
        "ds 4",
        "4"
      ]
    },
    {
      "id": "volkswagen.beetle",
      "make": "volkswagen",
      "label": "Volkswagen Beetle",
      "names": [
        "beetle"
      ]
    },
    {
      "id": "volkswagen.tiguan",
      "make": "volkswagen",
      "label": "Volkswagen Tiguan",
      "names": [
        "tiguan"
      ]
    },
    {
      "id": "seat.altea",
      "make": "seat",
      "label": "SEAT Altea",
      "names": [
        "altea",
        "altea xl"
      ]
    },
    {
      "id": "seat.toledo",
      "make": "seat",
      "label": "SEAT Toledo",
      "names": [
        "toledo"
      ]
    },
    {
      "id": "skoda.yeti",
      "make": "skoda",
      "label": "Škoda Yeti",
      "names": [
        "yeti"
      ]
    },
    {
      "id": "skoda.rapid",
      "make": "skoda",
      "label": "Škoda Rapid",
      "names": [
        "rapid"
      ]
    },
    {
      "id": "audi.a4",
      "make": "audi",
      "label": "Audi A4",
      "names": [
        "a4",
        "a4 avant",
        "a4 allroad",
        "allroad"
      ]
    },
    {
      "id": "audi.a5",
      "make": "audi",
      "label": "Audi A5",
      "names": [
        "a5",
        "a5 sportback",
        "a5 cabriolet"
      ]
    },
    {
      "id": "audi.a6",
      "make": "audi",
      "label": "Audi A6",
      "names": [
        "a6",
        "a6 avant"
      ]
    },
    {
      "id": "audi.a8",
      "make": "audi",
      "label": "Audi A8",
      "names": [
        "a8"
      ]
    },
    {
      "id": "audi.q3",
      "make": "audi",
      "label": "Audi Q3",
      "names": [
        "q3"
      ]
    },
    {
      "id": "audi.q5",
      "make": "audi",
      "label": "Audi Q5",
      "names": [
        "q5"
      ]
    },
    {
      "id": "audi.tt",
      "make": "audi",
      "label": "Audi TT",
      "names": [
        "tt",
        "tt roadster"
      ]
    },
    {
      "id": "volkswagen.eos",
      "make": "volkswagen",
      "label": "Volkswagen Eos",
      "names": [
        "eos"
      ]
    },
    {
      "id": "volkswagen.sharan",
      "make": "volkswagen",
      "label": "Volkswagen Sharan",
      "names": [
        "sharan"
      ]
    },
    {
      "id": "seat.alhambra",
      "make": "seat",
      "label": "SEAT Alhambra",
      "names": [
        "alhambra"
      ]
    },
    {
      "id": "seat.exeo",
      "make": "seat",
      "label": "SEAT Exeo",
      "names": [
        "exeo",
        "exeo st"
      ]
    },
    {
      "id": "skoda.roomster",
      "make": "skoda",
      "label": "Škoda Roomster",
      "names": [
        "roomster"
      ]
    },
    {
      "id": "skoda.superb",
      "make": "skoda",
      "label": "Škoda Superb",
      "names": [
        "superb"
      ]
    },
    {
      "id": "audi.q7",
      "make": "audi",
      "label": "Audi Q7",
      "names": [
        "q7"
      ]
    },
    {
      "id": "bmw.6series",
      "make": "bmw",
      "label": "BMW 6 Series",
      "names": [
        "6 series",
        "6er",
        "serie 6",
        "640i"
      ]
    },
    {
      "id": "bmw.7series",
      "make": "bmw",
      "label": "BMW 7 Series",
      "names": [
        "7 series",
        "7er",
        "serie 7"
      ]
    },
    {
      "id": "bmw.x5",
      "make": "bmw",
      "label": "BMW X5",
      "names": [
        "x5"
      ]
    },
    {
      "id": "bmw.x6",
      "make": "bmw",
      "label": "BMW X6",
      "names": [
        "x6"
      ]
    },
    {
      "id": "bmw.z4",
      "make": "bmw",
      "label": "BMW Z4",
      "names": [
        "z4"
      ]
    },
    {
      "id": "mercedes.cclass",
      "make": "mercedes",
      "label": "Mercedes-Benz C-Class",
      "names": [
        "c-class",
        "c class",
        "classe c",
        "c-klasse",
        "c 180",
        "c 200",
        "c 220",
        "c 230",
        "c 250",
        "c 280",
        "c 300",
        "c 350"
      ]
    },
    {
      "id": "mercedes.eclass",
      "make": "mercedes",
      "label": "Mercedes-Benz E-Class",
      "names": [
        "e-class",
        "e class",
        "classe e",
        "e-klasse",
        "e 200",
        "e 220",
        "e 250",
        "e 280",
        "e 300",
        "e 350"
      ]
    },
    {
      "id": "mercedes.glk",
      "make": "mercedes",
      "label": "Mercedes-Benz GLK",
      "names": [
        "glk"
      ]
    },
    {
      "id": "mercedes.slk",
      "make": "mercedes",
      "label": "Mercedes-Benz SLK",
      "names": [
        "slk"
      ]
    },
    {
      "id": "ford.fiesta",
      "make": "ford",
      "label": "Ford Fiesta",
      "names": [
        "fiesta"
      ]
    },
    {
      "id": "ford.focus",
      "make": "ford",
      "label": "Ford Focus",
      "names": [
        "focus"
      ]
    },
    {
      "id": "ford.ecosport",
      "make": "ford",
      "label": "Ford EcoSport",
      "names": [
        "ecosport",
        "eco sport"
      ]
    },
    {
      "id": "ford.b_max",
      "make": "ford",
      "label": "Ford B-MAX",
      "names": [
        "b-max",
        "b max",
        "bmax"
      ]
    },
    {
      "id": "ford.c_max",
      "make": "ford",
      "label": "Ford C-MAX",
      "names": [
        "c-max",
        "c max",
        "cmax"
      ]
    },
    {
      "id": "ford.mondeo",
      "make": "ford",
      "label": "Ford Mondeo",
      "names": [
        "mondeo"
      ]
    },
    {
      "id": "ford.puma",
      "make": "ford",
      "label": "Ford Puma",
      "names": [
        "puma"
      ]
    },
    {
      "id": "nissan.juke",
      "make": "nissan",
      "label": "Nissan Juke",
      "names": [
        "juke"
      ]
    }
  ],
  "generations": [],
  "engines": [
    {
      "id": "psa.eb2dt",
      "family": "EB2",
      "codes": [
        "EB2DT",
        "HNZ"
      ],
      "fuel": "petrol",
      "displacementCc": null,
      "powerKw": [
        81
      ],
      "label": {
        "en": "1.2 PureTech turbo 110 hp (EB2DT / HNZ)",
        "pt": "1.2 PureTech turbo 110 cv (EB2DT / HNZ)",
        "ru": "1.2 PureTech турбо 110 л. с. (EB2DT / HNZ)",
        "uk": "1.2 PureTech турбо 110 к. с. (EB2DT / HNZ)",
        "fr": "1.2 PureTech turbo 110 ch (EB2DT / HNZ)"
      },
      "evidence": [
        "ev_pt_e08",
        "ev_pt_e17"
      ]
    },
    {
      "id": "psa.eb2dts",
      "family": "EB2",
      "codes": [
        "EB2DTS",
        "HNY"
      ],
      "fuel": "petrol",
      "displacementCc": null,
      "powerKw": [
        96
      ],
      "label": {
        "en": "1.2 PureTech turbo 130 hp (EB2DTS / HNY)",
        "pt": "1.2 PureTech turbo 130 cv (EB2DTS / HNY)",
        "ru": "1.2 PureTech турбо 130 л. с. (EB2DTS / HNY)",
        "uk": "1.2 PureTech турбо 130 к. с. (EB2DTS / HNY)",
        "fr": "1.2 PureTech turbo 130 ch (EB2DTS / HNY)"
      },
      "evidence": [
        "ev_pt_e08",
        "ev_pt_e17"
      ]
    },
    {
      "id": "psa.eb2f",
      "family": "EB2",
      "codes": [
        "EB2",
        "EB2F",
        "EB2FA"
      ],
      "fuel": "petrol",
      "displacementCc": null,
      "powerKw": [],
      "label": {
        "en": "1.2 PureTech naturally aspirated 75/82 hp (EB2F / EB2FA)",
        "pt": "1.2 PureTech atmosférico 75/82 cv (EB2F / EB2FA)",
        "ru": "1.2 PureTech атмосферный 75/82 л. с. (EB2F / EB2FA)",
        "uk": "1.2 PureTech атмосферний 75/82 к. с. (EB2F / EB2FA)",
        "fr": "1.2 PureTech atmosphérique 75/82 ch (EB2F / EB2FA)"
      },
      "evidence": [
        "ev_pt_e08",
        "ev_pt_e17"
      ]
    },
    {
      "id": "psa.eb2lted",
      "family": "EB2",
      "codes": [
        "EB2LTED",
        "EB2LTEDH2"
      ],
      "fuel": "petrol",
      "displacementCc": null,
      "powerKw": [],
      "label": {
        "en": "1.2 Gen3 with timing chain (EB2LTED / EB2LTEDH2)",
        "pt": "1.2 Gen3 com corrente de distribuição (EB2LTED / EB2LTEDH2)",
        "ru": "1.2 Gen3 с цепью ГРМ (EB2LTED / EB2LTEDH2)",
        "uk": "1.2 Gen3 з ланцюгом ГРМ (EB2LTED / EB2LTEDH2)",
        "fr": "1.2 Gen3 à chaîne de distribution (EB2LTED / EB2LTEDH2)"
      },
      "evidence": [
        "ev_pt_e10",
        "ev_pt_e18"
      ]
    },
    {
      "id": "bmw.n47d20",
      "family": "N47",
      "codes": [
        "N47D20",
        "N47D20U0",
        "N47D20O0",
        "N47D20T0"
      ],
      "fuel": "diesel",
      "displacementCc": null,
      "powerKw": [
        105,
        130,
        150
      ],
      "label": {
        "en": "BMW N47 2.0 diesel (N47D20)",
        "pt": "BMW N47 2.0 diesel (N47D20)",
        "ru": "BMW N47 2.0 дизель (N47D20)",
        "uk": "BMW N47 2.0 дизель (N47D20)",
        "fr": "BMW N47 2.0 diesel (N47D20)"
      },
      "evidence": [
        "ev_bm_e11",
        "ev_bm_e01"
      ]
    },
    {
      "id": "vag.ea111_12tsi",
      "family": "EA111",
      "codes": [
        "CBZA",
        "CBZB",
        "CBZC"
      ],
      "fuel": "petrol",
      "displacementCc": 1197,
      "powerKw": [
        63,
        66,
        77
      ],
      "label": {
        "en": "1.2 TSI EA111 (CBZA / CBZB / CBZC)",
        "pt": "1.2 TSI EA111 (CBZA / CBZB / CBZC)",
        "ru": "1.2 TSI EA111 (CBZA / CBZB / CBZC)",
        "uk": "1.2 TSI EA111 (CBZA / CBZB / CBZC)",
        "fr": "1.2 TSI EA111 (CBZA / CBZB / CBZC)"
      },
      "evidence": [
        "ev_ts_e03",
        "ev_ts_e05"
      ]
    },
    {
      "id": "vag.ea111_14tsi",
      "family": "EA111",
      "codes": [
        "BMY",
        "BWK",
        "CAVA",
        "CAVD",
        "CAXA",
        "CDGA",
        "CTHA"
      ],
      "fuel": "petrol",
      "displacementCc": 1390,
      "powerKw": [],
      "label": {
        "en": "1.4 TSI EA111 (BMY / BWK / CAVA / CAVD / CAXA / CDGA / CTHA)",
        "pt": "1.4 TSI EA111 (BMY / BWK / CAVA / CAVD / CAXA / CDGA / CTHA)",
        "ru": "1.4 TSI EA111 (BMY / BWK / CAVA / CAVD / CAXA / CDGA / CTHA)",
        "uk": "1.4 TSI EA111 (BMY / BWK / CAVA / CAVD / CAXA / CDGA / CTHA)",
        "fr": "1.4 TSI EA111 (BMY / BWK / CAVA / CAVD / CAXA / CDGA / CTHA)"
      },
      "evidence": [
        "ev_ts_e04",
        "ev_ts_e06"
      ]
    },
    {
      "id": "vag.ea888_18tfsi",
      "family": "EA888",
      "codes": [
        "BYT",
        "CDHB",
        "CDAA",
        "CDAB"
      ],
      "fuel": "petrol",
      "displacementCc": 1798,
      "powerKw": [],
      "label": {
        "en": "1.8 TFSI/TSI EA888 (BYT / CDHB / CDAA / CDAB)",
        "pt": "1.8 TFSI/TSI EA888 (BYT / CDHB / CDAA / CDAB)",
        "ru": "1.8 TFSI/TSI EA888 (BYT / CDHB / CDAA / CDAB)",
        "uk": "1.8 TFSI/TSI EA888 (BYT / CDHB / CDAA / CDAB)",
        "fr": "1.8 TFSI/TSI EA888 (BYT / CDHB / CDAA / CDAB)"
      },
      "evidence": [
        "ev_to_e07"
      ]
    },
    {
      "id": "vag.ea888_20tfsi",
      "family": "EA888",
      "codes": [
        "CAEA",
        "CAEB",
        "CDNB",
        "CDNC"
      ],
      "fuel": "petrol",
      "displacementCc": 1984,
      "powerKw": [],
      "label": {
        "en": "2.0 TFSI EA888, longitudinal (CAEA / CAEB / CDNB / CDNC)",
        "pt": "2.0 TFSI EA888, longitudinal (CAEA / CAEB / CDNB / CDNC)",
        "ru": "2.0 TFSI EA888, продольный (CAEA / CAEB / CDNB / CDNC)",
        "uk": "2.0 TFSI EA888, поздовжній (CAEA / CAEB / CDNB / CDNC)",
        "fr": "2.0 TFSI EA888, longitudinal (CAEA / CAEB / CDNB / CDNC)"
      },
      "evidence": [
        "ev_to_e01",
        "ev_to_e07"
      ]
    },
    {
      "id": "vag.ea888_20tfsi_t",
      "family": "EA888",
      "codes": [
        "CBFA",
        "CCTA",
        "CCZA",
        "CCZB",
        "CAWB",
        "CESA",
        "CAWA",
        "CCZC",
        "CCZD"
      ],
      "fuel": "petrol",
      "displacementCc": 1984,
      "powerKw": [],
      "label": {
        "en": "2.0 TFSI EA888, transverse (CBFA / CCTA / CCZA / CCZB / CAWB / CESA / CAWA / CCZC / CCZD)",
        "pt": "2.0 TFSI EA888, transversal (CBFA / CCTA / CCZA / CCZB / CAWB / CESA / CAWA / CCZC / CCZD)",
        "ru": "2.0 TFSI EA888, поперечный (CBFA / CCTA / CCZA / CCZB / CAWB / CESA / CAWA / CCZC / CCZD)",
        "uk": "2.0 TFSI EA888, поперечний (CBFA / CCTA / CCZA / CCZB / CAWB / CESA / CAWA / CCZC / CCZD)",
        "fr": "2.0 TFSI EA888, transversal (CBFA / CCTA / CCZA / CCZB / CAWB / CESA / CAWA / CCZC / CCZD)"
      },
      "evidence": [
        "ev_wp_e05",
        "ev_to_e07"
      ]
    },
    {
      "id": "vag.ea189_20tdi_140",
      "family": "EA189",
      "codes": [
        "CBEA",
        "CJAA"
      ],
      "fuel": "diesel",
      "displacementCc": 1968,
      "powerKw": [
        103
      ],
      "label": {
        "en": "2.0 TDI common rail 140 hp EA189 (CBEA / CJAA)",
        "pt": "2.0 TDI common rail 140 cv EA189 (CBEA / CJAA)",
        "ru": "2.0 TDI common rail 140 л. с. EA189 (CBEA / CJAA)",
        "uk": "2.0 TDI common rail 140 к. с. EA189 (CBEA / CJAA)",
        "fr": "2.0 TDI common rail 140 ch EA189 (CBEA / CJAA)"
      },
      "evidence": [
        "ev_td_e01",
        "ev_td_e03"
      ]
    },
    {
      "id": "bmw.n51",
      "family": "N51",
      "codes": [
        "N51"
      ],
      "fuel": "petrol",
      "displacementCc": null,
      "powerKw": [],
      "label": {
        "en": "BMW N51 inline-six petrol",
        "pt": "BMW N51 gasolina, seis cilindros em linha",
        "ru": "BMW N51, бензиновый рядный шестицилиндровый",
        "uk": "BMW N51, бензиновий рядний шестициліндровий",
        "fr": "BMW N51 essence, six cylindres en ligne"
      },
      "evidence": [
        "ev_bmmb_e02",
        "ev_bmmb_e05"
      ]
    },
    {
      "id": "bmw.n52k",
      "family": "N52",
      "codes": [
        "N52K"
      ],
      "fuel": "petrol",
      "displacementCc": null,
      "powerKw": [],
      "label": {
        "en": "BMW N52K inline-six petrol",
        "pt": "BMW N52K gasolina, seis cilindros em linha",
        "ru": "BMW N52K, бензиновый рядный шестицилиндровый",
        "uk": "BMW N52K, бензиновий рядний шестициліндровий",
        "fr": "BMW N52K essence, six cylindres en ligne"
      },
      "evidence": [
        "ev_bmmb_e02",
        "ev_bmmb_e05"
      ]
    },
    {
      "id": "bmw.n52t",
      "family": "N52",
      "codes": [
        "N52T"
      ],
      "fuel": "petrol",
      "displacementCc": null,
      "powerKw": [],
      "label": {
        "en": "BMW N52T inline-six petrol",
        "pt": "BMW N52T gasolina, seis cilindros em linha",
        "ru": "BMW N52T, бензиновый рядный шестицилиндровый",
        "uk": "BMW N52T, бензиновий рядний шестициліндровий",
        "fr": "BMW N52T essence, six cylindres en ligne"
      },
      "evidence": [
        "ev_bmmb_e02",
        "ev_bmmb_e05"
      ]
    },
    {
      "id": "bmw.n55",
      "family": "N55",
      "codes": [
        "N55"
      ],
      "fuel": "petrol",
      "displacementCc": null,
      "powerKw": [],
      "label": {
        "en": "BMW N55 inline-six petrol",
        "pt": "BMW N55 gasolina, seis cilindros em linha",
        "ru": "BMW N55, бензиновый рядный шестицилиндровый",
        "uk": "BMW N55, бензиновий рядний шестициліндровий",
        "fr": "BMW N55 essence, six cylindres en ligne"
      },
      "evidence": [
        "ev_bmmb_e03",
        "ev_bmmb_e05",
        "ev_bmmb_e08"
      ]
    },
    {
      "id": "bmw.n20",
      "family": "N20",
      "codes": [
        "N20"
      ],
      "fuel": "petrol",
      "displacementCc": null,
      "powerKw": [],
      "label": {
        "en": "BMW N20 petrol",
        "pt": "BMW N20 gasolina",
        "ru": "BMW N20, бензиновый",
        "uk": "BMW N20, бензиновий",
        "fr": "BMW N20 essence"
      },
      "evidence": [
        "ev_bmmb_e07",
        "ev_bmmb_e09"
      ]
    },
    {
      "id": "mercedes.m271",
      "family": "M271",
      "codes": [
        "M271"
      ],
      "fuel": "petrol",
      "displacementCc": 1796,
      "powerKw": [],
      "label": {
        "en": "Mercedes M271 1.8 petrol (supercharged and EVO)",
        "pt": "Mercedes M271 1.8 gasolina (com compressor e EVO)",
        "ru": "Mercedes M271 1.8 бензин (с компрессором и EVO)",
        "uk": "Mercedes M271 1.8 бензин (з компресором і EVO)",
        "fr": "Mercedes M271 1.8 essence (à compresseur et EVO)"
      },
      "evidence": [
        "ev_bmmb_e15",
        "ev_bmmb_e16"
      ]
    },
    {
      "id": "mercedes.om651_220_250",
      "family": "OM651",
      "codes": [
        "OM651"
      ],
      "fuel": "diesel",
      "displacementCc": null,
      "powerKw": [
        125,
        150
      ],
      "label": {
        "en": "Mercedes OM651 diesel, 220 CDI and 250 CDI versions",
        "pt": "Mercedes OM651 diesel, versões 220 CDI e 250 CDI",
        "ru": "Mercedes OM651 дизель, версии 220 CDI и 250 CDI",
        "uk": "Mercedes OM651 дизель, версії 220 CDI і 250 CDI",
        "fr": "Mercedes OM651 diesel, versions 220 CDI et 250 CDI"
      },
      "evidence": [
        "ev_bmmb_e10",
        "ev_bmmb_e11"
      ]
    },
    {
      "id": "ford.fox_1_0",
      "family": "FOX",
      "codes": [
        "M1JA",
        "M1JH",
        "M1JL",
        "M1JE",
        "M1JJ",
        "M1JU",
        "SFJA",
        "SFJB",
        "SFJC",
        "SFJD",
        "M2DA",
        "M2DC",
        "M1DA",
        "M1DC",
        "M1DD",
        "M1DH",
        "M1CA",
        "M1CB",
        "YYJA",
        "YYJB",
        "YYJC",
        "M0JB",
        "B3DA",
        "B7JB",
        "B7JC",
        "BZJA"
      ],
      "fuel": "petrol",
      "displacementCc": 999,
      "powerKw": [],
      "label": {
        "en": "Ford 1.0 EcoBoost (Fox) turbo petrol",
        "pt": "Ford 1.0 EcoBoost (Fox) turbo a gasolina",
        "ru": "Ford 1.0 EcoBoost (Fox) бензиновый турбо",
        "uk": "Ford 1.0 EcoBoost (Fox) бензиновий турбо",
        "fr": "Ford 1.0 EcoBoost (Fox) essence turbo"
      },
      "evidence": [
        "ev_pf_w01",
        "ev_pf_w07"
      ]
    }
  ],
  "gearboxes": [
    {
      "id": "vag.dq200",
      "family": "DQ200",
      "codes": [
        "0AM",
        "0CW",
        "0BM"
      ],
      "type": "dct_dry",
      "label": {
        "en": "7-speed DSG with dry clutches (DQ200, 0AM / 0CW / 0BM)",
        "pt": "DSG de 7 velocidades com embraiagens a seco (DQ200, 0AM / 0CW / 0BM)",
        "ru": "7-ступенчатая DSG с сухими сцеплениями (DQ200, 0AM / 0CW / 0BM)",
        "uk": "7-ступінчаста DSG із сухими зчепленнями (DQ200, 0AM / 0CW / 0BM)",
        "fr": "DSG 7 rapports à embrayages à sec (DQ200, 0AM / 0CW / 0BM)"
      },
      "evidence": [
        "ev_dq_e11",
        "ev_dq_e15"
      ]
    },
    {
      "id": "vag.dq250",
      "family": "DQ250",
      "codes": [
        "02E"
      ],
      "type": "dct_wet",
      "label": {
        "en": "6-speed DSG with wet clutches (DQ250, 02E)",
        "pt": "DSG de 6 velocidades com embraiagens em banho de óleo (DQ250, 02E)",
        "ru": "6-ступенчатая DSG с мокрыми сцеплениями (DQ250, 02E)",
        "uk": "6-ступінчаста DSG з мокрими зчепленнями (DQ250, 02E)",
        "fr": "DSG 6 rapports à embrayages humides (DQ250, 02E)"
      },
      "evidence": [
        "ev_dq_e15"
      ]
    },
    {
      "id": "vag.dq381",
      "family": "DQ381",
      "codes": [],
      "type": "dct_wet",
      "label": {
        "en": "7-speed DSG with wet clutches (DQ381)",
        "pt": "DSG de 7 velocidades com embraiagens em banho de óleo (DQ381)",
        "ru": "7-ступенчатая DSG с мокрыми сцеплениями (DQ381)",
        "uk": "7-ступінчаста DSG з мокрими зчепленнями (DQ381)",
        "fr": "DSG 7 rapports à embrayages humides (DQ381)"
      },
      "evidence": [
        "ev_dq_e15"
      ]
    },
    {
      "id": "vag.dq500",
      "family": "DQ500",
      "codes": [],
      "type": "dct_wet",
      "label": {
        "en": "7-speed DSG with wet clutches (DQ500)",
        "pt": "DSG de 7 velocidades com embraiagens em banho de óleo (DQ500)",
        "ru": "7-ступенчатая DSG с мокрыми сцеплениями (DQ500)",
        "uk": "7-ступінчаста DSG з мокрими зчепленнями (DQ500)",
        "fr": "DSG 7 rapports à embrayages humides (DQ500)"
      },
      "evidence": [
        "ev_dq_e15"
      ]
    },
    {
      "id": "ford.dps6",
      "family": "DPS6",
      "codes": [],
      "type": "dct_dry",
      "label": {
        "en": "Ford 6-speed dual-clutch with dry clutches (DPS6, Powershift)",
        "pt": "Ford de 6 velocidades de dupla embraiagem a seco (DPS6, Powershift)",
        "ru": "6-ступенчатая Ford с двумя сухими сцеплениями (DPS6, Powershift)",
        "uk": "6-ступінчаста Ford із двома сухими зчепленнями (DPS6, Powershift)",
        "fr": "Ford 6 rapports à double embrayage sec (DPS6, Powershift)"
      },
      "evidence": [
        "ev_pf_p01",
        "ev_pf_p03"
      ]
    },
    {
      "id": "jatco.jf015e",
      "family": "JF015E",
      "codes": [
        "JF015E",
        "RE0F11A"
      ],
      "type": "cvt",
      "label": {
        "en": "Jatco JF015E / Nissan RE0F11A belt CVT",
        "pt": "Jatco JF015E / Nissan RE0F11A, CVT de correia",
        "ru": "Вариатор Jatco JF015E / Nissan RE0F11A (ремень)",
        "uk": "Варіатор Jatco JF015E / Nissan RE0F11A (пас)",
        "fr": "CVT à courroie Jatco JF015E / Nissan RE0F11A"
      },
      "evidence": [
        "ev_cv_e07"
      ]
    },
    {
      "id": "jatco.jf016e",
      "family": "JF016E",
      "codes": [
        "JF016E",
        "RE0F10D"
      ],
      "type": "cvt",
      "label": {
        "en": "Jatco JF016E / Nissan RE0F10D belt CVT",
        "pt": "Jatco JF016E / Nissan RE0F10D, CVT de correia",
        "ru": "Вариатор Jatco JF016E / Nissan RE0F10D (ремень)",
        "uk": "Варіатор Jatco JF016E / Nissan RE0F10D (пас)",
        "fr": "CVT à courroie Jatco JF016E / Nissan RE0F10D"
      },
      "evidence": [
        "ev_cv_e02",
        "ev_cv_e07"
      ]
    },
    {
      "id": "jatco.jf017e",
      "family": "JF017E",
      "codes": [
        "JF017E",
        "RE0F10E",
        "RE0F10H",
        "RE0F10J"
      ],
      "type": "cvt",
      "label": {
        "en": "Jatco JF017E / Nissan RE0F10E, H, J chain CVT",
        "pt": "Jatco JF017E / Nissan RE0F10E, H, J, CVT de corrente",
        "ru": "Вариатор Jatco JF017E / Nissan RE0F10E, H, J (цепь)",
        "uk": "Варіатор Jatco JF017E / Nissan RE0F10E, H, J (ланцюг)",
        "fr": "CVT à chaîne Jatco JF017E / Nissan RE0F10E, H, J"
      },
      "evidence": [
        "ev_cv_e07",
        "ev_cv_e08"
      ]
    }
  ],
  "fitments": []
}
''';

const String defectsV3CanonJson = r'''
{
  "format": 3,
  "languages": [
    "en",
    "pt",
    "ru",
    "uk",
    "fr"
  ],
  "questions": {
    "model": {
      "label": {
        "en": "Model",
        "pt": "Modelo",
        "ru": "Модель",
        "uk": "Модель",
        "fr": "Modèle"
      },
      "help": {
        "en": "The model name as on the registration document, e.g. Golf, 208, 320d.",
        "pt": "O nome do modelo como consta do documento único, p. ex. Golf, 208, 320d.",
        "ru": "Название модели как в регистрационном документе, например Golf, 208, 320d.",
        "uk": "Назва моделі як у реєстраційному документі, наприклад Golf, 208, 320d.",
        "fr": "Le nom du modèle tel qu'il figure sur le certificat d'immatriculation, p. ex. Golf, 208, 320d."
      }
    },
    "year": {
      "label": {
        "en": "Year of manufacture",
        "pt": "Ano de fabrico",
        "ru": "Год выпуска",
        "uk": "Рік випуску",
        "fr": "Année de fabrication"
      },
      "help": {
        "en": "If unsure, the date of first registration (field B of the EU registration certificate) is a close guide.",
        "pt": "Em caso de dúvida, a data da primeira matrícula (campo B do certificado de matrícula UE) é uma boa referência.",
        "ru": "Если не уверены, ориентируйтесь на дату первой регистрации (поле B европейского свидетельства о регистрации).",
        "uk": "Якщо не впевнені, орієнтуйтеся на дату першої реєстрації (поле B європейського свідоцтва про реєстрацію).",
        "fr": "En cas de doute, la date de première immatriculation (champ B du certificat d'immatriculation UE) est un bon repère."
      }
    },
    "fuel": {
      "label": {
        "en": "Fuel",
        "pt": "Combustível",
        "ru": "Топливо",
        "uk": "Пальне",
        "fr": "Carburant"
      },
      "help": {
        "en": "Field P.3 of the EU registration certificate.",
        "pt": "Campo P.3 do certificado de matrícula UE.",
        "ru": "Поле P.3 европейского свидетельства о регистрации.",
        "uk": "Поле P.3 європейського свідоцтва про реєстрацію.",
        "fr": "Champ P.3 du certificat d'immatriculation UE."
      }
    },
    "gearbox": {
      "label": {
        "en": "Gearbox type",
        "pt": "Tipo de caixa de velocidades",
        "ru": "Тип КПП",
        "uk": "Тип КПП",
        "fr": "Type de boîte de vitesses"
      },
      "help": {
        "en": "Manual or automatic? On VW group cars a dual-clutch gearbox usually shows 'DSG' or 'S tronic' on or near the gear lever.",
        "pt": "Manual ou automática? Nos automóveis do grupo VW, uma caixa de dupla embraiagem costuma ter 'DSG' ou 'S tronic' na alavanca ou junto dela.",
        "ru": "Механика или автомат? На машинах группы VW коробка с двумя сцеплениями обычно обозначена «DSG» или «S tronic» на рычаге или рядом с ним.",
        "uk": "Механіка чи автомат? На машинах групи VW коробка з двома зчепленнями зазвичай позначена «DSG» або «S tronic» на важелі чи поруч із ним.",
        "fr": "Manuelle ou automatique ? Sur les véhicules du groupe VW, une boîte à double embrayage porte généralement « DSG » ou « S tronic » sur le levier ou à côté."
      }
    },
    "gearboxCode": {
      "label": {
        "en": "Gearbox code",
        "pt": "Código da caixa de velocidades",
        "ru": "Код КПП",
        "uk": "Код КПП",
        "fr": "Code de la boîte de vitesses"
      },
      "help": {
        "en": "Stamped on the gearbox housing and returned by a dealer VIN query; on VW group cars also printed on the vehicle data sticker.",
        "pt": "Gravado na carcaça da caixa e indicado por uma consulta do VIN no concessionário; nos automóveis do grupo VW também consta da etiqueta de dados do veículo.",
        "ru": "Выбит на корпусе КПП и выдаётся дилером по запросу VIN; на машинах группы VW также напечатан на наклейке с данными автомобиля.",
        "uk": "Вибитий на корпусі КПП і видається дилером за запитом VIN; на машинах групи VW також надрукований на наліпці з даними автомобіля.",
        "fr": "Frappé sur le carter de boîte et fourni par le concessionnaire à partir du VIN ; sur les véhicules du groupe VW, il figure aussi sur l'étiquette de données du véhicule."
      }
    },
    "engineCode": {
      "label": {
        "en": "Engine code",
        "pt": "Código do motor",
        "ru": "Код двигателя",
        "uk": "Код двигуна",
        "fr": "Code moteur"
      },
      "help": {
        "en": "On the engine plate or block, or from a dealer VIN query. Displacement (P.1) and power in kW (P.2) on the registration certificate help narrow it down.",
        "pt": "Na placa ou no bloco do motor, ou numa consulta do VIN no concessionário. A cilindrada (P.1) e a potência em kW (P.2) do certificado de matrícula ajudam a identificá-lo.",
        "ru": "На табличке или блоке двигателя либо по запросу VIN у дилера. Сузить выбор помогут объём (P.1) и мощность в кВт (P.2) из свидетельства о регистрации.",
        "uk": "На табличці або блоці двигуна чи за запитом VIN у дилера. Звузити вибір допоможуть об'єм (P.1) і потужність у кВт (P.2) зі свідоцтва про реєстрацію.",
        "fr": "Sur la plaque ou le bloc moteur, ou via une requête VIN chez le concessionnaire. La cylindrée (P.1) et la puissance en kW (P.2) du certificat d'immatriculation aident à le déterminer."
      }
    },
    "productionDate": {
      "label": {
        "en": "Production month",
        "pt": "Mês de produção",
        "ru": "Месяц выпуска",
        "uk": "Місяць випуску",
        "fr": "Mois de production"
      },
      "help": {
        "en": "The build date (YYYY-MM) on the door-pillar label or from a dealer VIN query. The affected range starts or ends within this year.",
        "pt": "A data de fabrico (AAAA-MM) na etiqueta do pilar da porta ou numa consulta do VIN no concessionário. O período afetado começa ou termina dentro deste ano.",
        "ru": "Дата сборки (ГГГГ-ММ) на наклейке в проёме двери или по запросу VIN у дилера. Граница затронутого периода приходится на этот год.",
        "uk": "Дата збирання (РРРР-ММ) на наліпці в отворі дверей або за запитом VIN у дилера. Межа ураженого періоду припадає на цей рік.",
        "fr": "La date de fabrication (AAAA-MM) sur l'étiquette du montant de porte ou via une requête VIN chez le concessionnaire. La période concernée commence ou se termine dans cette année."
      }
    }
  },
  "defects": [
    {
      "id": "dsg.dq200",
      "aliases": [],
      "status": "published",
      "replacedBy": null,
      "revision": 1,
      "updatedAt": "2026-10-13",
      "legacyRule": "vag-known-issues",
      "title": {
        "en": "VW group 7-speed DSG DQ200 (0AM / 0CW / 0BM, dry clutches): reported mechatronic and clutch faults",
        "pt": "DSG de 7 velocidades DQ200 do grupo VW (0AM / 0CW / 0BM, embraiagens a seco): avarias referidas da mecatrónica e da embraiagem",
        "ru": "7-ступенчатая DSG DQ200 группы VW (0AM / 0CW / 0BM, сухие сцепления): сообщаемые отказы мехатроника и сцепления",
        "uk": "7-ступінчаста DSG DQ200 групи VW (0AM / 0CW / 0BM, сухі зчеплення): повідомлювані відмови мехатроніка та зчеплення",
        "fr": "DSG 7 rapports DQ200 du groupe VW (0AM / 0CW / 0BM, embrayages à sec) : défaillances signalées du mécatronique et de l'embrayage"
      },
      "summary": {
        "en": "In 2013 Volkswagen announced a gearbox oil and software measure for DQ200 units (about 1.8 million vehicles worldwide according to L'argus); in Germany and France it was carried out at workshop visits rather than as a recall. Regulators also recorded recalls for a possible loss of drive (NHTSA 13V568 and 19V866, US Jetta Hybrid only; Hong Kong 10000424, where the notice says it happens only in isolated cases). Recalls and trade-press reports describe faults of the mechatronic unit; workshop sources also describe clutch wear. The 7-speed dry-clutch DSG is used with engines up to about 250 Nm.",
        "pt": "Em 2013 a Volkswagen anunciou uma medida de óleo e software para as caixas DQ200 (cerca de 1,8 milhões de veículos no mundo, segundo o L'argus); na Alemanha e em França foi executada nas visitas à oficina e não como chamada. As autoridades registaram também chamadas por possível perda de tração (NHTSA 13V568 e 19V866, apenas Jetta Hybrid nos EUA; Hong Kong 10000424, cuja nota indica que ocorre apenas em casos isolados). As chamadas e a imprensa técnica descrevem avarias da unidade mecatrónica; fontes de oficinas descrevem também desgaste da embraiagem. A DSG de 7 velocidades com embraiagens a seco é usada com motores até cerca de 250 Nm.",
        "ru": "В 2013 году Volkswagen объявила мероприятие по замене масла и обновлению ПО на коробках DQ200 (около 1,8 млн машин в мире по данным L'argus); в Германии и Франции оно выполнялось при визитах в сервис, а не как отзыв. Регуляторы также зарегистрировали отзывы из-за возможной потери тяги (NHTSA 13V568 и 19V866, только Jetta Hybrid в США; Гонконг 10000424, где в уведомлении сказано, что это бывает лишь в единичных случаях). Отзывы и техническая пресса описывают неисправности мехатроника; источники из мастерских описывают и износ сцеплений. 7-ступенчатую DSG с сухими сцеплениями ставят на двигатели до примерно 250 Н·м.",
        "uk": "У 2013 році Volkswagen оголосила захід із заміни оливи та оновлення ПЗ на коробках DQ200 (близько 1,8 млн машин у світі за даними L'argus); у Німеччині та Франції його виконували під час візитів до сервісу, а не як відкликання. Регулятори також зареєстрували відкликання через можливу втрату тяги (NHTSA 13V568 і 19V866, лише Jetta Hybrid у США; Гонконг 10000424, де в повідомленні сказано, що це трапляється лише в поодиноких випадках). Відкликання й технічна преса описують несправності мехатроніка; джерела з майстерень описують також знос зчеплень. 7-ступінчасту DSG із сухими зчепленнями ставлять на двигуни до приблизно 250 Н·м.",
        "fr": "En 2013, Volkswagen a annoncé une action huile et logiciel sur les boîtes DQ200 (environ 1,8 million de véhicules dans le monde selon L'argus) ; en Allemagne et en France, elle a été menée lors des passages à l'atelier plutôt que par un rappel. Des autorités ont aussi enregistré des rappels pour une possible perte de motricité (NHTSA 13V568 et 19V866, Jetta Hybrid américaine uniquement ; Hong Kong 10000424, dont la fiche indique que cela n'arrive que dans des cas isolés). Les rappels et la presse technique décrivent des défauts de l'unité mécatronique ; des sources d'ateliers décrivent aussi une usure des embrayages. La DSG 7 rapports à embrayages à sec est montée avec des moteurs jusqu'à environ 250 Nm."
      },
      "checklistPrompt": {
        "en": "DSG (DQ200 dry-clutch) — check for judder and mechatronic faults",
        "pt": "DSG (DQ200 embraiagem seca) — verificar trepidação e avarias da mecatrónica",
        "ru": "DSG (DQ200, сухое сцепление) — проверить рывки и неисправности мехатроника",
        "uk": "DSG (DQ200, сухе зчеплення) — перевірити ривки та несправності мехатроніка",
        "fr": "DSG (DQ200 à embrayage à sec) — vérifier à-coups et défauts du mécatronique"
      },
      "component": "transmission.dct.mechatronic",
      "mechanism": {
        "en": "The mechatronic unit combines the hydraulic pressure accumulator, an electric pump and the control electronics. Recalls and the trade press describe: additives in the original synthetic gearbox oil that could corrode the electronics (addressed in 2013 with mineral oil and new software); cracks in the accumulator or housing that let hydraulic pressure drop so the clutches may not engage; and wear of the dry clutches reported by workshops. Reported results include judder and gears not engaging and, in the recalls, a possible sudden loss of drive; the Hong Kong notice says the latter occurs only in isolated cases.",
        "pt": "A unidade mecatrónica junta o acumulador de pressão hidráulica, uma bomba elétrica e a eletrónica de controlo. As chamadas e a imprensa técnica descrevem: aditivos do óleo sintético original da caixa que podiam corroer a eletrónica (tratado em 2013 com óleo mineral e novo software); fissuras no acumulador ou no corpo que fazem cair a pressão hidráulica, pelo que as embraiagens podem não engatar; e desgaste das embraiagens a seco referido por oficinas. Os resultados referidos incluem trepidação e mudanças que não entram e, nas chamadas, uma possível perda súbita de tração; a nota de Hong Kong indica que esta ocorre apenas em casos isolados.",
        "ru": "Мехатроник объединяет гидроаккумулятор, электронасос и электронику управления. В отзывах и технической прессе описаны: присадки в исходном синтетическом масле КПП, способные вызывать коррозию электроники (в 2013 году — переход на минеральное масло и новое ПО); трещины в гидроаккумуляторе или корпусе, из-за которых падает давление и сцепления могут не включаться; а также износ сухих сцеплений по сообщениям мастерских. Сообщаемые последствия — рывки, невключение передач и, в отзывах, возможная внезапная потеря тяги; в уведомлении Гонконга сказано, что она возникает лишь в единичных случаях.",
        "uk": "Мехатронік поєднує гідроакумулятор, електронасос і електроніку керування. У відкликаннях і технічній пресі описано: присадки у вихідній синтетичній оливі КПП, здатні спричиняти корозію електроніки (у 2013 році — перехід на мінеральну оливу та нове ПЗ); тріщини в гідроакумуляторі чи корпусі, через які падає тиск і зчеплення можуть не вмикатися; а також знос сухих зчеплень за повідомленнями майстерень. Повідомлювані наслідки — ривки, невмикання передач і, у відкликаннях, можлива раптова втрата тяги; у повідомленні Гонконгу сказано, що вона трапляється лише в поодиноких випадках.",
        "fr": "Le mécatronique réunit l'accumulateur de pression hydraulique, une pompe électrique et l'électronique de commande. Les rappels et la presse technique décrivent : des additifs de l'huile synthétique d'origine de la boîte pouvant corroder l'électronique (traité en 2013 par une huile minérale et un nouveau logiciel) ; des fissures de l'accumulateur ou du carter qui font chuter la pression, de sorte que les embrayages peuvent ne plus s'engager ; et une usure des embrayages à sec signalée par des ateliers. Les effets signalés comprennent des à-coups, des rapports qui ne passent pas et, dans les rappels, une possible perte soudaine de motricité ; la fiche de Hong Kong précise qu'elle n'arrive que dans des cas isolés."
      },
      "applicability": {
        "models": [
          "volkswagen.golf",
          "volkswagen.polo",
          "volkswagen.passat",
          "volkswagen.caddy",
          "volkswagen.jetta",
          "volkswagen.scirocco",
          "volkswagen.touran",
          "audi.a1",
          "audi.a3",
          "seat.ibiza",
          "seat.leon",
          "skoda.fabia",
          "skoda.octavia"
        ],
        "when": {
          "gearbox": {
            "family": [
              "DQ200"
            ],
            "codes": [
              "0AM",
              "0CW",
              "0BM"
            ]
          }
        },
        "markets": [
          "EU",
          "US",
          "HK",
          "AU",
          "CN",
          "RU"
        ],
        "hint": {
          "en": "Only cars with the 7-speed DSG with dry clutches (DQ200, gearbox codes 0AM / 0CW / 0BM). Not applicable to manual gearboxes or to wet-clutch DSGs (DQ250 / 02E, DQ381, DQ500).",
          "pt": "Apenas automóveis com DSG de 7 velocidades com embraiagens a seco (DQ200, códigos de caixa 0AM / 0CW / 0BM). Não se aplica a caixas manuais nem a DSG com embraiagens em banho de óleo (DQ250 / 02E, DQ381, DQ500).",
          "ru": "Только машины с 7-ступенчатой DSG с сухими сцеплениями (DQ200, коды КПП 0AM / 0CW / 0BM). Не относится к механическим коробкам и к DSG с мокрыми сцеплениями (DQ250 / 02E, DQ381, DQ500).",
          "uk": "Лише машини із 7-ступінчастою DSG із сухими зчепленнями (DQ200, коди КПП 0AM / 0CW / 0BM). Не стосується механічних коробок і DSG з мокрими зчепленнями (DQ250 / 02E, DQ381, DQ500).",
          "fr": "Uniquement les véhicules équipés de la DSG 7 rapports à embrayages à sec (DQ200, codes de boîte 0AM / 0CW / 0BM). Ne concerne ni les boîtes manuelles ni les DSG à embrayages humides (DQ250 / 02E, DQ381, DQ500)."
        },
        "notes": {
          "en": "The gearbox codes come from secondary sources (0CW is described as a revised version from 2013; 0BM is the code used on some Audi models). Campaign build windows differ by market, for example Germany 2008 to May 2011 and October 2012 to April 2013. A 2019 Australian accumulator recall is not included because its notice does not name the gearbox type.",
          "pt": "Os códigos de caixa vêm de fontes secundárias (a 0CW é descrita como versão revista desde 2013; a 0BM é o código usado em alguns modelos Audi). Os períodos de fabrico abrangidos pelas campanhas variam por mercado, por exemplo na Alemanha de 2008 a maio de 2011 e de outubro de 2012 a abril de 2013. Uma chamada australiana de 2019 relativa ao acumulador não é incluída porque a nota não indica o tipo de caixa.",
          "ru": "Коды КПП взяты из вторичных источников (0CW описывается как доработанная версия с 2013 года; 0BM — код, используемый на некоторых моделях Audi). Периоды выпуска, охваченные кампаниями, зависят от рынка: например, в Германии 2008–05.2011 и 10.2012–04.2013. Австралийский отзыв 2019 года по гидроаккумулятору не включён: в уведомлении тип КПП не указан.",
          "uk": "Коди КПП узято з вторинних джерел (0CW описується як доопрацьована версія з 2013 року; 0BM — код, що використовується на деяких моделях Audi). Періоди випуску, охоплені кампаніями, залежать від ринку: наприклад, у Німеччині 2008–05.2011 і 10.2012–04.2013. Австралійське відкликання 2019 року щодо гідроакумулятора не включено: у повідомленні тип КПП не вказано.",
          "fr": "Les codes de boîte proviennent de sources secondaires (0CW est décrite comme une version révisée à partir de 2013 ; 0BM est le code utilisé sur certains modèles Audi). Les périodes de production couvertes par les campagnes varient selon le marché, par exemple en Allemagne de 2008 à mai 2011 et d'octobre 2012 à avril 2013. Un rappel australien de 2019 portant sur l'accumulateur n'est pas repris car sa notice ne précise pas le type de boîte."
        }
      },
      "severity": "major",
      "safety": true,
      "critical": false,
      "symptoms": [
        {
          "id": "s1",
          "stage": "early",
          "text": {
            "en": "Judder or shudder when pulling away",
            "pt": "Trepidação ao arrancar",
            "ru": "Рывки или вибрация при трогании",
            "uk": "Ривки або вібрація під час рушання",
            "fr": "À-coups ou broutement au démarrage"
          }
        },
        {
          "id": "s2",
          "stage": "early",
          "text": {
            "en": "Clunk or rattle at standstill or on load change",
            "pt": "Pancada ou ruído parado ou na mudança de carga",
            "ru": "Удар или дребезг на месте или при смене нагрузки",
            "uk": "Удар або деренчання на місці чи під час зміни навантаження",
            "fr": "Claquement ou cliquetis à l'arrêt ou lors des changements de charge"
          }
        },
        {
          "id": "s3",
          "stage": "late",
          "text": {
            "en": "Gear not engaging, or sudden loss of drive",
            "pt": "Mudança que não entra ou perda súbita de tração",
            "ru": "Передача не включается или внезапная потеря тяги",
            "uk": "Передача не вмикається або раптова втрата тяги",
            "fr": "Rapport qui ne s'engage pas ou perte soudaine de motricité"
          }
        },
        {
          "id": "s4",
          "stage": "late",
          "text": {
            "en": "Gearbox warning light or flashing gear indicator",
            "pt": "Luz de aviso da caixa ou indicador de mudança a piscar",
            "ru": "Лампа неисправности КПП или мигающий индикатор передач",
            "uk": "Лампа несправності КПП або блимаючий індикатор передач",
            "fr": "Voyant de boîte ou indicateur de rapport clignotant"
          }
        }
      ],
      "inspection": [
        {
          "id": "i1",
          "method": "document",
          "tools": [],
          "text": {
            "en": "Confirm the gearbox is a DQ200: read the code (0AM / 0CW / 0BM) on the gearbox housing or from a dealer VIN query. Wet-clutch DSGs (DQ250, DQ381, DQ500) are different units.",
            "pt": "Confirme que a caixa é uma DQ200: leia o código (0AM / 0CW / 0BM) na carcaça da caixa ou numa consulta do VIN no concessionário. As DSG com embraiagens em banho de óleo (DQ250, DQ381, DQ500) são unidades diferentes.",
            "ru": "Убедитесь, что стоит DQ200: код (0AM / 0CW / 0BM) на корпусе КПП или по запросу VIN у дилера. DSG с мокрыми сцеплениями (DQ250, DQ381, DQ500) — другие агрегаты.",
            "uk": "Переконайтеся, що стоїть DQ200: код (0AM / 0CW / 0BM) на корпусі КПП або за запитом VIN у дилера. DSG з мокрими зчепленнями (DQ250, DQ381, DQ500) — інші агрегати.",
            "fr": "Vérifiez qu'il s'agit d'une DQ200 : lisez le code (0AM / 0CW / 0BM) sur le carter de boîte ou via une requête VIN chez le concessionnaire. Les DSG à embrayages humides (DQ250, DQ381, DQ500) sont d'autres boîtes."
          },
          "redFlag": null
        },
        {
          "id": "i2",
          "method": "document",
          "tools": [],
          "text": {
            "en": "Check recall and campaign status by VIN and ask whether the 2013 oil and software measure was done.",
            "pt": "Verifique o estado de chamadas e campanhas pelo VIN e pergunte se a medida de 2013 (óleo e software) foi realizada.",
            "ru": "Проверьте по VIN статус отзывов и кампаний и уточните, выполнено ли мероприятие 2013 года (масло и ПО).",
            "uk": "Перевірте за VIN статус відкликань і кампаній та з'ясуйте, чи виконано захід 2013 року (олива та ПЗ).",
            "fr": "Vérifiez par le VIN l'état des rappels et campagnes et demandez si l'action de 2013 (huile et logiciel) a été réalisée."
          },
          "redFlag": {
            "en": "Open campaign, or no record on a car built 2008–2013.",
            "pt": "Campanha pendente, ou sem registo num automóvel fabricado entre 2008 e 2013.",
            "ru": "Кампания не закрыта или нет записей для машины 2008–2013 годов выпуска.",
            "uk": "Кампанія не закрита або немає записів для машини 2008–2013 років випуску.",
            "fr": "Campagne ouverte, ou aucune trace sur un véhicule produit entre 2008 et 2013."
          }
        },
        {
          "id": "i3",
          "method": "obd",
          "tools": [
            "ODIS",
            "VCDS"
          ],
          "text": {
            "en": "Read the gearbox fault memory (P17BF, P189C, P1895) and, with a suitable tester, hydraulic pressure build-up and clutch adaptation values.",
            "pt": "Leia a memória de avarias da caixa (P17BF, P189C, P1895) e, com um equipamento adequado, a subida de pressão hidráulica e os valores de adaptação da embraiagem.",
            "ru": "Считайте память ошибок КПП (P17BF, P189C, P1895) и подходящим тестером — нарастание давления гидравлики и адаптации сцеплений.",
            "uk": "Зчитайте пам'ять помилок КПП (P17BF, P189C, P1895) і відповідним тестером — наростання тиску гідравліки та адаптації зчеплень.",
            "fr": "Lisez la mémoire de défauts de la boîte (P17BF, P189C, P1895) et, avec un outil adapté, la montée en pression hydraulique et les valeurs d'adaptation d'embrayage."
          },
          "redFlag": {
            "en": "Pressure-loss or clutch fault codes: price in a mechatronic or clutch repair.",
            "pt": "Códigos de perda de pressão ou de embraiagem: inclua no preço uma reparação da mecatrónica ou da embraiagem.",
            "ru": "Ошибки потери давления или сцепления — заложите в цену ремонт мехатроника или сцепления.",
            "uk": "Помилки втрати тиску чи зчеплення — закладіть у ціну ремонт мехатроніка або зчеплення.",
            "fr": "Codes de perte de pression ou d'embrayage : intégrez dans le prix une réparation du mécatronique ou de l'embrayage."
          }
        },
        {
          "id": "i4",
          "method": "test_drive",
          "tools": [],
          "text": {
            "en": "Test drive in stop-and-go traffic and pull away on a slope: feel for judder, clunks, hesitation, gears not engaging or a flashing gear indicator.",
            "pt": "Faça um ensaio em pára-arranca e arranque numa subida: atenção a trepidação, pancadas, hesitação, mudanças que não entram ou indicador de mudança a piscar.",
            "ru": "Проедьте в режиме «старт-стоп» и тронитесь в горку: обратите внимание на рывки, удары, задержки, невключение передач или мигающий индикатор.",
            "uk": "Проїдьте в режимі «старт-стоп» і рушайте вгору: зверніть увагу на ривки, удари, затримки, невмикання передач або блимаючий індикатор.",
            "fr": "Faites un essai en circulation urbaine et un démarrage en côte : à-coups, claquements, hésitations, rapports qui ne passent pas ou indicateur clignotant."
          },
          "redFlag": {
            "en": "Any judder or delayed engagement.",
            "pt": "Qualquer trepidação ou engate atrasado.",
            "ru": "Любые рывки или запаздывание включения.",
            "uk": "Будь-які ривки або запізнення вмикання.",
            "fr": "Tout à-coup ou engagement retardé."
          }
        }
      ],
      "repair": {
        "remedy": {
          "en": "Depending on the fault: mechatronic replacement (the remedy in the Hong Kong recall) or repair kit (US recall 19V866), clutch replacement, then software update and adaptation.",
          "pt": "Consoante a avaria: substituição da mecatrónica (solução da chamada de Hong Kong) ou kit de reparação (chamada 19V866 nos EUA), substituição da embraiagem, seguida de atualização de software e adaptação.",
          "ru": "В зависимости от неисправности: замена мехатроника (мера по отзыву в Гонконге) или ремкомплект (отзыв 19V866 в США), замена сцепления, затем обновление ПО и адаптация.",
          "uk": "Залежно від несправності: заміна мехатроніка (захід за відкликанням у Гонконзі) або ремкомплект (відкликання 19V866 у США), заміна зчеплення, потім оновлення ПЗ і адаптація.",
          "fr": "Selon le défaut : remplacement du mécatronique (remède du rappel de Hong Kong) ou kit de réparation (rappel 19V866 aux États-Unis), remplacement de l'embrayage, puis mise à jour logicielle et adaptation."
        },
        "cost": null,
        "worstCase": null,
        "manufacturerProgramme": {
          "evidence": [
            "ev_dq_e06",
            "ev_dq_e07",
            "ev_dq_e08"
          ],
          "text": {
            "en": "In November 2013 Volkswagen announced a change from synthetic to mineral gearbox oil for DQ200 units, with a software update (about 257,000 cars in Germany; about 1.8 million worldwide according to L'argus); in Germany and France this was done at workshop visits, not as an official recall. In Russia, Volkswagen offered a 5-year / 150,000 km DSG warranty from summer 2012, not applied to cars built from 1 January 2014.",
            "pt": "Em novembro de 2013 a Volkswagen anunciou a troca do óleo sintético da caixa por óleo mineral nas DQ200, com atualização de software (cerca de 257 000 automóveis na Alemanha; cerca de 1,8 milhões no mundo, segundo o L'argus); na Alemanha e em França isto foi feito nas visitas à oficina, não como chamada oficial. Na Rússia, a Volkswagen ofereceu a partir do verão de 2012 uma garantia de 5 anos / 150 000 km para a DSG, não aplicada aos automóveis fabricados a partir de 1 de janeiro de 2014.",
            "ru": "В ноябре 2013 года Volkswagen объявила о замене синтетического масла КПП минеральным на DQ200 с обновлением ПО (около 257 000 машин в Германии; около 1,8 млн в мире по данным L'argus); в Германии и Франции это делалось при визитах в сервис, а не как официальный отзыв. В России Volkswagen с лета 2012 года давала гарантию на DSG 5 лет / 150 000 км; на машины выпуска с 1 января 2014 года она не распространялась.",
            "uk": "У листопаді 2013 року Volkswagen оголосила про заміну синтетичної оливи КПП мінеральною на DQ200 з оновленням ПЗ (близько 257 000 машин у Німеччині; близько 1,8 млн у світі за даними L'argus); у Німеччині та Франції це робилося під час візитів до сервісу, а не як офіційне відкликання. У Росії Volkswagen з літа 2012 року давала гарантію на DSG 5 років / 150 000 км; на машини випуску з 1 січня 2014 року вона не поширювалася.",
            "fr": "En novembre 2013, Volkswagen a annoncé le remplacement de l'huile synthétique de boîte par une huile minérale sur les DQ200, avec une mise à jour logicielle (environ 257 000 voitures en Allemagne ; environ 1,8 million dans le monde selon L'argus) ; en Allemagne et en France, cela s'est fait lors des passages à l'atelier et non par un rappel officiel. En Russie, Volkswagen a proposé dès l'été 2012 une garantie DSG de 5 ans / 150 000 km, non appliquée aux véhicules produits à partir du 1er janvier 2014."
          }
        }
      },
      "evidence": [
        "ev_dq_e01",
        "ev_dq_e02",
        "ev_dq_e03",
        "ev_dq_e04",
        "ev_dq_e06",
        "ev_dq_e07",
        "ev_dq_e08",
        "ev_dq_e11",
        "ev_dq_e12",
        "ev_dq_e14",
        "ev_dq_e15"
      ],
      "prevalence": [
        "pv_dq_none",
        "pv_dq_13v568",
        "pv_dq_19v866"
      ]
    },
    {
      "id": "n47.chain",
      "aliases": [],
      "status": "published",
      "replacedBy": null,
      "revision": 1,
      "updatedAt": "2026-10-13",
      "legacyRule": "bmw-known-issues",
      "title": {
        "en": "BMW N47 2.0 diesel: rear timing chain wear and failure",
        "pt": "BMW N47 2.0 diesel: desgaste e rotura da corrente de distribuição traseira",
        "ru": "BMW N47 2.0 дизель: износ и обрыв цепи ГРМ (со стороны КПП)",
        "uk": "BMW N47 2.0 дизель: знос і обрив ланцюга ГРМ (з боку КПП)",
        "fr": "BMW N47 2.0 diesel : usure et rupture de la chaîne de distribution arrière"
      },
      "summary": {
        "en": "BMW ran a workshop campaign in 2015 (0011540300) fitting a new chain tensioner to N47 2.0 diesels built up to the end of 2008. On the N47 2.0 diesel the timing chain sits at the gearbox end of the engine; sources describe wear of the chain, guide rails or tensioner, a chain that lengthens and rattles and, in extreme cases, engine damage.",
        "pt": "A BMW realizou em 2015 uma campanha de oficina (0011540300) que montou um novo tensor da corrente nos N47 2.0 diesel fabricados até ao fim de 2008. No N47 2.0 diesel a corrente de distribuição fica do lado da caixa de velocidades; as fontes descrevem desgaste da corrente, das guias ou do tensor, uma corrente que alonga e faz ruído e, em casos extremos, danos no motor.",
        "ru": "В 2015 году BMW провела сервисную кампанию (0011540300) с установкой нового натяжителя цепи на дизели N47 2.0, выпущенные до конца 2008 года. На дизеле N47 2.0 цепь ГРМ расположена со стороны КПП; в источниках описаны износ цепи, направляющих или натяжителя, вытягивание цепи с шумом и, в крайних случаях, повреждение двигателя.",
        "uk": "У 2015 році BMW провела сервісну кампанію (0011540300) із встановленням нового натягувача ланцюга на дизелі N47 2.0, випущені до кінця 2008 року. На дизелі N47 2.0 ланцюг ГРМ розташований з боку КПП; у джерелах описано знос ланцюга, напрямних чи натягувача, витягування ланцюга з шумом і, в крайніх випадках, пошкодження двигуна.",
        "fr": "BMW a mené en 2015 une campagne atelier (0011540300) montant un nouveau tendeur de chaîne sur les N47 2.0 diesel produits jusqu'à fin 2008. Sur le N47 2.0 diesel, la chaîne de distribution est côté boîte de vitesses ; les sources décrivent une usure de la chaîne, des guides ou du tendeur, une chaîne qui s'allonge et cliquette et, dans les cas extrêmes, des dégâts au moteur."
      },
      "checklistPrompt": {
        "en": "N47 diesel timing chain (rear of engine) — check for stretch and rattle",
        "pt": "Corrente N47 diesel (traseira do motor) — verificar alongamento e ruído",
        "ru": "Цепь ГРМ дизеля N47 (со стороны КПП) — проверить вытягивание и шум",
        "uk": "Ланцюг ГРМ дизеля N47 (з боку КПП) — перевірити витягування й шум",
        "fr": "Chaîne de distribution du diesel N47 (côté boîte) — vérifier allongement et cliquetis"
      },
      "component": "engine.timing.chain",
      "mechanism": {
        "en": "A timing chain at the transmission end drives the camshafts. Wear of the chain, the sprockets, the guide rails or the tensioner lets the chain lengthen; early engines had sharp-edged sprockets, and BMW introduced a new crankshaft part number from January 2009. The lengthened chain rattles and the timing can drift; in extreme cases the engine can be severely damaged. Because the chain is at the rear, the replacement is extensive work. According to a BMW workshop note as reported by L'argus, the risk is higher if maintenance was missed or oils of variable quality were used.",
        "pt": "Uma corrente de distribuição do lado da caixa aciona as árvores de cames. O desgaste da corrente, das rodas dentadas, das guias ou do tensor deixa a corrente alongar; os primeiros motores tinham rodas dentadas de arestas vivas e a BMW introduziu uma nova referência de cambota a partir de janeiro de 2009. A corrente alongada faz ruído e a calagem pode desviar-se; em casos extremos o motor pode sofrer danos graves. Como a corrente fica atrás, a substituição é uma intervenção extensa. Segundo uma nota de oficina da BMW referida pelo L'argus, o risco é maior se a manutenção não foi cumprida ou se foram usados óleos de qualidade variável.",
        "ru": "Распредвалы приводит цепь со стороны КПП. Износ цепи, звёздочек, направляющих или натяжителя приводит к вытягиванию цепи; у ранних моторов были острокромочные звёздочки, а с января 2009 года BMW ввела новый номер коленвала. Вытянутая цепь гремит, фазы могут смещаться; в крайних случаях возможны серьёзные повреждения двигателя. Так как цепь расположена сзади, замена — объёмная работа. По сервисной записке BMW, о которой пишет L'argus, риск выше при пропущенном ТО или масле переменного качества.",
        "uk": "Розподільні вали приводить ланцюг з боку КПП. Знос ланцюга, зірочок, напрямних або натягувача призводить до витягування ланцюга; у ранніх моторів були гострокромкові зірочки, а з січня 2009 року BMW запровадила новий номер колінчастого вала. Витягнутий ланцюг гримить, фази можуть зміщуватися; у крайніх випадках можливе серйозне пошкодження двигуна. Оскільки ланцюг розташований ззаду, заміна — об'ємна робота. За сервісною запискою BMW, про яку пише L'argus, ризик вищий за пропущеного ТО або оливи змінної якості.",
        "fr": "Une chaîne de distribution côté boîte de vitesses entraîne les arbres à cames. L'usure de la chaîne, des pignons, des guides ou du tendeur laisse la chaîne s'allonger ; les premiers moteurs avaient des pignons à arêtes vives et BMW a introduit une nouvelle référence de vilebrequin à partir de janvier 2009. La chaîne allongée cliquette et le calage peut dériver ; dans les cas extrêmes, le moteur peut subir de graves dommages. La chaîne étant à l'arrière, le remplacement est une intervention importante. D'après une note atelier BMW rapportée par L'argus, le risque est plus élevé si l'entretien n'a pas été respecté ou si des huiles de qualité variable ont été utilisées."
      },
      "applicability": {
        "models": [
          "bmw.1series",
          "bmw.2series",
          "bmw.3series",
          "bmw.5series",
          "bmw.x1",
          "bmw.x3"
        ],
        "when": {
          "all": [
            {
              "engine": {
                "ids": [
                  "bmw.n47d20"
                ]
              }
            },
            {
              "productionDate": {
                "from": "2007-03",
                "to": "2015-12"
              }
            }
          ]
        },
        "markets": [
          "EU"
        ],
        "hint": {
          "en": "Only BMW 2.0 diesels with the N47 engine (N47D20), built from March 2007 to about 2015 (sources give September 2014 or 2015). Petrol engines and the later B47 diesel are outside this entry.",
          "pt": "Apenas BMW 2.0 diesel com motor N47 (N47D20), fabricados entre março de 2007 e cerca de 2015 (as fontes indicam setembro de 2014 ou 2015). Os motores a gasolina e o diesel B47 posterior ficam fora desta entrada.",
          "ru": "Только BMW 2.0 дизель с двигателем N47 (N47D20), выпущенные с марта 2007 примерно по 2015 год (источники называют сентябрь 2014 или 2015 год). Бензиновые моторы и более поздний дизель B47 в эту запись не входят.",
          "uk": "Лише BMW 2.0 дизель з двигуном N47 (N47D20), випущені з березня 2007 приблизно по 2015 рік (джерела називають вересень 2014 або 2015 рік). Бензинові мотори та пізніший дизель B47 до цього запису не входять.",
          "fr": "Uniquement les BMW 2.0 diesel à moteur N47 (N47D20) produites de mars 2007 à 2015 environ (les sources indiquent septembre 2014 ou 2015). Les moteurs essence et le diesel B47 ultérieur ne relèvent pas de cette fiche."
        },
        "notes": {
          "en": "BMW splits production into bands: before 5 January 2009 (the cars that, according to BMW, did not receive later improvements; covered by the 2015 campaign up to the end of 2008), 5 January 2009 to 1 March 2011, and later. Other N47 variants (1.6 N47D16, N47S, N47T) are not confirmed by the sources used here. No official recall specifically for the chain was identified in the sources used here. According to a legal trade report, a German appeal court (OLG Frankfurt am Main, 2017) treated chain noise on its own as a comfort issue, not a substantial defect. The end of production is given as September 2014 by one encyclopedia entry and as 2015 by two magazines.",
          "pt": "A BMW divide a produção em faixas: antes de 5 de janeiro de 2009 (os automóveis que, segundo a BMW, não receberam as melhorias posteriores; abrangidos pela campanha de 2015 até ao fim de 2008), de 5 de janeiro de 2009 a 1 de março de 2011, e posteriores. Outras variantes do N47 (1.6 N47D16, N47S, N47T) não são confirmadas pelas fontes aqui usadas. Nas fontes aqui usadas não foi identificada nenhuma chamada oficial específica para a corrente. Segundo uma publicação jurídica, um tribunal de recurso alemão (OLG Frankfurt am Main, 2017) considerou o ruído da corrente, por si só, uma questão de conforto e não um defeito substancial. O fim da produção é indicado como setembro de 2014 por uma enciclopédia e como 2015 por duas revistas.",
          "ru": "BMW делит выпуск на периоды: до 5 января 2009 года (машины, которые, по словам BMW, не получили последующих улучшений; кампания 2015 года охватила выпуск до конца 2008 года), с 5 января 2009 по 1 марта 2011 года и позже. Другие версии N47 (1.6 N47D16, N47S, N47T) использованными источниками не подтверждены. В использованных источниках официального отзыва именно по цепи не обнаружено. По данным юридического издания, апелляционный суд Германии (OLG Frankfurt am Main, 2017) счёл сам по себе шум цепи вопросом комфорта, а не существенным дефектом. Окончание производства указано как сентябрь 2014 года в одной энциклопедии и как 2015 год в двух журналах.",
          "uk": "BMW ділить випуск на періоди: до 5 січня 2009 року (машини, які, за словами BMW, не отримали подальших покращень; кампанія 2015 року охопила випуск до кінця 2008 року), з 5 січня 2009 по 1 березня 2011 року і пізніше. Інші версії N47 (1.6 N47D16, N47S, N47T) використаними джерелами не підтверджено. У використаних джерелах офіційного відкликання саме щодо ланцюга не виявлено. За даними юридичного видання, апеляційний суд Німеччини (OLG Frankfurt am Main, 2017) визнав сам по собі шум ланцюга питанням комфорту, а не суттєвим дефектом. Закінчення виробництва вказано як вересень 2014 року в одній енциклопедії та як 2015 рік у двох журналах.",
          "fr": "BMW découpe la production en plages : avant le 5 janvier 2009 (véhicules qui, selon BMW, n'ont pas bénéficié des améliorations ultérieures ; couverts par la campagne 2015 jusqu'à fin 2008), du 5 janvier 2009 au 1er mars 2011, et après. Les autres variantes du N47 (1.6 N47D16, N47S, N47T) ne sont pas confirmées par les sources utilisées ici. Aucun rappel officiel portant spécifiquement sur la chaîne n'a été identifié dans les sources utilisées ici. Selon une revue juridique spécialisée, une cour d'appel allemande (OLG Frankfurt am Main, 2017) a jugé que le bruit de chaîne, à lui seul, relevait du confort et non d'un défaut substantiel. La fin de production est indiquée comme septembre 2014 par une encyclopédie et comme 2015 par deux magazines."
        }
      },
      "severity": "critical",
      "safety": false,
      "critical": true,
      "symptoms": [
        {
          "id": "s1",
          "stage": "early",
          "text": {
            "en": "Metallic rattle at cold start, often for a few seconds",
            "pt": "Ruído metálico no arranque a frio, muitas vezes durante alguns segundos",
            "ru": "Металлический стук при холодном пуске, часто несколько секунд",
            "uk": "Металевий стук під час холодного пуску, часто кілька секунд",
            "fr": "Claquement métallique au démarrage à froid, souvent quelques secondes"
          }
        },
        {
          "id": "s2",
          "stage": "early",
          "text": {
            "en": "Scraping or grinding from the rear of the engine around 1,500 rpm",
            "pt": "Ruído de raspagem na parte traseira do motor por volta das 1 500 rpm",
            "ru": "Скрежет со стороны задней части двигателя около 1 500 об/мин",
            "uk": "Скрегіт із задньої частини двигуна близько 1 500 об/хв",
            "fr": "Raclement à l'arrière du moteur vers 1 500 tr/min"
          }
        },
        {
          "id": "s3",
          "stage": "late",
          "text": {
            "en": "Engine warning light, loss of power or hard starting",
            "pt": "Luz de avaria do motor, perda de potência ou arranque difícil",
            "ru": "Лампа неисправности двигателя, потеря мощности или трудный пуск",
            "uk": "Лампа несправності двигуна, втрата потужності або важкий пуск",
            "fr": "Voyant moteur, perte de puissance ou démarrage difficile"
          }
        }
      ],
      "inspection": [
        {
          "id": "i1",
          "method": "document",
          "tools": [],
          "text": {
            "en": "Confirm the N47 engine and the build date (door-pillar label or dealer VIN query) and place the car in BMW's bands: before 5 January 2009, up to 1 March 2011, or later.",
            "pt": "Confirme o motor N47 e a data de fabrico (etiqueta do pilar da porta ou consulta do VIN no concessionário) e situe o automóvel nas faixas da BMW: antes de 5 de janeiro de 2009, até 1 de março de 2011, ou depois.",
            "ru": "Уточните, что стоит N47, и дату выпуска (наклейка в проёме двери или запрос VIN у дилера); определите период по BMW: до 5 января 2009, до 1 марта 2011 или позже.",
            "uk": "Уточніть, що стоїть N47, і дату випуску (наліпка в отворі дверей або запит VIN у дилера); визначте період за BMW: до 5 січня 2009, до 1 березня 2011 або пізніше.",
            "fr": "Confirmez le moteur N47 et la date de fabrication (étiquette du montant de porte ou requête VIN chez le concessionnaire) et situez le véhicule dans les plages BMW : avant le 5 janvier 2009, jusqu'au 1er mars 2011, ou après."
          },
          "redFlag": {
            "en": "Built before 5 January 2009 with no record of chain work.",
            "pt": "Fabricado antes de 5 de janeiro de 2009 sem registo de intervenção na corrente.",
            "ru": "Выпуск до 5 января 2009 года и нет записей о работах с цепью.",
            "uk": "Випуск до 5 січня 2009 року і немає записів про роботи з ланцюгом.",
            "fr": "Produit avant le 5 janvier 2009 sans trace d'intervention sur la chaîne."
          }
        },
        {
          "id": "i2",
          "method": "document",
          "tools": [],
          "text": {
            "en": "Ask for the status of BMW campaign 0011540300 and for invoices of any chain, guide rail, tensioner or crankshaft work.",
            "pt": "Peça o estado da campanha BMW 0011540300 e as faturas de qualquer intervenção na corrente, guias, tensor ou cambota.",
            "ru": "Запросите статус кампании BMW 0011540300 и счета за любые работы с цепью, направляющими, натяжителем или коленвалом.",
            "uk": "Запитайте статус кампанії BMW 0011540300 і рахунки за будь-які роботи з ланцюгом, напрямними, натягувачем або колінчастим валом.",
            "fr": "Demandez l'état de la campagne BMW 0011540300 et les factures de toute intervention sur la chaîne, les guides, le tendeur ou le vilebrequin."
          },
          "redFlag": {
            "en": "No chain work on record for a car built before 2009: price the repair in.",
            "pt": "Sem intervenção na corrente registada num automóvel anterior a 2009: inclua a reparação no preço.",
            "ru": "Для машины до 2009 года нет записей о работах с цепью — заложите ремонт в цену.",
            "uk": "Для машини до 2009 року немає записів про роботи з ланцюгом — закладіть ремонт у ціну.",
            "fr": "Aucune intervention sur la chaîne pour un véhicule antérieur à 2009 : intégrez la réparation dans le prix."
          }
        },
        {
          "id": "i3",
          "method": "listen",
          "tools": [],
          "text": {
            "en": "Start the engine from fully cold and listen at the rear of the engine for rattle, then for scraping around 1,500 rpm.",
            "pt": "Ponha o motor a trabalhar completamente frio e escute na parte traseira do motor se há ruído metálico e, depois, raspagem por volta das 1 500 rpm.",
            "ru": "Запустите полностью холодный двигатель и послушайте заднюю часть мотора: стук при пуске, затем скрежет около 1 500 об/мин.",
            "uk": "Запустіть повністю холодний двигун і послухайте задню частину мотора: стук під час пуску, потім скрегіт близько 1 500 об/хв.",
            "fr": "Démarrez le moteur complètement froid et écoutez l'arrière du moteur : claquement au démarrage, puis raclement vers 1 500 tr/min."
          },
          "redFlag": {
            "en": "Rattle or scraping: have a specialist check the chain before buying.",
            "pt": "Ruído ou raspagem: peça a um especialista para verificar a corrente antes de comprar.",
            "ru": "Стук или скрежет — до покупки проверьте цепь у специалиста.",
            "uk": "Стук або скрегіт — до купівлі перевірте ланцюг у фахівця.",
            "fr": "Claquement ou raclement : faites contrôler la chaîne par un spécialiste avant l'achat."
          }
        },
        {
          "id": "i4",
          "method": "document",
          "tools": [],
          "text": {
            "en": "Check the oil-change history: changes every 10,000–15,000 km rather than long-life intervals only.",
            "pt": "Verifique o histórico de mudanças de óleo: a cada 10 000–15 000 km, e não apenas com intervalos longos (long-life).",
            "ru": "Проверьте историю замены масла: каждые 10 000–15 000 км, а не только по увеличенным интервалам (long-life).",
            "uk": "Перевірте історію заміни оливи: кожні 10 000–15 000 км, а не лише за збільшеними інтервалами (long-life).",
            "fr": "Vérifiez l'historique des vidanges : tous les 10 000–15 000 km plutôt qu'uniquement aux intervalles longue durée."
          },
          "redFlag": {
            "en": "No oil history, or long-life intervals only.",
            "pt": "Sem histórico de óleo, ou apenas intervalos longos.",
            "ru": "Нет истории замены масла или только увеличенные интервалы.",
            "uk": "Немає історії заміни оливи або лише збільшені інтервали.",
            "fr": "Pas d'historique de vidange, ou uniquement des intervalles longue durée."
          }
        }
      ],
      "repair": {
        "remedy": {
          "en": "Replacement of both timing chains with guide rails, tensioners and seals; the work is extensive because the chain sits at the gearbox end of the engine.",
          "pt": "Substituição das duas correntes de distribuição, com guias, tensores e vedantes; a intervenção é extensa porque a corrente fica do lado da caixa de velocidades.",
          "ru": "Замена обеих цепей ГРМ с направляющими, натяжителями и уплотнениями; работа объёмная, так как цепь расположена со стороны КПП.",
          "uk": "Заміна обох ланцюгів ГРМ з напрямними, натягувачами та ущільненнями; робота об'ємна, бо ланцюг розташований з боку КПП.",
          "fr": "Remplacement des deux chaînes de distribution avec guides, tendeurs et joints ; l'intervention est importante car la chaîne est côté boîte de vitesses."
        },
        "cost": {
          "currency": "EUR",
          "low": 1500,
          "high": 2500,
          "asOf": "2026-03",
          "basis": {
            "en": "Germany: magazine range; a published workshop offer for the full chain job is about 1,850 EUR (about 550 EUR more on X models / all-wheel drive).",
            "pt": "Alemanha: intervalo indicado por uma revista; uma oferta publicada de uma oficina para o trabalho completo é de cerca de 1 850 EUR (cerca de 550 EUR a mais nos modelos X / tração integral).",
            "ru": "Германия: диапазон по данным журнала; опубликованное предложение мастерской на полный комплекс работ — около 1 850 EUR (около 550 EUR дороже для моделей X / полного привода).",
            "uk": "Німеччина: діапазон за даними журналу; опублікована пропозиція майстерні на повний комплекс робіт — близько 1 850 EUR (близько 550 EUR дорожче для моделей X / повного приводу).",
            "fr": "Allemagne : fourchette d'un magazine ; une offre publiée d'atelier pour l'intervention complète est d'environ 1 850 EUR (environ 550 EUR de plus sur les modèles X / transmission intégrale)."
          },
          "evidence": [
            "ev_bm_e09a",
            "ev_bm_e08"
          ]
        },
        "worstCase": null,
        "manufacturerProgramme": {
          "evidence": [
            "ev_bm_e01"
          ],
          "text": {
            "en": "BMW workshop campaign 0011540300 (network notified on 23 January 2015) fits a newly developed chain tensioner to cars built up to the end of 2008. In France, BMW's after-sales service told L'argus in 2015 that repair costs were covered close to 100% where maintenance had followed the manufacturer's recommendations.",
            "pt": "A campanha de oficina BMW 0011540300 (rede notificada a 23 de janeiro de 2015) monta um tensor da corrente desenvolvido de novo nos automóveis fabricados até ao fim de 2008. Em França, o serviço pós-venda da BMW disse ao L'argus, em 2015, que os custos de reparação eram cobertos em perto de 100% quando a manutenção tinha seguido as recomendações do fabricante.",
            "ru": "Сервисная кампания BMW 0011540300 (сеть уведомлена 23 января 2015 года): установка нового натяжителя цепи на машины выпуска до конца 2008 года. Во Франции послепродажная служба BMW в 2015 году сообщила L'argus, что расходы на ремонт покрываются почти на 100%, если ТО выполнялось по рекомендациям производителя.",
            "uk": "Сервісна кампанія BMW 0011540300 (мережу повідомлено 23 січня 2015 року): встановлення нового натягувача ланцюга на машини випуску до кінця 2008 року. У Франції післяпродажна служба BMW у 2015 році повідомила L'argus, що витрати на ремонт покриваються майже на 100%, якщо ТО виконувалося за рекомендаціями виробника.",
            "fr": "La campagne atelier BMW 0011540300 (réseau informé le 23 janvier 2015) monte un tendeur de chaîne nouvellement développé sur les véhicules produits jusqu'à fin 2008. En France, le service après-vente de BMW a indiqué à L'argus en 2015 une prise en charge des réparations proche de 100 % lorsque l'entretien avait suivi les préconisations du constructeur."
          }
        }
      },
      "evidence": [
        "ev_bm_e01",
        "ev_bm_e03",
        "ev_bm_e05",
        "ev_bm_e08",
        "ev_bm_e09a",
        "ev_bm_e09b",
        "ev_bm_e10",
        "ev_bm_e11"
      ],
      "prevalence": [
        "pv_n47_none"
      ]
    },
    {
      "id": "puretech.wetbelt",
      "aliases": [],
      "status": "published",
      "replacedBy": null,
      "revision": 1,
      "updatedAt": "2026-10-13",
      "legacyRule": "psa-known-issues",
      "title": {
        "en": "1.2 PureTech turbo (EB2DT / EB2DTS): wet timing belt degradation",
        "pt": "1.2 PureTech turbo (EB2DT / EB2DTS): degradação da correia de distribuição em banho de óleo",
        "ru": "1.2 PureTech турбо (EB2DT / EB2DTS): деградация «мокрого» ремня ГРМ",
        "uk": "1.2 PureTech турбо (EB2DT / EB2DTS): деградація «мокрого» ременя ГРМ",
        "fr": "1.2 PureTech turbo (EB2DT / EB2DTS) : dégradation de la courroie de distribution humide"
      },
      "summary": {
        "en": "Peugeot, Citroën and DS recalled 1.2 turbo petrol cars built from March 2013 to April 2017 (RappelConso A12/01505/20 and A12/01504/20) because material from the timing belt, which runs in engine oil, can damage the brake vacuum pump. A timing-kit supplier bulletin adds that belt residue can also plug the oil pump strainer, and consumer organisations report cases up to engine failure.",
        "pt": "A Peugeot, a Citroën e a DS chamaram automóveis 1.2 turbo a gasolina fabricados entre março de 2013 e abril de 2017 (RappelConso A12/01505/20 e A12/01504/20) porque o material da correia de distribuição, que trabalha em banho de óleo, pode danificar a bomba de vácuo dos travões. Um boletim de um fornecedor de kits de distribuição acrescenta que os resíduos da correia podem também obstruir o filtro da bomba de óleo, e organizações de consumidores referem casos que chegam à avaria total do motor.",
        "ru": "Peugeot, Citroën и DS отозвали бензиновые машины 1.2 турбо, выпущенные с марта 2013 по апрель 2017 года (RappelConso A12/01505/20 и A12/01504/20): материал ремня ГРМ, работающего в масле, может повредить вакуумный насос тормозов. Бюллетень поставщика комплектов ГРМ добавляет, что остатки ремня могут также забить сетку маслозаборника, а потребительские организации сообщают о случаях вплоть до отказа двигателя.",
        "uk": "Peugeot, Citroën і DS відкликали бензинові машини 1.2 турбо, випущені з березня 2013 по квітень 2017 року (RappelConso A12/01505/20 і A12/01504/20): матеріал ременя ГРМ, що працює в оливі, може пошкодити вакуумний насос гальм. Бюлетень постачальника комплектів ГРМ додає, що рештки ременя можуть також забити сітку оливоприймача, а споживчі організації повідомляють про випадки аж до відмови двигуна.",
        "fr": "Peugeot, Citroën et DS ont rappelé des véhicules 1.2 turbo essence produits de mars 2013 à avril 2017 (RappelConso A12/01505/20 et A12/01504/20) car le matériau de la courroie de distribution, qui baigne dans l'huile, peut endommager la pompe à vide du freinage. Un bulletin d'équipementier (kits de distribution) ajoute que les résidus de courroie peuvent aussi obstruer la crépine de la pompe à huile, et des associations de consommateurs font état de cas allant jusqu'à la défaillance du moteur."
      },
      "checklistPrompt": {
        "en": "PureTech 1.2 wet timing belt — can degrade and affect the oil system (check belt and oil)",
        "pt": "Correia em banho de óleo 1.2 PureTech — pode degradar-se e afetar o circuito de óleo (verificar correia e óleo)",
        "ru": "«Мокрый» ремень ГРМ PureTech 1.2 — может деградировать и влиять на систему смазки (проверить ремень и масло)",
        "uk": "«Мокрий» ремінь ГРМ PureTech 1.2 — може деградувати й впливати на систему мащення (перевірити ремінь і оливу)",
        "fr": "Courroie de distribution humide PureTech 1.2 — peut se dégrader et affecter le circuit d'huile (vérifier courroie et huile)"
      },
      "component": "engine.timing.belt",
      "mechanism": {
        "en": "The timing belt runs immersed in engine oil. According to a timing-kit supplier bulletin, oil diluted by fuel on short, mostly urban trips can become abrasive to the belt, and belt residue can plug the oil pump strainer, the variable valve timing solenoids and the brake vacuum pump. Reported effects include loss of oil pressure, camshaft and valve fouling and reduced brake assist; consumer organisations report cases up to engine failure. Stellantis attributes the problem to premature oil ageing under specific driving conditions and does not acknowledge a design defect.",
        "pt": "A correia de distribuição trabalha mergulhada no óleo do motor. Segundo um boletim de um fornecedor de kits de distribuição, o óleo diluído por combustível em trajetos curtos, sobretudo urbanos, pode tornar-se abrasivo para a correia, e os resíduos da correia podem obstruir o filtro da bomba de óleo, as eletroválvulas da distribuição variável e a bomba de vácuo dos travões. Os efeitos referidos incluem perda de pressão de óleo, sujidade nas árvores de cames e nas válvulas e menor assistência à travagem; organizações de consumidores referem casos que chegam à avaria total do motor. A Stellantis atribui o problema ao envelhecimento prematuro do óleo em condições de utilização específicas e não reconhece um defeito de conceção.",
        "ru": "Ремень ГРМ работает погружённым в моторное масло. По бюллетеню поставщика комплектов ГРМ, масло, разжиженное топливом при коротких, преимущественно городских поездках, может становиться абразивным для ремня, а остатки ремня могут забивать сетку маслозаборника, электроклапаны изменения фаз газораспределения и вакуумный насос тормозов. Среди сообщаемых последствий — падение давления масла, загрязнение распредвалов и клапанов и ослабление усилителя тормозов; потребительские организации сообщают о случаях вплоть до отказа двигателя. Stellantis объясняет проблему преждевременным старением масла в особых условиях эксплуатации и не признаёт конструктивного дефекта.",
        "uk": "Ремінь ГРМ працює зануреним у моторну оливу. За бюлетенем постачальника комплектів ГРМ, олива, розріджена паливом під час коротких, переважно міських поїздок, може ставати абразивною для ременя, а рештки ременя можуть забивати сітку оливоприймача, електроклапани зміни фаз газорозподілу та вакуумний насос гальм. Серед повідомлюваних наслідків — падіння тиску оливи, забруднення розподільних валів і клапанів та послаблення підсилювача гальм; споживчі організації повідомляють про випадки аж до відмови двигуна. Stellantis пояснює проблему передчасним старінням оливи в особливих умовах експлуатації та не визнає конструктивного дефекту.",
        "fr": "La courroie de distribution baigne dans l'huile moteur. Selon le bulletin d'un équipementier de kits de distribution, l'huile diluée par le carburant lors de trajets courts, surtout urbains, peut devenir abrasive pour la courroie, et les résidus de courroie peuvent obstruer la crépine de la pompe à huile, les électrovannes de distribution variable et la pompe à vide du freinage. Les effets signalés comprennent une baisse de pression d'huile, un encrassement des arbres à cames et des soupapes et une assistance de freinage réduite ; des associations de consommateurs font état de cas allant jusqu'à la défaillance du moteur. Stellantis attribue le problème à un vieillissement prématuré de l'huile dans des conditions d'utilisation particulières et ne reconnaît pas de défaut de conception."
      },
      "applicability": {
        "models": [
          "peugeot.208",
          "peugeot.2008",
          "peugeot.308",
          "peugeot.3008",
          "peugeot.5008",
          "peugeot.partner",
          "citroen.c3",
          "citroen.c3_picasso",
          "citroen.c4",
          "citroen.c4_cactus",
          "citroen.c4_picasso",
          "citroen.berlingo",
          "citroen.ds3",
          "citroen.ds4",
          "ds.ds3",
          "ds.ds4"
        ],
        "when": {
          "all": [
            {
              "engine": {
                "codes": [
                  "EB2DT",
                  "HNZ",
                  "EB2DTS",
                  "HNY"
                ]
              }
            },
            {
              "productionDate": {
                "from": "2013-03",
                "to": "2017-04"
              }
            }
          ]
        },
        "markets": [
          "EU"
        ],
        "hint": {
          "en": "Only the 1.2 turbo petrol engines EB2DT (HNZ, 110 hp) and EB2DTS (HNY, 130 hp) built from March 2013 to April 2017. Diesel engines, the naturally aspirated 1.2 and the chain-driven Gen3 1.2 are outside this entry.",
          "pt": "Apenas os motores 1.2 turbo a gasolina EB2DT (HNZ, 110 cv) e EB2DTS (HNY, 130 cv) fabricados entre março de 2013 e abril de 2017. Os motores diesel, o 1.2 atmosférico e o 1.2 Gen3 com corrente ficam fora desta entrada.",
          "ru": "Только бензиновые 1.2 турбо EB2DT (HNZ, 110 л. с.) и EB2DTS (HNY, 130 л. с.), выпущенные с марта 2013 по апрель 2017 года. Дизели, атмосферный 1.2 и цепной 1.2 Gen3 в эту запись не входят.",
          "uk": "Лише бензинові 1.2 турбо EB2DT (HNZ, 110 к. с.) і EB2DTS (HNY, 130 к. с.), випущені з березня 2013 по квітень 2017 року. Дизелі, атмосферний 1.2 і ланцюговий 1.2 Gen3 до цього запису не входять.",
          "fr": "Uniquement les moteurs 1.2 turbo essence EB2DT (HNZ, 110 ch) et EB2DTS (HNY, 130 ch) produits de mars 2013 à avril 2017. Les diesels, le 1.2 atmosphérique et le 1.2 Gen3 à chaîne ne relèvent pas de cette fiche."
        },
        "notes": {
          "en": "The recall records do not name the engine code; the link between codes and recall comes from a timing-kit supplier bulletin (NTN-SNR) and the press. Cars built from 2017 to 2020 were covered by a separate vacuum-pump lubrication recall whose records also do not name the engine; they are outside this entry until that link is confirmed. The belt interval was cut from 10 years / 180,000 km to 6 years / 100,000 km in December 2020 (supplier bulletin and specialist press). The extended warranty is given as 175,000 km by most sources and as 180,000 km by one.",
          "pt": "Os registos de chamada não indicam o código do motor; a ligação entre códigos e chamada vem de um boletim de um fornecedor de kits de distribuição (NTN-SNR) e da imprensa. Os automóveis fabricados entre 2017 e 2020 foram abrangidos por uma chamada separada por lubrificação da bomba de vácuo cujos registos também não indicam o motor; ficam fora desta entrada até essa ligação ser confirmada. O intervalo da correia foi reduzido de 10 anos / 180 000 km para 6 anos / 100 000 km em dezembro de 2020 (boletim do fornecedor e imprensa especializada). A garantia alargada é indicada como 175 000 km pela maioria das fontes e como 180 000 km por uma.",
          "ru": "В записях об отзыве код двигателя не указан; соответствие кодов и отзыва взято из бюллетеня поставщика комплектов ГРМ (NTN-SNR) и прессы. Машины 2017–2020 годов выпуска попали под отдельный отзыв по смазке вакуумного насоса, в записях которого двигатель тоже не назван; они не входят в эту запись, пока связь не подтверждена. Интервал замены ремня в декабре 2020 года сокращён с 10 лет / 180 000 км до 6 лет / 100 000 км (бюллетень поставщика и специализированная пресса). Продлённую гарантию большинство источников указывает как 175 000 км, один — как 180 000 км.",
          "uk": "У записах про відкликання код двигуна не вказано; відповідність кодів і відкликання взято з бюлетеня постачальника комплектів ГРМ (NTN-SNR) і преси. Машини 2017–2020 років випуску потрапили під окреме відкликання щодо змащення вакуумного насоса, у записах якого двигун теж не названо; вони не входять до цього запису, доки зв'язок не підтверджено. Інтервал заміни ременя в грудні 2020 року скорочено з 10 років / 180 000 км до 6 років / 100 000 км (бюлетень постачальника та спеціалізована преса). Продовжену гарантію більшість джерел вказує як 175 000 км, одне — як 180 000 км.",
          "fr": "Les fiches de rappel ne citent pas le code moteur ; la correspondance entre codes et rappel provient d'un bulletin d'un fournisseur de kits de distribution (NTN-SNR) et de la presse. Les véhicules produits de 2017 à 2020 ont fait l'objet d'un rappel distinct pour lubrification de la pompe à vide, dont les fiches ne nomment pas non plus le moteur ; ils ne relèvent pas de cette fiche tant que ce lien n'est pas confirmé. L'intervalle de la courroie a été ramené de 10 ans / 180 000 km à 6 ans / 100 000 km en décembre 2020 (bulletin du fournisseur et presse spécialisée). La garantie étendue est donnée à 175 000 km par la plupart des sources et à 180 000 km par une."
        }
      },
      "severity": "critical",
      "safety": true,
      "critical": true,
      "symptoms": [
        {
          "id": "s1",
          "stage": "early",
          "text": {
            "en": "Oil-pressure warning light",
            "pt": "Luz de aviso de pressão de óleo",
            "ru": "Лампа давления масла",
            "uk": "Лампа тиску оливи",
            "fr": "Voyant de pression d'huile"
          }
        },
        {
          "id": "s3",
          "stage": "early",
          "text": {
            "en": "Higher than usual oil consumption",
            "pt": "Consumo de óleo acima do habitual",
            "ru": "Повышенный расход масла",
            "uk": "Підвищена витрата оливи",
            "fr": "Consommation d'huile anormalement élevée"
          }
        },
        {
          "id": "s4",
          "stage": "late",
          "text": {
            "en": "Engine damage or failure in severe reported cases",
            "pt": "Danos ou avaria do motor em casos graves referidos",
            "ru": "Повреждение или отказ двигателя в тяжёлых из описанных случаев",
            "uk": "Пошкодження або відмова двигуна в тяжких із описаних випадків",
            "fr": "Dommages ou défaillance du moteur dans les cas graves signalés"
          }
        },
        {
          "id": "s6",
          "stage": "late",
          "text": {
            "en": "Hard brake pedal (reduced vacuum assist)",
            "pt": "Pedal de travão duro (menor assistência por vácuo)",
            "ru": "Тугая педаль тормоза (ослаб вакуумный усилитель)",
            "uk": "Туга педаль гальма (ослаб вакуумний підсилювач)",
            "fr": "Pédale de frein dure (assistance par dépression réduite)"
          }
        }
      ],
      "inspection": [
        {
          "id": "i1",
          "method": "document",
          "tools": [],
          "text": {
            "en": "Check the VIN on the manufacturer's recall lookup and ask for proof that the 2020 recall (Peugeot JZR, Citroën/DS HFC) was carried out.",
            "pt": "Verifique o VIN na consulta de chamadas do fabricante e peça prova de que a chamada de 2020 (Peugeot JZR, Citroën/DS HFC) foi executada.",
            "ru": "Проверьте VIN в сервисе отзывов производителя и попросите подтверждение, что отзыв 2020 года (Peugeot JZR, Citroën/DS HFC) выполнен.",
            "uk": "Перевірте VIN у сервісі відкликань виробника та попросіть підтвердження, що відкликання 2020 року (Peugeot JZR, Citroën/DS HFC) виконано.",
            "fr": "Vérifiez le VIN sur le service de rappel du constructeur et demandez la preuve que le rappel de 2020 (Peugeot JZR, Citroën/DS HFC) a été effectué."
          },
          "redFlag": {
            "en": "Open recall, or no proof that it was done.",
            "pt": "Chamada pendente ou sem prova de execução.",
            "ru": "Отзыв не закрыт или нет подтверждения.",
            "uk": "Відкликання не закрите або немає підтвердження.",
            "fr": "Rappel ouvert ou aucune preuve de réalisation."
          }
        },
        {
          "id": "i2",
          "method": "document",
          "tools": [],
          "text": {
            "en": "Confirm the engine: belt-driven EB2DT / EB2DTS, or the chain-driven engine introduced in 2023, from the engine plate or the registration documents.",
            "pt": "Confirme o motor: EB2DT / EB2DTS com correia, ou o motor com corrente introduzido em 2023, pela placa do motor ou pelos documentos do veículo.",
            "ru": "Уточните двигатель: ременной EB2DT / EB2DTS или цепной, появившийся в 2023 году, — по табличке двигателя или документам.",
            "uk": "Уточніть двигун: ремінний EB2DT / EB2DTS або ланцюговий, що з'явився у 2023 році, — за табличкою двигуна чи документами.",
            "fr": "Identifiez le moteur : EB2DT / EB2DTS à courroie, ou le moteur à chaîne introduit en 2023, d'après la plaque moteur ou les papiers du véhicule."
          },
          "redFlag": null
        },
        {
          "id": "i3",
          "method": "tool",
          "tools": [
            "G-0109-6"
          ],
          "text": {
            "en": "Have the belt width checked through the oil filler opening with the manufacturer's gauge (G-0109-6).",
            "pt": "Peça a verificação da largura da correia pelo bocal de enchimento de óleo com o calibre do fabricante (G-0109-6).",
            "ru": "Попросите проверить ширину ремня через маслозаливную горловину калибром производителя (G-0109-6).",
            "uk": "Попросіть перевірити ширину ременя через оливозаливну горловину калібром виробника (G-0109-6).",
            "fr": "Faites contrôler la largeur de la courroie par l'orifice de remplissage d'huile avec la jauge du constructeur (G-0109-6)."
          },
          "redFlag": {
            "en": "Belt width outside the specification: belt (and vacuum pump) replacement due. A pass is a screening result only.",
            "pt": "Largura da correia fora da especificação: substituição da correia (e da bomba de vácuo) necessária. Passar no teste é apenas uma triagem.",
            "ru": "Ширина ремня вне нормы — нужна замена ремня (и вакуумного насоса). Прохождение проверки — лишь предварительный результат.",
            "uk": "Ширина ременя поза нормою — потрібна заміна ременя (і вакуумного насоса). Проходження перевірки — лише попередній результат.",
            "fr": "Largeur de courroie hors spécification : remplacement de la courroie (et de la pompe à vide) nécessaire. Un contrôle réussi n'est qu'un dépistage."
          }
        },
        {
          "id": "i4",
          "method": "document",
          "tools": [],
          "text": {
            "en": "Review the service history: oil and filter at least yearly with the recommended oil if the car does under 15,000 km a year, mostly on short trips, and the belt replaced within 6 years / 100,000 km.",
            "pt": "Analise o histórico de manutenção: óleo e filtro pelo menos uma vez por ano com o óleo recomendado se o automóvel faz menos de 15 000 km por ano, sobretudo em trajetos curtos, e correia substituída dentro de 6 anos / 100 000 km.",
            "ru": "Изучите историю ТО: замена масла и фильтра рекомендованным маслом не реже раза в год, если машина проезжает меньше 15 000 км в год в основном короткими поездками, и замена ремня в пределах 6 лет / 100 000 км.",
            "uk": "Перегляньте історію ТО: заміна оливи та фільтра рекомендованою оливою не рідше разу на рік, якщо машина проїжджає менше 15 000 км на рік переважно короткими поїздками, і заміна ременя в межах 6 років / 100 000 км.",
            "fr": "Examinez l'historique d'entretien : vidange et filtre au moins une fois par an avec l'huile préconisée si le véhicule roule moins de 15 000 km par an, surtout sur trajets courts, et courroie remplacée dans les 6 ans / 100 000 km."
          },
          "redFlag": {
            "en": "Missed yearly oil changes on such a car, or no belt replacement past 6 years / 100,000 km.",
            "pt": "Mudanças de óleo anuais em falta num automóvel assim, ou correia não substituída após 6 anos / 100 000 km.",
            "ru": "Пропущенные ежегодные замены масла на такой машине или ремень не менялся после 6 лет / 100 000 км.",
            "uk": "Пропущені щорічні заміни оливи на такій машині або ремінь не мінявся після 6 років / 100 000 км.",
            "fr": "Vidanges annuelles manquées sur un tel véhicule, ou courroie non remplacée au-delà de 6 ans / 100 000 km."
          }
        },
        {
          "id": "i5",
          "method": "obd",
          "tools": [
            "OBD scanner"
          ],
          "text": {
            "en": "Read the fault memory for engine faults and any oil-pressure alerts.",
            "pt": "Leia a memória de avarias à procura de avarias do motor e de alertas de pressão de óleo.",
            "ru": "Считайте память ошибок: неисправности двигателя и предупреждения о давлении масла.",
            "uk": "Зчитайте пам'ять помилок: несправності двигуна й попередження про тиск оливи.",
            "fr": "Lisez la mémoire de défauts : défauts moteur et alertes de pression d'huile."
          },
          "redFlag": {
            "en": "Any oil-pressure or valve-timing fault: have a workshop diagnose it before deciding to buy.",
            "pt": "Qualquer avaria de pressão de óleo ou de distribuição: peça um diagnóstico em oficina antes de decidir comprar.",
            "ru": "Любая ошибка давления масла или фаз газораспределения — до решения о покупке сделайте диагностику в сервисе.",
            "uk": "Будь-яка помилка тиску оливи чи фаз газорозподілу — перед рішенням про купівлю зробіть діагностику в сервісі.",
            "fr": "Tout défaut de pression d'huile ou de calage : faites faire un diagnostic en atelier avant de décider d'acheter."
          }
        },
        {
          "id": "i6",
          "method": "document",
          "tools": [],
          "text": {
            "en": "Ask about the service history and keep the invoices: the manufacturer's extended cover asks for maintenance to the recommended plan, with diagnosis and repair done in the brand network.",
            "pt": "Pergunte pelo histórico de manutenção e guarde as faturas: a cobertura alargada do fabricante pede manutenção segundo o plano recomendado, com diagnóstico e reparação feitos na rede da marca.",
            "ru": "Спросите историю обслуживания и сохраните счета: продлённое покрытие производителя предполагает ТО по рекомендованному плану, а диагностику и ремонт — в сети марки.",
            "uk": "Запитайте історію обслуговування й збережіть рахунки: продовжене покриття виробника передбачає ТО за рекомендованим планом, а діагностику й ремонт — у мережі марки.",
            "fr": "Demandez l'historique d'entretien et conservez les factures : la prise en charge étendue du constructeur suppose un entretien conforme au plan préconisé, avec diagnostic et réparation dans le réseau de la marque."
          },
          "redFlag": {
            "en": "Maintenance plan not followed, or repairs done outside the brand network: the extended cover may be refused.",
            "pt": "Plano de manutenção não cumprido, ou reparações feitas fora da rede da marca: a cobertura alargada pode ser recusada.",
            "ru": "План ТО не соблюдался или ремонт делали вне сети марки — в продлённом покрытии могут отказать.",
            "uk": "План ТО не дотримувався або ремонт робили поза мережею марки — у продовженому покритті можуть відмовити.",
            "fr": "Plan d'entretien non respecté, ou réparations faites hors du réseau de la marque : la prise en charge étendue peut être refusée."
          }
        }
      ],
      "repair": {
        "remedy": {
          "en": "Recall remedy: engine control unit update (earlier oil-pressure warning), belt width check, vacuum pump replacement, and cleaning or replacement of the oil pump strainer and timing solenoids as needed. The belt interval was reduced to 6 years / 100,000 km.",
          "pt": "Solução da chamada: atualização da unidade de controlo do motor (aviso de pressão de óleo mais cedo), verificação da largura da correia, substituição da bomba de vácuo e limpeza ou substituição do filtro da bomba de óleo e das eletroválvulas, conforme necessário. O intervalo da correia foi reduzido para 6 anos / 100 000 km.",
          "ru": "Мероприятия по отзыву: обновление ЭБУ двигателя (более раннее предупреждение о давлении масла), проверка ширины ремня, замена вакуумного насоса, при необходимости очистка или замена сетки маслозаборника и электроклапанов фаз. Интервал замены ремня сокращён до 6 лет / 100 000 км.",
          "uk": "Заходи за відкликанням: оновлення ЕБК двигуна (раніше попередження про тиск оливи), перевірка ширини ременя, заміна вакуумного насоса, за потреби очищення або заміна сітки оливоприймача й електроклапанів фаз. Інтервал заміни ременя скорочено до 6 років / 100 000 км.",
          "fr": "Remède du rappel : mise à jour du calculateur moteur (alerte de pression d'huile plus précoce), contrôle de la largeur de courroie, remplacement de la pompe à vide, et nettoyage ou remplacement de la crépine de pompe à huile et des électrovannes selon le cas. L'intervalle de la courroie a été ramené à 6 ans / 100 000 km."
        },
        "cost": null,
        "worstCase": null,
        "manufacturerProgramme": {
          "evidence": [
            "ev_pt_e09",
            "ev_pt_e10",
            "ev_pt_e12",
            "ev_pt_e13"
          ],
          "text": {
            "en": "Since 18 March 2024 Stellantis covers the belt and excess oil consumption up to 10 years or 175,000 km (one press report says 180,000 km), provided the maintenance plan was followed and diagnosis and repair are done in the brand network. A compensation platform opened on 16 January 2025 for repairs paid between 1 January 2022 and 31 December 2024.",
            "pt": "Desde 18 de março de 2024, a Stellantis cobre a correia e o consumo excessivo de óleo até 10 anos ou 175 000 km (uma notícia de imprensa indica 180 000 km), desde que o plano de manutenção tenha sido cumprido e o diagnóstico e a reparação sejam feitos na rede da marca. Uma plataforma de indemnização abriu a 16 de janeiro de 2025 para reparações pagas entre 1 de janeiro de 2022 e 31 de dezembro de 2024.",
            "ru": "С 18 марта 2024 года Stellantis покрывает ремень и повышенный расход масла до 10 лет или 175 000 км (в одной публикации — 180 000 км) при соблюдении плана ТО, диагностике и ремонте в сети марки. 16 января 2025 года открыта платформа компенсаций за ремонты, оплаченные с 1 января 2022 по 31 декабря 2024 года.",
            "uk": "З 18 березня 2024 року Stellantis покриває ремінь і підвищену витрату оливи до 10 років або 175 000 км (в одній публікації — 180 000 км) за дотримання плану ТО, діагностики й ремонту в мережі марки. 16 січня 2025 року відкрито платформу компенсацій за ремонти, оплачені з 1 січня 2022 по 31 грудня 2024 року.",
            "fr": "Depuis le 18 mars 2024, Stellantis prend en charge la courroie et la surconsommation d'huile jusqu'à 10 ans ou 175 000 km (un article de presse indique 180 000 km), à condition que le plan d'entretien ait été respecté et que le diagnostic et la réparation soient faits dans le réseau de la marque. Une plate-forme d'indemnisation a ouvert le 16 janvier 2025 pour les réparations payées entre le 1er janvier 2022 et le 31 décembre 2024."
          }
        }
      },
      "evidence": [
        "ev_pt_e01",
        "ev_pt_e02",
        "ev_pt_e03",
        "ev_pt_e04",
        "ev_pt_e05",
        "ev_pt_e06",
        "ev_pt_e07",
        "ev_pt_e08",
        "ev_pt_e09",
        "ev_pt_e10",
        "ev_pt_e12",
        "ev_pt_e13",
        "ev_pt_e14",
        "ev_pt_e17",
        "ev_pt_e18"
      ],
      "prevalence": [
        "pv_pt_none",
        "pv_pt_recall_fr",
        "pv_pt_claims"
      ]
    },
    {
      "id": "tsi.chain",
      "aliases": [],
      "status": "published",
      "replacedBy": null,
      "revision": 1,
      "updatedAt": "2026-10-13",
      "legacyRule": "vag-known-issues",
      "title": {
        "en": "VW group 1.2 / 1.4 TSI (EA111, timing chain): reported chain stretch and tensioner rattle on cold start",
        "pt": "1.2 / 1.4 TSI do grupo VW (EA111, corrente de distribuição): alongamento da corrente e ruído do tensor no arranque a frio referidos",
        "ru": "1.2 / 1.4 TSI группы VW (EA111, цепь ГРМ): сообщаемое растяжение цепи и стук натяжителя на холодном пуске",
        "uk": "1.2 / 1.4 TSI групи VW (EA111, ланцюг ГРМ): повідомлюване розтягування ланцюга та стукіт натягувача на холодному пуску",
        "fr": "1.2 / 1.4 TSI du groupe VW (EA111, chaîne de distribution) : allongement de chaîne et cliquetis du tendeur à froid signalés"
      },
      "summary": {
        "en": "AUTO BILD reported in 2018 that Volkswagen had admitted that the timing chain of its EA111 1.2 and 1.4 TSI petrol engines can stretch and skip, that a supplier was said to have used stamping tools beyond their wear limit, and that a 2012 goodwill promise for older cars had been withdrawn. In April 2012 the trade press, citing AUTO BILD, reported a production error that can let these chains stretch and skip, and a widening of Volkswagen's goodwill to 50 to 100% of parts and labour. A parts maker describes the 1.2 TSI built before October 2011 (CBZA, CBZB, CBZC) as prone to chain elongation and a revised kit from 2011. No official recall was identified. The sources describe start-up noise differently, so a repeated or longer rattle is worth a check.",
        "pt": "A AUTO BILD referiu em 2018 que a Volkswagen admitiu que a corrente de distribuição dos seus motores a gasolina EA111 1.2 e 1.4 TSI pode alongar e saltar, que um fornecedor terá usado ferramentas de estampagem além do limite de desgaste, e que uma promessa de boa vontade de 2012 para automóveis mais antigos foi retirada. Em abril de 2012 a imprensa técnica, citando a AUTO BILD, referiu um erro de produção que pode fazer estas correntes alongar e saltar, e o alargamento da boa vontade da Volkswagen a 50 a 100% de peças e mão de obra. Um fabricante de peças descreve o 1.2 TSI fabricado antes de outubro de 2011 (CBZA, CBZB, CBZC) como propenso a alongamento da corrente e um kit revisto desde 2011. Não foi identificada nenhuma chamada oficial. As fontes descrevem de forma diferente o ruído no arranque, pelo que um ruído repetido ou mais longo merece verificação.",
        "ru": "AUTO BILD в 2018 году сообщил, что Volkswagen признала возможность растяжения и перескока цепи ГРМ бензиновых моторов EA111 1.2 и 1.4 TSI, что причиной, по имеющимся сведениям, был поставщик, использовавший штамповочный инструмент сверх предела износа, и что обещание помощи 2012 года для старых машин отозвано. В апреле 2012 года отраслевая пресса со ссылкой на AUTO BILD сообщила о производственной ошибке, из-за которой эти цепи могут растягиваться и перескакивать, и о расширении помощи Volkswagen до 50-100% стоимости деталей и работы. Производитель запчастей описывает 1.2 TSI выпуска до октября 2011 года (CBZA, CBZB, CBZC) как склонный к растяжению цепи и доработанный комплект с 2011 года. Официального отзыва не найдено. Источники по-разному описывают шум при пуске, поэтому повторяющийся или более долгий стук стоит проверить.",
        "uk": "AUTO BILD у 2018 році повідомив, що Volkswagen визнала можливість розтягування та перескоку ланцюга ГРМ бензинових моторів EA111 1.2 і 1.4 TSI, що причиною, за наявними відомостями, був постачальник, який використовував штампувальний інструмент понад межу зносу, і що обіцянку допомоги 2012 року для старих машин скасовано. У квітні 2012 року галузева преса з посиланням на AUTO BILD повідомила про виробничу помилку, через яку ці ланцюги можуть розтягуватися й перескакувати, і про розширення допомоги Volkswagen до 50-100% вартості деталей і роботи. Виробник запчастин описує 1.2 TSI випуску до жовтня 2011 року (CBZA, CBZB, CBZC) як схильний до розтягування ланцюга та доопрацьований комплект із 2011 року. Офіційного відкликання не знайдено. Джерела по-різному описують шум під час пуску, тому повторюваний або довший стукіт варто перевірити.",
        "fr": "AUTO BILD a rapporté en 2018 que Volkswagen avait admis que la chaîne de distribution de ses moteurs essence EA111 1.2 et 1.4 TSI peut s'allonger et sauter, qu'un fournisseur aurait utilisé des outils d'estampage au-delà de leur limite d'usure, et qu'une promesse de geste commercial de 2012 pour les véhicules anciens avait été retirée. En avril 2012, la presse professionnelle, citant AUTO BILD, a fait état d'une erreur de production pouvant laisser ces chaînes s'allonger et sauter, et d'une extension du geste commercial de Volkswagen à 50 à 100 % des pièces et de la main-d'œuvre. Un équipementier décrit le 1.2 TSI produit avant octobre 2011 (CBZA, CBZB, CBZC) comme sujet à l'allongement de chaîne, et un kit révisé à partir de 2011. Aucun rappel officiel n'a été identifié. Les sources décrivent différemment le bruit au démarrage ; un cliquetis répété ou plus long mérite donc un contrôle."
      },
      "checklistPrompt": {
        "en": "Timing chain (1.2/1.4 TSI) — check for chain stretch and cold-start rattle",
        "pt": "Corrente de distribuição (1.2/1.4 TSI) — verificar alongamento e ruído no arranque a frio",
        "ru": "Цепь ГРМ (1.2/1.4 TSI) — проверить растяжение и стук на холодном пуске",
        "uk": "Ланцюг ГРМ (1.2/1.4 TSI) — перевірити розтягування та стукіт на холодному пуску",
        "fr": "Chaîne de distribution (1.2/1.4 TSI) — vérifier allongement et cliquetis à froid"
      },
      "component": "engine.timing.chain",
      "mechanism": {
        "en": "AUTO BILD (2018) reports that Volkswagen admitted the chain can stretch and skip, and that a supplier is said to have used stamping tools beyond their wear limit; a 2012 trade-press report, citing AUTO BILD, speaks of a production error. For 1.4 TSI engines a parts maker states that the series manufacturer reported quality problems with components (worn tools left burrs on the chain shells, causing premature chain wear) and that the manufacturer requires the newer camshaft adjusters (OE 03C 109 088 E); the parts maker also advises an engine control unit software update afterwards. For the 1.2 TSI the same maker describes a revised kit from 2011 with a wider chain, new guides, a larger tensioner and improved sprocket teeth. If a stretched chain skips teeth, valve timing is wrong; the sources describe uneven running, a possible warning light and, in the worst case, valves touching pistons with severe engine damage.",
        "pt": "A AUTO BILD (2018) refere que a Volkswagen admitiu que a corrente pode alongar e saltar, e que um fornecedor terá usado ferramentas de estampagem além do limite de desgaste; uma notícia da imprensa técnica de 2012, citando a AUTO BILD, fala de um erro de produção. Nos motores 1.4 TSI, um fabricante de peças afirma que o fabricante de série comunicou problemas de qualidade em componentes (ferramentas gastas deixaram rebarbas nas conchas da corrente, causando desgaste precoce) e que o fabricante exige os variadores de árvore de cames mais recentes (OE 03C 109 088 E); o fabricante de peças aconselha ainda uma atualização de software da unidade de comando do motor. No 1.2 TSI, o mesmo fabricante descreve um kit revisto desde 2011 com corrente mais larga, novas guias, tensor maior e dentes das rodas melhorados. Se uma corrente alongada saltar dentes, a distribuição fica incorreta; as fontes descrevem funcionamento irregular, possível luz de aviso e, no pior caso, válvulas a tocar nos pistões com danos graves no motor.",
        "ru": "AUTO BILD (2018) сообщает, что Volkswagen признала возможность растяжения и перескока цепи, а поставщик, по имеющимся сведениям, использовал штамповочный инструмент сверх предела износа; заметка отраслевой прессы 2012 года со ссылкой на AUTO BILD говорит о производственной ошибке. Для моторов 1.4 TSI производитель запчастей указывает, что серийный изготовитель сообщил о проблемах качества деталей (изношенный инструмент оставил заусенцы на башмаках цепи, что ведёт к преждевременному износу) и что изготовитель требует ставить новые фазовращатели распредвала (OE 03C 109 088 E); производитель запчастей также советует после этого обновить ПО блока управления двигателем. Для 1.2 TSI он же описывает доработанный комплект с 2011 года: более широкая цепь, новые успокоители, больший натяжитель, улучшенные зубья звёздочек. Если растянутая цепь перескакивает, фазы газораспределения нарушаются; источники описывают неровную работу, возможную лампу неисправности и в худшем случае касание клапанами поршней с тяжёлым повреждением двигателя.",
        "uk": "AUTO BILD (2018) повідомляє, що Volkswagen визнала можливість розтягування та перескоку ланцюга, а постачальник, за наявними відомостями, використовував штампувальний інструмент понад межу зносу; замітка галузевої преси 2012 року з посиланням на AUTO BILD говорить про виробничу помилку. Для моторів 1.4 TSI виробник запчастин зазначає, що серійний виробник повідомив про проблеми якості деталей (зношений інструмент залишив задирки на башмаках ланцюга, що веде до передчасного зносу) і що виробник вимагає ставити новіші фазорегулятори розподільного вала (OE 03C 109 088 E); виробник запчастин також радить після цього оновити ПЗ блока керування двигуном. Для 1.2 TSI він же описує доопрацьований комплект із 2011 року: ширший ланцюг, нові заспокоювачі, більший натягувач, покращені зуби зірочок. Якщо розтягнутий ланцюг перескакує, фази газорозподілу порушуються; джерела описують нерівну роботу, можливу лампу несправності та в гіршому разі дотик клапанів до поршнів із важким пошкодженням двигуна.",
        "fr": "AUTO BILD (2018) rapporte que Volkswagen a admis que la chaîne peut s'allonger et sauter, et qu'un fournisseur aurait utilisé des outils d'estampage au-delà de leur limite d'usure ; un article de la presse professionnelle de 2012, citant AUTO BILD, parle d'une erreur de production. Pour les moteurs 1.4 TSI, un équipementier indique que le constructeur de série a signalé des problèmes de qualité sur des composants (des outils usés ont laissé des bavures sur les patins de chaîne, d'où une usure prématurée) et que le constructeur exige les déphaseurs d'arbre à cames plus récents (OE 03C 109 088 E) ; l'équipementier conseille en outre une mise à jour logicielle du calculateur moteur. Pour le 1.2 TSI, le même équipementier décrit un kit révisé à partir de 2011 avec chaîne plus large, nouveaux guides, tendeur plus grand et dents de pignon améliorées. Si une chaîne allongée saute des dents, le calage est faux ; les sources décrivent un fonctionnement irrégulier, un voyant possible et, au pire, des soupapes touchant les pistons avec de graves dégâts moteur."
      },
      "applicability": {
        "models": [
          "volkswagen.golf",
          "volkswagen.polo",
          "volkswagen.jetta",
          "volkswagen.passat",
          "volkswagen.scirocco",
          "volkswagen.touran",
          "volkswagen.caddy",
          "volkswagen.tiguan",
          "volkswagen.beetle",
          "audi.a1",
          "audi.a3",
          "seat.ibiza",
          "seat.leon",
          "seat.altea",
          "seat.toledo",
          "skoda.octavia",
          "skoda.fabia",
          "skoda.yeti",
          "skoda.rapid",
          "volkswagen.eos",
          "volkswagen.sharan",
          "seat.alhambra",
          "skoda.roomster",
          "skoda.superb"
        ],
        "when": {
          "any": [
            {
              "all": [
                {
                  "engine": {
                    "ids": [
                      "vag.ea111_12tsi"
                    ]
                  }
                },
                {
                  "productionDate": {
                    "to": "2011-09"
                  }
                }
              ]
            },
            {
              "engine": {
                "ids": [
                  "vag.ea111_14tsi"
                ]
              }
            }
          ]
        },
        "markets": [
          "EU"
        ],
        "hint": {
          "en": "Only EA111 petrol TSI engines: the 1.2 TSI (CBZA / CBZB / CBZC) built up to September 2011, and the 1.4 TSI with the codes listed in the notes. Other engines are outside this entry.",
          "pt": "Apenas motores a gasolina TSI EA111: o 1.2 TSI (CBZA / CBZB / CBZC) fabricado até setembro de 2011 e o 1.4 TSI com os códigos indicados nas notas. Outros motores ficam fora desta entrada.",
          "ru": "Только бензиновые TSI EA111: 1.2 TSI (CBZA / CBZB / CBZC) выпуска до сентября 2011 года и 1.4 TSI с кодами из примечаний. Другие двигатели в эту запись не входят.",
          "uk": "Лише бензинові TSI EA111: 1.2 TSI (CBZA / CBZB / CBZC) випуску до вересня 2011 року та 1.4 TSI з кодами з приміток. Інші двигуни до цього запису не входять.",
          "fr": "Uniquement les moteurs essence TSI EA111 : le 1.2 TSI (CBZA / CBZB / CBZC) produit jusqu'en septembre 2011 et le 1.4 TSI aux codes indiqués dans les notes. Les autres moteurs ne relèvent pas de cette fiche."
        },
        "notes": {
          "en": "The 1.2 TSI window (before October 2011) comes from one parts maker; AUTO BILD gives no production years. The model list follows AUTO BILD's list of cars fitted with these engines, plus encyclopedia applications for the 1.2 TSI. The 1.4 TSI codes (BMY, BWK, CAVA, CAVD, CAXA, CDGA, CTHA) come from an engine catalogue and are not an official list, and no build window is available for them. Volkswagen goodwill terms changed over time (2012 widening, later withdrawal reported in 2018). No official recall or manufacturer bulletin could be opened: the French RappelConso V2 data holds none for timing chains, and the document 2040174/29 is known only through AUTO BILD. The parts maker attributes a rattle in the first seconds after start to the hydraulic tensioner rather than to chain elongation.",
          "pt": "A janela do 1.2 TSI (antes de outubro de 2011) vem de um fabricante de peças; a AUTO BILD não indica anos de produção. A lista de modelos segue a lista da AUTO BILD de automóveis com estes motores, mais as aplicações do 1.2 TSI numa enciclopédia. Os códigos do 1.4 TSI (BMY, BWK, CAVA, CAVD, CAXA, CDGA, CTHA) vêm de um catálogo de motores e não são uma lista oficial, e não existe janela de fabrico para eles. As condições de boa vontade da Volkswagen mudaram ao longo do tempo (alargamento em 2012, retirada referida em 2018). Não foi possível abrir nenhuma chamada oficial nem boletim do fabricante: os dados franceses RappelConso V2 não têm nenhuma sobre correntes de distribuição, e o documento 2040174/29 só é conhecido através da AUTO BILD. O fabricante de peças atribui um ruído nos primeiros segundos após o arranque ao tensor hidráulico e não ao alongamento da corrente.",
          "ru": "Окно для 1.2 TSI (до октября 2011 года) взято у одного производителя запчастей; AUTO BILD годы выпуска не называет. Список моделей следует перечню AUTO BILD машин с этими моторами, плюс применения 1.2 TSI из энциклопедии. Коды 1.4 TSI (BMY, BWK, CAVA, CAVD, CAXA, CDGA, CTHA) взяты из каталога двигателей и не являются официальным списком, окна выпуска для них нет. Условия помощи Volkswagen менялись (расширение в 2012 году, отзыв, о котором сообщено в 2018 году). Открыть официальный отзыв или бюллетень производителя не удалось: во французской базе RappelConso V2 записей по цепям ГРМ нет, а документ 2040174/29 известен только со слов AUTO BILD. Производитель запчастей связывает стук в первые секунды после пуска с гидронатяжителем, а не с растяжением цепи.",
          "uk": "Вікно для 1.2 TSI (до жовтня 2011 року) взято в одного виробника запчастин; AUTO BILD роки випуску не називає. Список моделей відповідає переліку AUTO BILD машин із цими моторами, плюс застосування 1.2 TSI з енциклопедії. Коди 1.4 TSI (BMY, BWK, CAVA, CAVD, CAXA, CDGA, CTHA) узято з каталогу двигунів і вони не є офіційним списком, вікна випуску для них немає. Умови допомоги Volkswagen змінювалися (розширення 2012 року, скасування, про яке повідомлено 2018 року). Відкрити офіційне відкликання чи бюлетень виробника не вдалося: у французькій базі RappelConso V2 записів щодо ланцюгів ГРМ немає, а документ 2040174/29 відомий лише зі слів AUTO BILD. Виробник запчастин пов'язує стукіт у перші секунди після пуску з гідронатягувачем, а не з розтягуванням ланцюга.",
          "fr": "La fenêtre du 1.2 TSI (avant octobre 2011) provient d'un équipementier ; AUTO BILD ne donne pas d'années de production. La liste des modèles suit la liste d'AUTO BILD des véhicules équipés de ces moteurs, complétée par les applications du 1.2 TSI d'une encyclopédie. Les codes du 1.4 TSI (BMY, BWK, CAVA, CAVD, CAXA, CDGA, CTHA) viennent d'un catalogue de moteurs et ne forment pas une liste officielle, et aucune fenêtre de production n'est disponible pour eux. Les conditions du geste commercial de Volkswagen ont évolué (extension en 2012, retrait rapporté en 2018). Aucun rappel officiel ni bulletin du constructeur n'a pu être ouvert : les données françaises RappelConso V2 n'en contiennent aucun sur les chaînes de distribution, et le document 2040174/29 n'est connu que par AUTO BILD. L'équipementier attribue un cliquetis dans les premières secondes après le démarrage au tendeur hydraulique et non à l'allongement de la chaîne."
        }
      },
      "severity": "critical",
      "safety": false,
      "critical": false,
      "symptoms": [
        {
          "id": "s1",
          "stage": "early",
          "text": {
            "en": "Brief rattle from the engine after a cold start",
            "pt": "Ruído breve do motor após o arranque a frio",
            "ru": "Краткий стук двигателя после холодного пуска",
            "uk": "Короткий стукіт двигуна після холодного пуску",
            "fr": "Cliquetis bref du moteur après un démarrage à froid"
          }
        },
        {
          "id": "s2",
          "stage": "early",
          "text": {
            "en": "A workshop tester shows chain-elongation values outside the normal range",
            "pt": "Um equipamento de diagnóstico da oficina mostra valores de alongamento da corrente fora do normal",
            "ru": "Диагностический тестер в мастерской показывает значения растяжения цепи вне нормы",
            "uk": "Діагностичний тестер у майстерні показує значення розтягування ланцюга поза нормою",
            "fr": "Un testeur d'atelier affiche des valeurs d'allongement de chaîne hors de la plage normale"
          }
        },
        {
          "id": "s3",
          "stage": "late",
          "text": {
            "en": "Uneven running or engine warning light",
            "pt": "Funcionamento irregular ou luz de aviso do motor",
            "ru": "Неровная работа или лампа неисправности двигателя",
            "uk": "Нерівна робота або лампа несправності двигуна",
            "fr": "Fonctionnement irrégulier ou voyant moteur"
          }
        },
        {
          "id": "s4",
          "stage": "late",
          "text": {
            "en": "Sudden engine damage if the chain skips teeth",
            "pt": "Dano súbito no motor se a corrente saltar dentes",
            "ru": "Внезапное повреждение двигателя, если цепь перескочит",
            "uk": "Раптове пошкодження двигуна, якщо ланцюг перескочить",
            "fr": "Dommage moteur soudain si la chaîne saute des dents"
          }
        }
      ],
      "inspection": [
        {
          "id": "i1",
          "method": "document",
          "tools": [],
          "text": {
            "en": "Confirm the engine code (1.2 TSI CBZA / CBZB / CBZC, or a 1.4 TSI EA111 code) on the engine or from a dealer VIN query, and the build date; for the 1.2 TSI check whether it was built before October 2011.",
            "pt": "Confirme o código do motor (1.2 TSI CBZA / CBZB / CBZC, ou um código 1.4 TSI EA111) no motor ou numa consulta do VIN no concessionário, e a data de fabrico; no 1.2 TSI verifique se foi fabricado antes de outubro de 2011.",
            "ru": "Уточните код двигателя (1.2 TSI CBZA / CBZB / CBZC или код 1.4 TSI EA111) на моторе или по запросу VIN у дилера и дату выпуска; для 1.2 TSI проверьте, выпущен ли он до октября 2011 года.",
            "uk": "Уточніть код двигуна (1.2 TSI CBZA / CBZB / CBZC або код 1.4 TSI EA111) на моторі чи за запитом VIN у дилера та дату випуску; для 1.2 TSI перевірте, чи випущений він до жовтня 2011 року.",
            "fr": "Confirmez le code moteur (1.2 TSI CBZA / CBZB / CBZC, ou un code 1.4 TSI EA111) sur le moteur ou via une requête VIN chez le concessionnaire, ainsi que la date de production ; pour le 1.2 TSI, vérifiez s'il a été produit avant octobre 2011."
          },
          "redFlag": null
        },
        {
          "id": "i2",
          "method": "document",
          "tools": [],
          "text": {
            "en": "Ask for invoices of any timing chain work and whether the revised parts were fitted (on the 1.4 TSI the newer camshaft adjusters and the software update), and whether goodwill was paid.",
            "pt": "Peça as faturas de qualquer trabalho na corrente de distribuição e se foram montadas as peças revistas (no 1.4 TSI, os variadores de árvore de cames mais recentes e a atualização de software), e se houve pagamento de boa vontade.",
            "ru": "Запросите счета за любые работы с цепью ГРМ и уточните, ставились ли доработанные детали (на 1.4 TSI — новые фазовращатели и обновление ПО) и выплачивалась ли помощь.",
            "uk": "Запросіть рахунки за будь-які роботи з ланцюгом ГРМ і уточніть, чи ставилися доопрацьовані деталі (на 1.4 TSI — нові фазорегулятори та оновлення ПЗ) і чи виплачувалася допомога.",
            "fr": "Demandez les factures de tout travail sur la chaîne de distribution et si les pièces révisées ont été montées (sur le 1.4 TSI, les déphaseurs plus récents et la mise à jour logicielle), ainsi que si un geste commercial a été versé."
          },
          "redFlag": {
            "en": "No record of chain work on a 1.2 TSI built before October 2011.",
            "pt": "Sem registo de trabalhos na corrente num 1.2 TSI fabricado antes de outubro de 2011.",
            "ru": "Нет записей о работах с цепью на 1.2 TSI выпуска до октября 2011 года.",
            "uk": "Немає записів про роботи з ланцюгом на 1.2 TSI випуску до жовтня 2011 року.",
            "fr": "Aucune trace d'intervention sur la chaîne d'un 1.2 TSI produit avant octobre 2011."
          }
        },
        {
          "id": "i3",
          "method": "listen",
          "tools": [],
          "text": {
            "en": "Start the engine cold and listen to the first seconds. A parts maker attributes a rattle in the first five seconds after start to the hydraulic tensioner, heard more often on older, high-mileage engines, and not to chain elongation; AUTO BILD lists a brief rattle after a cold start as a warning sign.",
            "pt": "Arranque o motor a frio e ouça os primeiros segundos. Um fabricante de peças atribui um ruído nos primeiros cinco segundos após o arranque ao tensor hidráulico, mais frequente em motores antigos com muitos quilómetros, e não ao alongamento da corrente; a AUTO BILD indica um ruído breve após o arranque a frio como sinal de alerta.",
            "ru": "Запустите холодный двигатель и послушайте первые секунды. Производитель запчастей связывает стук в первые пять секунд после пуска с гидронатяжителем (чаще на старых моторах с большим пробегом), а не с растяжением цепи; AUTO BILD называет краткий стук после холодного пуска тревожным признаком.",
            "uk": "Запустіть холодний двигун і послухайте перші секунди. Виробник запчастин пов'язує стукіт у перші п'ять секунд після пуску з гідронатягувачем (частіше на старих моторах із великим пробігом), а не з розтягуванням ланцюга; AUTO BILD називає короткий стукіт після холодного пуску тривожною ознакою.",
            "fr": "Démarrez le moteur à froid et écoutez les premières secondes. Un équipementier attribue un cliquetis dans les cinq premières secondes au tendeur hydraulique, plus fréquent sur les moteurs anciens et kilométrés, et non à l'allongement de la chaîne ; AUTO BILD cite un cliquetis bref au démarrage à froid comme signe d'alerte."
          },
          "redFlag": {
            "en": "Rattle longer than a few seconds, returning when warm, or with uneven running.",
            "pt": "Ruído mais longo do que alguns segundos, que volta com o motor quente ou com funcionamento irregular.",
            "ru": "Стук дольше нескольких секунд, возвращающийся на прогретом моторе или с неровной работой.",
            "uk": "Стукіт довший за кілька секунд, що повертається на прогрітому моторі або з нерівною роботою.",
            "fr": "Cliquetis de plus de quelques secondes, qui revient à chaud ou accompagné d'un fonctionnement irrégulier."
          }
        },
        {
          "id": "i4",
          "method": "obd",
          "tools": [],
          "text": {
            "en": "Ask a workshop to read the chain-elongation values and the fault memory (AUTO BILD says testers show at least four such values, which Volkswagen reads only on complaint).",
            "pt": "Peça a uma oficina para ler os valores de alongamento da corrente e a memória de avarias (a AUTO BILD diz que os equipamentos mostram pelo menos quatro valores deste tipo, que a Volkswagen só lê perante queixa).",
            "ru": "Попросите мастерскую считать значения растяжения цепи и память ошибок (AUTO BILD сообщает, что тестеры показывают не менее четырёх таких значений, которые Volkswagen считывает только при жалобе).",
            "uk": "Попросіть майстерню зчитати значення розтягування ланцюга та пам'ять помилок (AUTO BILD повідомляє, що тестери показують щонайменше чотири такі значення, які Volkswagen зчитує лише за скарги).",
            "fr": "Demandez à un atelier de lire les valeurs d'allongement de chaîne et la mémoire de défauts (AUTO BILD indique que les testeurs affichent au moins quatre valeurs de ce type, que Volkswagen ne lit que sur réclamation)."
          },
          "redFlag": {
            "en": "Chain-elongation values outside the normal range, or timing faults stored.",
            "pt": "Valores de alongamento da corrente fora do normal, ou avarias de distribuição registadas.",
            "ru": "Значения растяжения цепи вне нормы или записанные ошибки фаз ГРМ.",
            "uk": "Значення розтягування ланцюга поза нормою або записані помилки фаз ГРМ.",
            "fr": "Valeurs d'allongement de chaîne hors plage, ou défauts de calage enregistrés."
          }
        }
      ],
      "repair": {
        "remedy": {
          "en": "Replacement of the timing chain kit (chain, guides, tensioner, sprockets) with revised parts; on the 1.4 TSI a parts maker reports that the manufacturer requires the newer camshaft adjusters (OE 03C 109 088 E) and advises a control unit software update afterwards.",
          "pt": "Substituição do kit da corrente de distribuição (corrente, guias, tensor, rodas dentadas) por peças revistas; no 1.4 TSI, um fabricante de peças refere que o fabricante exige os variadores de árvore de cames mais recentes (OE 03C 109 088 E) e aconselha depois uma atualização de software da unidade de comando.",
          "ru": "Замена комплекта цепи ГРМ (цепь, успокоители, натяжитель, звёздочки) на доработанные детали; на 1.4 TSI, по данным производителя запчастей, изготовитель требует новые фазовращатели (OE 03C 109 088 E), а после этого рекомендуется обновить ПО блока управления.",
          "uk": "Заміна комплекта ланцюга ГРМ (ланцюг, заспокоювачі, натягувач, зірочки) на доопрацьовані деталі; на 1.4 TSI, за даними виробника запчастин, виробник вимагає новіші фазорегулятори (OE 03C 109 088 E), а після цього рекомендовано оновити ПЗ блока керування.",
          "fr": "Remplacement du kit de chaîne de distribution (chaîne, guides, tendeur, pignons) par des pièces révisées ; sur le 1.4 TSI, un équipementier indique que le constructeur exige les déphaseurs plus récents (OE 03C 109 088 E) et conseille ensuite une mise à jour logicielle du calculateur."
        },
        "cost": {
          "currency": "EUR",
          "low": 1600,
          "high": 1600,
          "asOf": "2018-06",
          "basis": {
            "en": "One reported case in Germany: a second chain job on a Jetta 1.4 TSI at 78,000 km quoted at about 1,600 EUR (AUTO BILD, 2018); the same car's first chain job plus a camshaft adjuster had cost about 4,000 EUR in total. Not a range.",
            "pt": "Um caso referido na Alemanha: segunda substituição da corrente num Jetta 1.4 TSI aos 78 000 km orçada em cerca de 1 600 EUR (AUTO BILD, 2018); a primeira substituição da corrente do mesmo automóvel com um variador de árvore de cames custou cerca de 4 000 EUR no total. Não é um intervalo.",
            "ru": "Один случай в Германии: вторая замена цепи на Jetta 1.4 TSI при 78 000 км оценена примерно в 1 600 EUR (AUTO BILD, 2018); первая замена цепи на той же машине вместе с фазовращателем обошлась примерно в 4 000 EUR. Это не диапазон.",
            "uk": "Один випадок у Німеччині: друга заміна ланцюга на Jetta 1.4 TSI за 78 000 км оцінена приблизно в 1 600 EUR (AUTO BILD, 2018); перша заміна ланцюга на тій самій машині разом із фазорегулятором коштувала приблизно 4 000 EUR. Це не діапазон.",
            "fr": "Un cas rapporté en Allemagne : second remplacement de chaîne sur une Jetta 1.4 TSI à 78 000 km chiffré à environ 1 600 EUR (AUTO BILD, 2018) ; le premier remplacement de chaîne de la même voiture avec un déphaseur avait coûté environ 4 000 EUR au total. Ce n'est pas une fourchette."
          },
          "evidence": [
            "ev_ts_e01"
          ]
        },
        "worstCase": null,
        "manufacturerProgramme": {
          "evidence": [
            "ev_ts_e01",
            "ev_ts_e02"
          ],
          "text": {
            "en": "No recall was identified. In April 2012 Volkswagen widened its goodwill on timing chains to 50 to 100% of parts and labour depending on mileage and history (kfz-betrieb, citing AUTO BILD). AUTO BILD reports that a 2012 promise of at least 50% for cars over six years old, for all EA111 TSI engines without a mileage limit, was later withdrawn, a Volkswagen spokesperson saying it applied only to cars already out of warranty at the time.",
            "pt": "Não foi identificada nenhuma chamada. Em abril de 2012 a Volkswagen alargou a boa vontade para correntes de distribuição a 50 a 100% de peças e mão de obra, consoante a quilometragem e o historial (kfz-betrieb, citando a AUTO BILD). A AUTO BILD refere que uma promessa de 2012 de pelo menos 50% para automóveis com mais de seis anos, para todos os motores TSI EA111 sem limite de quilómetros, foi depois retirada, tendo um porta-voz da Volkswagen dito que se aplicava apenas a automóveis já fora de garantia nessa altura.",
            "ru": "Отзыв не найден. В апреле 2012 года Volkswagen расширила помощь по цепям ГРМ до 50-100% стоимости деталей и работы в зависимости от пробега и истории (kfz-betrieb со ссылкой на AUTO BILD). AUTO BILD сообщает, что обещание 2012 года — не менее 50% для машин старше шести лет, для всех моторов TSI EA111 без ограничения пробега — позже отозвано; представитель Volkswagen сказал, что оно касалось только машин, уже вышедших из гарантии.",
            "uk": "Відкликання не знайдено. У квітні 2012 року Volkswagen розширила допомогу щодо ланцюгів ГРМ до 50-100% вартості деталей і роботи залежно від пробігу та історії (kfz-betrieb з посиланням на AUTO BILD). AUTO BILD повідомляє, що обіцянку 2012 року — не менше 50% для машин старше шести років, для всіх моторів TSI EA111 без обмеження пробігу — згодом скасовано; речник Volkswagen сказав, що вона стосувалася лише машин, які вже вийшли з гарантії.",
            "fr": "Aucun rappel n'a été identifié. En avril 2012, Volkswagen a étendu son geste commercial sur les chaînes de distribution à 50 à 100 % des pièces et de la main-d'œuvre selon le kilométrage et l'historique (kfz-betrieb, citant AUTO BILD). AUTO BILD rapporte qu'une promesse de 2012 d'au moins 50 % pour les véhicules de plus de six ans, pour tous les moteurs TSI EA111 sans limite de kilométrage, a ensuite été retirée, un porte-parole de Volkswagen disant qu'elle ne visait que les véhicules déjà hors garantie à l'époque."
          }
        }
      },
      "evidence": [
        "ev_ts_e01",
        "ev_ts_e02",
        "ev_ts_e03",
        "ev_ts_e04",
        "ev_ts_e05",
        "ev_ts_e06"
      ],
      "prevalence": [
        "pv_ts_none",
        "pv_ts_complaints"
      ]
    },
    {
      "id": "tdi.egr",
      "aliases": [],
      "status": "published",
      "replacedBy": null,
      "revision": 1,
      "updatedAt": "2026-10-13",
      "legacyRule": "vag-known-issues",
      "title": {
        "en": "VW 2.0 TDI (EA189, codes CBEA / CJAA, US-specification): EGR flow fault P0401 with DPF soot, per a Volkswagen service bulletin",
        "pt": "VW 2.0 TDI (EA189, códigos CBEA / CJAA, especificação EUA): avaria de caudal EGR P0401 com fuligem no FAP, segundo um boletim de serviço da Volkswagen",
        "ru": "VW 2.0 TDI (EA189, коды CBEA / CJAA, версия для США): ошибка потока EGR P0401 при саже в DPF по сервисному бюллетеню Volkswagen",
        "uk": "VW 2.0 TDI (EA189, коди CBEA / CJAA, версія для США): помилка потоку EGR P0401 за сажі в DPF за сервісним бюлетенем Volkswagen",
        "fr": "VW 2.0 TDI (EA189, codes CBEA / CJAA, version États-Unis) : défaut de débit EGR P0401 avec suie du FAP, selon un bulletin de service de Volkswagen"
      },
      "summary": {
        "en": "Volkswagen Group of America service bulletin 2034898 (original V011333 of October 2013, revised until November 2021) covers 2.0 TDI cars with engine codes CBEA (2009) and CJAA (2010 to 2014) when the warning light is on with fault P0401 'EGR flow insufficient', possibly with P2463 'DPF soot accumulation'. The bulletin states that high soot loads before a regeneration can cause restrictions in the EGR filter. Where soot is found at the filter connection, it calls for replacing the DPF and the EGR filter together, and says no other parts, including the EGR cooler, need replacing for this fault. It names US-market models only and gives no rate.",
        "pt": "O boletim de serviço 2034898 da Volkswagen Group of America (original V011333 de outubro de 2013, revisto até novembro de 2021) abrange 2.0 TDI com os códigos de motor CBEA (2009) e CJAA (2010 a 2014) quando a luz de aviso está acesa com a avaria P0401 'caudal EGR insuficiente', possivelmente com P2463 'acumulação de fuligem no FAP'. O boletim indica que cargas elevadas de fuligem antes de uma regeneração podem causar restrições no filtro EGR. Se houver fuligem na ligação do filtro, manda substituir o FAP e o filtro EGR em conjunto e diz que não é necessário substituir mais peças, incluindo o arrefecedor EGR, para esta avaria. Indica apenas modelos do mercado dos EUA e não dá nenhuma taxa.",
        "ru": "Сервисный бюллетень 2034898 Volkswagen Group of America (исходный V011333 от октября 2013 года, правки до ноября 2021 года) охватывает 2.0 TDI с кодами двигателя CBEA (2009) и CJAA (2010-2014), когда горит лампа неисправности и записана ошибка P0401 «недостаточный поток EGR», возможно вместе с P2463 «накопление сажи в DPF». В бюллетене сказано, что высокие сажевые нагрузки перед регенерацией могут вызывать засорение фильтра EGR. Если на патрубке фильтра найдена сажа, предписано менять DPF и фильтр EGR вместе, а другие детали, включая охладитель EGR, для этой ошибки менять не нужно. Названы только модели для рынка США, частота не указана.",
        "uk": "Сервісний бюлетень 2034898 Volkswagen Group of America (початковий V011333 від жовтня 2013 року, правки до листопада 2021 року) охоплює 2.0 TDI з кодами двигуна CBEA (2009) і CJAA (2010-2014), коли світиться лампа несправності та записана помилка P0401 «недостатній потік EGR», можливо разом із P2463 «накопичення сажі в DPF». У бюлетені сказано, що високі сажові навантаження перед регенерацією можуть спричиняти засмічення фільтра EGR. Якщо на патрубку фільтра знайдено сажу, приписано міняти DPF і фільтр EGR разом, а інші деталі, зокрема охолоджувач EGR, для цієї помилки міняти не потрібно. Названо лише моделі для ринку США, частоту не вказано.",
        "fr": "Le bulletin de service 2034898 de Volkswagen Group of America (original V011333 d'octobre 2013, révisé jusqu'en novembre 2021) couvre les 2.0 TDI de codes moteur CBEA (2009) et CJAA (2010 à 2014) lorsque le voyant est allumé avec le défaut P0401 « débit EGR insuffisant », éventuellement avec P2463 « accumulation de suie du FAP ». Le bulletin indique que de fortes charges de suie avant une régénération peuvent provoquer des restrictions du filtre EGR. Si de la suie est trouvée au raccord du filtre, il prescrit de remplacer le FAP et le filtre EGR ensemble, et précise qu'aucune autre pièce, y compris le refroidisseur EGR, n'a à être remplacée pour ce défaut. Il ne nomme que des modèles du marché américain et ne donne aucun taux."
      },
      "checklistPrompt": {
        "en": "EGR / DPF (2.0 TDI CBEA, CJAA) — check EGR flow fault P0401 and soot",
        "pt": "EGR / FAP (2.0 TDI CBEA, CJAA) — verificar avaria de caudal EGR P0401 e fuligem",
        "ru": "EGR / DPF (2.0 TDI CBEA, CJAA) — проверить ошибку потока EGR P0401 и сажу",
        "uk": "EGR / DPF (2.0 TDI CBEA, CJAA) — перевірити помилку потоку EGR P0401 і сажу",
        "fr": "EGR / FAP (2.0 TDI CBEA, CJAA) — vérifier le défaut de débit EGR P0401 et la suie"
      },
      "component": "engine.emissions.egr",
      "mechanism": {
        "en": "According to Volkswagen's bulletin, high soot loads before a regeneration can cause restrictions in the EGR filter, which is fitted at the diesel particulate filter. The resulting low EGR flow is stored as P0401, sometimes together with P2463 (DPF soot accumulation). The bulletin's diagnosis is to remove the EGR filter from the DPF and wipe the inside of the exhaust pipe at the connection: black soot calls for replacing the DPF and EGR filter together. Because the DPF itself suffers where intake airflow is poor, it also advises checking the intake air filter and the warm air valve. The bulletin does not attribute the fault to driving style.",
        "pt": "Segundo o boletim da Volkswagen, cargas elevadas de fuligem antes de uma regeneração podem causar restrições no filtro EGR, montado junto do filtro de partículas diesel. O baixo caudal EGR resultante fica registado como P0401, por vezes com P2463 (acumulação de fuligem no FAP). O diagnóstico do boletim consiste em retirar o filtro EGR do FAP e limpar o interior do tubo de escape na ligação: fuligem preta implica substituir o FAP e o filtro EGR em conjunto. Como o próprio FAP sofre quando o caudal de ar de admissão é fraco, aconselha também verificar o filtro de ar e a válvula de ar quente. O boletim não atribui a avaria ao estilo de condução.",
        "ru": "По бюллетеню Volkswagen, высокие сажевые нагрузки перед регенерацией могут вызывать засорение фильтра EGR, установленного у сажевого фильтра. Возникающий малый поток EGR записывается как P0401, иногда вместе с P2463 (накопление сажи в DPF). Диагностика по бюллетеню: снять фильтр EGR с DPF и протереть внутри трубу в месте соединения; чёрная сажа означает замену DPF и фильтра EGR вместе. Поскольку сам DPF страдает при плохом притоке воздуха, также советуют проверить воздушный фильтр и клапан подогрева воздуха. Причиной неисправности стиль езды в бюллетене не назван.",
        "uk": "За бюлетенем Volkswagen, високі сажові навантаження перед регенерацією можуть спричиняти засмічення фільтра EGR, встановленого біля сажового фільтра. Малий потік EGR, що виникає, записується як P0401, іноді разом із P2463 (накопичення сажі в DPF). Діагностика за бюлетенем: зняти фільтр EGR з DPF і протерти всередині трубу в місці з'єднання; чорна сажа означає заміну DPF і фільтра EGR разом. Оскільки сам DPF потерпає за поганого притоку повітря, також радять перевірити повітряний фільтр і клапан підігріву повітря. Причиною несправності стиль їзди в бюлетені не названо.",
        "fr": "Selon le bulletin de Volkswagen, de fortes charges de suie avant une régénération peuvent provoquer des restrictions du filtre EGR, monté au niveau du filtre à particules. Le faible débit EGR qui en résulte est enregistré comme P0401, parfois avec P2463 (accumulation de suie du FAP). Le diagnostic du bulletin consiste à déposer le filtre EGR du FAP et à essuyer l'intérieur du tube d'échappement au raccord : de la suie noire impose de remplacer le FAP et le filtre EGR ensemble. Comme le FAP lui-même souffre quand l'admission d'air est mauvaise, il conseille aussi de contrôler le filtre à air et le volet d'air chaud. Le bulletin n'attribue pas le défaut au style de conduite."
      },
      "applicability": {
        "models": [
          "volkswagen.jetta",
          "volkswagen.golf",
          "volkswagen.beetle"
        ],
        "when": {
          "any": [
            {
              "all": [
                {
                  "model": [
                    "volkswagen.jetta"
                  ]
                },
                {
                  "engine": {
                    "codes": [
                      "CBEA"
                    ]
                  }
                },
                {
                  "modelYear": {
                    "from": 2008,
                    "to": 2010
                  }
                }
              ]
            },
            {
              "all": [
                {
                  "model": [
                    "volkswagen.golf",
                    "volkswagen.jetta"
                  ]
                },
                {
                  "engine": {
                    "codes": [
                      "CJAA"
                    ]
                  }
                },
                {
                  "modelYear": {
                    "from": 2009,
                    "to": 2015
                  }
                }
              ]
            },
            {
              "all": [
                {
                  "model": [
                    "volkswagen.beetle"
                  ]
                },
                {
                  "engine": {
                    "codes": [
                      "CJAA"
                    ]
                  }
                },
                {
                  "modelYear": {
                    "from": 2012,
                    "to": 2015
                  }
                }
              ]
            }
          ]
        },
        "markets": [
          "US"
        ],
        "hint": {
          "en": "Only the bulletin's cars: Jetta and Jetta Wagon 2009 with the 2.0 TDI code CBEA; Golf, Jetta, Jetta SportWagen and Golf Wagon 2010-2014 and Beetle 2013-2014 with code CJAA. Other TDI engines are outside this entry.",
          "pt": "Apenas os automóveis do boletim: Jetta e Jetta Wagon 2009 com o 2.0 TDI de código CBEA; Golf, Jetta, Jetta SportWagen e Golf Wagon 2010-2014 e Beetle 2013-2014 com o código CJAA. Outros motores TDI ficam fora desta entrada.",
          "ru": "Только машины из бюллетеня: Jetta и Jetta Wagon 2009 года с 2.0 TDI кода CBEA; Golf, Jetta, Jetta SportWagen и Golf Wagon 2010-2014 и Beetle 2013-2014 с кодом CJAA. Другие двигатели TDI в эту запись не входят.",
          "uk": "Лише машини з бюлетеня: Jetta і Jetta Wagon 2009 року з 2.0 TDI коду CBEA; Golf, Jetta, Jetta SportWagen і Golf Wagon 2010-2014 та Beetle 2013-2014 з кодом CJAA. Інші двигуни TDI до цього запису не входять.",
          "fr": "Uniquement les véhicules du bulletin : Jetta et Jetta Wagon 2009 avec le 2.0 TDI de code CBEA ; Golf, Jetta, Jetta SportWagen et Golf Wagon 2010-2014 et Beetle 2013-2014 avec le code CJAA. Les autres moteurs TDI sont hors de cette entrée."
        },
        "notes": {
          "en": "Source is the US bulletin only; the codes CBEA and CJAA belong to the 140 hp EA189 common-rail engine (a press table lists them in the EA189 family), but no European document for this fault was found. The bulletin gives US model years; because the year entered for a car can be its build or registration year, the rule accepts one year on either side of each range. The French RappelConso V2 data contains no recall for EGR or DPF clogging on these engines. The earlier legacy wording about short-trip use is not supported by any official source opened here and is left out.",
          "pt": "A fonte é apenas o boletim norte-americano; os códigos CBEA e CJAA pertencem ao motor common-rail EA189 de 140 cv (uma tabela da imprensa inclui-os na família EA189), mas não foi encontrado nenhum documento europeu sobre esta avaria. O boletim indica anos-modelo dos EUA; como o ano indicado para um automóvel pode ser o de fabrico ou de matrícula, a regra aceita um ano a mais ou a menos em cada intervalo. Os dados franceses RappelConso V2 não contêm nenhuma chamada por obstrução da EGR ou do DPF nestes motores. A anterior formulação sobre trajetos curtos não é suportada por nenhuma fonte oficial aqui aberta e foi deixada de fora.",
          "ru": "Источник — только американский бюллетень; коды CBEA и CJAA относятся к 140-сильному EA189 common rail (в таблице прессы они отнесены к семейству EA189), но европейского документа по этой неисправности не найдено. Бюллетень даёт американские модельные годы; поскольку указанный для машины год может быть годом выпуска или регистрации, правило допускает год в обе стороны от каждого диапазона. Во французской базе RappelConso V2 отзывов по засорению EGR или DPF на этих моторах нет. Прежняя формулировка про короткие поездки не подтверждена ни одним открытым официальным источником и не включена.",
          "uk": "Джерело — лише американський бюлетень; коди CBEA і CJAA належать до 140-сильного EA189 common rail (у таблиці преси їх віднесено до сімейства EA189), але європейського документа щодо цієї несправності не знайдено. Бюлетень наводить американські модельні роки; оскільки вказаний для машини рік може бути роком випуску чи реєстрації, правило допускає рік в обидва боки від кожного діапазону. У французькій базі RappelConso V2 відкликань щодо засмічення EGR або DPF на цих моторах немає. Попереднє формулювання про короткі поїздки не підтверджене жодним відкритим офіційним джерелом і не включене.",
          "fr": "La source est uniquement le bulletin américain ; les codes CBEA et CJAA appartiennent au moteur common rail EA189 de 140 ch (un tableau de presse les range dans la famille EA189), mais aucun document européen sur ce défaut n'a été trouvé. Le bulletin donne des années-modèles américaines ; comme l'année saisie pour un véhicule peut être celle de fabrication ou d'immatriculation, la règle accepte une année de plus ou de moins pour chaque plage. Les données françaises RappelConso V2 ne contiennent aucun rappel pour colmatage EGR ou FAP sur ces moteurs. L'ancienne formulation sur les trajets courts n'est étayée par aucune source officielle ouverte ici et a été écartée."
        }
      },
      "severity": "moderate",
      "safety": false,
      "critical": false,
      "symptoms": [
        {
          "id": "s1",
          "stage": "early",
          "text": {
            "en": "Engine warning light on with fault P0401 (EGR flow insufficient)",
            "pt": "Luz de aviso do motor acesa com a avaria P0401 (caudal EGR insuficiente)",
            "ru": "Горит лампа неисправности двигателя, ошибка P0401 (недостаточный поток EGR)",
            "uk": "Світиться лампа несправності двигуна, помилка P0401 (недостатній потік EGR)",
            "fr": "Voyant moteur allumé avec le défaut P0401 (débit EGR insuffisant)"
          }
        },
        {
          "id": "s2",
          "stage": "early",
          "text": {
            "en": "Fault P2463 (DPF soot accumulation) stored together with P0401",
            "pt": "Avaria P2463 (acumulação de fuligem no FAP) registada junto com P0401",
            "ru": "Ошибка P2463 (накопление сажи в DPF) записана вместе с P0401",
            "uk": "Помилка P2463 (накопичення сажі в DPF) записана разом із P0401",
            "fr": "Défaut P2463 (accumulation de suie du FAP) enregistré avec P0401"
          }
        }
      ],
      "inspection": [
        {
          "id": "i1",
          "method": "document",
          "tools": [],
          "text": {
            "en": "Confirm the engine code (CBEA or CJAA) and the model year against the bulletin's list; ask whether the DPF and EGR filter were ever replaced and whether the control unit software is the latest.",
            "pt": "Confirme o código do motor (CBEA ou CJAA) e o ano-modelo com a lista do boletim; pergunte se o FAP e o filtro EGR já foram substituídos e se o software da unidade de comando é o mais recente.",
            "ru": "Сверьте код двигателя (CBEA или CJAA) и модельный год со списком бюллетеня; спросите, менялись ли DPF и фильтр EGR и последняя ли версия ПО блока управления.",
            "uk": "Звірте код двигуна (CBEA або CJAA) і модельний рік зі списком бюлетеня; запитайте, чи мінялися DPF і фільтр EGR та чи остання версія ПЗ блока керування.",
            "fr": "Confirmez le code moteur (CBEA ou CJAA) et l'année-modèle avec la liste du bulletin ; demandez si le FAP et le filtre EGR ont déjà été remplacés et si le logiciel du calculateur est à jour."
          },
          "redFlag": null
        },
        {
          "id": "i2",
          "method": "obd",
          "tools": [],
          "text": {
            "en": "Read the fault memory for P0401 and P2463.",
            "pt": "Leia a memória de avarias para P0401 e P2463.",
            "ru": "Считайте память ошибок на P0401 и P2463.",
            "uk": "Зчитайте пам'ять помилок на P0401 і P2463.",
            "fr": "Lisez la mémoire de défauts pour P0401 et P2463."
          },
          "redFlag": {
            "en": "P0401 or P2463 stored: a DPF and EGR filter replacement may follow.",
            "pt": "P0401 ou P2463 registados: pode seguir-se a substituição do FAP e do filtro EGR.",
            "ru": "Записаны P0401 или P2463: возможна замена DPF и фильтра EGR.",
            "uk": "Записані P0401 або P2463: можлива заміна DPF і фільтра EGR.",
            "fr": "P0401 ou P2463 enregistré : un remplacement du FAP et du filtre EGR peut suivre."
          }
        },
        {
          "id": "i3",
          "method": "tool",
          "tools": [],
          "text": {
            "en": "Ask a workshop to remove the EGR filter and wipe the inside of the exhaust pipe at the connection, as the bulletin describes; black soot on the cloth is the bulletin's criterion for replacement.",
            "pt": "Peça a uma oficina para retirar o filtro EGR e limpar o interior do tubo de escape na ligação, como descreve o boletim; fuligem preta no pano é o critério do boletim para substituição.",
            "ru": "Попросите мастерскую снять фильтр EGR и протереть внутри трубу в месте соединения, как описано в бюллетене; чёрная сажа на ткани — критерий бюллетеня для замены.",
            "uk": "Попросіть майстерню зняти фільтр EGR і протерти всередині трубу в місці з'єднання, як описано в бюлетені; чорна сажа на тканині — критерій бюлетеня для заміни.",
            "fr": "Demandez à un atelier de déposer le filtre EGR et d'essuyer l'intérieur du tube d'échappement au raccord, comme le décrit le bulletin ; de la suie noire sur le chiffon est le critère de remplacement du bulletin."
          },
          "redFlag": {
            "en": "Black soot at the EGR filter connection.",
            "pt": "Fuligem preta na ligação do filtro EGR.",
            "ru": "Чёрная сажа на соединении фильтра EGR.",
            "uk": "Чорна сажа на з'єднанні фільтра EGR.",
            "fr": "Suie noire au raccord du filtre EGR."
          }
        }
      ],
      "repair": {
        "remedy": {
          "en": "Replace the DPF and the EGR filter together when soot is found at the EGR filter connection; no other parts (NOx storage catalyst, sulphur catalyst, exhaust flap, EGR cooler) are required for this fault. Then perform the guided adaptation, bring the control unit to the latest software, and check the intake air filter and warm air valve.",
          "pt": "Substituir o FAP e o filtro EGR em conjunto quando houver fuligem na ligação do filtro EGR; não são necessárias outras peças (catalisador de armazenamento de NOx, catalisador de enxofre, borboleta de escape, arrefecedor EGR) para esta avaria. Depois fazer a adaptação guiada, atualizar a unidade de comando para o software mais recente e verificar o filtro de ar e a válvula de ar quente.",
          "ru": "Менять DPF и фильтр EGR вместе, если на соединении фильтра EGR найдена сажа; другие детали (накопительный NOx-катализатор, серный катализатор, заслонка выпуска, охладитель EGR) для этой ошибки не требуются. Затем выполнить адаптацию через Guided Functions, обновить ПО блока управления до последней версии и проверить воздушный фильтр и клапан подогрева воздуха.",
          "uk": "Міняти DPF і фільтр EGR разом, якщо на з'єднанні фільтра EGR знайдено сажу; інші деталі (накопичувальний NOx-каталізатор, сірчаний каталізатор, заслінка випуску, охолоджувач EGR) для цієї помилки не потрібні. Потім виконати адаптацію через Guided Functions, оновити ПЗ блока керування до останньої версії та перевірити повітряний фільтр і клапан підігріву повітря.",
          "fr": "Remplacer le FAP et le filtre EGR ensemble si de la suie est trouvée au raccord du filtre EGR ; aucune autre pièce (catalyseur de stockage des NOx, catalyseur de soufre, volet d'échappement, refroidisseur EGR) n'est requise pour ce défaut. Puis réaliser l'adaptation guidée, mettre le calculateur à la dernière version logicielle et contrôler le filtre à air et le volet d'air chaud."
        },
        "cost": null,
        "worstCase": null,
        "manufacturerProgramme": {
          "evidence": [
            "ev_td_e01",
            "ev_td_e02"
          ],
          "text": {
            "en": "No recall was identified. Volkswagen published the repair procedure as a service bulletin (versions from October 2013 to November 2021); the bulletin states it is informational only when the car is outside any warranty, and that new software was implemented in production.",
            "pt": "Não foi identificada nenhuma chamada. A Volkswagen publicou o procedimento de reparação como boletim de serviço (versões de outubro de 2013 a novembro de 2021); o boletim indica que é apenas informativo quando o automóvel está fora de qualquer garantia, e que foi implementado novo software na produção.",
            "ru": "Отзыв не найден. Volkswagen опубликовала порядок ремонта как сервисный бюллетень (редакции с октября 2013 по ноябрь 2021 года); в бюллетене сказано, что вне гарантии он носит информационный характер и что новое ПО внедрено в производство.",
            "uk": "Відкликання не знайдено. Volkswagen опублікувала порядок ремонту як сервісний бюлетень (редакції з жовтня 2013 до листопада 2021 року); у бюлетені сказано, що поза гарантією він має інформаційний характер і що нове ПЗ впроваджено у виробництво.",
            "fr": "Aucun rappel n'a été identifié. Volkswagen a publié la procédure de réparation sous forme de bulletin de service (versions d'octobre 2013 à novembre 2021) ; le bulletin précise qu'il est purement informatif hors garantie et qu'un nouveau logiciel a été mis en œuvre en production."
          }
        }
      },
      "evidence": [
        "ev_td_e01",
        "ev_td_e02",
        "ev_td_e03"
      ],
      "prevalence": [
        "pv_td_none"
      ]
    },
    {
      "id": "tsi.oil",
      "aliases": [],
      "status": "published",
      "replacedBy": null,
      "revision": 1,
      "updatedAt": "2026-10-13",
      "legacyRule": "vag-known-issues",
      "title": {
        "en": "VW group 1.8 / 2.0 TFSI (EA888 first generations, built about 2008 to 2011): reported high oil consumption",
        "pt": "1.8 / 2.0 TFSI do grupo VW (primeiras gerações EA888, fabricadas por volta de 2008 a 2011): consumo de óleo elevado relatado",
        "ru": "1.8 / 2.0 TFSI концерна VW (первые поколения EA888, выпуск примерно 2008-2011): сообщения о высоком расходе масла",
        "uk": "1.8 / 2.0 TFSI концерну VW (перші покоління EA888, випуск приблизно 2008-2011): повідомлення про високу витрату оливи",
        "fr": "1.8 / 2.0 TFSI du groupe VW (premières générations EA888, produites environ de 2008 à 2011) : consommation d'huile élevée signalée"
      },
      "summary": {
        "en": "Audi of America issued service bulletin 2027731 (first published November 2011, revision 6 in January 2015) for excessive oil consumption of the 2.0 TFSI (code CAEB) in the 2009-2011 A4, 2010-2011 A5 and 2011 Q5. Audi states that internal engine pressure can influence consumption in stop-and-go driving, and the bulletin prescribes a crankcase pressure valve, a front crankshaft seal and a software update on complaint. Settling a US class action, Audi extended the warranty for these cars to 8 years / 80,000 miles (Audi and Volkswagen deny wrongdoing). AUTO BILD reported in 2017 that, according to Audi, 785,000 EA888 1.8 and 2.0 engines had been built with oil control rings that the magazine describes as too narrow, and that Audi had tried several ring designs; the magazine's report covers the EA888 1.8 and 2.0 in general, not only Audi models.",
        "pt": "A Audi of America publicou o boletim de serviço 2027731 (primeira publicação em novembro de 2011, revisão 6 em janeiro de 2015) sobre consumo excessivo de óleo do 2.0 TFSI (código CAEB) no A4 2009-2011, A5 2010-2011 e Q5 2011. A Audi afirma que a pressão interna do motor pode influenciar o consumo em pára-arranca, e o boletim prescreve, perante reclamação, uma válvula de pressão do cárter, um retentor dianteiro da cambota e uma atualização de software. Num acordo de ação coletiva nos EUA, a Audi alargou a garantia destes automóveis para 8 anos / 80 000 milhas (a Audi e a Volkswagen negam qualquer irregularidade). A AUTO BILD referiu em 2017 que, segundo a Audi, 785 000 motores EA888 1.8 e 2.0 foram fabricados com segmentos raspadores de óleo que a revista descreve como demasiado estreitos, e que a Audi experimentou vários desenhos de segmentos; o artigo abrange o EA888 1.8 e 2.0 em geral, não só os modelos Audi.",
        "ru": "Audi of America выпустила сервисный бюллетень 2027731 (первая публикация в ноябре 2011 года, ревизия 6 в январе 2015 года) о повышенном расходе масла у 2.0 TFSI (код CAEB) в A4 2009-2011, A5 2010-2011 и Q5 2011. Audi указывает, что внутреннее давление в двигателе может влиять на расход в режиме пробок, и бюллетень по жалобе предписывает клапан давления картерных газов, передний сальник коленвала и обновление ПО. По мировому соглашению в коллективном иске в США Audi продлила гарантию на эти машины до 8 лет / 80 000 миль (Audi и Volkswagen отрицают нарушения). AUTO BILD в 2017 году сообщил, что, по словам Audi, 785 000 моторов EA888 1.8 и 2.0 построены с маслосъёмными кольцами, которые журнал называет слишком узкими, и что Audi перепробовала несколько конструкций колец; статья относится к EA888 1.8 и 2.0 в целом, а не только к моделям Audi.",
        "uk": "Audi of America випустила сервісний бюлетень 2027731 (перша публікація в листопаді 2011 року, ревізія 6 у січні 2015 року) щодо підвищеної витрати оливи у 2.0 TFSI (код CAEB) в A4 2009-2011, A5 2010-2011 і Q5 2011. Audi зазначає, що внутрішній тиск у двигуні може впливати на витрату в режимі заторів, і бюлетень за скаргою приписує клапан тиску картерних газів, передній сальник колінвала та оновлення ПЗ. За мировою угодою в колективному позові в США Audi продовжила гарантію на ці машини до 8 років / 80 000 миль (Audi і Volkswagen заперечують порушення). AUTO BILD у 2017 році повідомив, що, за словами Audi, 785 000 моторів EA888 1.8 і 2.0 збудовано з оливознімними кільцями, які журнал називає надто вузькими, і що Audi випробувала кілька конструкцій кілець; стаття стосується EA888 1.8 і 2.0 загалом, а не лише моделей Audi.",
        "fr": "Audi of America a publié le bulletin de service 2027731 (première publication en novembre 2011, révision 6 en janvier 2015) pour une consommation d'huile excessive du 2.0 TFSI (code CAEB) sur l'A4 2009-2011, l'A5 2010-2011 et le Q5 2011. Audi indique que la pression interne du moteur peut influer sur la consommation en circulation urbaine avec arrêts fréquents, et le bulletin prescrit, sur réclamation, une soupape de pression de carter, une bague d'étanchéité avant de vilebrequin et une mise à jour logicielle. Dans le cadre d'une transaction d'action collective aux États-Unis, Audi a porté la garantie de ces véhicules à 8 ans / 80 000 miles (Audi et Volkswagen contestent toute faute). AUTO BILD a rapporté en 2017 que, selon Audi, 785 000 moteurs EA888 1.8 et 2.0 avaient été produits avec des segments racleurs que le magazine qualifie de trop étroits, et qu'Audi avait essayé plusieurs conceptions de segments ; l'article porte sur l'EA888 1.8 et 2.0 en général, pas seulement sur les modèles Audi."
      },
      "checklistPrompt": {
        "en": "Oil consumption (1.8/2.0 TFSI, about 2008-2011) — measure consumption over 1,000 km",
        "pt": "Consumo de óleo (1.8/2.0 TFSI, cerca de 2008-2011) — medir o consumo em 1 000 km",
        "ru": "Расход масла (1.8/2.0 TFSI, примерно 2008-2011) — измерить расход на 1 000 км",
        "uk": "Витрата оливи (1.8/2.0 TFSI, приблизно 2008-2011) — виміряти витрату на 1 000 км",
        "fr": "Consommation d'huile (1.8/2.0 TFSI, environ 2008-2011) — mesurer la consommation sur 1 000 km"
      },
      "component": "engine.lubrication.oil_consumption",
      "mechanism": {
        "en": "Two explanations are on record, from different speakers. Audi's bulletin attributes high consumption to internal engine pressure under certain driving conditions (stop-and-go traffic with long idling) and prescribes replacing the crankcase pressure regulating valve and the front crankshaft seal and updating the engine software; the production solution was crankcase pressure reduction from model year 2012. AUTO BILD reports that, according to Audi, 785,000 engines were built with oil control rings of part number 06J 198 151 H, which the magazine describes as too narrow and names as the probable cause; it also reports at least four other ring variants before a wave ring from mid-2015, and that consumption becomes noticeable from about 40,000 to 70,000 km. In the US settlement, Audi and Volkswagen denied any wrongdoing.",
        "pt": "Há duas explicações registadas, de autores diferentes. O boletim da Audi atribui o consumo elevado à pressão interna do motor em certas condições (pára-arranca com longos períodos ao ralenti) e prescreve a substituição da válvula reguladora de pressão do cárter e do retentor dianteiro da cambota e a atualização do software do motor; a solução de produção foi a redução da pressão do cárter a partir do ano-modelo 2012. A AUTO BILD refere que, segundo a Audi, 785 000 motores foram fabricados com segmentos raspadores de óleo de referência 06J 198 151 H, que a revista descreve como demasiado estreitos e aponta como causa provável; refere ainda pelo menos quatro outras variantes de segmentos antes de um segmento ondulado a partir de meados de 2015, e que o consumo se torna notório a partir de cerca de 40 000 a 70 000 km. No acordo nos EUA, a Audi e a Volkswagen negaram qualquer irregularidade.",
        "ru": "Есть два объяснения от разных сторон. Бюллетень Audi связывает высокий расход с внутренним давлением в двигателе в определённых условиях (пробки с долгим холостым ходом) и предписывает заменить клапан регулировки давления картерных газов и передний сальник коленвала и обновить ПО двигателя; производственное решение — снижение давления в картере с 2012 модельного года. AUTO BILD сообщает, что, по словам Audi, 785 000 моторов построены с маслосъёмными кольцами номер 06J 198 151 H, которые журнал называет слишком узкими и вероятной причиной; журнал также пишет как минимум о четырёх других вариантах колец до волнистого кольца с середины 2015 года и о том, что расход становится заметным примерно с 40 000-70 000 км. В мировом соглашении в США Audi и Volkswagen отрицали какие-либо нарушения.",
        "uk": "Є два пояснення від різних сторін. Бюлетень Audi пов'язує високу витрату з внутрішнім тиском у двигуні за певних умов (затори з довгим холостим ходом) і приписує замінити клапан регулювання тиску картерних газів і передній сальник колінвала та оновити ПЗ двигуна; виробниче рішення — зниження тиску в картері з 2012 модельного року. AUTO BILD повідомляє, що, за словами Audi, 785 000 моторів збудовано з оливознімними кільцями номер 06J 198 151 H, які журнал називає надто вузькими та ймовірною причиною; журнал також пише щонайменше про чотири інші варіанти кілець до хвилястого кільця з середини 2015 року і про те, що витрата стає помітною приблизно з 40 000-70 000 км. У мировій угоді в США Audi і Volkswagen заперечували будь-які порушення.",
        "fr": "Deux explications existent, de sources différentes. Le bulletin d'Audi attribue la consommation élevée à la pression interne du moteur dans certaines conditions (circulation avec arrêts fréquents et longs ralentis) et prescrit le remplacement de la soupape de régulation de pression du carter et de la bague d'étanchéité avant de vilebrequin ainsi qu'une mise à jour du logiciel moteur ; la solution de production a été la réduction de la pression de carter à partir de l'année-modèle 2012. AUTO BILD rapporte que, selon Audi, 785 000 moteurs ont été produits avec des segments racleurs de référence 06J 198 151 H, que le magazine qualifie de trop étroits et désigne comme cause probable ; il fait aussi état d'au moins quatre autres variantes de segments avant un segment ondulé à partir de mi-2015, et d'une consommation qui devient sensible à partir d'environ 40 000 à 70 000 km. Dans la transaction américaine, Audi et Volkswagen ont contesté toute faute."
      },
      "applicability": {
        "models": [
          "audi.a4",
          "audi.a5",
          "audi.q5",
          "audi.a3",
          "audi.tt",
          "audi.q3",
          "volkswagen.golf",
          "volkswagen.jetta",
          "volkswagen.passat",
          "volkswagen.scirocco",
          "volkswagen.tiguan",
          "skoda.octavia",
          "skoda.superb",
          "skoda.yeti",
          "seat.leon",
          "seat.altea",
          "seat.exeo"
        ],
        "when": {
          "all": [
            {
              "engine": {
                "ids": [
                  "vag.ea888_18tfsi",
                  "vag.ea888_20tfsi",
                  "vag.ea888_20tfsi_t"
                ]
              }
            },
            {
              "productionDate": {
                "from": "2008-01",
                "to": "2011-12"
              }
            }
          ]
        },
        "markets": [
          "US",
          "EU"
        ],
        "hint": {
          "en": "VW-group cars with the EA888 1.8 or 2.0 TFSI/TSI built roughly from 2008 to 2011. The Audi bulletin names the 2.0 TFSI code CAEB in the A4 2009-2011, A5 2010-2011 and Q5 2011; AUTO BILD's report covers EA888 1.8 and 2.0 engines in general. Later EA888 generations and other engines are outside this entry.",
          "pt": "Automóveis do grupo VW com o EA888 1.8 ou 2.0 TFSI/TSI fabricados aproximadamente de 2008 a 2011. O boletim da Audi indica o 2.0 TFSI de código CAEB no A4 2009-2011, A5 2010-2011 e Q5 2011; o artigo da AUTO BILD abrange os motores EA888 1.8 e 2.0 em geral. As gerações EA888 posteriores e outros motores ficam fora desta entrada.",
          "ru": "Машины концерна VW с EA888 1.8 или 2.0 TFSI/TSI выпуска примерно 2008-2011 годов. Бюллетень Audi называет 2.0 TFSI с кодом CAEB в A4 2009-2011, A5 2010-2011 и Q5 2011; статья AUTO BILD относится к моторам EA888 1.8 и 2.0 в целом. Более поздние поколения EA888 и другие моторы в эту запись не входят.",
          "uk": "Машини концерну VW з EA888 1.8 або 2.0 TFSI/TSI випуску приблизно 2008-2011 років. Бюлетень Audi називає 2.0 TFSI з кодом CAEB в A4 2009-2011, A5 2010-2011 і Q5 2011; стаття AUTO BILD стосується моторів EA888 1.8 і 2.0 загалом. Пізніші покоління EA888 та інші мотори до цього запису не входять.",
          "fr": "Véhicules du groupe VW équipés de l'EA888 1.8 ou 2.0 TFSI/TSI produits environ de 2008 à 2011. Le bulletin d'Audi cite le 2.0 TFSI de code CAEB sur l'A4 2009-2011, l'A5 2010-2011 et le Q5 2011 ; l'article d'AUTO BILD porte sur les moteurs EA888 1.8 et 2.0 en général. Les générations EA888 ultérieures et les autres moteurs sont hors de cette entrée."
        },
        "notes": {
          "en": "Audi's bulletin names engine code CAEB only; the other codes (2.0: CAEA, CDNB, CDNC and transverse codes; 1.8: BYT, CDHB, CDAA, CDAB) come from an encyclopedia list, and the 2008 to mid-2011 window comes from AUTO BILD ('probably'). AUTO BILD speaks of EA888 1.8 and 2.0 engines without limiting it to Audi, so VW, SEAT and Skoda models with these engines are included; the model list is based on the encyclopedia's applications and may be incomplete. Only the Audi cases are documented by a manufacturer bulletin. A later, separate US settlement (D.N.J. 1:21-cv-10546, final approval 16 May 2024) concerns 2012-2017 Audi models and is not part of this entry. No recall was found: the French RappelConso V2 data holds none for oil consumption. Audi's bulletin, not the settlement, gives the manufacturer's own explanation.",
          "pt": "O boletim da Audi indica apenas o código de motor CAEB; os restantes códigos (2.0: CAEA, CDNB, CDNC e códigos transversais; 1.8: BYT, CDHB, CDAA, CDAB) vêm de uma lista de enciclopédia, e a janela de 2008 a meados de 2011 vem da AUTO BILD ('provavelmente'). A AUTO BILD fala de motores EA888 1.8 e 2.0 sem se limitar à Audi, pelo que os modelos VW, SEAT e Skoda com estes motores estão incluídos; a lista de modelos baseia-se nas aplicações da enciclopédia e pode estar incompleta. Só os casos Audi estão documentados por um boletim do fabricante. Um acordo posterior e distinto nos EUA (D.N.J. 1:21-cv-10546, aprovação final em 16 de maio de 2024) diz respeito a modelos Audi de 2012-2017 e não faz parte desta entrada. Não foi encontrada nenhuma chamada: os dados franceses RappelConso V2 não têm nenhuma sobre consumo de óleo. É o boletim da Audi, e não o acordo, que dá a explicação do próprio fabricante.",
          "ru": "Бюллетень Audi называет только код CAEB; остальные коды (2.0: CAEA, CDNB, CDNC и поперечные коды; 1.8: BYT, CDHB, CDAA, CDAB) взяты из энциклопедического списка, а окно с 2008 до середины 2011 года — из AUTO BILD («вероятно»). AUTO BILD говорит о моторах EA888 1.8 и 2.0 без ограничения маркой Audi, поэтому модели VW, SEAT и Skoda с этими моторами включены; список моделей основан на применениях из энциклопедии и может быть неполным. Бюллетенем производителя задокументированы только случаи Audi. Более позднее отдельное мировое соглашение в США (D.N.J. 1:21-cv-10546, окончательное одобрение 16 мая 2024 года) касается моделей Audi 2012-2017 годов и в эту запись не входит. Отзывов не найдено: во французской базе RappelConso V2 записей о расходе масла нет. Собственное объяснение производителя даёт бюллетень Audi, а не соглашение.",
          "uk": "Бюлетень Audi називає лише код CAEB; решта кодів (2.0: CAEA, CDNB, CDNC і поперечні коди; 1.8: BYT, CDHB, CDAA, CDAB) узято з енциклопедичного списку, а вікно з 2008 до середини 2011 року — з AUTO BILD («імовірно»). AUTO BILD говорить про мотори EA888 1.8 і 2.0 без обмеження маркою Audi, тому моделі VW, SEAT і Skoda з цими моторами включено; список моделей ґрунтується на застосуваннях з енциклопедії і може бути неповним. Бюлетенем виробника задокументовано лише випадки Audi. Пізніша окрема мирова угода в США (D.N.J. 1:21-cv-10546, остаточне схвалення 16 травня 2024 року) стосується моделей Audi 2012-2017 років і до цього запису не входить. Відкликань не знайдено: у французькій базі RappelConso V2 записів щодо витрати оливи немає. Власне пояснення виробника дає бюлетень Audi, а не угода.",
          "fr": "Le bulletin d'Audi ne cite que le code moteur CAEB ; les autres codes (2.0 : CAEA, CDNB, CDNC et codes transversaux ; 1.8 : BYT, CDHB, CDAA, CDAB) proviennent d'une liste encyclopédique, et la fenêtre de 2008 à mi-2011 provient d'AUTO BILD (« probablement »). AUTO BILD parle des moteurs EA888 1.8 et 2.0 sans se limiter à Audi ; les modèles VW, SEAT et Skoda équipés de ces moteurs sont donc inclus ; la liste des modèles repose sur les applications de l'encyclopédie et peut être incomplète. Seuls les cas Audi sont documentés par un bulletin du constructeur. Une transaction américaine ultérieure et distincte (D.N.J. 1:21-cv-10546, approbation définitive le 16 mai 2024) concerne des modèles Audi 2012-2017 et ne fait pas partie de cette entrée. Aucun rappel n'a été trouvé : les données françaises RappelConso V2 n'en contiennent aucun pour la consommation d'huile. C'est le bulletin d'Audi, et non la transaction, qui donne l'explication du constructeur."
        }
      },
      "severity": "major",
      "safety": false,
      "critical": false,
      "symptoms": [
        {
          "id": "s1",
          "stage": "early",
          "text": {
            "en": "Oil level falling between services; frequent top-ups",
            "pt": "Nível de óleo a descer entre revisões; reposições frequentes",
            "ru": "Уровень масла падает между ТО; частые доливы",
            "uk": "Рівень оливи падає між ТО; часті доливи",
            "fr": "Niveau d'huile qui baisse entre les entretiens ; appoints fréquents"
          }
        },
        {
          "id": "s2",
          "stage": "late",
          "text": {
            "en": "Consumption above about one litre per 1,000 km (reported in owner cases)",
            "pt": "Consumo acima de cerca de um litro por 1 000 km (referido em casos de proprietários)",
            "ru": "Расход выше примерно литра на 1 000 км (в случаях владельцев)",
            "uk": "Витрата понад приблизно літр на 1 000 км (у випадках власників)",
            "fr": "Consommation supérieure à environ un litre aux 1 000 km (rapportée dans des cas de propriétaires)"
          }
        },
        {
          "id": "s3",
          "stage": "late",
          "text": {
            "en": "Low oil level warning light",
            "pt": "Luz de aviso de nível de óleo baixo",
            "ru": "Лампа низкого уровня масла",
            "uk": "Лампа низького рівня оливи",
            "fr": "Voyant de niveau d'huile bas"
          }
        }
      ],
      "inspection": [
        {
          "id": "i1",
          "method": "document",
          "tools": [],
          "text": {
            "en": "Confirm the engine code (CAEB and the other EA888 1.8 / 2.0 codes in the notes) and the build date; ask whether the crankcase pressure valve, front crankshaft seal and software update were done and whether the warranty extension or goodwill was used.",
            "pt": "Confirme o código do motor (CAEB e os outros códigos das notas) e a data de fabrico; pergunte se a válvula de pressão do cárter, o retentor dianteiro da cambota e a atualização de software foram feitos e se a extensão de garantia ou a boa vontade foi usada.",
            "ru": "Уточните код двигателя (CAEB и другие коды из примечаний) и дату выпуска; спросите, выполнены ли замена клапана давления картера и переднего сальника коленвала и обновление ПО, использовалось ли продление гарантии или помощь.",
            "uk": "Уточніть код двигуна (CAEB та інші коди з приміток) і дату випуску; запитайте, чи виконано заміну клапана тиску картера й переднього сальника колінвала та оновлення ПЗ, чи використовувалося подовження гарантії або допомога.",
            "fr": "Confirmez le code moteur (CAEB et les autres codes des notes) et la date de production ; demandez si la soupape de pression de carter, le joint avant de vilebrequin et la mise à jour logicielle ont été faits, et si l'extension de garantie ou le geste commercial a été utilisé."
          },
          "redFlag": null
        },
        {
          "id": "i2",
          "method": "dipstick",
          "tools": [],
          "text": {
            "en": "Check the oil level cold on level ground and ask for the service history and how often oil was added; compare with the oil change interval.",
            "pt": "Verifique o nível de óleo a frio em piso plano e peça o historial de manutenção e com que frequência foi acrescentado óleo; compare com o intervalo de mudança de óleo.",
            "ru": "Проверьте уровень масла на холодном двигателе на ровной площадке и запросите историю ТО и частоту доливов; сравните с интервалом замены масла.",
            "uk": "Перевірте рівень оливи на холодному двигуні на рівному майданчику та запросіть історію ТО і частоту доливів; порівняйте з інтервалом заміни оливи.",
            "fr": "Contrôlez le niveau d'huile à froid sur sol plat et demandez l'historique d'entretien et la fréquence des appoints ; comparez avec l'intervalle de vidange."
          },
          "redFlag": {
            "en": "A low level between services, or the seller reporting regular top-ups.",
            "pt": "Nível baixo entre revisões, ou o vendedor a referir reposições regulares.",
            "ru": "Низкий уровень между ТО или продавец сообщает о регулярных доливах.",
            "uk": "Низький рівень між ТО або продавець повідомляє про регулярні доливи.",
            "fr": "Niveau bas entre les entretiens, ou vendeur signalant des appoints réguliers."
          }
        },
        {
          "id": "i3",
          "method": "tool",
          "tools": [],
          "text": {
            "en": "Ask for a measured consumption test: Audi's method for later model years uses an electronic measurement over about 630 miles (1,000 km) without adding oil; an independent workshop can run a comparable test over the same distance.",
            "pt": "Peça um ensaio de consumo medido: o método da Audi para anos-modelo posteriores usa uma medição eletrónica durante cerca de 630 milhas (1 000 km) sem acrescentar óleo; uma oficina independente pode fazer um ensaio comparável na mesma distância.",
            "ru": "Запросите измеренный тест расхода: метод Audi для более поздних модельных годов — электронное измерение на примерно 630 милях (1 000 км) без доливов; независимая мастерская может провести сопоставимый тест на том же пробеге.",
            "uk": "Запросіть виміряний тест витрати: метод Audi для пізніших модельних років — електронне вимірювання на приблизно 630 милях (1 000 км) без доливів; незалежна майстерня може провести співставний тест на тому самому пробігу.",
            "fr": "Demandez un test de consommation mesuré : la méthode d'Audi pour des années-modèles ultérieures utilise une mesure électronique sur environ 630 miles (1 000 km) sans ajout d'huile ; un atelier indépendant peut réaliser un test comparable sur la même distance."
          },
          "redFlag": {
            "en": "Consumption near or above one litre per 1,000 km.",
            "pt": "Consumo próximo ou acima de um litro por 1 000 km.",
            "ru": "Расход около литра на 1 000 км или выше.",
            "uk": "Витрата близько літра на 1 000 км або вище.",
            "fr": "Consommation proche ou supérieure à un litre aux 1 000 km."
          }
        }
      ],
      "repair": {
        "remedy": {
          "en": "On complaint, Audi's bulletin prescribes replacing the crankcase pressure regulating valve and the front crankshaft seal, updating the engine control software and measuring oil consumption. Independent workshops quoted in AUTO BILD rebuilt the engine with new pistons and rings; the article gives one rebuilder's price of about 3,200 EUR.",
          "pt": "Perante queixa, o boletim da Audi prescreve substituir a válvula reguladora de pressão do cárter e o retentor dianteiro da cambota, atualizar o software de controlo do motor e medir o consumo de óleo. Oficinas independentes citadas pela AUTO BILD reconstruíram o motor com pistões e segmentos novos; o artigo indica o preço de um reconstrutor de cerca de 3 200 EUR.",
          "ru": "По жалобе бюллетень Audi предписывает заменить клапан регулирования давления в картере и передний сальник коленвала, обновить ПО блока управления двигателем и измерить расход масла. Независимые мастерские, упомянутые в AUTO BILD, перебирали двигатель с новыми поршнями и кольцами; в статье указана цена одного моториста около 3 200 EUR.",
          "uk": "За скаргою бюлетень Audi приписує замінити клапан регулювання тиску в картері та передній сальник колінвала, оновити ПЗ блока керування двигуном і виміряти витрату оливи. Незалежні майстерні, згадані в AUTO BILD, перебирали двигун із новими поршнями та кільцями; у статті вказано ціну одного моториста близько 3 200 EUR.",
          "fr": "Sur plainte, le bulletin d'Audi prescrit de remplacer la soupape de régulation de pression de carter et le joint avant de vilebrequin, de mettre à jour le logiciel de commande moteur et de mesurer la consommation d'huile. Des ateliers indépendants cités par AUTO BILD ont refait le moteur avec pistons et segments neufs ; l'article donne le prix d'un motoriste d'environ 3 200 EUR."
        },
        "cost": {
          "currency": "EUR",
          "low": 3200,
          "high": 6500,
          "asOf": "2017-04",
          "basis": {
            "en": "Germany, owner cases reported by AUTO BILD (2017): from about 3,200 EUR quoted by an independent engine rebuilder to an Audi repair estimate of about 6,500 EUR; one independent repair cost 4,852 EUR.",
            "pt": "Alemanha, casos de proprietários referidos pela AUTO BILD (2017): de cerca de 3 200 EUR indicados por um reconstrutor independente a um orçamento da Audi de cerca de 6 500 EUR; uma reparação independente custou 4 852 EUR.",
            "ru": "Германия, случаи владельцев по AUTO BILD (2017): от около 3 200 EUR у независимого моториста до сметы Audi около 6 500 EUR; один независимый ремонт стоил 4 852 EUR.",
            "uk": "Німеччина, випадки власників за AUTO BILD (2017): від близько 3 200 EUR в незалежного моториста до кошторису Audi близько 6 500 EUR; один незалежний ремонт коштував 4 852 EUR.",
            "fr": "Allemagne, cas de propriétaires rapportés par AUTO BILD (2017) : d'environ 3 200 EUR chez un motoriste indépendant à un devis d'Audi d'environ 6 500 EUR ; une réparation indépendante a coûté 4 852 EUR."
          },
          "evidence": [
            "ev_to_e04"
          ]
        },
        "worstCase": null,
        "manufacturerProgramme": {
          "evidence": [
            "ev_to_e01",
            "ev_to_e05"
          ],
          "text": {
            "en": "No recall was identified. Audi's service bulletin 2027731 (2011 to 2015) sets a repair on complaint. As part of a US class action settlement approved on 29 May 2015, the warranty of 2009 A4, 2010 A4 and A5 and 2011 A4, A5 and Q5 with the 2.0 TFSI (CAEB) was extended from 4 years / 50,000 miles to 8 years / 80,000 miles for repairs correcting excessive oil consumption; Audi and Volkswagen deny the allegations. AUTO BILD (2017) reports that goodwill in Germany was refused or partial in the owner cases it described.",
            "pt": "Não foi identificada nenhuma chamada. O boletim de serviço 2027731 da Audi (2011 a 2015) fixa uma reparação perante queixa. No âmbito de um acordo de ação coletiva nos EUA aprovado a 29 de maio de 2015, a garantia dos A4 2009, A4 e A5 2010 e A4, A5 e Q5 2011 com o 2.0 TFSI (CAEB) foi alargada de 4 anos / 50 000 milhas para 8 anos / 80 000 milhas para reparações que corrigem o consumo excessivo de óleo; a Audi e a Volkswagen negam as alegações. A AUTO BILD (2017) refere que a boa vontade na Alemanha foi recusada ou parcial nos casos de proprietários que descreveu.",
            "ru": "Отзыв не найден. Сервисный бюллетень Audi 2027731 (2011-2015) задаёт ремонт по жалобе. В рамках мирового соглашения по коллективному иску в США, одобренного 29 мая 2015 года, гарантия на A4 2009, A4 и A5 2010 и A4, A5 и Q5 2011 с 2.0 TFSI (CAEB) продлена с 4 лет / 50 000 миль до 8 лет / 80 000 миль на ремонт для устранения чрезмерного расхода масла; Audi и Volkswagen отрицают обвинения. AUTO BILD (2017) сообщает, что в описанных им случаях владельцев помощь в Германии была отклонена или частичной.",
            "uk": "Відкликання не знайдено. Сервісний бюлетень Audi 2027731 (2011-2015) задає ремонт за скаргою. У межах мирової угоди за колективним позовом у США, схваленої 29 травня 2015 року, гарантію на A4 2009, A4 і A5 2010 та A4, A5 і Q5 2011 із 2.0 TFSI (CAEB) подовжено з 4 років / 50 000 миль до 8 років / 80 000 миль на ремонт для усунення надмірної витрати оливи; Audi і Volkswagen заперечують звинувачення. AUTO BILD (2017) повідомляє, що в описаних ним випадках власників допомогу в Німеччині було відхилено або надано частково.",
            "fr": "Aucun rappel n'a été identifié. Le bulletin de service 2027731 d'Audi (2011 à 2015) fixe une réparation sur plainte. Dans le cadre d'un accord d'action collective américain approuvé le 29 mai 2015, la garantie des A4 2009, A4 et A5 2010 et A4, A5 et Q5 2011 à 2.0 TFSI (CAEB) a été étendue de 4 ans / 50 000 miles à 8 ans / 80 000 miles pour les réparations corrigeant une consommation d'huile excessive ; Audi et Volkswagen contestent les allégations. AUTO BILD (2017) rapporte que le geste commercial en Allemagne a été refusé ou partiel dans les cas de propriétaires décrits."
          }
        }
      },
      "evidence": [
        "ev_to_e01",
        "ev_to_e02",
        "ev_to_e03",
        "ev_to_e04",
        "ev_to_e05",
        "ev_to_e06",
        "ev_to_e07"
      ],
      "prevalence": [
        "pv_to_none",
        "pv_to_785k"
      ]
    },
    {
      "id": "waterpump",
      "aliases": [],
      "status": "published",
      "replacedBy": null,
      "revision": 1,
      "updatedAt": "2026-10-13",
      "legacyRule": "vag-known-issues",
      "title": {
        "en": "Audi 2.0 TFSI (EA888): coolant leaks at the thermostat housing or the water pump, per Audi service bulletins",
        "pt": "Audi 2.0 TFSI (EA888): fugas de líquido de refrigeração no alojamento do termóstato ou na bomba de água, segundo boletins de serviço da Audi",
        "ru": "Audi 2.0 TFSI (EA888): течи охлаждающей жидкости у корпуса термостата или помпы по сервисным бюллетеням Audi",
        "uk": "Audi 2.0 TFSI (EA888): витоки охолоджувальної рідини біля корпуса термостата чи помпи за сервісними бюлетенями Audi",
        "fr": "Audi 2.0 TFSI (EA888) : fuites de liquide de refroidissement au boîtier de thermostat ou à la pompe à eau, selon des bulletins de service d'Audi"
      },
      "summary": {
        "en": "Audi of America published bulletin 2061604 (December 2020, revised to November 2022) for coolant loss around the coolant thermostat housing or the coolant pump of the 2.0 TFSI in the A3 2007-2013, A4 2007-2016, A5 2010-2016, A6 2012-2015, A8 2013, Q3 2012-2018, Q5 2011-2017 and TT 2009-2014 (earlier revisions name the 'Evo2' engine). Customers report a coolant temperature warning light and coolant marks under the front end; the bulletin prescribes a pressure test and replacing only the leaking part. Two other Audi bulletins cover a leak at the water pump and heater hose connection (2009-2013) and a revised procedure for the water pump and thermostat housing on EA888 Evo2 (2013-2019) and Gen3 (2015-2019) engines. The sources do not say that plastic is the cause and do not extend the finding to other brands.",
        "pt": "A Audi of America publicou o boletim 2061604 (dezembro de 2020, revisto até novembro de 2022) sobre perda de líquido de refrigeração junto ao corpo do termóstato ou à bomba de água do 2.0 TFSI no A3 2007-2013, A4 2007-2016, A5 2010-2016, A6 2012-2015, A8 2013, Q3 2012-2018, Q5 2011-2017 e TT 2009-2014 (as revisões anteriores indicam o motor 'Evo2'). Os clientes referem a luz de aviso da temperatura do líquido de refrigeração e marcas de líquido sob a frente; o boletim prescreve um teste de pressão e a substituição apenas da peça com fuga. Outros dois boletins da Audi tratam de uma fuga na ligação entre a bomba de água e a mangueira do aquecimento (2009-2013) e de um procedimento revisto para a bomba de água e o corpo do termóstato nos motores EA888 Evo2 (2013-2019) e Gen3 (2015-2019). As fontes não dizem que o plástico é a causa e não alargam a conclusão a outras marcas.",
        "ru": "Audi of America выпустила бюллетень 2061604 (декабрь 2020 года, ревизии до ноября 2022 года) о потере охлаждающей жидкости в районе корпуса термостата или помпы 2.0 TFSI в A3 2007-2013, A4 2007-2016, A5 2010-2016, A6 2012-2015, A8 2013, Q3 2012-2018, Q5 2011-2017 и TT 2009-2014 (в ранних ревизиях указан мотор «Evo2»). Клиенты сообщают о лампе температуры охлаждающей жидкости и следах жидкости под передней частью; бюллетень предписывает опрессовку и замену только протекающей детали. Ещё два бюллетеня Audi касаются течи в соединении помпы со шлангом отопителя (2009-2013) и обновлённой процедуры для помпы и корпуса термостата на моторах EA888 Evo2 (2013-2019) и Gen3 (2015-2019). Источники не называют пластик причиной и не распространяют вывод на другие марки.",
        "uk": "Audi of America випустила бюлетень 2061604 (грудень 2020 року, ревізії до листопада 2022 року) щодо втрати охолоджувальної рідини в районі корпусу термостата або помпи 2.0 TFSI в A3 2007-2013, A4 2007-2016, A5 2010-2016, A6 2012-2015, A8 2013, Q3 2012-2018, Q5 2011-2017 і TT 2009-2014 (у ранніх ревізіях зазначено мотор «Evo2»). Клієнти повідомляють про лампу температури охолоджувальної рідини та сліди рідини під передньою частиною; бюлетень приписує опресування і заміну лише деталі, що протікає. Ще два бюлетені Audi стосуються течі в з'єднанні помпи зі шлангом опалювача (2009-2013) і оновленої процедури для помпи та корпусу термостата на моторах EA888 Evo2 (2013-2019) і Gen3 (2015-2019). Джерела не називають пластик причиною і не поширюють висновок на інші марки.",
        "fr": "Audi of America a publié le bulletin 2061604 (décembre 2020, révisé jusqu'en novembre 2022) pour une perte de liquide de refroidissement autour du boîtier de thermostat ou de la pompe à eau du 2.0 TFSI sur l'A3 2007-2013, l'A4 2007-2016, l'A5 2010-2016, l'A6 2012-2015, l'A8 2013, le Q3 2012-2018, le Q5 2011-2017 et le TT 2009-2014 (les révisions antérieures citent le moteur « Evo2 »). Les clients signalent le voyant de température du liquide de refroidissement et des traces de liquide sous l'avant ; le bulletin prescrit un test de pression et le remplacement de la seule pièce qui fuit. Deux autres bulletins d'Audi portent sur une fuite au raccord entre la pompe à eau et la durite de chauffage (2009-2013) et sur une procédure révisée pour la pompe à eau et le boîtier de thermostat des moteurs EA888 Evo2 (2013-2019) et Gen3 (2015-2019). Les sources ne désignent pas le plastique comme cause et n'étendent pas le constat à d'autres marques."
      },
      "checklistPrompt": {
        "en": "Cooling (Audi 2.0 TFSI) — check for coolant leaks at the water pump and thermostat housing",
        "pt": "Arrefecimento (Audi 2.0 TFSI) — verificar fugas na bomba de água e no alojamento do termóstato",
        "ru": "Охлаждение (Audi 2.0 TFSI) — проверить течи у помпы и корпуса термостата",
        "uk": "Охолодження (Audi 2.0 TFSI) — перевірити витоки біля помпи та корпуса термостата",
        "fr": "Refroidissement (Audi 2.0 TFSI) — vérifier les fuites à la pompe à eau et au boîtier de thermostat"
      },
      "component": "engine.cooling.water_pump",
      "mechanism": {
        "en": "Audi's bulletins describe the condition (coolant loss traced to the coolant thermostat housing or the coolant pump, or to the pump-to-heater-hose connection) and the repair, but state no cause; the 2013 bulletin says the seal ring is not the cause and that replacing it alone may not stop a repeat leak. A 2019 bulletin, for cars where an aluminium water pump is installed, notes that the pump seals have become available separately and says to replace the pump only if coolant leaks from its control (weep) hole.",
        "pt": "Os boletins da Audi descrevem a condição (perda de líquido localizada no corpo do termóstato ou na bomba de água, ou na ligação da bomba à mangueira do aquecimento) e a reparação, mas não indicam a causa; o boletim de 2013 diz que o anel de vedação não é a causa e que substituí-lo sozinho pode não impedir nova fuga. Um boletim de 2019, para automóveis com bomba de água de alumínio montada, refere que as juntas da bomba passaram a estar disponíveis separadamente e diz para substituir a bomba apenas se houver fuga pelo orifício de controlo.",
        "ru": "Бюллетени Audi описывают состояние (потеря жидкости у корпуса термостата или помпы либо в соединении помпы со шлангом отопителя) и ремонт, но причину не называют; бюллетень 2013 года указывает, что уплотнительное кольцо не является причиной и что его замена сама по себе может не остановить повторную течь. Бюллетень 2019 года для машин с установленной алюминиевой помпой отмечает, что уплотнения помпы стали продаваться отдельно, и предписывает менять помпу только при течи из контрольного отверстия.",
        "uk": "Бюлетені Audi описують стан (втрата рідини біля корпусу термостата чи помпи або в з'єднанні помпи зі шлангом опалювача) і ремонт, але причину не називають; бюлетень 2013 року зазначає, що ущільнювальне кільце не є причиною і що його заміна сама по собі може не зупинити повторну течу. Бюлетень 2019 року для машин зі встановленою алюмінієвою помпою зазначає, що ущільнення помпи почали продавати окремо, і приписує міняти помпу лише в разі течі з контрольного отвору.",
        "fr": "Les bulletins d'Audi décrivent la situation (perte de liquide localisée au boîtier de thermostat ou à la pompe à eau, ou au raccord pompe-durite de chauffage) et la réparation, mais n'indiquent pas de cause ; le bulletin de 2013 précise que la bague d'étanchéité n'est pas en cause et que la remplacer seule peut ne pas empêcher une nouvelle fuite. Un bulletin de 2019, pour les véhicules équipés d'une pompe à eau en aluminium, note que les joints de la pompe sont désormais vendus séparément et prescrit de ne remplacer la pompe qu'en cas de fuite par son orifice de contrôle."
      },
      "applicability": {
        "models": [
          "audi.a3",
          "audi.a4",
          "audi.a5",
          "audi.a6",
          "audi.a8",
          "audi.q3",
          "audi.q5",
          "audi.tt",
          "audi.q7"
        ],
        "when": {
          "any": [
            {
              "all": [
                {
                  "engine": {
                    "ids": [
                      "vag.ea888_20tfsi",
                      "vag.ea888_20tfsi_t"
                    ]
                  }
                },
                {
                  "any": [
                    {
                      "all": [
                        {
                          "model": [
                            "audi.a3"
                          ]
                        },
                        {
                          "modelYear": {
                            "from": 2006,
                            "to": 2014
                          }
                        }
                      ]
                    },
                    {
                      "all": [
                        {
                          "model": [
                            "audi.a4"
                          ]
                        },
                        {
                          "modelYear": {
                            "from": 2006,
                            "to": 2017
                          }
                        }
                      ]
                    },
                    {
                      "all": [
                        {
                          "model": [
                            "audi.a5"
                          ]
                        },
                        {
                          "modelYear": {
                            "from": 2009,
                            "to": 2017
                          }
                        }
                      ]
                    },
                    {
                      "all": [
                        {
                          "model": [
                            "audi.a6"
                          ]
                        },
                        {
                          "modelYear": {
                            "from": 2011,
                            "to": 2016
                          }
                        }
                      ]
                    },
                    {
                      "all": [
                        {
                          "model": [
                            "audi.a8"
                          ]
                        },
                        {
                          "modelYear": {
                            "from": 2012,
                            "to": 2014
                          }
                        }
                      ]
                    },
                    {
                      "all": [
                        {
                          "model": [
                            "audi.q3"
                          ]
                        },
                        {
                          "modelYear": {
                            "from": 2011,
                            "to": 2019
                          }
                        }
                      ]
                    },
                    {
                      "all": [
                        {
                          "model": [
                            "audi.q5"
                          ]
                        },
                        {
                          "modelYear": {
                            "from": 2010,
                            "to": 2018
                          }
                        }
                      ]
                    },
                    {
                      "all": [
                        {
                          "model": [
                            "audi.tt"
                          ]
                        },
                        {
                          "modelYear": {
                            "from": 2008,
                            "to": 2015
                          }
                        }
                      ]
                    }
                  ]
                }
              ]
            },
            {
              "all": [
                {
                  "engine": {
                    "family": [
                      "EA888"
                    ]
                  }
                },
                {
                  "modelYear": {
                    "from": 2012,
                    "to": 2020
                  }
                }
              ]
            }
          ]
        },
        "markets": [
          "US"
        ],
        "hint": {
          "en": "Audi cars with the 2.0 TFSI (EA888) in the model and year ranges of bulletin 2061604 (A3 2007-2013, A4 2007-2016, A5 2010-2016, A6 2012-2015, A8 2013, Q3 2012-2018, Q5 2011-2017, TT 2009-2014), and Audi cars of any model with an EA888 Evo2 engine from 2013 to 2019 or EA888 Gen3 from 2015 to 2019 (bulletin 2052657). Volkswagen, SEAT and Skoda cars and other engines are outside this entry.",
          "pt": "Automóveis Audi com o 2.0 TFSI (EA888) nos modelos e anos do boletim 2061604 (A3 2007-2013, A4 2007-2016, A5 2010-2016, A6 2012-2015, A8 2013, Q3 2012-2018, Q5 2011-2017, TT 2009-2014), e automóveis Audi de qualquer modelo com motor EA888 Evo2 de 2013 a 2019 ou EA888 Gen3 de 2015 a 2019 (boletim 2052657). Automóveis Volkswagen, SEAT e Skoda e outros motores ficam fora desta entrada.",
          "ru": "Машины Audi с 2.0 TFSI (EA888) в моделях и годах бюллетеня 2061604 (A3 2007-2013, A4 2007-2016, A5 2010-2016, A6 2012-2015, A8 2013, Q3 2012-2018, Q5 2011-2017, TT 2009-2014), а также Audi любой модели с мотором EA888 Evo2 2013-2019 или EA888 Gen3 2015-2019 годов (бюллетень 2052657). Машины Volkswagen, SEAT и Skoda и другие моторы в эту запись не входят.",
          "uk": "Машини Audi з 2.0 TFSI (EA888) у моделях і роках бюлетеня 2061604 (A3 2007-2013, A4 2007-2016, A5 2010-2016, A6 2012-2015, A8 2013, Q3 2012-2018, Q5 2011-2017, TT 2009-2014), а також Audi будь-якої моделі з мотором EA888 Evo2 2013-2019 або EA888 Gen3 2015-2019 років (бюлетень 2052657). Машини Volkswagen, SEAT і Skoda та інші мотори до цього запису не входять.",
          "fr": "Véhicules Audi avec le 2.0 TFSI (EA888) dans les modèles et années du bulletin 2061604 (A3 2007-2013, A4 2007-2016, A5 2010-2016, A6 2012-2015, A8 2013, Q3 2012-2018, Q5 2011-2017, TT 2009-2014), et véhicules Audi de tout modèle avec un moteur EA888 Evo2 de 2013 à 2019 ou EA888 Gen3 de 2015 à 2019 (bulletin 2052657). Les véhicules Volkswagen, SEAT et Skoda et les autres moteurs sont hors de cette entrée."
        },
        "notes": {
          "en": "The legacy entry spoke of a plastic water pump and thermostat housing on VAG cars in general; no source opened here supports that wording or any other brand, so the scope is limited to what Audi's bulletins document. The bulletins name the engine as 'Evo2' (and 'Gen3' in a 2019 bulletin) and give model years, not engine codes; the codes listed are a best-effort match from an encyclopedia list and some cars may have other codes. The latest revision of bulletin 2061604 (November 2022) lists the A4 for 2007-2013 and 2015-2016 and no longer restricts the engine version; the rule keeps the wider earlier range. The bulletins give US model years; because the year entered for a car can be its build or registration year, the rule accepts one year on either side of each range. All bulletins are US documents; no European recall or bulletin was found. The French RappelConso V2 data holds no recall for these leaks.",
          "pt": "A entrada antiga falava de bomba de água e corpo do termóstato em plástico em automóveis VAG em geral; nenhuma fonte aqui aberta suporta essa formulação nem outra marca, pelo que o âmbito se limita ao que os boletins da Audi documentam. Os boletins designam o motor como 'Evo2' (e 'Gen3' num boletim de 2019) e indicam anos-modelo, não códigos de motor; os códigos listados são uma correspondência aproximada a partir de uma lista de enciclopédia e alguns automóveis podem ter outros códigos. A revisão mais recente do boletim 2061604 (novembro de 2022) indica o A4 para 2007-2013 e 2015-2016 e deixou de restringir a versão do motor; a regra mantém o intervalo anterior, mais amplo. Os boletins indicam anos-modelo dos EUA; como o ano indicado para um automóvel pode ser o de fabrico ou de matrícula, a regra aceita um ano a mais ou a menos em cada intervalo. Todos os boletins são documentos norte-americanos; não foi encontrada nenhuma chamada nem boletim europeu. Os dados franceses RappelConso V2 não têm nenhuma chamada para estas fugas.",
          "ru": "Старая запись говорила о пластиковой помпе и корпусе термостата у машин VAG в целом; ни один открытый источник не подтверждает ни эту формулировку, ни другие марки, поэтому охват ограничен тем, что документируют бюллетени Audi. Бюллетени называют мотор «Evo2» (и «Gen3» в бюллетене 2019 года) и дают модельные годы, а не коды двигателей; перечисленные коды — приблизительное сопоставление по энциклопедическому списку, у части машин могут быть другие коды. Последняя ревизия бюллетеня 2061604 (ноябрь 2022 года) указывает A4 за 2007-2013 и 2015-2016 годы и больше не ограничивает версию мотора; правило сохраняет прежний, более широкий диапазон. Бюллетени дают американские модельные годы; поскольку указанный для машины год может быть годом выпуска или регистрации, правило допускает год в обе стороны от каждого диапазона. Все бюллетени — американские документы; европейских отзывов или бюллетеней не найдено. Во французской базе RappelConso V2 отзывов по этим течам нет.",
          "uk": "Старий запис говорив про пластикову помпу та корпус термостата в машин VAG загалом; жодне відкрите джерело не підтверджує ні цього формулювання, ні інших марок, тому охоплення обмежене тим, що документують бюлетені Audi. Бюлетені називають мотор «Evo2» (і «Gen3» у бюлетені 2019 року) та наводять модельні роки, а не коди двигунів; перелічені коди — приблизне зіставлення за енциклопедичним списком, у частини машин можуть бути інші коди. Остання ревізія бюлетеня 2061604 (листопад 2022 року) вказує A4 за 2007-2013 і 2015-2016 роки і більше не обмежує версію мотора; правило зберігає попередній, ширший діапазон. Бюлетені наводять американські модельні роки; оскільки вказаний для машини рік може бути роком випуску чи реєстрації, правило допускає рік в обидва боки від кожного діапазону. Усі бюлетені — американські документи; європейських відкликань чи бюлетенів не знайдено. У французькій базі RappelConso V2 відкликань щодо цих теч немає.",
          "fr": "L'ancienne entrée parlait d'une pompe à eau et d'un boîtier de thermostat en plastique sur les véhicules VAG en général ; aucune source ouverte ici n'étaye cette formulation ni d'autres marques, le champ est donc limité à ce que documentent les bulletins d'Audi. Les bulletins désignent le moteur comme « Evo2 » (et « Gen3 » dans un bulletin de 2019) et donnent des années-modèles, pas des codes moteur ; les codes listés sont une correspondance approximative tirée d'une liste encyclopédique et certains véhicules peuvent avoir d'autres codes. La dernière révision du bulletin 2061604 (novembre 2022) indique l'A4 pour 2007-2013 et 2015-2016 et ne restreint plus la version du moteur ; la règle conserve la plage antérieure, plus large. Les bulletins donnent des années-modèles américaines ; comme l'année saisie pour un véhicule peut être celle de fabrication ou d'immatriculation, la règle accepte une année de plus ou de moins pour chaque plage. Tous les bulletins sont des documents américains ; aucun rappel ni bulletin européen n'a été trouvé. Les données françaises RappelConso V2 ne contiennent aucun rappel pour ces fuites."
        }
      },
      "severity": "moderate",
      "safety": false,
      "critical": false,
      "symptoms": [
        {
          "id": "s1",
          "stage": "early",
          "text": {
            "en": "Coolant marks or drips under the front end of the car",
            "pt": "Marcas ou gotas de líquido de refrigeração sob a frente do automóvel",
            "ru": "Следы или капли охлаждающей жидкости под передней частью машины",
            "uk": "Сліди чи краплі охолоджувальної рідини під передньою частиною машини",
            "fr": "Traces ou gouttes de liquide de refroidissement sous l'avant de la voiture"
          }
        },
        {
          "id": "s2",
          "stage": "late",
          "text": {
            "en": "Low coolant level warning light",
            "pt": "Luz de aviso de nível baixo de líquido de refrigeração",
            "ru": "Лампа низкого уровня охлаждающей жидкости",
            "uk": "Лампа низького рівня охолоджувальної рідини",
            "fr": "Voyant de niveau bas de liquide de refroidissement"
          }
        },
        {
          "id": "s3",
          "stage": "late",
          "text": {
            "en": "Coolant temperature warning light",
            "pt": "Luz de aviso de temperatura do líquido de refrigeração",
            "ru": "Лампа температуры охлаждающей жидкости",
            "uk": "Лампа температури охолоджувальної рідини",
            "fr": "Voyant de température du liquide de refroidissement"
          }
        }
      ],
      "inspection": [
        {
          "id": "i1",
          "method": "document",
          "tools": [],
          "text": {
            "en": "Confirm the car is an Audi with the 2.0 TFSI (or another EA888 engine from 2013) and check model, year and engine code against the bulletin ranges; ask whether the water pump or thermostat housing has been replaced and when.",
            "pt": "Confirme que o automóvel é um Audi com o 2.0 TFSI (ou outro motor EA888 a partir de 2013) e verifique modelo, ano e código do motor face aos intervalos dos boletins; pergunte se a bomba de água ou o corpo do termóstato já foram substituídos e quando.",
            "ru": "Убедитесь, что это Audi с 2.0 TFSI (или другим мотором EA888 с 2013 года), и сверьте модель, год и код двигателя с диапазонами бюллетеней; спросите, менялись ли помпа или корпус термостата и когда.",
            "uk": "Переконайтеся, що це Audi з 2.0 TFSI (або іншим мотором EA888 з 2013 року), і звірте модель, рік і код двигуна з діапазонами бюлетенів; запитайте, чи мінялися помпа або корпус термостата і коли.",
            "fr": "Vérifiez qu'il s'agit d'une Audi avec le 2.0 TFSI (ou un autre moteur EA888 à partir de 2013) et contrôlez modèle, année et code moteur par rapport aux plages des bulletins ; demandez si la pompe à eau ou le boîtier de thermostat ont été remplacés et quand."
          },
          "redFlag": null
        },
        {
          "id": "i2",
          "method": "visual",
          "tools": [],
          "text": {
            "en": "With the engine cold, look under the front end and around the thermostat housing and the water pump for coolant residue, dried crusts or drips, and check the coolant level and the pump's control (weep) hole.",
            "pt": "Com o motor frio, observe sob a frente e à volta do alojamento do termóstato e da bomba de água resíduos de líquido, crostas secas ou gotas, e verifique o nível do líquido e o orifício de controlo da bomba.",
            "ru": "На холодном двигателе осмотрите низ передней части и область корпуса термостата и помпы на следы жидкости, засохшие подтёки или капли, проверьте уровень жидкости и контрольное отверстие помпы.",
            "uk": "На холодному двигуні огляньте низ передньої частини й ділянку корпуса термостата та помпи на сліди рідини, засохлі патьоки чи краплі, перевірте рівень рідини та контрольний отвір помпи.",
            "fr": "Moteur froid, examinez le dessous de l'avant et les abords du boîtier de thermostat et de la pompe à eau : résidus de liquide, croûtes séchées ou gouttes ; contrôlez le niveau de liquide et l'orifice de contrôle de la pompe."
          },
          "redFlag": {
            "en": "Wet or crusted residue at the housing or pump, or a coolant level that falls between checks.",
            "pt": "Resíduos húmidos ou com crosta no alojamento ou na bomba, ou nível de líquido que desce entre verificações.",
            "ru": "Влажные или засохшие следы на корпусе или помпе либо уровень жидкости, падающий между проверками.",
            "uk": "Вологі чи засохлі сліди на корпусі або помпі, або рівень рідини, що падає між перевірками.",
            "fr": "Résidus humides ou croûteux au boîtier ou à la pompe, ou niveau de liquide qui baisse entre les contrôles."
          }
        },
        {
          "id": "i3",
          "method": "tool",
          "tools": [],
          "text": {
            "en": "Ask a workshop for a cooling system pressure test, as the bulletin prescribes before any part is replaced.",
            "pt": "Peça a uma oficina um teste de pressão do circuito de arrefecimento, como o boletim prescreve antes de qualquer peça ser substituída.",
            "ru": "Попросите мастерскую провести опрессовку системы охлаждения, как предписывает бюллетень перед заменой любой детали.",
            "uk": "Попросіть майстерню провести опресування системи охолодження, як приписує бюлетень перед заміною будь-якої деталі.",
            "fr": "Demandez à un atelier un test en pression du circuit de refroidissement, comme le prescrit le bulletin avant tout remplacement de pièce."
          },
          "redFlag": {
            "en": "Pressure drop at the pump or thermostat housing.",
            "pt": "Queda de pressão na bomba ou no alojamento do termóstato.",
            "ru": "Падение давления у помпы или корпуса термостата.",
            "uk": "Падіння тиску біля помпи або корпуса термостата.",
            "fr": "Chute de pression à la pompe ou au boîtier de thermostat."
          }
        }
      ],
      "repair": {
        "remedy": {
          "en": "Pressure-check the cooling system and replace only the component that leaks (water pump or thermostat housing), together with its seal; the two parts are not to be replaced together unless both leak. For the pump-to-heater-hose leak of the 2009-2013 bulletin: replace the water pump with thermostat, the seal ring and the heater hose.",
          "pt": "Fazer um teste de pressão do circuito e substituir apenas o componente com fuga (bomba de água ou alojamento do termóstato), com o respetivo vedante; as duas peças não devem ser substituídas em conjunto se só uma tiver fuga. Para a fuga entre a bomba e o tubo do aquecimento do boletim de 2009-2013: substituir a bomba de água com termóstato, o anel de vedação e o tubo do aquecimento.",
          "ru": "Опрессовать систему охлаждения и заменить только текущий узел (помпу или корпус термостата) вместе с уплотнением; две детали вместе менять не нужно, если течёт только одна. При течи в соединении помпы со шлангом отопителя по бюллетеню для 2009-2013: заменить помпу с термостатом, уплотнительное кольцо и шланг отопителя.",
          "uk": "Опресувати систему охолодження і замінити лише витікаючий вузол (помпу чи корпус термостата) разом з ущільненням; дві деталі разом міняти не потрібно, якщо тече лише одна. За витоку в з'єднанні помпи зі шлангом опалювача за бюлетенем для 2009-2013: замінити помпу з термостатом, ущільнювальне кільце й шланг опалювача.",
          "fr": "Contrôler le circuit en pression et remplacer le seul composant qui fuit (pompe à eau ou boîtier de thermostat), avec son joint ; les deux pièces ne se remplacent pas ensemble si une seule fuit. Pour la fuite pompe / durit de chauffage du bulletin 2009-2013 : remplacer la pompe à eau avec thermostat, le joint et le durit de chauffage."
        },
        "cost": null,
        "worstCase": null,
        "manufacturerProgramme": null
      },
      "evidence": [
        "ev_wp_e01",
        "ev_wp_e02",
        "ev_wp_e03",
        "ev_wp_e04",
        "ev_wp_e05"
      ],
      "prevalence": [
        "pv_wp_none"
      ]
    },
    {
      "id": "vanos",
      "aliases": [],
      "status": "published",
      "replacedBy": null,
      "revision": 1,
      "updatedAt": "2026-10-13",
      "legacyRule": "bmw-known-issues",
      "title": {
        "en": "BMW N51, N52K, N52T and N55 petrol engines (2009-2012 builds): VANOS unit bolts can loosen, with internal oil leak and reduced-power mode",
        "pt": "BMW N51, N52K, N52T e N55 a gasolina (fabrico 2009-2012): os parafusos da unidade VANOS podem soltar-se, com fuga interna de óleo e modo de potência reduzida",
        "ru": "BMW N51, N52K, N52T и N55 бензин (выпуск 2009-2012): болты блока VANOS могут ослабнуть, внутренняя утечка масла и режим со сниженной мощностью",
        "uk": "BMW N51, N52K, N52T і N55 бензин (випуск 2009-2012): болти блока VANOS можуть послабнути, внутрішній витік оливи та режим зі зниженою потужністю",
        "fr": "BMW N51, N52K, N52T et N55 essence (fabrication 2009-2012) : les vis de l'unité VANOS peuvent se desserrer, avec fuite d'huile interne et mode à puissance réduite"
      },
      "summary": {
        "en": "BMW has run safety recalls for the VANOS (variable camshaft timing) adjustment units of N51, N52K, N52T and N55 petrol engines: recall 14V-176 in the USA in 2014 and recall 23V-707 effective 23 October 2023 for cars built from 2 September 2009 to 12 July 2012. BMW states that the unit bolts can loosen and break and that the units can develop an internal oil leak, which can put the engine into a reduced-power safe mode and, in rare cases, stall it.",
        "pt": "A BMW realizou chamadas de segurança para as unidades de ajuste VANOS (distribuição variável) dos motores a gasolina N51, N52K, N52T e N55: a chamada 14V-176 nos EUA em 2014 e a chamada 23V-707, em vigor desde 23 de outubro de 2023, para automóveis fabricados entre 2 de setembro de 2009 e 12 de julho de 2012. A BMW indica que os parafusos da unidade podem soltar-se e partir-se e que as unidades podem ter uma fuga interna de óleo, o que pode colocar o motor num modo de segurança com potência reduzida e, em casos raros, fazê-lo parar.",
        "ru": "BMW провела отзывные кампании по безопасности для блоков регулировки VANOS (изменение фаз газораспределения) бензиновых двигателей N51, N52K, N52T и N55: отзыв 14V-176 в США в 2014 году и отзыв 23V-707, действующий с 23 октября 2023 года, для машин выпуска со 2 сентября 2009 по 12 июля 2012 года. BMW сообщает, что болты блока могут ослабнуть и сломаться, а в блоках может возникнуть внутренняя утечка масла; это может перевести двигатель в аварийный режим со сниженной мощностью, а в редких случаях — привести к его остановке.",
        "uk": "BMW провела відкличні кампанії з безпеки для блоків регулювання VANOS (зміна фаз газорозподілу) бензинових двигунів N51, N52K, N52T і N55: відкликання 14V-176 у США в 2014 році та відкликання 23V-707, чинне з 23 жовтня 2023 року, для машин випуску з 2 вересня 2009 по 12 липня 2012 року. BMW повідомляє, що болти блока можуть послабнути й зламатися, а в блоках може виникнути внутрішній витік оливи; це може перевести двигун в аварійний режим зі зниженою потужністю, а в рідкісних випадках — призвести до його зупинки.",
        "fr": "BMW a mené des rappels de sécurité pour les unités de réglage VANOS (distribution variable) des moteurs essence N51, N52K, N52T et N55 : le rappel 14V-176 aux États-Unis en 2014 et le rappel 23V-707, en vigueur au 23 octobre 2023, pour les voitures produites du 2 septembre 2009 au 12 juillet 2012. BMW indique que les vis de l'unité peuvent se desserrer et se rompre et que les unités peuvent développer une fuite d'huile interne, ce qui peut placer le moteur en mode de secours à puissance réduite et, dans de rares cas, le faire caler."
      },
      "checklistPrompt": {
        "en": "N51/N52K/N52T/N55 petrol, built 2009-2012: VANOS bolt recall (14V-176 / 23V-707) — check it was done",
        "pt": "N51/N52K/N52T/N55 gasolina, fabrico 2009-2012: chamada dos parafusos VANOS (14V-176 / 23V-707) — verificar se foi feita",
        "ru": "N51/N52K/N52T/N55 бензин, выпуск 2009-2012: отзыв по болтам VANOS (14V-176 / 23V-707) — проверить, выполнен ли",
        "uk": "N51/N52K/N52T/N55 бензин, випуск 2009-2012: відкликання за болтами VANOS (14V-176 / 23V-707) — перевірити, чи виконано",
        "fr": "N51/N52K/N52T/N55 essence, fabrication 2009-2012 : rappel des vis VANOS (14V-176 / 23V-707) — vérifier qu'il a été effectué"
      },
      "component": "engine.timing.vvt",
      "mechanism": {
        "en": "According to BMW service bulletins, the VANOS adjustment units may develop an internal oil leakage that no longer lets the VANOS adjust quickly enough, so the engine emergency mode and engine malfunction stay permanently active. In the 2023 bulletin BMW states that the VANOS assembly bolts may, over time, loosen and eventually break; a reduced-power safe mode may then activate, the engine may not restart after being switched off and, in rare cases, the engine could stall. BMW's remedy replaces the bolts, or the whole VANOS assembly where bolts are loose or broken. A Hong Kong Transport Department notice describes the same bolting and an internal oil leak with lower oil pressure.",
        "pt": "Segundo os boletins de serviço da BMW, as unidades de ajuste VANOS podem ter uma fuga interna de óleo que deixa de permitir o ajuste rápido do VANOS, pelo que o modo de emergência e a avaria do motor ficam permanentemente ativos. No boletim de 2023, a BMW indica que os parafusos do conjunto VANOS podem, com o tempo, soltar-se e acabar por partir-se; pode então ativar-se um modo de segurança com potência reduzida, o motor pode não voltar a arrancar depois de desligado e, em casos raros, pode parar. A solução da BMW substitui os parafusos, ou o conjunto VANOS completo se estiverem soltos ou partidos. Um aviso do Departamento de Transportes de Hong Kong descreve a mesma fixação e uma fuga interna de óleo com pressão de óleo mais baixa.",
        "ru": "По сервисным бюллетеням BMW, в блоках регулировки VANOS может возникнуть внутренняя утечка масла, из-за которой VANOS перестаёт перестраиваться достаточно быстро, и аварийный режим двигателя с индикацией неисправности остаётся включённым постоянно. В бюллетене 2023 года BMW указывает, что болты узла VANOS со временем могут ослабнуть и в итоге сломаться; тогда может включиться аварийный режим со сниженной мощностью, двигатель может не завестись после остановки, а в редких случаях — заглохнуть. Мера BMW: замена болтов, а при ослабленных или сломанных болтах — всего узла VANOS. Уведомление транспортного департамента Гонконга описывает то же крепление и внутреннюю утечку масла с пониженным давлением масла.",
        "uk": "За сервісними бюлетенями BMW, у блоках регулювання VANOS може виникнути внутрішній витік оливи, через який VANOS перестає перебудовуватися достатньо швидко, і аварійний режим двигуна з індикацією несправності залишається ввімкненим постійно. У бюлетені 2023 року BMW зазначає, що болти вузла VANOS із часом можуть послабнути й зрештою зламатися; тоді може ввімкнутися аварійний режим зі зниженою потужністю, двигун може не завестися після зупинки, а в рідкісних випадках — заглохнути. Захід BMW: заміна болтів, а за послаблених чи зламаних болтів — усього вузла VANOS. Повідомлення транспортного департаменту Гонконгу описує те саме кріплення та внутрішній витік оливи зі зниженим тиском оливи.",
        "fr": "Selon les bulletins de service BMW, les unités de réglage VANOS peuvent développer une fuite d'huile interne qui ne permet plus au VANOS de s'ajuster assez vite, de sorte que le mode de secours moteur et le défaut moteur restent actifs en permanence. Dans le bulletin de 2023, BMW indique que les vis de l'ensemble VANOS peuvent, avec le temps, se desserrer puis se rompre ; un mode de secours à puissance réduite peut alors s'activer, le moteur peut ne pas redémarrer après avoir été coupé et, dans de rares cas, caler. Le remède de BMW remplace les vis, ou tout l'ensemble VANOS si des vis sont desserrées ou rompues. Un avis du département des transports de Hong Kong décrit la même fixation et une fuite d'huile interne avec une pression d'huile plus basse."
      },
      "applicability": {
        "models": [
          "bmw.1series",
          "bmw.3series",
          "bmw.5series",
          "bmw.6series",
          "bmw.7series",
          "bmw.x1",
          "bmw.x3",
          "bmw.x5",
          "bmw.x6",
          "bmw.z4"
        ],
        "when": {
          "all": [
            {
              "engine": {
                "ids": [
                  "bmw.n51",
                  "bmw.n52k",
                  "bmw.n52t",
                  "bmw.n55"
                ]
              }
            },
            {
              "productionDate": {
                "from": "2009-09",
                "to": "2012-07"
              }
            }
          ]
        },
        "markets": [
          "US",
          "HK"
        ],
        "hint": {
          "en": "Only BMW petrol cars with an N51, N52K, N52T or N55 engine built from September 2009 to July 2012 (BMW's 2023 recall window: 2 September 2009 to 12 July 2012). Other BMW engines, including the N54, are not covered by the sources used here. Cars with both VANOS units or the whole engine replaced on or after 1 September 2012 have compliant parts, according to BMW.",
          "pt": "Apenas automóveis BMW a gasolina com motor N51, N52K, N52T ou N55 fabricados entre setembro de 2009 e julho de 2012 (janela da chamada de 2023 da BMW: 2 de setembro de 2009 a 12 de julho de 2012). Outros motores BMW, incluindo o N54, não são abrangidos pelas fontes aqui usadas. Segundo a BMW, os automóveis com as duas unidades VANOS ou o motor completo substituídos em ou após 1 de setembro de 2012 têm peças conformes.",
          "ru": "Только бензиновые BMW с двигателем N51, N52K, N52T или N55 выпуска с сентября 2009 по июль 2012 года (окно отзыва BMW 2023 года: со 2 сентября 2009 по 12 июля 2012). Другие двигатели BMW, включая N54, использованными источниками не охвачены. По данным BMW, у машин, где оба блока VANOS или весь двигатель заменены 1 сентября 2012 года или позже, детали уже соответствуют требованиям.",
          "uk": "Лише бензинові BMW з двигуном N51, N52K, N52T або N55 випуску з вересня 2009 по липень 2012 року (вікно відкликання BMW 2023 року: з 2 вересня 2009 по 12 липня 2012). Інші двигуни BMW, включно з N54, використаними джерелами не охоплені. За даними BMW, у машин, де обидва блоки VANOS або весь двигун замінені 1 вересня 2012 року чи пізніше, деталі вже відповідають вимогам.",
          "fr": "Uniquement les BMW essence à moteur N51, N52K, N52T ou N55 produites de septembre 2009 à juillet 2012 (fenêtre du rappel BMW de 2023 : du 2 septembre 2009 au 12 juillet 2012). Les autres moteurs BMW, dont le N54, ne sont pas couverts par les sources utilisées ici. Selon BMW, les voitures dont les deux unités VANOS ou le moteur complet ont été remplacés le 1er septembre 2012 ou après ont des pièces conformes."
        },
        "notes": {
          "en": "The 2014 US recall (14V-176) used the window September 2009 to November 2011; the 2023 recall (23V-707) widened it to 12 July 2012 and to model years 2010-2013; a Hong Kong recall (10001167) gives builds from 9 October 2009 to 14 June 2011 and also lists the 7 Series. The recalls are documented in the USA and Hong Kong; no RappelConso record was found on 13 October 2026, so the status in the EU is not confirmed by the sources used here. The earlier checklist wording (rattle and rough idle) is not supported by the BMW documents, which describe emergency mode and reduced power.",
          "pt": "A chamada de 2014 nos EUA (14V-176) usou a janela de setembro de 2009 a novembro de 2011; a chamada de 2023 (23V-707) alargou-a a 12 de julho de 2012 e aos anos-modelo 2010-2013; uma chamada de Hong Kong (10001167) indica fabricos de 9 de outubro de 2009 a 14 de junho de 2011 e inclui também o Série 7. As chamadas estão documentadas nos EUA e em Hong Kong; não foi encontrado nenhum registo no RappelConso a 13 de outubro de 2026, pelo que o estado na UE não é confirmado pelas fontes aqui usadas. A formulação anterior da lista de verificação (ruído e ralenti irregular) não é sustentada pelos documentos da BMW, que descrevem modo de emergência e potência reduzida.",
          "ru": "Отзыв 2014 года в США (14V-176) охватывал период с сентября 2009 по ноябрь 2011 года; отзыв 2023 года (23V-707) расширил его до 12 июля 2012 года и до 2010-2013 модельных годов; отзыв в Гонконге (10001167) указывает выпуск с 9 октября 2009 по 14 июня 2011 года и включает также 7-ю серию. Отзывы задокументированы в США и Гонконге; записи в RappelConso на 13 октября 2026 года не найдено, поэтому статус в ЕС использованными источниками не подтверждён. Прежняя формулировка чек-листа (стук и неровный холостой ход) документами BMW не подтверждается: в них описаны аварийный режим и сниженная мощность.",
          "uk": "Відкликання 2014 року в США (14V-176) охоплювало період з вересня 2009 по листопад 2011 року; відкликання 2023 року (23V-707) розширило його до 12 липня 2012 року та до 2010-2013 модельних років; відкликання в Гонконгу (10001167) вказує випуск з 9 жовтня 2009 по 14 червня 2011 року й включає також 7-му серію. Відкликання задокументовані в США та Гонконгу; запису в RappelConso на 13 жовтня 2026 року не знайдено, тож статус у ЄС використаними джерелами не підтверджено. Попереднє формулювання чек-листа (стукіт і нерівний холостий хід) документами BMW не підтверджується: у них описано аварійний режим і знижену потужність.",
          "fr": "Le rappel américain de 2014 (14V-176) retenait la fenêtre de septembre 2009 à novembre 2011 ; le rappel de 2023 (23V-707) l'a élargie au 12 juillet 2012 et aux millésimes 2010-2013 ; un rappel de Hong Kong (10001167) indique des constructions du 9 octobre 2009 au 14 juin 2011 et cite aussi la Série 7. Les rappels sont documentés aux États-Unis et à Hong Kong ; aucune fiche RappelConso n'a été trouvée le 13 octobre 2026, donc le statut dans l'UE n'est pas confirmé par les sources utilisées ici. L'ancien libellé de la liste de contrôle (cliquetis et ralenti irrégulier) n'est pas étayé par les documents BMW, qui décrivent un mode de secours et une puissance réduite."
        }
      },
      "severity": "critical",
      "safety": true,
      "critical": false,
      "symptoms": [
        {
          "id": "s1",
          "stage": "early",
          "text": {
            "en": "Engine malfunction indication with the emergency mode permanently active",
            "pt": "Indicação de avaria do motor com o modo de emergência permanentemente ativo",
            "ru": "Индикация неисправности двигателя с постоянно включённым аварийным режимом",
            "uk": "Індикація несправності двигуна з постійно ввімкненим аварійним режимом",
            "fr": "Voyant de défaut moteur avec mode de secours actif en permanence"
          }
        },
        {
          "id": "s2",
          "stage": "late",
          "text": {
            "en": "Reduced engine power (safe mode)",
            "pt": "Potência do motor reduzida (modo de segurança)",
            "ru": "Сниженная мощность двигателя (аварийный режим)",
            "uk": "Знижена потужність двигуна (аварійний режим)",
            "fr": "Puissance moteur réduite (mode de secours)"
          }
        },
        {
          "id": "s3",
          "stage": "late",
          "text": {
            "en": "Engine does not restart after switching off, or stalls (rare, per BMW)",
            "pt": "O motor não volta a arrancar depois de desligado, ou para (raro, segundo a BMW)",
            "ru": "Двигатель не заводится после остановки или глохнет (редко, по данным BMW)",
            "uk": "Двигун не заводиться після зупинки або глухне (рідко, за даними BMW)",
            "fr": "Le moteur ne redémarre pas après coupure, ou cale (rare, selon BMW)"
          }
        }
      ],
      "inspection": [
        {
          "id": "i1",
          "method": "document",
          "tools": [],
          "text": {
            "en": "Confirm the engine (N51, N52K, N52T or N55) and the build date (door-pillar label or dealer VIN query) and whether it falls between September 2009 and July 2012.",
            "pt": "Confirme o motor (N51, N52K, N52T ou N55) e a data de fabrico (etiqueta do pilar da porta ou consulta do VIN no concessionário) e se se situa entre setembro de 2009 e julho de 2012.",
            "ru": "Уточните двигатель (N51, N52K, N52T или N55) и дату выпуска (наклейка в проёме двери или запрос VIN у дилера) и попадает ли она в период с сентября 2009 по июль 2012 года.",
            "uk": "Уточніть двигун (N51, N52K, N52T або N55) і дату випуску (наліпка в отворі дверей або запит VIN у дилера) та чи потрапляє вона в період з вересня 2009 по липень 2012 року.",
            "fr": "Confirmez le moteur (N51, N52K, N52T ou N55) et la date de fabrication (étiquette du montant de porte ou requête VIN chez le concessionnaire) et si elle se situe entre septembre 2009 et juillet 2012."
          },
          "redFlag": {
            "en": "Engine in the list and built in the window.",
            "pt": "Motor da lista e fabricado dentro da janela.",
            "ru": "Двигатель из списка и выпуск в этом периоде.",
            "uk": "Двигун зі списку та випуск у цьому періоді.",
            "fr": "Moteur de la liste et fabriqué dans la fenêtre."
          }
        },
        {
          "id": "i2",
          "method": "document",
          "tools": [],
          "text": {
            "en": "Ask a BMW dealer to check by VIN whether a VANOS bolt recall is open for the car (in the USA: 23V-707 and, for the earlier window, 14V-176; in Hong Kong: 10001167), and ask for proof it was completed. For 14V-176 BMW's bulletin says a campaign label with code 684 punched out on the B-pillar means it was done.",
            "pt": "Peça a um concessionário BMW que verifique pelo VIN se há uma chamada aberta para os parafusos VANOS (nos EUA: 23V-707 e, para a janela anterior, 14V-176; em Hong Kong: 10001167) e peça prova de que foi realizada. Para a 14V-176, o boletim da BMW diz que uma etiqueta de campanha com o código 684 perfurado no pilar B indica que foi feita.",
            "ru": "Попросите дилера BMW проверить по VIN, нет ли открытого отзыва по болтам VANOS (в США: 23V-707 и, для более раннего окна, 14V-176; в Гонконге: 10001167), и попросите подтверждение выполнения. Для 14V-176 бюллетень BMW говорит, что наклейка кампании с пробитым кодом 684 на стойке B означает, что работа выполнена.",
            "uk": "Попросіть дилера BMW перевірити за VIN, чи немає відкритого відкликання щодо болтів VANOS (у США: 23V-707 і, для ранішого вікна, 14V-176; у Гонконзі: 10001167), і попросіть підтвердження виконання. Для 14V-176 бюлетень BMW каже, що наліпка кампанії з пробитим кодом 684 на стійці B означає, що роботу виконано.",
            "fr": "Demandez à un concessionnaire BMW de vérifier par le VIN si un rappel sur les vis VANOS est ouvert (aux États-Unis : 23V-707 et, pour la fenêtre antérieure, 14V-176 ; à Hong Kong : 10001167), et demandez la preuve de sa réalisation. Pour le 14V-176, le bulletin BMW indique qu'une étiquette de campagne avec le code 684 poinçonné sur le montant B signifie qu'il a été effectué."
          },
          "redFlag": {
            "en": "Recall open, or no proof it was done.",
            "pt": "Chamada aberta, ou sem prova de que foi feita.",
            "ru": "Отзыв открыт или нет подтверждения выполнения.",
            "uk": "Відкликання відкрите або немає підтвердження виконання.",
            "fr": "Rappel ouvert, ou aucune preuve d'exécution."
          }
        },
        {
          "id": "i3",
          "method": "document",
          "tools": [],
          "text": {
            "en": "Ask for invoices of VANOS unit or engine replacement: according to BMW, cars with both VANOS units or a whole engine replaced on or after 1 September 2012 already have compliant parts.",
            "pt": "Peça faturas da substituição das unidades VANOS ou do motor: segundo a BMW, os automóveis com as duas unidades VANOS ou o motor completo substituídos em ou após 1 de setembro de 2012 já têm peças conformes.",
            "ru": "Запросите счета на замену блоков VANOS или двигателя: по данным BMW, у машин, где оба блока VANOS или весь двигатель заменены 1 сентября 2012 года или позже, детали уже соответствуют требованиям.",
            "uk": "Запитайте рахунки на заміну блоків VANOS або двигуна: за даними BMW, у машин, де обидва блоки VANOS або весь двигун замінені 1 вересня 2012 року чи пізніше, деталі вже відповідають вимогам.",
            "fr": "Demandez les factures de remplacement des unités VANOS ou du moteur : selon BMW, les voitures dont les deux unités VANOS ou le moteur complet ont été remplacés le 1er septembre 2012 ou après ont déjà des pièces conformes."
          },
          "redFlag": {
            "en": "In the window, recall open and no VANOS work on record.",
            "pt": "Dentro da janela, chamada aberta e sem registo de intervenção no VANOS.",
            "ru": "Выпуск в периоде, отзыв открыт и нет записей о работах с VANOS.",
            "uk": "Випуск у періоді, відкликання відкрите й немає записів про роботи з VANOS.",
            "fr": "Dans la fenêtre, rappel ouvert et aucune intervention VANOS documentée."
          }
        },
        {
          "id": "i4",
          "method": "obd",
          "tools": [],
          "text": {
            "en": "Read the fault memory and test drive for an engine warning light or an emergency (reduced-power) mode.",
            "pt": "Leia a memória de avarias e faça um teste de condução à procura de luz de avaria do motor ou de modo de emergência (potência reduzida).",
            "ru": "Считайте память ошибок и сделайте тест-драйв: нет ли контрольной лампы двигателя или аварийного режима (сниженная мощность).",
            "uk": "Зчитайте пам'ять помилок і зробіть тест-драйв: чи немає контрольної лампи двигуна або аварійного режиму (знижена потужність).",
            "fr": "Lisez la mémoire de défauts et faites un essai routier à la recherche d'un voyant moteur ou d'un mode de secours (puissance réduite)."
          },
          "redFlag": {
            "en": "Warning light or emergency mode: have a BMW specialist check the VANOS units before buying.",
            "pt": "Luz de avaria ou modo de emergência: peça a um especialista BMW para verificar as unidades VANOS antes de comprar.",
            "ru": "Контрольная лампа или аварийный режим — до покупки проверьте блоки VANOS у специалиста по BMW.",
            "uk": "Контрольна лампа або аварійний режим — до купівлі перевірте блоки VANOS у фахівця з BMW.",
            "fr": "Voyant ou mode de secours : faites contrôler les unités VANOS par un spécialiste BMW avant l'achat."
          }
        }
      ],
      "repair": {
        "remedy": {
          "en": "Replacement of the VANOS bolts; where bolts are loose or broken, replacement of the whole VANOS assembly on that side. If bolt heads are broken, the fragments must be retrieved from the engine first.",
          "pt": "Substituição dos parafusos do VANOS; se estiverem soltos ou partidos, substituição do conjunto VANOS completo desse lado. Se as cabeças dos parafusos estiverem partidas, os fragmentos têm de ser retirados primeiro do motor.",
          "ru": "Замена болтов VANOS; при ослабленных или сломанных болтах — замена всего узла VANOS с этой стороны. Если головки болтов сломаны, сначала нужно извлечь обломки из двигателя.",
          "uk": "Заміна болтів VANOS; за послаблених чи зламаних болтів — заміна всього вузла VANOS з цього боку. Якщо головки болтів зламані, спершу потрібно витягти уламки з двигуна.",
          "fr": "Remplacement des vis VANOS ; si des vis sont desserrées ou rompues, remplacement de tout l'ensemble VANOS de ce côté. Si des têtes de vis sont cassées, les morceaux doivent d'abord être retirés du moteur."
        },
        "cost": null,
        "worstCase": null,
        "manufacturerProgramme": {
          "evidence": [
            "ev_bmmb_e01",
            "ev_bmmb_e04",
            "ev_bmmb_e05"
          ],
          "text": {
            "en": "US recalls 14V-176 (2014) and 23V-707 (BMW AG voluntary safety recall effective 23 October 2023) provide the repair free of charge. For 14V-176, NHTSA also records an extended warranty for about 170,172 model year 2010-2012 inline-six cars not covered by the recall, and BMW's 2023 bulletin refers to a VANOS limited warranty extension of 10 years / unlimited mileage (SI B01 10 14).",
            "pt": "As chamadas 14V-176 (2014) e 23V-707 (chamada de segurança voluntária da BMW AG em vigor desde 23 de outubro de 2023) nos EUA incluem a reparação sem custos. Na 14V-176, a NHTSA regista também uma extensão de garantia para cerca de 170 172 automóveis de seis cilindros em linha dos anos-modelo 2010-2012 não abrangidos pela chamada, e o boletim de 2023 da BMW refere uma extensão de garantia limitada do VANOS de 10 anos / quilometragem ilimitada (SI B01 10 14).",
            "ru": "Отзывы в США 14V-176 (2014) и 23V-707 (добровольный отзыв по безопасности BMW AG, действует с 23 октября 2023 года) предусматривают бесплатный ремонт. По 14V-176 NHTSA также фиксирует расширенную гарантию для около 170 172 рядных шестицилиндровых машин 2010-2012 модельных годов, не охваченных отзывом, а бюллетень BMW 2023 года упоминает ограниченную расширенную гарантию на VANOS 10 лет без ограничения пробега (SI B01 10 14).",
            "uk": "Відкликання в США 14V-176 (2014) і 23V-707 (добровільне відкликання з безпеки BMW AG, чинне з 23 жовтня 2023 року) передбачають безкоштовний ремонт. За 14V-176 NHTSA також фіксує розширену гарантію для близько 170 172 рядних шестициліндрових машин 2010-2012 модельних років, не охоплених відкликанням, а бюлетень BMW 2023 року згадує обмежену розширену гарантію на VANOS 10 років без обмеження пробігу (SI B01 10 14).",
            "fr": "Les rappels américains 14V-176 (2014) et 23V-707 (rappel de sécurité volontaire de BMW AG en vigueur au 23 octobre 2023) prévoient la réparation gratuite. Pour le 14V-176, la NHTSA consigne aussi une extension de garantie pour environ 170 172 voitures six cylindres en ligne des millésimes 2010-2012 non couvertes par le rappel, et le bulletin BMW de 2023 mentionne une extension de garantie limitée du VANOS de 10 ans / kilométrage illimité (SI B01 10 14)."
          }
        }
      },
      "evidence": [
        "ev_bmmb_e01",
        "ev_bmmb_e02",
        "ev_bmmb_e03",
        "ev_bmmb_e04",
        "ev_bmmb_e05",
        "ev_bmmb_e06"
      ],
      "prevalence": [
        "pv_vanos_14v176",
        "pv_vanos_23v707",
        "pv_vanos_elw",
        "pv_vanos_none"
      ]
    },
    {
      "id": "oil.leaks",
      "aliases": [],
      "status": "published",
      "replacedBy": null,
      "revision": 1,
      "updatedAt": "2026-10-13",
      "legacyRule": "bmw-known-issues",
      "title": {
        "en": "BMW N20 and N55 petrol engines (August 2011 to March 2012 builds): plastic oil filter housing oil or coolant leak",
        "pt": "BMW N20 e N55 a gasolina (fabrico agosto de 2011 a março de 2012): fuga de óleo ou de líquido de refrigeração no suporte plástico do filtro de óleo",
        "ru": "BMW N20 и N55 бензин (выпуск август 2011 — март 2012): утечка масла или охлаждающей жидкости из пластикового корпуса масляного фильтра",
        "uk": "BMW N20 і N55 бензин (випуск серпень 2011 — березень 2012): витік оливи чи охолодної рідини з пластикового корпусу оливного фільтра",
        "fr": "BMW N20 et N55 essence (fabrication août 2011 à mars 2012) : fuite d'huile ou de liquide de refroidissement du boîtier plastique du filtre à huile"
      },
      "summary": {
        "en": "BMW issued service actions in 2015 for N20 and N55 engines built from August 2011 to March 2012: the plastic oil filter housing may fail and lead to an internal and/or external engine oil or coolant leak. Dealers inspect the housing and replace it if it is the plastic (black) type; the aluminium (silver) type needs no action. The earlier checklist item also named valve cover gaskets; no usable source was found for that and it is not covered here.",
        "pt": "A BMW emitiu em 2015 ações de serviço para os motores N20 e N55 fabricados entre agosto de 2011 e março de 2012: o suporte plástico do filtro de óleo pode falhar e provocar uma fuga interna e/ou externa de óleo do motor ou de líquido de refrigeração. Os concessionários inspecionam o suporte e substituem-no se for do tipo plástico (preto); o de alumínio (prateado) não requer ação. O item anterior da lista de verificação referia também as juntas da tampa de válvulas; não foi encontrada fonte utilizável para isso e não é abrangido aqui.",
        "ru": "BMW в 2015 году выпустила сервисные акции для двигателей N20 и N55 выпуска с августа 2011 по март 2012 года: пластиковый корпус масляного фильтра может выйти из строя и привести к внутренней и (или) наружной утечке моторного масла или охлаждающей жидкости. Дилеры осматривают корпус и заменяют его, если он пластиковый (чёрный); алюминиевый (серебристый) действий не требует. В прежнем пункте чек-листа упоминались и прокладки клапанной крышки; пригодных источников по ним не найдено, и здесь они не рассматриваются.",
        "uk": "BMW у 2015 році випустила сервісні акції для двигунів N20 і N55 випуску з серпня 2011 по березень 2012 року: пластиковий корпус оливного фільтра може вийти з ладу й призвести до внутрішнього та (або) зовнішнього витоку моторної оливи чи охолодної рідини. Дилери оглядають корпус і замінюють його, якщо він пластиковий (чорний); алюмінієвий (сріблястий) дій не потребує. У попередньому пункті чек-листа згадувалися й прокладки кришки клапанів; придатних джерел щодо них не знайдено, і тут вони не розглядаються.",
        "fr": "BMW a lancé en 2015 des actions de service pour les moteurs N20 et N55 produits d'août 2011 à mars 2012 : le boîtier plastique du filtre à huile peut défaillir et entraîner une fuite interne et/ou externe d'huile moteur ou de liquide de refroidissement. Les concessionnaires inspectent le boîtier et le remplacent s'il est en plastique (noir) ; le type aluminium (argent) ne demande aucune action. L'ancien point de la liste de contrôle citait aussi les joints de couvre-culasse ; aucune source exploitable n'a été trouvée et ils ne sont pas couverts ici."
      },
      "checklistPrompt": {
        "en": "N20/N55 petrol, built Aug 2011 - Mar 2012: oil filter housing — plastic (black) or aluminium (silver)? BMW service action",
        "pt": "N20/N55 gasolina, fabrico ago. 2011 - mar. 2012: suporte do filtro de óleo — plástico (preto) ou alumínio (prateado)? Ação de serviço BMW",
        "ru": "N20/N55 бензин, выпуск авг. 2011 — март 2012: корпус масляного фильтра — пластиковый (чёрный) или алюминиевый (серебристый)? Сервисная акция BMW",
        "uk": "N20/N55 бензин, випуск серп. 2011 — берез. 2012: корпус оливного фільтра — пластиковий (чорний) чи алюмінієвий (сріблястий)? Сервісна акція BMW",
        "fr": "N20/N55 essence, fabrication août 2011 - mars 2012 : boîtier du filtre à huile — plastique (noir) ou aluminium (argent) ? Action de service BMW"
      },
      "component": "engine.lubrication.oil_filter_housing",
      "mechanism": {
        "en": "According to BMW's service actions, the plastic oil filter housing fitted to N20 and N55 engines in the stated builds may fail and lead to an internal and/or external leak of engine oil or coolant. BMW's remedy is to replace the plastic (black) housing with a new one; cars already fitted with the aluminium (silver) housing need no action. The BMW documents give no cause for the failure.",
        "pt": "Segundo as ações de serviço da BMW, o suporte plástico do filtro de óleo montado nos motores N20 e N55 nas fabricações indicadas pode falhar e provocar uma fuga interna e/ou externa de óleo do motor ou de líquido de refrigeração. A solução da BMW é substituir o suporte plástico (preto) por um novo; os automóveis que já têm o suporte de alumínio (prateado) não requerem ação. Os documentos da BMW não indicam a causa da falha.",
        "ru": "По сервисным акциям BMW, пластиковый корпус масляного фильтра, установленный на двигателях N20 и N55 указанных периодов выпуска, может выйти из строя и привести к внутренней и (или) наружной утечке моторного масла или охлаждающей жидкости. Мера BMW — заменить пластиковый (чёрный) корпус на новый; машины, уже оснащённые алюминиевым (серебристым) корпусом, действий не требуют. Причина отказа в документах BMW не названа.",
        "uk": "За сервісними акціями BMW, пластиковий корпус оливного фільтра, встановлений на двигунах N20 і N55 зазначених періодів випуску, може вийти з ладу й призвести до внутрішнього та (або) зовнішнього витоку моторної оливи чи охолодної рідини. Захід BMW — замінити пластиковий (чорний) корпус на новий; машини, уже оснащені алюмінієвим (сріблястим) корпусом, дій не потребують. Причину відмови в документах BMW не названо.",
        "fr": "Selon les actions de service de BMW, le boîtier plastique du filtre à huile monté sur les moteurs N20 et N55 des fabrications indiquées peut défaillir et entraîner une fuite interne et/ou externe d'huile moteur ou de liquide de refroidissement. Le remède de BMW consiste à remplacer le boîtier plastique (noir) par un neuf ; les voitures déjà équipées du boîtier aluminium (argent) ne demandent aucune action. Les documents BMW n'indiquent pas la cause de la défaillance."
      },
      "applicability": {
        "models": [
          "bmw.x1",
          "bmw.z4",
          "bmw.5series",
          "bmw.x3",
          "bmw.3series"
        ],
        "when": {
          "any": [
            {
              "all": [
                {
                  "productionDate": {
                    "from": "2011-08",
                    "to": "2012-03"
                  }
                },
                {
                  "any": [
                    {
                      "engine": {
                        "ids": [
                          "bmw.n20"
                        ]
                      }
                    },
                    {
                      "all": [
                        {
                          "engine": {
                            "ids": [
                              "bmw.n55"
                            ]
                          }
                        },
                        {
                          "model": [
                            "bmw.3series"
                          ]
                        }
                      ]
                    }
                  ]
                }
              ]
            },
            {
              "all": [
                {
                  "engine": {
                    "ids": [
                      "bmw.n55"
                    ]
                  }
                },
                {
                  "productionDate": {
                    "from": "2011-08",
                    "to": "2012-01"
                  }
                }
              ]
            }
          ]
        },
        "markets": [
          "US"
        ],
        "hint": {
          "en": "BMW cars with the N20 engine (E84 X1, E89 Z4, F10 5 Series, F25 X3, F30 3 Series) or the N55 engine in the F30 3 Series built from August 2011 to March 2012, and other N55 cars of these series built from August 2011 to January 2012, and only if the oil filter housing is the black plastic type. Other BMW engines and other build dates are not covered.",
          "pt": "Automóveis BMW com o motor N20 (E84 X1, E89 Z4, F10 Série 5, F25 X3, F30 Série 3) ou o motor N55 no F30 Série 3 fabricados de agosto de 2011 a março de 2012, e outros automóveis N55 destas séries fabricados de agosto de 2011 a janeiro de 2012, e apenas se o corpo do filtro de óleo for o tipo em plástico preto. Outros motores BMW e outras datas de fabrico não estão abrangidos.",
          "ru": "Машины BMW с мотором N20 (E84 X1, E89 Z4, F10 5 серии, F25 X3, F30 3 серии) или с N55 в F30 3 серии выпуска с августа 2011 по март 2012 года, а также другие машины этих серий с N55 выпуска с августа 2011 по январь 2012 года, и только если корпус масляного фильтра чёрный пластиковый. Другие моторы BMW и другие даты выпуска не охвачены.",
          "uk": "Машини BMW з мотором N20 (E84 X1, E89 Z4, F10 5 серії, F25 X3, F30 3 серії) або з N55 в F30 3 серії випуску з серпня 2011 по березень 2012 року, а також інші машини цих серій з N55 випуску з серпня 2011 по січень 2012 року, і лише якщо корпус оливного фільтра чорний пластиковий. Інші мотори BMW та інші дати випуску не охоплено.",
          "fr": "Véhicules BMW avec le moteur N20 (E84 X1, E89 Z4, F10 Série 5, F25 X3, F30 Série 3) ou le moteur N55 sur la F30 Série 3 produits d'août 2011 à mars 2012, et autres véhicules N55 de ces séries produits d'août 2011 à janvier 2012, et seulement si le boîtier de filtre à huile est le type en plastique noir. Les autres moteurs BMW et les autres dates de production ne sont pas couverts."
        },
        "notes": {
          "en": "The BMW bulletins are US service documents (BMW of North America); whether the same housings were fitted to European-market cars is not stated in them. BMW's N55 service action names only the F30; a separate BMW information bulletin lists the black plastic housing on N20 and N55 engines in E84, E89, F10, F10H, F25 and F30 cars built from August 2011 to January 2012, so other N55 cars of those builds are included as possible: check the housing colour. The N20 action lists labour operations for inspection only (aluminium) and for replacement (plastic). No failure rate or repair cost is published in the sources used here.",
          "pt": "Os boletins da BMW são documentos de serviço norte-americanos (BMW of North America); não indicam se os mesmos corpos foram montados em automóveis do mercado europeu. A ação de serviço da BMW para o N55 só indica o F30; um boletim de informação BMW separado indica o corpo em plástico preto nos motores N20 e N55 dos E84, E89, F10, F10H, F25 e F30 fabricados de agosto de 2011 a janeiro de 2012, pelo que outros automóveis N55 desse período ficam incluídos como possíveis: verifique a cor do corpo. A ação para o N20 indica operações de mão de obra só para inspeção (alumínio) e para substituição (plástico). As fontes aqui usadas não publicam taxa de avarias nem custo de reparação.",
          "ru": "Бюллетени BMW — американские сервисные документы (BMW of North America); ставились ли такие же корпуса на машины европейского рынка, в них не сказано. Сервисная акция BMW для N55 называет только F30; отдельный информационный бюллетень BMW указывает чёрный пластиковый корпус на моторах N20 и N55 в E84, E89, F10, F10H, F25 и F30 выпуска с августа 2011 по январь 2012 года, поэтому другие машины с N55 этого периода включены как возможные: проверьте цвет корпуса. Для N20 акция указывает трудовые операции только для осмотра (алюминий) и для замены (пластик). Доля отказов и стоимость ремонта в использованных источниках не опубликованы.",
          "uk": "Бюлетені BMW — американські сервісні документи (BMW of North America); чи ставилися такі самі корпуси на машини європейського ринку, у них не сказано. Сервісна акція BMW для N55 називає лише F30; окремий інформаційний бюлетень BMW зазначає чорний пластиковий корпус на моторах N20 і N55 в E84, E89, F10, F10H, F25 і F30 випуску з серпня 2011 по січень 2012 року, тому інші машини з N55 цього періоду включено як можливі: перевірте колір корпусу. Для N20 акція вказує трудові операції лише для огляду (алюміній) і для заміни (пластик). Частка відмов і вартість ремонту у використаних джерелах не опубліковані.",
          "fr": "Les bulletins BMW sont des documents de service américains (BMW of North America) ; ils ne disent pas si les mêmes boîtiers ont été montés sur des véhicules du marché européen. L'action de service BMW pour le N55 ne cite que la F30 ; un bulletin d'information BMW distinct indique le boîtier en plastique noir sur les moteurs N20 et N55 des E84, E89, F10, F10H, F25 et F30 produits d'août 2011 à janvier 2012, si bien que les autres véhicules N55 de cette période sont inclus comme possibles : vérifiez la couleur du boîtier. L'action N20 prévoit des opérations de main-d'œuvre pour la seule inspection (aluminium) et pour le remplacement (plastique). Aucun taux de défaillance ni coût de réparation n'est publié dans les sources utilisées ici."
        }
      },
      "severity": "moderate",
      "safety": false,
      "critical": false,
      "symptoms": [
        {
          "id": "s1",
          "stage": "early",
          "text": {
            "en": "Engine oil or coolant leaking at the oil filter housing",
            "pt": "Fuga de óleo ou de líquido de refrigeração no suporte do filtro de óleo",
            "ru": "Течь масла или охлаждающей жидкости у корпуса масляного фильтра",
            "uk": "Витік оливи чи охолодної рідини біля корпусу оливного фільтра",
            "fr": "Fuite d'huile ou de liquide de refroidissement au boîtier du filtre à huile"
          }
        },
        {
          "id": "s2",
          "stage": "late",
          "text": {
            "en": "Internal leak of engine oil or coolant",
            "pt": "Fuga interna de óleo do motor ou de líquido de refrigeração",
            "ru": "Внутренняя утечка моторного масла или охлаждающей жидкости",
            "uk": "Внутрішній витік моторної оливи чи охолодної рідини",
            "fr": "Fuite interne d'huile moteur ou de liquide de refroidissement"
          }
        }
      ],
      "inspection": [
        {
          "id": "i1",
          "method": "document",
          "tools": [],
          "text": {
            "en": "Confirm the engine (N20, or N55) and the build date (door-pillar label or dealer VIN query): August 2011 to March 2012 for the N20 and the N55 in an F30, August 2011 to January 2012 for other N55 cars.",
            "pt": "Confirme o motor (N20 ou N55) e a data de fabrico (etiqueta no pilar da porta ou consulta do VIN no concessionário): agosto de 2011 a março de 2012 para o N20 e para o N55 no F30, agosto de 2011 a janeiro de 2012 para outros automóveis N55.",
            "ru": "Подтвердите двигатель (N20 или N55) и дату выпуска (табличка на стойке двери или запрос по VIN у дилера): с августа 2011 по март 2012 года для N20 и для N55 в F30, с августа 2011 по январь 2012 года для других машин с N55.",
            "uk": "Підтвердіть двигун (N20 або N55) і дату випуску (табличка на стійці дверей або запит за VIN у дилера): з серпня 2011 по березень 2012 року для N20 і для N55 в F30, з серпня 2011 по січень 2012 року для інших машин з N55.",
            "fr": "Vérifiez le moteur (N20 ou N55) et la date de production (étiquette de montant de porte ou requête VIN chez un concessionnaire) : d'août 2011 à mars 2012 pour le N20 et pour le N55 sur la F30, d'août 2011 à janvier 2012 pour les autres véhicules N55."
          },
          "redFlag": {
            "en": "Engine and build date in range.",
            "pt": "Motor e data de fabrico dentro do intervalo.",
            "ru": "Двигатель и дата выпуска в диапазоне.",
            "uk": "Двигун і дата випуску в діапазоні.",
            "fr": "Moteur et date de fabrication dans la plage."
          }
        },
        {
          "id": "i2",
          "method": "visual",
          "tools": [],
          "text": {
            "en": "Look at the oil filter housing: black plastic is the type BMW's service action replaces; silver aluminium needs no action. Look around it for oil or coolant residue.",
            "pt": "Observe o suporte do filtro de óleo: o plástico preto é o tipo que a ação de serviço da BMW substitui; o alumínio prateado não requer ação. Procure à volta resíduos de óleo ou de líquido de refrigeração.",
            "ru": "Осмотрите корпус масляного фильтра: чёрный пластик — тип, который заменяет сервисная акция BMW; серебристый алюминий действий не требует. Проверьте вокруг следы масла или охлаждающей жидкости.",
            "uk": "Огляньте корпус оливного фільтра: чорний пластик — тип, який замінює сервісна акція BMW; сріблястий алюміній дій не потребує. Перевірте навколо сліди оливи чи охолодної рідини.",
            "fr": "Regardez le boîtier du filtre à huile : le plastique noir est le type que remplace l'action de service BMW ; l'aluminium argent ne demande aucune action. Cherchez autour des traces d'huile ou de liquide de refroidissement."
          },
          "redFlag": {
            "en": "Black plastic housing, or oil or coolant residue around it.",
            "pt": "Suporte de plástico preto, ou resíduos de óleo ou de líquido de refrigeração à volta.",
            "ru": "Чёрный пластиковый корпус или следы масла либо охлаждающей жидкости вокруг него.",
            "uk": "Чорний пластиковий корпус або сліди оливи чи охолодної рідини навколо нього.",
            "fr": "Boîtier plastique noir, ou traces d'huile ou de liquide de refroidissement autour."
          }
        },
        {
          "id": "i3",
          "method": "document",
          "tools": [],
          "text": {
            "en": "Ask for invoices showing the oil filter housing was inspected or replaced under BMW's service action (SI B11 13 15 for N20, SI B11 14 15 for N55).",
            "pt": "Peça faturas que mostrem que o suporte do filtro de óleo foi inspecionado ou substituído ao abrigo da ação de serviço da BMW (SI B11 13 15 para o N20, SI B11 14 15 para o N55).",
            "ru": "Запросите счета, подтверждающие, что корпус масляного фильтра осмотрен или заменён по сервисной акции BMW (SI B11 13 15 для N20, SI B11 14 15 для N55).",
            "uk": "Запитайте рахунки, що підтверджують, що корпус оливного фільтра оглянуто чи замінено за сервісною акцією BMW (SI B11 13 15 для N20, SI B11 14 15 для N55).",
            "fr": "Demandez les factures montrant que le boîtier du filtre à huile a été inspecté ou remplacé dans le cadre de l'action de service BMW (SI B11 13 15 pour le N20, SI B11 14 15 pour le N55)."
          },
          "redFlag": {
            "en": "Plastic housing in the build window and no record of the action.",
            "pt": "Suporte de plástico na janela de fabrico e sem registo da ação.",
            "ru": "Пластиковый корпус в периоде выпуска и нет записей об акции.",
            "uk": "Пластиковий корпус у періоді випуску й немає записів про акцію.",
            "fr": "Boîtier plastique dans la fenêtre de fabrication et aucune trace de l'action."
          }
        }
      ],
      "repair": {
        "remedy": {
          "en": "Replacement of the plastic oil filter housing (with the related seals and coolant hoses listed in the BMW bulletin) on cars that have the black plastic type; no action for the aluminium type.",
          "pt": "Substituição do suporte plástico do filtro de óleo (com os vedantes e mangueiras de refrigeração indicados no boletim da BMW) nos automóveis com o tipo plástico preto; nenhuma ação no tipo de alumínio.",
          "ru": "Замена пластикового корпуса масляного фильтра (с уплотнениями и патрубками охлаждающей жидкости из перечня в бюллетене BMW) на машинах с чёрным пластиковым корпусом; для алюминиевого типа действий нет.",
          "uk": "Заміна пластикового корпусу оливного фільтра (з ущільненнями та патрубками охолодної рідини з переліку в бюлетені BMW) на машинах із чорним пластиковим корпусом; для алюмінієвого типу дій немає.",
          "fr": "Remplacement du boîtier plastique du filtre à huile (avec les joints et durites de refroidissement listés dans le bulletin BMW) sur les voitures qui ont le type plastique noir ; aucune action pour le type aluminium."
        },
        "cost": null,
        "worstCase": null,
        "manufacturerProgramme": {
          "evidence": [
            "ev_bmmb_e07",
            "ev_bmmb_e08"
          ],
          "text": {
            "en": "BMW service actions SI B11 13 15 (N20) and SI B11 14 15 (N55), 2015: dealers inspect the housing and replace the plastic (black) type. The bulletins give dealer reimbursement labour operations but do not state the terms for owners.",
            "pt": "Ações de serviço BMW SI B11 13 15 (N20) e SI B11 14 15 (N55), 2015: os concessionários inspecionam o suporte e substituem o tipo plástico (preto). Os boletins indicam operações de mão de obra reembolsadas aos concessionários, mas não indicam as condições para os proprietários.",
            "ru": "Сервисные акции BMW SI B11 13 15 (N20) и SI B11 14 15 (N55), 2015 год: дилеры осматривают корпус и заменяют пластиковый (чёрный) тип. В бюллетенях указаны трудовые операции с компенсацией дилерам, но условия для владельцев не приведены.",
            "uk": "Сервісні акції BMW SI B11 13 15 (N20) і SI B11 14 15 (N55), 2015 рік: дилери оглядають корпус і замінюють пластиковий (чорний) тип. У бюлетенях указано трудові операції з компенсацією дилерам, але умов для власників не наведено.",
            "fr": "Actions de service BMW SI B11 13 15 (N20) et SI B11 14 15 (N55), 2015 : les concessionnaires inspectent le boîtier et remplacent le type plastique (noir). Les bulletins donnent les opérations de main-d'œuvre remboursées aux concessionnaires mais n'indiquent pas les conditions pour les propriétaires."
          }
        }
      },
      "evidence": [
        "ev_bmmb_e07",
        "ev_bmmb_e08",
        "ev_bmmb_e09"
      ],
      "prevalence": [
        "pv_oil_none"
      ]
    },
    {
      "id": "om651.injectors",
      "aliases": [],
      "status": "published",
      "replacedBy": null,
      "revision": 1,
      "updatedAt": "2026-10-13",
      "legacyRule": "mercedes-known-issues",
      "title": {
        "en": "Mercedes OM651 diesel 220 CDI and 250 CDI (from 2009): early piezo injector failures",
        "pt": "Mercedes OM651 diesel 220 CDI e 250 CDI (a partir de 2009): falhas dos primeiros injetores piezo",
        "ru": "Mercedes OM651 дизель 220 CDI и 250 CDI (с 2009): отказы ранних пьезофорсунок",
        "uk": "Mercedes OM651 дизель 220 CDI і 250 CDI (з 2009): відмови ранніх п'єзофорсунок",
        "fr": "Mercedes OM651 diesel 220 CDI et 250 CDI (à partir de 2009) : pannes des premiers injecteurs piézo"
      },
      "summary": {
        "en": "Press reports from 2009 to 2012, quoting Mercedes, describe failures of the piezo injectors of the new OM651 diesel in the 220 CDI and 250 CDI (C-Class, E-Class, GLK), with the engine warning light, uneven running and, at worst, limp-home mode. Mercedes attributed the cases to production-related electrical faults at its injector supplier and ran customer-service measures (injector replacement, warranty extension or vouchers depending on the country). It was not an official recall in France.",
        "pt": "Reportagens de 2009 a 2012, que citam a Mercedes, descrevem falhas dos injetores piezo do novo diesel OM651 nos 220 CDI e 250 CDI (Classe C, Classe E, GLK), com luz de aviso do motor, funcionamento irregular e, no pior caso, modo de emergência (limp-home). A Mercedes atribuiu os casos a falhas elétricas ligadas à produção no seu fornecedor de injetores e executou medidas de apoio ao cliente (substituição dos injetores, extensão de garantia ou vales consoante o país). Em França não foi uma chamada oficial.",
        "ru": "В публикациях прессы 2009-2012 годов со ссылкой на Mercedes описаны отказы пьезофорсунок нового дизеля OM651 на 220 CDI и 250 CDI (C-класс, E-класс, GLK): контрольная лампа двигателя, неровная работа и, в худшем случае, аварийный режим (limp-home). Mercedes объяснила случаи связанными с производством электрическими дефектами у поставщика форсунок и провела клиентские меры (замена форсунок, продление гарантии или ваучеры — в зависимости от страны). Во Франции это не был официальный отзыв.",
        "uk": "У публікаціях преси 2009-2012 років із посиланням на Mercedes описано відмови п'єзофорсунок нового дизеля OM651 на 220 CDI і 250 CDI (C-клас, E-клас, GLK): контрольна лампа двигуна, нерівна робота та, у гіршому разі, аварійний режим (limp-home). Mercedes пояснила випадки пов'язаними з виробництвом електричними дефектами в постачальника форсунок і провела клієнтські заходи (заміна форсунок, продовження гарантії або ваучери — залежно від країни). У Франції це не було офіційним відкликанням.",
        "fr": "Des articles de presse de 2009 à 2012, citant Mercedes, décrivent des pannes des injecteurs piézo du nouveau diesel OM651 des 220 CDI et 250 CDI (Classe C, Classe E, GLK), avec voyant moteur, fonctionnement irrégulier et, au pire, mode dégradé (limp-home). Mercedes a attribué les cas à des défauts électriques liés à la production chez son fournisseur d'injecteurs et a mené des mesures commerciales (remplacement des injecteurs, extension de garantie ou bons selon les pays). En France, ce n'était pas un rappel officiel."
      },
      "checklistPrompt": {
        "en": "OM651 diesel 220/250 CDI (2009+): injectors — replaced under Mercedes measure? Warning light or limp mode?",
        "pt": "OM651 diesel 220/250 CDI (2009+): injetores — substituídos ao abrigo da medida Mercedes? Luz de aviso ou modo de emergência?",
        "ru": "OM651 дизель 220/250 CDI (2009+): форсунки — заменены по мере Mercedes? Есть ли контрольная лампа или аварийный режим?",
        "uk": "OM651 дизель 220/250 CDI (2009+): форсунки — замінені за заходом Mercedes? Чи є контрольна лампа або аварійний режим?",
        "fr": "OM651 diesel 220/250 CDI (2009+) : injecteurs — remplacés dans le cadre de la mesure Mercedes ? Voyant ou mode dégradé ?"
      },
      "component": "engine.fuel.injector",
      "mechanism": {
        "en": "The OM651 220 CDI and 250 CDI used new-generation piezo injectors (2,000 bar). According to Mercedes, as quoted by AUTO BILD in 2009, technical analysis traced the cases mainly to production-related electrical faults of the injector, corrected at the supplier; AUTO BILD and L'argus name the supplier as Delphi, and L'argus says the manufacturer declined to answer its questions on this point. In January 2012 Daimler told AUTO BILD that the then-current failures came from contact problems at the connector, possibly after repeated injector replacement, and that the injector wiring harness was being replaced with an optimised part at inspections. Mercedes said the 200 CDI, with magnetically controlled injectors, was not affected.",
        "pt": "O OM651 220 CDI e 250 CDI usava injetores piezoelétricos de nova geração (2 000 bar). Segundo a Mercedes, citada pela AUTO BILD em 2009, a análise técnica atribuiu os casos sobretudo a falhas elétricas do injetor ligadas à produção, corrigidas no fornecedor; a AUTO BILD e a L'argus indicam a Delphi como fornecedor, e a L'argus diz que o fabricante não quis responder às suas perguntas sobre este ponto. Em janeiro de 2012 a Daimler disse à AUTO BILD que as avarias de então vinham de problemas de contacto na ficha, possivelmente após substituições repetidas de injetores, e que a cablagem dos injetores estava a ser substituída por uma peça otimizada nas revisões. A Mercedes disse que o 200 CDI, com injetores de comando magnético, não era afetado.",
        "ru": "OM651 в версиях 220 CDI и 250 CDI использовал пьезофорсунки нового поколения (2 000 бар). По словам Mercedes, приведённым AUTO BILD в 2009 году, технический анализ связал случаи в основном с производственными электрическими дефектами форсунки, устранёнными у поставщика; AUTO BILD и L'argus называют поставщиком Delphi, а L'argus пишет, что производитель не стал отвечать на вопросы журнала по этому поводу. В январе 2012 года Daimler сообщила AUTO BILD, что текущие отказы вызваны проблемами контакта в разъёме, возможно после многократной замены форсунок, и что жгут проводов форсунок при ТО заменяют на доработанный. Mercedes заявила, что 200 CDI с электромагнитными форсунками не затронут.",
        "uk": "OM651 у версіях 220 CDI і 250 CDI використовував п'єзофорсунки нового покоління (2 000 бар). За словами Mercedes, наведеними AUTO BILD у 2009 році, технічний аналіз пов'язав випадки переважно з виробничими електричними дефектами форсунки, усуненими в постачальника; AUTO BILD і L'argus називають постачальником Delphi, а L'argus пише, що виробник не став відповідати на запитання журналу щодо цього. У січні 2012 року Daimler повідомила AUTO BILD, що поточні відмови спричинені проблемами контакту в роз'ємі, можливо після багаторазової заміни форсунок, і що джгут проводів форсунок під час ТО замінюють на доопрацьований. Mercedes заявила, що 200 CDI з електромагнітними форсунками не зачеплений.",
        "fr": "Les OM651 220 CDI et 250 CDI utilisaient des injecteurs piézo de nouvelle génération (2 000 bars). Selon Mercedes, citée par AUTO BILD en 2009, l'analyse technique a attribué les cas surtout à des défauts électriques de l'injecteur liés à la production, corrigés chez le fournisseur ; AUTO BILD et L'argus désignent Delphi comme fournisseur, et L'argus indique que le constructeur n'a pas souhaité répondre à ses questions sur ce point. En janvier 2012, Daimler a indiqué à AUTO BILD que les pannes d'alors venaient de problèmes de contact au connecteur, éventuellement après des remplacements répétés d'injecteurs, et que le faisceau des injecteurs était remplacé par une pièce optimisée lors des entretiens. Mercedes a déclaré que le 200 CDI, à injecteurs à commande magnétique, n'était pas concerné."
      },
      "applicability": {
        "models": [
          "mercedes.cclass",
          "mercedes.eclass",
          "mercedes.glk",
          "mercedes.slk"
        ],
        "when": {
          "all": [
            {
              "engine": {
                "ids": [
                  "mercedes.om651_220_250"
                ]
              }
            },
            {
              "productionDate": {
                "from": "2009-02"
              }
            }
          ]
        },
        "markets": [
          "EU",
          "UK"
        ],
        "hint": {
          "en": "Only Mercedes OM651 diesels in the 220 CDI (170 hp) and 250 CDI (204 hp) versions of the C-Class (W204), E-Class (W212) and GLK, from the first cars built in 2009. Mercedes stated the 200 CDI, with magnetic injectors, is not affected. The French service measure covered cars built February to August 2009. The same engine in the SLK 250 CDI is treated as possibly affected; the sources do not name that model.",
          "pt": "Apenas diesel Mercedes OM651 nas versões 220 CDI (170 cv) e 250 CDI (204 cv) da Classe C (W204), Classe E (W212) e GLK, desde os primeiros automóveis fabricados em 2009. A Mercedes indicou que o 200 CDI, com injetores magnéticos, não é afetado. A medida de serviço em França abrangeu automóveis fabricados entre fevereiro e agosto de 2009. O mesmo motor no SLK 250 CDI é tratado como possivelmente afetado; as fontes não nomeiam esse modelo.",
          "ru": "Только дизели Mercedes OM651 в версиях 220 CDI (170 л. с.) и 250 CDI (204 л. с.) на C-классе (W204), E-классе (W212) и GLK, начиная с первых машин 2009 года выпуска. Mercedes заявила, что 200 CDI с магнитными форсунками не затронут. Сервисная мера во Франции охватывала машины, выпущенные с февраля по август 2009 года. Тот же двигатель в SLK 250 CDI считается возможно затронутым; источники эту модель не называют.",
          "uk": "Лише дизелі Mercedes OM651 у версіях 220 CDI (170 к. с.) і 250 CDI (204 к. с.) на C-класі (W204), E-класі (W212) та GLK, починаючи з перших машин 2009 року випуску. Mercedes заявила, що 200 CDI з магнітними форсунками не зачеплений. Сервісний захід у Франції охоплював машини, випущені з лютого по серпень 2009 року. Той самий двигун у SLK 250 CDI вважається можливо ураженим; джерела цю модель не називають.",
          "fr": "Uniquement les diesels Mercedes OM651 des versions 220 CDI (170 ch) et 250 CDI (204 ch) de la Classe C (W204), de la Classe E (W212) et du GLK, dès les premières voitures construites en 2009. Mercedes a précisé que le 200 CDI, à injecteurs magnétiques, n'est pas concerné. La mesure de service en France couvrait les voitures produites de février à août 2009. Le même moteur dans la SLK 250 CDI est traité comme possiblement concerné ; les sources ne citent pas ce modèle."
        },
        "notes": {
          "en": "Sources disagree on when piezo injectors were dropped: mbpassion (2025) says the 220 CDI changed to magnetic injectors from 2010 while the 250 CDI partly kept piezo elements to the end of the series, whereas AUTO BILD still reports injector failures in 2012. The end date is therefore left open. No recall record was found in RappelConso or in NHTSA for this injector issue (searched 13 October 2026). The customer-service measures were described in 2009 for Germany, France and the UK.",
          "pt": "As fontes divergem quanto ao momento em que os injetores piezo foram abandonados: a mbpassion (2025) diz que o 220 CDI passou a injetores magnéticos a partir de 2010, enquanto o 250 CDI manteve parcialmente elementos piezo até ao fim da série, ao passo que a AUTO BILD ainda reporta falhas de injetores em 2012. A data de fim fica, por isso, em aberto. Não foi encontrado nenhum registo de chamada no RappelConso nem na NHTSA para este problema de injetores (pesquisa em 13 de outubro de 2026). As medidas de apoio ao cliente foram descritas em 2009 para Alemanha, França e Reino Unido.",
          "ru": "Источники расходятся в том, когда отказались от пьезофорсунок: mbpassion (2025) пишет, что 220 CDI перешёл на магнитные форсунки с 2010 года, а 250 CDI частично сохранял пьезоэлементы до конца серии, тогда как AUTO BILD сообщает об отказах форсунок ещё в 2012 году. Поэтому дата окончания оставлена открытой. Записей об отзыве по этой проблеме форсунок в RappelConso и NHTSA не найдено (поиск 13 октября 2026 года). Клиентские меры описаны в 2009 году для Германии, Франции и Великобритании.",
          "uk": "Джерела розходяться щодо того, коли відмовилися від п'єзофорсунок: mbpassion (2025) пише, що 220 CDI перейшов на магнітні форсунки з 2010 року, а 250 CDI частково зберігав п'єзоелементи до кінця серії, тоді як AUTO BILD повідомляє про відмови форсунок ще у 2012 році. Тому дату закінчення залишено відкритою. Записів про відкликання щодо цієї проблеми форсунок у RappelConso і NHTSA не знайдено (пошук 13 жовтня 2026 року). Клієнтські заходи описано у 2009 році для Німеччини, Франції та Великої Британії.",
          "fr": "Les sources divergent sur la date d'abandon des injecteurs piézo : mbpassion (2025) indique que le 220 CDI est passé aux injecteurs magnétiques dès 2010 tandis que le 250 CDI a gardé en partie des éléments piézo jusqu'à la fin de la série, alors qu'AUTO BILD signale encore des pannes d'injecteurs en 2012. La date de fin reste donc ouverte. Aucune fiche de rappel n'a été trouvée dans RappelConso ni à la NHTSA pour ce problème d'injecteurs (recherche du 13 octobre 2026). Les mesures commerciales ont été décrites en 2009 pour l'Allemagne, la France et le Royaume-Uni."
        }
      },
      "severity": "major",
      "safety": false,
      "critical": false,
      "symptoms": [
        {
          "id": "s1",
          "stage": "early",
          "text": {
            "en": "Engine warning light and uneven running",
            "pt": "Luz de aviso do motor e funcionamento irregular",
            "ru": "Контрольная лампа двигателя и неровная работа",
            "uk": "Контрольна лампа двигуна й нерівна робота",
            "fr": "Voyant moteur et fonctionnement irrégulier"
          }
        },
        {
          "id": "s2",
          "stage": "early",
          "text": {
            "en": "Jerking, unstable idle or cut-outs (L'argus)",
            "pt": "Solavancos, ralenti instável ou cortes (L'argus)",
            "ru": "Рывки, нестабильный холостой ход или отключения (L'argus)",
            "uk": "Ривки, нестабільний холостий хід або відключення (L'argus)",
            "fr": "À-coups, ralenti instable ou coupures (L'argus)"
          }
        },
        {
          "id": "s3",
          "stage": "late",
          "text": {
            "en": "Limp-home mode with reduced speed",
            "pt": "Modo de emergência (limp-home) com velocidade reduzida",
            "ru": "Аварийный режим (limp-home) со сниженной скоростью",
            "uk": "Аварійний режим (limp-home) зі зниженою швидкістю",
            "fr": "Mode dégradé (limp-home) à vitesse réduite"
          }
        }
      ],
      "inspection": [
        {
          "id": "i1",
          "method": "document",
          "tools": [],
          "text": {
            "en": "Confirm the engine is the OM651 in a 220 CDI or 250 CDI and the build date (door-pillar label or dealer VIN query); the 200 CDI uses a different injector type.",
            "pt": "Confirme que o motor é o OM651 num 220 CDI ou 250 CDI e a data de fabrico (etiqueta do pilar da porta ou consulta do VIN no concessionário); o 200 CDI usa outro tipo de injetor.",
            "ru": "Уточните, что двигатель OM651 в версии 220 CDI или 250 CDI, и дату выпуска (наклейка в проёме двери или запрос VIN у дилера); у 200 CDI другой тип форсунок.",
            "uk": "Уточніть, що двигун OM651 у версії 220 CDI або 250 CDI, і дату випуску (наліпка в отворі дверей або запит VIN у дилера); у 200 CDI інший тип форсунок.",
            "fr": "Confirmez que le moteur est l'OM651 d'un 220 CDI ou 250 CDI et la date de fabrication (étiquette du montant de porte ou requête VIN chez le concessionnaire) ; le 200 CDI a un autre type d'injecteur."
          },
          "redFlag": {
            "en": "220/250 CDI built from 2009, especially February to August 2009.",
            "pt": "220/250 CDI fabricado desde 2009, sobretudo entre fevereiro e agosto de 2009.",
            "ru": "220/250 CDI выпуска с 2009 года, особенно с февраля по август 2009.",
            "uk": "220/250 CDI випуску з 2009 року, особливо з лютого по серпень 2009.",
            "fr": "220/250 CDI produit depuis 2009, surtout de février à août 2009."
          }
        },
        {
          "id": "i2",
          "method": "document",
          "tools": [],
          "text": {
            "en": "Ask for invoices of injector replacement (and of the injector wiring harness, which Daimler said was replaced free at inspections) and any goodwill paperwork.",
            "pt": "Peça faturas da substituição dos injetores (e do cabo dos injetores, que a Daimler disse ser substituído gratuitamente nas revisões) e qualquer documento de boa vontade.",
            "ru": "Запросите счета на замену форсунок (и жгута проводов форсунок, который, по словам Daimler, бесплатно меняли при обслуживании) и документы по goodwill.",
            "uk": "Запитайте рахунки на заміну форсунок (і джгута проводів форсунок, який, за словами Daimler, безкоштовно змінювали під час обслуговування) та документи щодо goodwill.",
            "fr": "Demandez les factures de remplacement des injecteurs (et du faisceau d'injecteurs, que Daimler disait remplacer gratuitement lors des entretiens) et tout document de geste commercial."
          },
          "redFlag": {
            "en": "No injector record on a 2009-2011 car.",
            "pt": "Sem registo de injetores num automóvel de 2009-2011.",
            "ru": "Нет записей о форсунках на машине 2009-2011 годов.",
            "uk": "Немає записів про форсунки на машині 2009-2011 років.",
            "fr": "Aucun historique d'injecteurs sur une voiture de 2009-2011."
          }
        },
        {
          "id": "i3",
          "method": "obd",
          "tools": [],
          "text": {
            "en": "Read the fault memory, then run the engine warm and idle it, and test drive: look for the warning light, uneven running, jerking or limp-home mode.",
            "pt": "Leia a memória de avarias, depois ponha o motor a trabalhar quente e em ralenti, e faça um teste de condução: procure luz de aviso, funcionamento irregular, solavancos ou modo de emergência.",
            "ru": "Считайте память ошибок, затем прогрейте двигатель, проверьте холостой ход и сделайте тест-драйв: нет ли контрольной лампы, неровной работы, рывков или аварийного режима.",
            "uk": "Зчитайте пам'ять помилок, потім прогрійте двигун, перевірте холостий хід і зробіть тест-драйв: чи немає контрольної лампи, нерівної роботи, ривків або аварійного режиму.",
            "fr": "Lisez la mémoire de défauts, puis laissez le moteur chaud tourner au ralenti et faites un essai routier : cherchez voyant, fonctionnement irrégulier, à-coups ou mode dégradé."
          },
          "redFlag": {
            "en": "Warning light, uneven running or limp mode: have the injectors checked by a Mercedes diesel specialist.",
            "pt": "Luz de aviso, funcionamento irregular ou modo de emergência: peça a um especialista em diesel Mercedes para verificar os injetores.",
            "ru": "Контрольная лампа, неровная работа или аварийный режим — проверьте форсунки у специалиста по дизелям Mercedes.",
            "uk": "Контрольна лампа, нерівна робота або аварійний режим — перевірте форсунки у фахівця з дизелів Mercedes.",
            "fr": "Voyant, fonctionnement irrégulier ou mode dégradé : faites contrôler les injecteurs par un spécialiste des diesels Mercedes."
          }
        }
      ],
      "repair": {
        "remedy": {
          "en": "Injector replacement; Mercedes UK said in 2009 that it aimed to replace all the injectors of an affected car at once. In 2012 Daimler also described replacing the injector wiring harness with an optimised part at inspections.",
          "pt": "Substituição dos injetores; a Mercedes do Reino Unido disse em 2009 que pretendia substituir de uma só vez todos os injetores de um automóvel afetado. Em 2012 a Daimler descreveu também a substituição da cablagem dos injetores por uma peça otimizada nas revisões.",
          "ru": "Замена форсунок; Mercedes UK в 2009 году заявила, что стремится менять сразу все форсунки затронутой машины. В 2012 году Daimler также описала замену жгута проводов форсунок на доработанный при ТО.",
          "uk": "Заміна форсунок; Mercedes UK у 2009 році заявила, що прагне міняти одразу всі форсунки зачепленої машини. У 2012 році Daimler також описала заміну джгута проводів форсунок на доопрацьований під час ТО.",
          "fr": "Remplacement des injecteurs ; Mercedes UK a indiqué en 2009 viser le remplacement en une fois de tous les injecteurs d'un véhicule concerné. En 2012, Daimler a aussi décrit le remplacement du faisceau des injecteurs par une pièce optimisée lors des entretiens."
        },
        "cost": null,
        "worstCase": null,
        "manufacturerProgramme": {
          "evidence": [
            "ev_bmmb_e10",
            "ev_bmmb_e11",
            "ev_bmmb_e12",
            "ev_bmmb_e13"
          ],
          "text": {
            "en": "2009 customer-service measures reported by the press: France, a customer-satisfaction operation (not a recall) with injector replacement under warranty and a warranty extension of 1 year or 200,000 km as a commercial gesture; Germany, free replacement cars and a 200 EUR voucher; UK, a loan car for customers with more than one failure and a 250 GBP voucher or free first service. Terms for later years are not documented in the sources used here.",
            "pt": "Medidas de apoio ao cliente de 2009 reportadas pela imprensa: França, uma operação de satisfação do cliente (não uma chamada) com substituição dos injetores em garantia e extensão de garantia de 1 ano ou 200 000 km como gesto comercial; Alemanha, automóveis de substituição gratuitos e um vale de 200 EUR; Reino Unido, um carro de substituição para clientes com mais de uma falha e um vale de 250 GBP ou a primeira revisão gratuita. As condições para anos posteriores não estão documentadas nas fontes aqui usadas.",
            "ru": "Клиентские меры 2009 года по данным прессы: Франция — акция лояльности (не отзыв) с заменой форсунок по гарантии и продлением гарантии на 1 год или 200 000 км как коммерческим жестом; Германия — бесплатные подменные машины и ваучер на 200 EUR; Великобритания — подменная машина для клиентов с более чем одним отказом и ваучер на 250 GBP либо бесплатное первое ТО. Условия на более поздние годы в использованных источниках не задокументированы.",
            "uk": "Клієнтські заходи 2009 року за даними преси: Франція — акція для клієнтів (не відкликання) із заміною форсунок за гарантією та продовженням гарантії на 1 рік або 200 000 км як комерційним жестом; Німеччина — безкоштовні підмінні машини та ваучер на 200 EUR; Велика Британія — підмінна машина для клієнтів із понад однією відмовою та ваучер на 250 GBP чи безкоштовне перше ТО. Умови на пізніші роки у використаних джерелах не задокументовані.",
            "fr": "Mesures commerciales de 2009 rapportées par la presse : France, une opération de satisfaction client (pas un rappel) avec remplacement des injecteurs sous garantie et extension de garantie de 1 an ou 200 000 km à titre commercial ; Allemagne, véhicules de remplacement gratuits et bon de 200 EUR ; Royaume-Uni, voiture de prêt pour les clients ayant subi plus d'une panne et bon de 250 GBP ou premier entretien gratuit. Les conditions pour les années suivantes ne sont pas documentées dans les sources utilisées ici."
          }
        }
      },
      "evidence": [
        "ev_bmmb_e10",
        "ev_bmmb_e11",
        "ev_bmmb_e12",
        "ev_bmmb_e13",
        "ev_bmmb_e14"
      ],
      "prevalence": [
        "pv_om651_cases",
        "pv_om651_none"
      ]
    },
    {
      "id": "m271.timingchain",
      "aliases": [
        "m271.balanceshaft"
      ],
      "status": "published",
      "replacedBy": null,
      "revision": 1,
      "updatedAt": "2026-10-13",
      "legacyRule": "mercedes-known-issues",
      "title": {
        "en": "Mercedes M271 1.8 petrol: timing chain, tensioner and camshaft adjuster wear",
        "pt": "Mercedes M271 1.8 gasolina: desgaste da corrente de distribuição, do tensor e dos variadores de cames",
        "ru": "Mercedes M271 1.8 бензин: износ цепи ГРМ, натяжителя и фазовращателей распредвалов",
        "uk": "Mercedes M271 1.8 бензин: знос ланцюга ГРМ, натягувача та фазообертачів розподільних валів",
        "fr": "Mercedes M271 1.8 essence : usure de la chaîne de distribution, du tendeur et des déphaseurs d'arbres à cames"
      },
      "summary": {
        "en": "Two independent German sources describe timing chain elongation on the M271 four-cylinder petrol engine (built 2002 to 2015), with a cold-start rattle, a worn tensioner and worn camshaft adjusters, and in the worst case a chain that jumps and damages the engine. One says older cars without the EVO optimisation are more affected; the other says the chain remained an issue on the EVO as well. The earlier checklist item named the balance shaft; none of the sources used here mentions it.",
        "pt": "Duas fontes alemãs independentes descrevem o alongamento da corrente de distribuição no motor a gasolina de quatro cilindros M271 (fabricado de 2002 a 2015), com ruído no arranque a frio, tensor e variadores de árvore de cames gastos e, no pior caso, uma corrente que salta e danifica o motor. Uma diz que os automóveis mais antigos sem a otimização EVO são mais afetados; a outra diz que a corrente continuou a ser um problema também no EVO. O item anterior da lista de verificação referia o veio de equilíbrio; nenhuma das fontes aqui usadas o menciona.",
        "ru": "Два независимых немецких источника описывают растяжение цепи ГРМ на четырёхцилиндровом бензиновом моторе M271 (выпуск 2002-2015) со стуком на холодном пуске, изношенным натяжителем и фазовращателями, а в худшем случае с перескоком цепи и повреждением двигателя. Один пишет, что сильнее затронуты старые машины без доработки EVO; другой — что цепь осталась проблемой и на EVO. Прежний пункт чек-листа называл балансирный вал; ни один из использованных источников его не упоминает.",
        "uk": "Два незалежні німецькі джерела описують розтягування ланцюга ГРМ на чотирициліндровому бензиновому моторі M271 (випуск 2002-2015) зі стукотом під час холодного пуску, зношеним натягувачем і фазорегуляторами, а в гіршому разі з перескоком ланцюга та пошкодженням двигуна. Одне пише, що більше зачеплені старі машини без доопрацювання EVO; інше — що ланцюг залишився проблемою і на EVO. Попередній пункт чек-листа називав балансирний вал; жодне з використаних джерел його не згадує.",
        "fr": "Deux sources allemandes indépendantes décrivent un allongement de la chaîne de distribution sur le moteur essence quatre cylindres M271 (produit de 2002 à 2015), avec un cliquetis au démarrage à froid, un tendeur et des déphaseurs usés et, au pire, une chaîne qui saute et endommage le moteur. L'une indique que les véhicules plus anciens sans l'optimisation EVO sont plus touchés ; l'autre, que la chaîne est restée un problème aussi sur l'EVO. L'ancien point de contrôle citait l'arbre d'équilibrage ; aucune des sources utilisées ici ne le mentionne."
      },
      "checklistPrompt": {
        "en": "M271 petrol (C/E-Class, SLK): timing chain — check for cold-start rattle and chain/tensioner replacement history",
        "pt": "M271 gasolina (Classe C/E, SLK): corrente de distribuição — verificar ruído no arranque a frio e histórico de substituição da corrente/tensor",
        "ru": "M271 бензин (C/E-класс, SLK): цепь ГРМ — проверить стук на холодном пуске и историю замены цепи/натяжителя",
        "uk": "M271 бензин (C/E-клас, SLK): ланцюг ГРМ — перевірити стукіт на холодному пуску та історію заміни ланцюга/натягувача",
        "fr": "M271 essence (Classe C/E, SLK) : chaîne de distribution — vérifier le cliquetis à froid et l'historique de remplacement chaîne/tendeur"
      },
      "component": "engine.timing.chain",
      "mechanism": {
        "en": "The M271 uses a single-row (simplex) timing chain. Gebrauchtwagenberater.de gives a defective chain tensioner as the usual cause of early elongation, with wear accelerated by late or missed oil changes, and says the camshaft adjuster sprockets can wear so that the chain jumps; mbpassion.de names wear of the chain and tensioner, says a worn tensioner can in the worst case let the chain jump, and that the camshaft adjusters wear with a worn chain, which raises the risk of engine damage. According to Gebrauchtwagenberater.de the EVO versions from 2009 changed to a toothed chain; mbpassion.de describes the earlier cars as more affected, while Gebrauchtwagenberater.de says the chain stayed an issue on the EVO. No Mercedes document on these changes was found.",
        "pt": "O M271 usa uma corrente de distribuição simples (simplex). A Gebrauchtwagenberater.de aponta um tensor defeituoso como causa habitual do alongamento precoce, com desgaste acelerado por mudanças de óleo tardias ou omitidas, e diz que as rodas dentadas dos variadores de árvore de cames podem desgastar-se ao ponto de a corrente saltar; a mbpassion.de indica desgaste da corrente e do tensor, diz que um tensor gasto pode, no pior caso, deixar a corrente saltar, e que os variadores se desgastam com uma corrente gasta, o que aumenta o risco de danos no motor. Segundo a Gebrauchtwagenberater.de, as versões EVO a partir de 2009 passaram a uma corrente dentada; a mbpassion.de descreve os automóveis anteriores como mais afetados, enquanto a Gebrauchtwagenberater.de diz que a corrente continuou a ser um problema no EVO. Não foi encontrado nenhum documento da Mercedes sobre estas alterações.",
        "ru": "M271 использует однорядную (simplex) цепь ГРМ. Gebrauchtwagenberater.de называет обычной причиной раннего растяжения дефектный натяжитель, износ ускоряют поздние или пропущенные замены масла, и пишет, что звёздочки фазовращателей могут изнашиваться так, что цепь перескакивает; mbpassion.de называет износ цепи и натяжителя, пишет, что изношенный натяжитель в худшем случае может привести к перескоку цепи, а фазовращатели изнашиваются вместе с цепью, что повышает риск повреждения двигателя. По данным Gebrauchtwagenberater.de, версии EVO с 2009 года перешли на зубчатую цепь; mbpassion.de считает более ранние машины более затронутыми, а Gebrauchtwagenberater.de пишет, что цепь осталась проблемой и на EVO. Документов Mercedes об этих изменениях не найдено.",
        "uk": "M271 використовує однорядний (simplex) ланцюг ГРМ. Gebrauchtwagenberater.de називає звичайною причиною раннього розтягування дефектний натягувач, знос прискорюють пізні або пропущені заміни оливи, і пише, що зірочки фазорегуляторів можуть зношуватися так, що ланцюг перескакує; mbpassion.de називає знос ланцюга й натягувача, пише, що зношений натягувач у гіршому разі може призвести до перескоку ланцюга, а фазорегулятори зношуються разом із ланцюгом, що підвищує ризик пошкодження двигуна. За даними Gebrauchtwagenberater.de, версії EVO з 2009 року перейшли на зубчастий ланцюг; mbpassion.de вважає раніші машини більш зачепленими, а Gebrauchtwagenberater.de пише, що ланцюг залишився проблемою і на EVO. Документів Mercedes про ці зміни не знайдено.",
        "fr": "Le M271 utilise une chaîne de distribution simple (simplex). Gebrauchtwagenberater.de désigne un tendeur défectueux comme cause habituelle de l'allongement précoce, l'usure étant accélérée par des vidanges tardives ou omises, et indique que les pignons des déphaseurs peuvent s'user au point de laisser sauter la chaîne ; mbpassion.de cite l'usure de la chaîne et du tendeur, indique qu'un tendeur usé peut au pire laisser sauter la chaîne, et que les déphaseurs s'usent avec une chaîne usée, ce qui augmente le risque de dégâts moteur. Selon Gebrauchtwagenberater.de, les versions EVO à partir de 2009 sont passées à une chaîne à dents ; mbpassion.de décrit les véhicules antérieurs comme plus touchés, tandis que Gebrauchtwagenberater.de indique que la chaîne est restée un problème sur l'EVO. Aucun document de Mercedes sur ces changements n'a été trouvé."
      },
      "applicability": {
        "models": [
          "mercedes.cclass",
          "mercedes.eclass",
          "mercedes.slk"
        ],
        "when": {
          "all": [
            {
              "engine": {
                "ids": [
                  "mercedes.m271"
                ]
              }
            },
            {
              "productionDate": {
                "from": "2002-01",
                "to": "2015-12"
              }
            }
          ]
        },
        "markets": [
          "EU"
        ],
        "hint": {
          "en": "Only Mercedes four-cylinder petrol engines of the M271 family (1,796 cc), built 2002 to 2015 according to the sources: the supercharged versions and the later turbocharged EVO versions. The sources say cars without the EVO changes are more affected. Mercedes V6 and V8 engines (M272, M273) are not part of this entry.",
          "pt": "Apenas motores Mercedes de quatro cilindros a gasolina da família M271 (1 796 cc), fabricados entre 2002 e 2015 segundo as fontes: as versões com compressor e as versões EVO turbo posteriores. As fontes dizem que os automóveis sem as alterações EVO são mais afetados. Os motores Mercedes V6 e V8 (M272, M273) não fazem parte desta entrada.",
          "ru": "Только бензиновые четырёхцилиндровые двигатели Mercedes семейства M271 (1 796 см3), выпуск 2002-2015 по данным источников: версии с компрессором и более поздние турбированные EVO. Источники пишут, что машины без доработок EVO затронуты сильнее. Двигатели Mercedes V6 и V8 (M272, M273) в эту запись не входят.",
          "uk": "Лише бензинові чотирициліндрові двигуни Mercedes родини M271 (1 796 см3), випуск 2002-2015 за даними джерел: версії з компресором і пізніші турбовані EVO. Джерела пишуть, що машини без доробок EVO зачеплені сильніше. Двигуни Mercedes V6 і V8 (M272, M273) до цього запису не входять.",
          "fr": "Uniquement les moteurs essence quatre cylindres Mercedes de la famille M271 (1 796 cm3), produits de 2002 à 2015 selon les sources : les versions à compresseur et les versions EVO turbo ultérieures. Les sources disent que les voitures sans les changements EVO sont plus touchées. Les moteurs Mercedes V6 et V8 (M272, M273) ne font pas partie de cette fiche."
        },
        "notes": {
          "en": "The legacy checklist item for this engine named a balance shaft; this entry covers the timing chain, which is what the sources describe. Engine sub-codes and the exact date of the EVO change are not given in the sources used. One source says the M271 was also used in other, lower-volume Mercedes models without naming them, so the model list may be incomplete. The only sources are two independent specialist articles; no manufacturer document, recall, regulator record or failure rate was found.",
          "pt": "O item antigo da lista de verificação para este motor referia um veio de equilíbrio; esta entrada trata da corrente de distribuição, que é o que as fontes descrevem. Os subcódigos do motor e a data exata da alteração EVO não são indicados nas fontes usadas. Uma fonte diz que o M271 foi usado também noutros modelos Mercedes de menor volume, sem os nomear, pelo que a lista de modelos pode estar incompleta. As únicas fontes são dois artigos especializados independentes; não foi encontrado nenhum documento do fabricante, chamada, registo de regulador nem taxa de avarias.",
          "ru": "Прежний пункт чек-листа для этого мотора называл балансирный вал; эта запись описывает цепь ГРМ, о которой говорят источники. Подкоды двигателя и точная дата перехода на EVO в использованных источниках не указаны. Один источник пишет, что M271 ставился и на другие, менее массовые модели Mercedes, не называя их, поэтому список моделей может быть неполным. Единственные источники — две независимые профильные статьи; документов производителя, отзывов, записей регулятора или доли отказов не найдено.",
          "uk": "Попередній пункт чек-листа для цього мотора називав балансирний вал; цей запис описує ланцюг ГРМ, про який говорять джерела. Підкоди двигуна і точна дата переходу на EVO у використаних джерелах не вказані. Одне джерело пише, що M271 ставився й на інші, менш масові моделі Mercedes, не називаючи їх, тому список моделей може бути неповним. Єдині джерела — дві незалежні профільні статті; документів виробника, відкликань, записів регулятора чи частки відмов не знайдено.",
          "fr": "L'ancien point de contrôle pour ce moteur citait un arbre d'équilibrage ; cette entrée porte sur la chaîne de distribution, que décrivent les sources. Les sous-codes moteur et la date exacte du passage à l'EVO ne sont pas donnés dans les sources utilisées. Une source indique que le M271 a aussi équipé d'autres modèles Mercedes à plus faible volume, sans les nommer ; la liste des modèles peut donc être incomplète. Les seules sources sont deux articles spécialisés indépendants ; aucun document du constructeur, rappel, dossier de régulateur ni taux de défaillance n'a été trouvé."
        }
      },
      "severity": "major",
      "safety": false,
      "critical": false,
      "symptoms": [
        {
          "id": "s1",
          "stage": "early",
          "text": {
            "en": "Rattling from the front of the engine at cold start and under load changes",
            "pt": "Ruído metálico na frente do motor no arranque a frio e nas mudanças de carga",
            "ru": "Стук в передней части двигателя на холодном пуске и при смене нагрузки",
            "uk": "Стукіт у передній частині двигуна на холодному пуску та при зміні навантаження",
            "fr": "Cliquetis à l'avant du moteur au démarrage à froid et lors des changements de charge"
          }
        },
        {
          "id": "s2",
          "stage": "late",
          "text": {
            "en": "Chain jumping a tooth after a worn tensioner or adjusters, with possible engine damage",
            "pt": "Corrente a saltar um dente por tensor ou variadores gastos, com possíveis danos no motor",
            "ru": "Перескок цепи на зуб из-за изношенного натяжителя или фазовращателей, возможно повреждение двигателя",
            "uk": "Перескок ланцюга на зуб через зношений натягувач або фазообертачі, можливе пошкодження двигуна",
            "fr": "Chaîne qui saute une dent après usure du tendeur ou des déphaseurs, avec possibles dégâts moteur"
          }
        }
      ],
      "inspection": [
        {
          "id": "i1",
          "method": "document",
          "tools": [],
          "text": {
            "en": "Confirm the engine is an M271 and the build date; ask whether the timing chain, tensioner, guides and camshaft adjusters were ever replaced, and ask for the oil-change history.",
            "pt": "Confirme que o motor é um M271 e a data de fabrico; pergunte se a corrente de distribuição, o tensor, as guias e os variadores de cames já foram substituídos e peça o histórico de mudanças de óleo.",
            "ru": "Уточните, что двигатель M271, и дату выпуска; спросите, менялись ли цепь ГРМ, натяжитель, направляющие и фазовращатели, и запросите историю замены масла.",
            "uk": "Уточніть, що двигун M271, і дату випуску; запитайте, чи змінювалися ланцюг ГРМ, натягувач, напрямні та фазообертачі, і запросіть історію заміни оливи.",
            "fr": "Confirmez que le moteur est un M271 et la date de fabrication ; demandez si la chaîne de distribution, le tendeur, les guides et les déphaseurs ont déjà été remplacés, et demandez l'historique des vidanges."
          },
          "redFlag": {
            "en": "No chain work on record and late or missed oil changes.",
            "pt": "Sem registo de intervenção na corrente e com mudanças de óleo tardias ou omitidas.",
            "ru": "Нет записей о работах с цепью и замены масла запаздывали или пропускались.",
            "uk": "Немає записів про роботи з ланцюгом, а заміни оливи запізнювалися або пропускалися.",
            "fr": "Aucune intervention sur la chaîne et vidanges tardives ou omises."
          }
        },
        {
          "id": "i2",
          "method": "listen",
          "tools": [],
          "text": {
            "en": "Start the engine fully cold and listen at the front of the engine for a metallic rattle, then listen again under changing load.",
            "pt": "Ponha o motor a trabalhar completamente frio e escute na frente do motor se há ruído metálico; depois volte a escutar com a carga a variar.",
            "ru": "Запустите полностью холодный двигатель и послушайте переднюю часть мотора: нет ли металлического стука; затем послушайте ещё раз при изменении нагрузки.",
            "uk": "Запустіть повністю холодний двигун і послухайте передню частину мотора: чи немає металевого стукоту; потім послухайте ще раз при зміні навантаження.",
            "fr": "Démarrez le moteur complètement froid et écoutez l'avant du moteur à la recherche d'un cliquetis métallique, puis écoutez à nouveau sous charge variable."
          },
          "redFlag": {
            "en": "Rattle: have a specialist measure the chain elongation before buying.",
            "pt": "Ruído: peça a um especialista para medir o alongamento da corrente antes de comprar.",
            "ru": "Стук — до покупки попросите специалиста измерить вытягивание цепи.",
            "uk": "Стукіт — до купівлі попросіть фахівця виміряти витягування ланцюга.",
            "fr": "Cliquetis : faites mesurer l'allongement de la chaîne par un spécialiste avant l'achat."
          }
        },
        {
          "id": "i3",
          "method": "obd",
          "tools": [],
          "text": {
            "en": "Read the fault memory for camshaft timing correlation faults; Gebrauchtwagenberater.de says the manufacturer offers a check of chain elongation with a measuring chain tensioner.",
            "pt": "Leia a memória de avarias à procura de falhas de correlação das árvores de cames; a Gebrauchtwagenberater.de diz que o fabricante disponibiliza uma verificação do alongamento da corrente com um tensor de medição.",
            "ru": "Считайте память неисправностей на ошибки корреляции распредвалов; Gebrauchtwagenberater.de пишет, что производитель предлагает проверку растяжения цепи с помощью измерительного натяжителя.",
            "uk": "Зчитайте пам'ять несправностей на помилки кореляції розподільних валів; Gebrauchtwagenberater.de пише, що виробник пропонує перевірку розтягування ланцюга за допомогою вимірювального натягувача.",
            "fr": "Lisez la mémoire de défauts à la recherche de défauts de corrélation des arbres à cames ; Gebrauchtwagenberater.de indique que le constructeur propose un contrôle de l'allongement de la chaîne au moyen d'un tendeur de mesure."
          },
          "redFlag": {
            "en": "Camshaft timing faults stored.",
            "pt": "Falhas de distribuição dos cames registadas.",
            "ru": "В памяти есть ошибки фаз распредвалов.",
            "uk": "У пам'яті є помилки фаз розподільних валів.",
            "fr": "Défauts de calage des arbres à cames enregistrés."
          }
        }
      ],
      "repair": {
        "remedy": {
          "en": "Replacement of the timing chain together with the tensioner, guides and camshaft adjusters, as the sources advise replacing them together. No cost figure is given in the sources used here.",
          "pt": "Substituição da corrente de distribuição em conjunto com o tensor, as guias e os variadores de cames, pois as fontes aconselham substituí-los em conjunto. As fontes aqui usadas não indicam custo.",
          "ru": "Замена цепи ГРМ вместе с натяжителем, направляющими и фазовращателями распредвалов — источники советуют менять их комплектом. Стоимость в использованных источниках не указана.",
          "uk": "Заміна ланцюга ГРМ разом із натягувачем, напрямними та фазообертачами розподільних валів — джерела радять міняти їх комплектом. Вартість у використаних джерелах не вказана.",
          "fr": "Remplacement de la chaîne de distribution avec le tendeur, les guides et les déphaseurs d'arbres à cames, les sources conseillant de les remplacer ensemble. Aucun coût n'est donné dans les sources utilisées ici."
        },
        "cost": null,
        "worstCase": null,
        "manufacturerProgramme": null
      },
      "evidence": [
        "ev_bmmb_e15",
        "ev_bmmb_e16"
      ],
      "prevalence": [
        "pv_m271_none"
      ]
    },
    {
      "id": "ecoboost.wetbelt",
      "aliases": [],
      "status": "published",
      "replacedBy": null,
      "revision": 1,
      "updatedAt": "2026-10-13",
      "legacyRule": "ford-known-issues",
      "title": {
        "en": "Ford 1.0 EcoBoost (Fox) with oil-bath timing belt: the oil pump belt, its tensioner or belt debris can cut oil pressure",
        "pt": "Ford 1.0 EcoBoost (Fox) com correia de distribuição em banho de óleo: a correia da bomba de óleo, o seu tensor ou resíduos da correia podem cortar a pressão do óleo",
        "ru": "Ford 1.0 EcoBoost (Fox) с ремнём ГРМ в масляной ванне: ремень масляного насоса, его натяжитель или частицы ремня могут привести к потере давления масла",
        "uk": "Ford 1.0 EcoBoost (Fox) з ременем ГРМ в масляній ванні: ремінь оливного насоса, його натяжник або частинки ременя можуть призвести до втрати тиску оливи",
        "fr": "Ford 1.0 EcoBoost (Fox) à courroie de distribution baignant dans l'huile : la courroie de pompe à huile, son tendeur ou des débris de courroie peuvent couper la pression d'huile"
      },
      "summary": {
        "en": "Ford recall 23V-905 (US, filed December 2023) covers 139,730 Focus and EcoSport with the 1.0L engine and 6F15 automatic: according to Ford, the oil pump belt tensioner arm may fracture or separate, or the belt may lose teeth, causing loss of oil pressure. In July 2026 NHTSA opened engineering analysis EA26-004 on 135,551 Fiesta, Focus and EcoSport. Its opening resume states that timing belt material may degrade and clog the oil pump pick-up screen; in the failure data provided to the investigation the average failure mileage was about 70,000 miles and 98% of failures came before the 150,000-mile belt interval. This is an open investigation, not a recall. NHTSA also reports that Ford announced a non-safety customer programme for 1.0L Fox Classic engines worldwide that cuts the belt interval to 100,000 miles or 6 years. No European recall was found.",
        "pt": "A chamada 23V-905 da Ford (EUA, apresentada em dezembro de 2023) abrange 139 730 Focus e EcoSport com motor 1.0L e caixa automática 6F15: segundo a Ford, o braço do tensor da correia da bomba de óleo pode partir-se ou soltar-se, ou a correia pode perder dentes, causando perda de pressão do óleo. Em julho de 2026 a NHTSA abriu a análise de engenharia EA26-004 sobre 135 551 Fiesta, Focus e EcoSport. O resumo de abertura indica que o material da correia de distribuição pode degradar-se e obstruir o filtro de aspiração da bomba de óleo; nos dados de avarias fornecidos à investigação, a quilometragem média de avaria foi de cerca de 70 000 milhas e 98% das avarias ocorreram antes do intervalo de 150 000 milhas da correia. Trata-se de uma investigação em curso, não de uma chamada. A NHTSA refere também que a Ford anunciou um programa de clientes sem carácter de segurança para os motores 1.0L Fox Classic em todo o mundo, que reduz o intervalo da correia para 100 000 milhas ou 6 anos. Não foi encontrada nenhuma chamada na Europa.",
        "ru": "Отзыв Ford 23V-905 (США, подан в декабре 2023) охватывает 139 730 Focus и EcoSport с двигателем 1.0L и автоматом 6F15: по данным Ford, рычаг натяжителя ремня масляного насоса может сломаться или отделиться, либо ремень может потерять зубья, что вызывает потерю давления масла. В июле 2026 NHTSA открыла инженерный анализ EA26-004 по 135 551 Fiesta, Focus и EcoSport. В резюме об открытии сказано, что материал ремня ГРМ может разрушаться и забивать сетку маслоприёмника насоса; в данных об отказах, переданных в расследование, средний пробег до отказа около 70 000 миль, и 98% отказов произошли до интервала замены ремня 150 000 миль. Это открытое расследование, а не отзыв. NHTSA также сообщает, что Ford объявила программу для клиентов, не связанную с безопасностью, для двигателей 1.0L Fox Classic по всему миру: интервал замены ремня сокращён до 100 000 миль или 6 лет. Европейского отзыва не найдено.",
        "uk": "Відкликання Ford 23V-905 (США, подане в грудні 2023) охоплює 139 730 Focus і EcoSport з двигуном 1.0L і автоматом 6F15: за даними Ford, важіль натяжника ременя оливного насоса може зламатися або відокремитися, або ремінь може втратити зуби, що спричиняє втрату тиску оливи. У липні 2026 NHTSA відкрила інженерний аналіз EA26-004 щодо 135 551 Fiesta, Focus і EcoSport. У резюме про відкриття сказано, що матеріал ременя ГРМ може руйнуватися й забивати сітку маслоприймача насоса; у даних про відмови, переданих до розслідування, середній пробіг до відмови близько 70 000 миль, і 98% відмов сталися до інтервалу заміни ременя 150 000 миль. Це відкрите розслідування, а не відкликання. NHTSA також повідомляє, що Ford оголосила програму для клієнтів, не пов'язану з безпекою, для двигунів 1.0L Fox Classic у всьому світі: інтервал заміни ременя скорочено до 100 000 миль або 6 років. Європейського відкликання не знайдено.",
        "fr": "Le rappel Ford 23V-905 (États-Unis, déposé en décembre 2023) concerne 139 730 Focus et EcoSport avec moteur 1.0L et boîte automatique 6F15 : selon Ford, le bras du tendeur de la courroie de pompe à huile peut se rompre ou se détacher, ou la courroie perdre des dents, entraînant une perte de pression d'huile. En juillet 2026, la NHTSA a ouvert l'analyse technique EA26-004 sur 135 551 Fiesta, Focus et EcoSport. Son résumé d'ouverture indique que le matériau de la courroie de distribution peut se dégrader et colmater la crépine d'aspiration de la pompe à huile ; dans les données de pannes fournies à l'enquête, le kilométrage moyen de panne était d'environ 70 000 miles et 98 % des pannes sont survenues avant l'intervalle de 150 000 miles de la courroie. Il s'agit d'une enquête en cours, pas d'un rappel. La NHTSA indique aussi que Ford a annoncé un programme client hors sécurité pour les moteurs 1.0L Fox Classic dans le monde entier, qui ramène l'intervalle de la courroie à 100 000 miles ou 6 ans. Aucun rappel européen n'a été trouvé."
      },
      "checklistPrompt": {
        "en": "1.0 EcoBoost (Fox): oil-bath belt service history, recall 23V-905 and Ford programmes - check them",
        "pt": "1.0 EcoBoost (Fox): historial da correia em banho de óleo, chamada 23V-905 e programas Ford - verificar",
        "ru": "1.0 EcoBoost (Fox): история замены ремня в масляной ванне, отзыв 23V-905 и программы Ford — проверить",
        "uk": "1.0 EcoBoost (Fox): історія заміни ременя в масляній ванні, відкликання 23V-905 і програми Ford — перевірити",
        "fr": "1.0 EcoBoost (Fox) : historique de la courroie baignant dans l'huile, rappel 23V-905 et programmes Ford - vérifier"
      },
      "component": "engine.timing.belt",
      "mechanism": {
        "en": "The 1.0 EcoBoost (Fox) drives the camshafts and the oil pump with belts that run in engine oil. In Ford's recall 23V-905 the oil pump belt tensioner arm can fracture or separate, or the belt can lose teeth, and oil pressure is lost; Ford says the arm retention joint is not robust to vibration. NHTSA's later analysis EA26-004 describes a second path: timing belt material may degrade and clog the mesh pick-up screen of the oil pump, which cannot be serviced without removing the engine. Dayco, the belt supplier, advises checking the oil for a petrol smell and checking the strainer. The causes are as stated by Ford in the recall and by NHTSA in an open investigation; the pick-up screen blockage is an investigation finding, not a recall.",
        "pt": "O 1.0 EcoBoost (Fox) acciona os cames e a bomba de óleo com correias que funcionam em óleo do motor. Na chamada 23V-905 da Ford, o braço do tensor da correia da bomba de óleo pode partir-se ou separar-se, ou a correia pode perder dentes, e perde-se pressão do óleo; a Ford diz que a fixação do braço não é robusta à vibração. A análise posterior EA26-004 da NHTSA descreve um segundo caminho: o material da correia de distribuição pode degradar-se e obstruir o filtro de malha de aspiração da bomba de óleo, que não é acessível sem retirar o motor. A Dayco, fornecedora das correias, aconselha verificar se o óleo cheira a gasolina e inspecionar o filtro. As causas são as indicadas pela Ford na chamada e pela NHTSA numa investigação em curso; a obstrução do filtro de aspiração é uma constatação da investigação, não uma chamada.",
        "ru": "1.0 EcoBoost (Fox) приводит распредвалы и масляный насос ремнями, работающими в моторном масле. В отзыве Ford 23V-905 рычаг натяжителя ремня масляного насоса может сломаться или отделиться, либо ремень может потерять зубья, и давление масла пропадает; Ford указывает, что крепление рычага не выдерживает вибрацию. Более поздний анализ NHTSA EA26-004 описывает второй путь: материал ремня ГРМ может разрушаться и забивать сетчатый маслоприёмник насоса, который нельзя обслужить без снятия двигателя. Поставщик ремней Dayco советует проверять масло на запах бензина и осматривать сетку. Причины изложены так, как их указали Ford в отзыве и NHTSA в открытом расследовании; засорение сетки маслоприёмника — вывод расследования, а не отзыв.",
        "uk": "1.0 EcoBoost (Fox) приводить розподільні вали та оливний насос ременями, що працюють у моторній оливі. У відкликанні Ford 23V-905 важіль натяжника ременя оливного насоса може зламатися або відокремитися, або ремінь може втратити зуби, і тиск оливи зникає; Ford вказує, що кріплення важеля не витримує вібрацію. Пізніший аналіз NHTSA EA26-004 описує другий шлях: матеріал ременя ГРМ може руйнуватися й забивати сітчастий маслоприймач насоса, який не можна обслужити без зняття двигуна. Постачальник ременів Dayco радить перевіряти оливу на запах бензину й оглядати сітку. Причини викладено так, як їх зазначили Ford у відкликанні та NHTSA у відкритому розслідуванні; забивання сітки маслоприймача — висновок розслідування, а не відкликання.",
        "fr": "Le 1.0 EcoBoost (Fox) entraîne les arbres à cames et la pompe à huile par des courroies qui tournent dans l'huile moteur. Dans le rappel Ford 23V-905, le bras du tendeur de la courroie de pompe à huile peut se rompre ou se séparer, ou la courroie perdre des dents, et la pression d'huile est perdue ; Ford dit que la fixation du bras ne résiste pas assez aux vibrations. L'analyse ultérieure EA26-004 de la NHTSA décrit une seconde voie : le matériau de la courroie de distribution peut se dégrader et colmater la crépine à maille de la pompe à huile, inaccessible sans déposer le moteur. Dayco, fournisseur des courroies, conseille de vérifier l'odeur d'essence de l'huile et la crépine. Les causes sont celles indiquées par Ford dans le rappel et par la NHTSA dans une enquête en cours ; le colmatage de la crépine est un constat d'enquête, pas un rappel."
      },
      "applicability": {
        "models": [
          "ford.fiesta",
          "ford.focus",
          "ford.ecosport",
          "ford.b_max",
          "ford.c_max",
          "ford.mondeo",
          "ford.puma"
        ],
        "when": {
          "all": [
            {
              "engine": {
                "ids": [
                  "ford.fox_1_0"
                ]
              }
            }
          ]
        },
        "markets": [
          "US",
          "UK",
          "EU"
        ],
        "hint": {
          "en": "Only Ford 1.0 EcoBoost (Fox) petrol engines with the oil-bath belts. The US documents cover Fiesta, Focus and EcoSport; the NTN-SNR supplier table also lists B-MAX, C-MAX, Mondeo and Puma with this belt. Parkers says Ford moved to a timing chain in late 2018 and that later Fiesta, Focus and Puma should have a chain, but early ones may still have the belt, so check by VIN or engine code. Recall 23V-905 itself covers only US Focus and EcoSport with the 6F15 automatic.",
          "pt": "Apenas motores a gasolina Ford 1.0 EcoBoost (Fox) com correias em banho de óleo. Os documentos dos EUA abrangem Fiesta, Focus e EcoSport; a tabela do fornecedor NTN-SNR indica também B-MAX, C-MAX, Mondeo e Puma com esta correia. A Parkers diz que a Ford passou para corrente de distribuição no fim de 2018 e que os Fiesta, Focus e Puma posteriores devem ter corrente, mas os primeiros ainda podem ter a correia; verifique pelo VIN ou pelo código do motor. A própria chamada 23V-905 abrange apenas Focus e EcoSport dos EUA com a automática 6F15.",
          "ru": "Только бензиновые Ford 1.0 EcoBoost (Fox) с ремнями в масляной ванне. Документы США охватывают Fiesta, Focus и EcoSport; таблица поставщика NTN-SNR указывает с этим ремнём также B-MAX, C-MAX, Mondeo и Puma. Parkers пишет, что в конце 2018 года Ford перешла на цепь и что более поздние Fiesta, Focus и Puma должны быть с цепью, но на первых машинах ещё может стоять ремень; проверяйте по VIN или коду двигателя. Сам отзыв 23V-905 охватывает только американские Focus и EcoSport с автоматом 6F15.",
          "uk": "Лише бензинові Ford 1.0 EcoBoost (Fox) з ременями в масляній ванні. Документи США охоплюють Fiesta, Focus і EcoSport; таблиця постачальника NTN-SNR вказує з цим ременем також B-MAX, C-MAX, Mondeo і Puma. Parkers пише, що наприкінці 2018 року Ford перейшла на ланцюг і що пізніші Fiesta, Focus і Puma мають бути з ланцюгом, але на перших машинах ще може стояти ремінь; перевіряйте за VIN або кодом двигуна. Саме відкликання 23V-905 охоплює лише американські Focus і EcoSport з автоматом 6F15.",
          "fr": "Uniquement les moteurs essence Ford 1.0 EcoBoost (Fox) à courroies baignant dans l'huile. Les documents américains couvrent Fiesta, Focus et EcoSport ; le tableau du fournisseur NTN-SNR cite aussi B-MAX, C-MAX, Mondeo et Puma avec cette courroie. Parkers indique que Ford est passé à une chaîne fin 2018 et que les Fiesta, Focus et Puma plus récentes devraient avoir une chaîne, mais les premières peuvent encore avoir la courroie : vérifiez par VIN ou code moteur. Le rappel 23V-905 lui-même ne couvre que les Focus et EcoSport américaines à boîte automatique 6F15."
        },
        "notes": {
          "en": "The engine code list comes from a supplier table (NTN-SNR, 2025), the only code source found, and is medium confidence. The same table also lists Transit and Tourneo Courier and Connect vans, which are not in the model list.",
          "pt": "A lista de códigos de motor vem de uma tabela de fornecedor (NTN-SNR, 2025), a única fonte de códigos encontrada, e tem confiança média. A mesma tabela inclui também as carrinhas Transit e Tourneo Courier e Connect, que não estão na lista de modelos.",
          "ru": "Список кодов двигателей взят из таблицы поставщика (NTN-SNR, 2025), единственного найденного источника кодов, и имеет среднюю достоверность. В той же таблице есть фургоны Transit и Tourneo Courier и Connect, которых нет в списке моделей.",
          "uk": "Список кодів двигунів взято з таблиці постачальника (NTN-SNR, 2025), єдиного знайденого джерела кодів, і має середню достовірність. У тій самій таблиці є фургони Transit і Tourneo Courier та Connect, яких немає в списку моделей.",
          "fr": "La liste des codes moteur vient d'un tableau de fournisseur (NTN-SNR, 2025), seule source de codes trouvée, et a une confiance moyenne. Le même tableau cite aussi les utilitaires Transit et Tourneo Courier et Connect, absents de la liste des modèles."
        }
      },
      "severity": "critical",
      "safety": true,
      "critical": false,
      "symptoms": [
        {
          "id": "s1",
          "stage": "early",
          "text": {
            "en": "Oil pressure warning light or low oil pressure reading",
            "pt": "Luz de aviso de pressão do óleo ou leitura de pressão baixa",
            "ru": "Контрольная лампа давления масла или низкие показания давления",
            "uk": "Контрольна лампа тиску оливи або низькі показники тиску",
            "fr": "Voyant de pression d'huile ou pression d'huile basse"
          }
        },
        {
          "id": "s2",
          "stage": "early",
          "text": {
            "en": "Petrol smell in the engine oil, or belt debris found at service (Dayco)",
            "pt": "Cheiro a gasolina no óleo do motor ou resíduos da correia encontrados na revisão (Dayco)",
            "ru": "Запах бензина в моторном масле или частицы ремня при обслуживании (Dayco)",
            "uk": "Запах бензину в моторній оливі або частинки ременя під час обслуговування (Dayco)",
            "fr": "Odeur d'essence dans l'huile moteur ou débris de courroie trouvés à l'entretien (Dayco)"
          }
        },
        {
          "id": "s3",
          "stage": "late",
          "text": {
            "en": "Loss of oil pressure and engine failure (Ford recall 23V-905)",
            "pt": "Perda de pressão do óleo e avaria do motor (chamada 23V-905 da Ford)",
            "ru": "Потеря давления масла и отказ двигателя (отзыв Ford 23V-905)",
            "uk": "Втрата тиску оливи та відмова двигуна (відкликання Ford 23V-905)",
            "fr": "Perte de pression d'huile et panne moteur (rappel Ford 23V-905)"
          }
        }
      ],
      "inspection": [
        {
          "id": "i1",
          "method": "document",
          "tools": [],
          "text": {
            "en": "Ask for proof of every timing belt and oil pump belt replacement, and check the VIN for recall 23V-905 (US cars) and for any Ford customer programme.",
            "pt": "Peça comprovativo de todas as substituições da correia de distribuição e da correia da bomba de óleo e verifique o VIN quanto à chamada 23V-905 (carros dos EUA) e a qualquer programa de clientes da Ford.",
            "ru": "Запросите подтверждение каждой замены ремня ГРМ и ремня масляного насоса и проверьте VIN на отзыв 23V-905 (машины для США) и на программы Ford для клиентов.",
            "uk": "Запросіть підтвердження кожної заміни ременя ГРМ і ременя оливного насоса та перевірте VIN на відкликання 23V-905 (машини для США) і на програми Ford для клієнтів.",
            "fr": "Demandez les preuves de chaque remplacement de la courroie de distribution et de la courroie de pompe à huile, et vérifiez le VIN pour le rappel 23V-905 (voitures américaines) et tout programme client Ford."
          },
          "redFlag": {
            "en": "No belt service record on a car older than 6 to 10 years, or recall 23V-905 open.",
            "pt": "Sem registo de substituição da correia num carro com mais de 6 a 10 anos, ou chamada 23V-905 por executar.",
            "ru": "Нет записей о замене ремня на машине старше 6-10 лет или отзыв 23V-905 не выполнен.",
            "uk": "Немає записів про заміну ременя на машині старше 6-10 років або відкликання 23V-905 не виконано.",
            "fr": "Aucune trace de remplacement de la courroie sur une voiture de plus de 6 à 10 ans, ou rappel 23V-905 non effectué."
          }
        },
        {
          "id": "i2",
          "method": "visual",
          "tools": [],
          "text": {
            "en": "Check the engine oil: smell for petrol and look for dark flakes or debris on the dipstick and in the filler area.",
            "pt": "Verifique o óleo do motor: cheire se tem gasolina e procure partículas escuras ou resíduos na vareta e na zona do bocal.",
            "ru": "Проверьте моторное масло: понюхайте на запах бензина и поищите тёмные частицы на щупе и в горловине.",
            "uk": "Перевірте моторну оливу: понюхайте на запах бензину й пошукайте темні частинки на щупі та в горловині.",
            "fr": "Contrôlez l'huile moteur : sentez l'odeur d'essence et cherchez des particules sombres sur la jauge et dans le goulot."
          },
          "redFlag": {
            "en": "Petrol smell, black flakes or debris in the oil.",
            "pt": "Cheiro a gasolina, flocos pretos ou resíduos no óleo.",
            "ru": "Запах бензина, чёрные хлопья или частицы в масле.",
            "uk": "Запах бензину, чорні пластівці або частинки в оливі.",
            "fr": "Odeur d'essence, flocons noirs ou débris dans l'huile."
          }
        },
        {
          "id": "i3",
          "method": "obd",
          "tools": [],
          "text": {
            "en": "Read the fault memory and watch the oil pressure indicator at cold start and at idle when warm.",
            "pt": "Leia a memória de avarias e observe o indicador de pressão do óleo no arranque a frio e em ralenti com o motor quente.",
            "ru": "Считайте память ошибок и следите за индикатором давления масла при холодном пуске и на прогретом холостом ходу.",
            "uk": "Зчитайте пам'ять помилок і стежте за індикатором тиску оливи під час холодного пуску та на прогрітому холостому ході.",
            "fr": "Lisez la mémoire de défauts et surveillez l'indicateur de pression d'huile au démarrage à froid et au ralenti à chaud."
          },
          "redFlag": {
            "en": "Oil pressure warning at any time, even briefly.",
            "pt": "Aviso de pressão do óleo em qualquer momento, mesmo breve.",
            "ru": "Предупреждение о давлении масла в любой момент, даже кратковременное.",
            "uk": "Попередження про тиск оливи в будь-який момент, навіть короткочасне.",
            "fr": "Alerte de pression d'huile à tout moment, même brève."
          }
        }
      ],
      "repair": {
        "remedy": {
          "en": "Recall 23V-905 fits a redesigned bolted tensioner with a shorter arm and a belt with updated material. Otherwise belt replacement at the interval; in the UK Parkers quotes about 800 to 2,000 GBP.",
          "pt": "A chamada 23V-905 monta um tensor aparafusado redesenhado com braço mais curto e uma correia com material atualizado. Caso contrário, substituição da correia no intervalo; no Reino Unido a Parkers indica cerca de 800 a 2000 GBP.",
          "ru": "Отзыв 23V-905 устанавливает переработанный болтовой натяжитель с более коротким рычагом и ремень с обновлённым материалом. В остальных случаях — замена ремня по регламенту; в Великобритании Parkers называет примерно 800-2000 GBP.",
          "uk": "Відкликання 23V-905 встановлює перероблений болтовий натяжник з коротшим важелем і ремінь з оновленим матеріалом. В інших випадках — заміна ременя за регламентом; у Великій Британії Parkers називає приблизно 800-2000 GBP.",
          "fr": "Le rappel 23V-905 monte un tendeur boulonné redessiné à bras plus court et une courroie au matériau mis à jour. Sinon, remplacement de la courroie à l'intervalle ; au Royaume-Uni, Parkers cite environ 800 à 2000 GBP."
        },
        "cost": null,
        "worstCase": null,
        "manufacturerProgramme": {
          "evidence": [
            "ev_pf_w01",
            "ev_pf_w04"
          ],
          "text": {
            "en": "US recall 23V-905 is free of charge and applies to US vehicles only. According to NHTSA's EA26-004 resume, in June 2026 Ford told NHTSA of a non-safety customer satisfaction programme for 1.0L Fox Classic engines worldwide: a revised belt interval of 100,000 miles or 6 years, and reimbursement for eligible owners who paid for earlier engine repairs linked to the belt. How it is applied in each European country was not found; ask a Ford dealer with the VIN.",
            "pt": "A chamada 23V-905 dos EUA é gratuita e aplica-se apenas a veículos dos EUA. Segundo o resumo EA26-004 da NHTSA, em junho de 2026 a Ford informou a NHTSA de um programa de satisfação do cliente sem carácter de segurança para os motores 1.0L Fox Classic em todo o mundo: novo intervalo da correia de 100 000 milhas ou 6 anos e reembolso aos proprietários elegíveis que pagaram reparações anteriores do motor ligadas à correia. Não foi encontrado como é aplicado em cada país europeu; pergunte a um concessionário Ford com o VIN.",
            "ru": "Отзыв 23V-905 в США бесплатный и касается только машин для США. Согласно резюме NHTSA по EA26-004, в июне 2026 Ford сообщила NHTSA о программе удовлетворения клиентов, не связанной с безопасностью, для двигателей 1.0L Fox Classic по всему миру: новый интервал замены ремня 100 000 миль или 6 лет и возмещение подходящим владельцам, которые оплатили более ранний ремонт двигателя, связанный с ремнём. Как она применяется в отдельных европейских странах, найти не удалось; уточните у дилера Ford по VIN.",
            "uk": "Відкликання 23V-905 у США безкоштовне і стосується лише машин для США. Згідно з резюме NHTSA щодо EA26-004, у червні 2026 Ford повідомила NHTSA про програму задоволення клієнтів, не пов'язану з безпекою, для двигунів 1.0L Fox Classic у всьому світі: новий інтервал заміни ременя 100 000 миль або 6 років і відшкодування власникам, які мають на це право й оплатили раніший ремонт двигуна, пов'язаний з ременем. Як вона застосовується в окремих європейських країнах, знайти не вдалося; уточніть у дилера Ford за VIN.",
            "fr": "Le rappel américain 23V-905 est gratuit et ne concerne que les véhicules américains. Selon le résumé EA26-004 de la NHTSA, en juin 2026 Ford a informé la NHTSA d'un programme de satisfaction client hors sécurité pour les moteurs 1.0L Fox Classic dans le monde entier : nouvel intervalle de courroie de 100 000 miles ou 6 ans et remboursement des propriétaires éligibles ayant payé une réparation moteur antérieure liée à la courroie. Son application dans chaque pays européen n'a pas été trouvée ; renseignez-vous auprès d'un concessionnaire Ford avec le VIN."
          }
        }
      },
      "evidence": [
        "ev_pf_w01",
        "ev_pf_w02",
        "ev_pf_w03",
        "ev_pf_w04",
        "ev_pf_w05",
        "ev_pf_w06",
        "ev_pf_w07"
      ],
      "prevalence": [
        "pv_pf_wb_recall",
        "pv_pf_wb_claims",
        "pv_pf_wb_none"
      ]
    },
    {
      "id": "ecoboost.coolant",
      "aliases": [],
      "status": "published",
      "replacedBy": null,
      "revision": 1,
      "updatedAt": "2026-10-13",
      "legacyRule": "ford-known-issues",
      "title": {
        "en": "Ford 1.0 EcoBoost (Fox) built October 2011 to October 2013: the degas pipe material can degrade, with coolant loss and overheating",
        "pt": "Ford 1.0 EcoBoost (Fox) fabricado de outubro de 2011 a outubro de 2013: o material do tubo de desgaseificação pode degradar-se, com perda de líquido de refrigeração e sobreaquecimento",
        "ru": "Ford 1.0 EcoBoost (Fox) выпуска октябрь 2011 - октябрь 2013: материал патрубка дегазации может разрушаться, с потерей охлаждающей жидкости и перегревом",
        "uk": "Ford 1.0 EcoBoost (Fox) випуску жовтень 2011 - жовтень 2013: матеріал патрубка дегазації може руйнуватися, з втратою охолоджувальної рідини та перегрівом",
        "fr": "Ford 1.0 EcoBoost (Fox) produit d'octobre 2011 à octobre 2013 : le matériau de la durite de dégazage peut se dégrader, avec perte de liquide de refroidissement et surchauffe"
      },
      "summary": {
        "en": "In a November 2018 letter to the UK House of Commons Transport Committee, Ford stated that the degas pipe material on the 1.0L Fox engine could degrade, causing coolant loss and then overheating. Ford changed the material in production from October 2013 and ran voluntary service action 4S615 on just over 44,600 UK Focus with engines built October 2011 to October 2013. Ford said the DVSA did not classify it as a safety issue, and that overheating can lead to engine distortion and seizure. Ford also reported coolant leakage on Fiesta, B-MAX and C-MAX, and from October 2018 offered a 100% goodwill contribution to repair costs at Ford dealers for 1.0L Fox cooling issues.",
        "pt": "Numa carta de novembro de 2018 à Comissão de Transportes da Câmara dos Comuns do Reino Unido, a Ford declarou que o material do tubo de desgaseificação do motor 1.0L Fox podia degradar-se, causando perda de líquido de refrigeração e depois sobreaquecimento. A Ford mudou o material na produção a partir de outubro de 2013 e realizou a ação de serviço voluntária 4S615 em pouco mais de 44 600 Focus no Reino Unido com motores fabricados de outubro de 2011 a outubro de 2013. A Ford disse que a DVSA não a classificou como problema de segurança e que o sobreaquecimento pode levar a distorção e gripagem do motor. A Ford referiu também fugas de líquido em Fiesta, B-MAX e C-MAX e, a partir de outubro de 2018, ofereceu uma contribuição de boa vontade de 100% para o custo de reparação em concessionários Ford para problemas de refrigeração do 1.0L Fox.",
        "ru": "В письме комитету по транспорту Палаты общин Великобритании в ноябре 2018 Ford заявила, что материал патрубка дегазации двигателя 1.0L Fox мог разрушаться, вызывая потерю охлаждающей жидкости и затем перегрев. Ford сменила материал в производстве с октября 2013 и провела добровольную сервисную акцию 4S615 для чуть более 44 600 британских Focus с двигателями выпуска октябрь 2011 - октябрь 2013. Ford сообщила, что DVSA не отнесла проблему к безопасности и что перегрев может привести к деформации и заклиниванию двигателя. Ford также сообщила об утечках охлаждающей жидкости на Fiesta, B-MAX и C-MAX и с октября 2018 предложила компенсацию 100% стоимости ремонта у дилеров Ford в порядке доброй воли при проблемах охлаждения 1.0L Fox.",
        "uk": "У листі до комітету з транспорту Палати громад Великої Британії в листопаді 2018 Ford заявила, що матеріал патрубка дегазації двигуна 1.0L Fox міг руйнуватися, спричиняючи втрату охолоджувальної рідини й потім перегрів. Ford змінила матеріал у виробництві з жовтня 2013 і провела добровільну сервісну акцію 4S615 для трохи більше ніж 44 600 британських Focus з двигунами випуску жовтень 2011 - жовтень 2013. Ford повідомила, що DVSA не віднесла проблему до безпеки і що перегрів може призвести до деформації та заклинювання двигуна. Ford також повідомила про витоки охолоджувальної рідини на Fiesta, B-MAX і C-MAX і з жовтня 2018 запропонувала компенсацію 100% вартості ремонту в дилерів Ford у порядку доброї волі за проблем охолодження 1.0L Fox.",
        "fr": "Dans une lettre de novembre 2018 à la commission des transports de la Chambre des communes britannique, Ford a déclaré que le matériau du tuyau de dégazage du moteur 1.0L Fox pouvait se dégrader, entraînant une perte de liquide de refroidissement puis une surchauffe. Ford a changé le matériau en production à partir d'octobre 2013 et mené l'action de service volontaire 4S615 sur un peu plus de 44 600 Focus britanniques à moteur fabriqué d'octobre 2011 à octobre 2013. Ford a indiqué que la DVSA ne l'a pas classée comme problème de sécurité et que la surchauffe peut entraîner une déformation et un grippage du moteur. Ford a aussi signalé des fuites de liquide sur Fiesta, B-MAX et C-MAX et, à partir d'octobre 2018, a proposé une contribution commerciale de 100 % au coût de réparation chez les concessionnaires Ford pour les problèmes de refroidissement du 1.0L Fox."
      },
      "checklistPrompt": {
        "en": "1.0 EcoBoost built 2011-2013: degas pipe - check it was replaced and the coolant level has been stable",
        "pt": "1.0 EcoBoost fabricado em 2011-2013: tubo de desgaseificação - verificar se foi substituído e se o nível do líquido é estável",
        "ru": "1.0 EcoBoost выпуска 2011-2013: патрубок дегазации — проверить, заменён ли он и стабилен ли уровень охлаждающей жидкости",
        "uk": "1.0 EcoBoost випуску 2011-2013: патрубок дегазації — перевірити, чи замінено його і чи стабільний рівень охолоджувальної рідини",
        "fr": "1.0 EcoBoost produit en 2011-2013 : durite de dégazage - vérifier son remplacement et la stabilité du niveau de liquide"
      },
      "component": "engine.cooling.hose",
      "mechanism": {
        "en": "According to Ford's own evidence, the pipe in the cooling system (the degas pipe) of the early 1.0L Fox was made of a material that could degrade. The pipe then leaks coolant, the engine can overheat, and sustained overheating can distort the engine and lead to seizure. Ford changed the material in production from October 2013. Ford says it found no evidence of cylinder head cracking on this engine. The legacy wording of this item mentioned the cylinder head; cylinder head cracking belongs to the 1.6 Sigma engine, a different engine and a different defect, and is not part of this record.",
        "pt": "Segundo a prova da própria Ford, o tubo do sistema de refrigeração (tubo de desgaseificação) do primeiro 1.0L Fox era de um material que podia degradar-se. O tubo passa então a perder líquido, o motor pode sobreaquecer e um sobreaquecimento prolongado pode deformar o motor e levar à gripagem. A Ford mudou o material na produção a partir de outubro de 2013. A Ford diz não ter encontrado indícios de fissuras na cabeça dos cilindros neste motor. A redação antiga deste item mencionava a cabeça; a fissura da cabeça pertence ao motor 1.6 Sigma, outro motor e outro defeito, e não faz parte deste registo.",
        "ru": "По собственным материалам Ford, патрубок системы охлаждения (патрубок дегазации) раннего 1.0L Fox был сделан из материала, который мог разрушаться. Тогда патрубок начинает течь, двигатель может перегреться, а длительный перегрев способен деформировать двигатель и привести к заклиниванию. Ford сменила материал в производстве с октября 2013. Ford сообщает, что не нашла признаков трещин головки блока на этом двигателе. Прежняя формулировка этого пункта упоминала головку; трещины головки относятся к двигателю 1.6 Sigma — другому двигателю и другому дефекту, и в эту запись не входят.",
        "uk": "За власними матеріалами Ford, патрубок системи охолодження (патрубок дегазації) раннього 1.0L Fox був виготовлений з матеріалу, що міг руйнуватися. Тоді патрубок починає текти, двигун може перегрітися, а тривалий перегрів здатен деформувати двигун і призвести до заклинювання. Ford змінила матеріал у виробництві з жовтня 2013. Ford повідомляє, що не знайшла ознак тріщин головки блока на цьому двигуні. Попереднє формулювання цього пункту згадувало головку; тріщини головки стосуються двигуна 1.6 Sigma — іншого двигуна й іншого дефекту, і в цей запис не входять.",
        "fr": "Selon les propres pièces de Ford, la durite du circuit de refroidissement (durite de dégazage) du premier 1.0L Fox était faite d'un matériau pouvant se dégrader. La durite fuit alors, le moteur peut surchauffer, et une surchauffe prolongée peut déformer le moteur et mener au serrage. Ford a changé le matériau en production à partir d'octobre 2013. Ford dit n'avoir trouvé aucune preuve de fissuration de culasse sur ce moteur. L'ancienne formulation de cet élément citait la culasse ; la fissuration de culasse relève du moteur 1.6 Sigma, un autre moteur et un autre défaut, et ne fait pas partie de cette fiche."
      },
      "applicability": {
        "models": [
          "ford.focus",
          "ford.fiesta",
          "ford.b_max",
          "ford.c_max"
        ],
        "when": {
          "all": [
            {
              "engine": {
                "ids": [
                  "ford.fox_1_0"
                ]
              }
            },
            {
              "productionDate": {
                "from": "2011-10",
                "to": "2013-10"
              }
            }
          ]
        },
        "markets": [
          "UK"
        ],
        "hint": {
          "en": "Only Ford 1.0 EcoBoost (Fox) engines built from October 2011 to October 2013. Ford's action covered the Focus; Ford says it also knows of coolant leakage on Fiesta, B-MAX and C-MAX 1.0L engines, so those are listed as likely rather than confirmed in scope.",
          "pt": "Apenas motores Ford 1.0 EcoBoost (Fox) fabricados de outubro de 2011 a outubro de 2013. A ação da Ford abrangeu o Focus; a Ford diz conhecer também fugas de líquido em motores 1.0L de Fiesta, B-MAX e C-MAX, pelo que estes são indicados como prováveis e não como confirmados no âmbito.",
          "ru": "Только двигатели Ford 1.0 EcoBoost (Fox) выпуска с октября 2011 по октябрь 2013. Акция Ford охватывала Focus; Ford сообщает, что знает об утечках охлаждающей жидкости и на двигателях 1.0L Fiesta, B-MAX и C-MAX, поэтому они указаны как вероятные, а не подтверждённые в охвате.",
          "uk": "Лише двигуни Ford 1.0 EcoBoost (Fox) випуску з жовтня 2011 по жовтень 2013. Акція Ford охоплювала Focus; Ford повідомляє, що знає про витоки охолоджувальної рідини й на двигунах 1.0L Fiesta, B-MAX та C-MAX, тому вони вказані як ймовірні, а не підтверджені в охопленні.",
          "fr": "Uniquement les moteurs Ford 1.0 EcoBoost (Fox) produits d'octobre 2011 à octobre 2013. L'action de Ford couvrait la Focus ; Ford dit connaître aussi des fuites sur les 1.0L de Fiesta, B-MAX et C-MAX, ils sont donc indiqués comme probables et non confirmés dans le périmètre."
        },
        "notes": {
          "en": "Ford's figures are for UK cars. Whether the same action applied outside the UK was not checked.",
          "pt": "Os números da Ford referem-se a carros do Reino Unido. Não foi verificado se a mesma ação se aplicou fora do Reino Unido.",
          "ru": "Цифры Ford относятся к британским машинам. Применялась ли такая же акция за пределами Великобритании, не проверялось.",
          "uk": "Цифри Ford стосуються британських машин. Чи застосовувалася така сама акція поза межами Великої Британії, не перевірялося.",
          "fr": "Les chiffres de Ford portent sur les voitures britanniques. L'application de la même action hors du Royaume-Uni n'a pas été vérifiée."
        }
      },
      "severity": "critical",
      "safety": false,
      "critical": true,
      "symptoms": [
        {
          "id": "s1",
          "stage": "early",
          "text": {
            "en": "Coolant level dropping, coolant smell or residue around the pipe",
            "pt": "Nível do líquido de refrigeração a descer, cheiro a líquido ou resíduos junto ao tubo",
            "ru": "Падение уровня охлаждающей жидкости, запах или следы около патрубка",
            "uk": "Падіння рівня охолоджувальної рідини, запах або сліди біля патрубка",
            "fr": "Baisse du niveau de liquide de refroidissement, odeur ou traces près de la durite"
          }
        },
        {
          "id": "s2",
          "stage": "early",
          "text": {
            "en": "Engine temperature warnings",
            "pt": "Avisos de temperatura do motor",
            "ru": "Предупреждения о температуре двигателя",
            "uk": "Попередження про температуру двигуна",
            "fr": "Alertes de température moteur"
          }
        },
        {
          "id": "s3",
          "stage": "late",
          "text": {
            "en": "Overheating, engine distortion and seizure (Ford)",
            "pt": "Sobreaquecimento, deformação e gripagem do motor (Ford)",
            "ru": "Перегрев, деформация и заклинивание двигателя (Ford)",
            "uk": "Перегрів, деформація та заклинювання двигуна (Ford)",
            "fr": "Surchauffe, déformation et serrage du moteur (Ford)"
          }
        }
      ],
      "inspection": [
        {
          "id": "i1",
          "method": "document",
          "tools": [],
          "text": {
            "en": "Check that the engine was built from October 2013 or that the degas pipe was replaced under Ford action 4S615 or later; ask for the invoice.",
            "pt": "Verifique se o motor foi fabricado a partir de outubro de 2013 ou se o tubo de desgaseificação foi substituído na ação 4S615 da Ford ou depois; peça a fatura.",
            "ru": "Проверьте, что двигатель выпущен с октября 2013 или патрубок дегазации заменён по акции Ford 4S615 или позже; запросите счёт.",
            "uk": "Перевірте, що двигун випущено з жовтня 2013 або патрубок дегазації замінено за акцією Ford 4S615 чи пізніше; запросіть рахунок.",
            "fr": "Vérifiez que le moteur date d'octobre 2013 ou après, ou que la durite de dégazage a été remplacée lors de l'action Ford 4S615 ou plus tard ; demandez la facture."
          },
          "redFlag": {
            "en": "Engine built October 2011 to October 2013 with no record of the pipe.",
            "pt": "Motor fabricado de outubro de 2011 a outubro de 2013 sem registo do tubo.",
            "ru": "Двигатель выпуска октябрь 2011 - октябрь 2013 без записей о патрубке.",
            "uk": "Двигун випуску жовтень 2011 - жовтень 2013 без записів про патрубок.",
            "fr": "Moteur produit d'octobre 2011 à octobre 2013 sans trace de la durite."
          }
        },
        {
          "id": "i2",
          "method": "visual",
          "tools": [],
          "text": {
            "en": "With the engine cold, check the coolant level and look for dried coolant around the degas pipe and expansion tank.",
            "pt": "Com o motor frio, verifique o nível do líquido de refrigeração e procure líquido seco à volta do tubo de desgaseificação e do depósito de expansão.",
            "ru": "На холодном двигателе проверьте уровень охлаждающей жидкости и следы высохшей жидкости около патрубка дегазации и расширительного бачка.",
            "uk": "На холодному двигуні перевірте рівень охолоджувальної рідини та сліди висохлої рідини біля патрубка дегазації й розширювального бачка.",
            "fr": "Moteur froid, vérifiez le niveau de liquide et cherchez des traces séchées autour de la durite de dégazage et du vase d'expansion."
          },
          "redFlag": {
            "en": "Low level, crusted residue or a recently topped-up system.",
            "pt": "Nível baixo, resíduos secos ou sistema atestado recentemente.",
            "ru": "Низкий уровень, засохшие следы или недавно доливаемая система.",
            "uk": "Низький рівень, засохлі сліди або нещодавно доливана система.",
            "fr": "Niveau bas, résidus séchés ou circuit récemment complété."
          }
        },
        {
          "id": "i3",
          "method": "obd",
          "tools": [],
          "text": {
            "en": "Read the fault memory and watch the temperature gauge on a test drive.",
            "pt": "Leia a memória de avarias e observe o indicador de temperatura num teste de condução.",
            "ru": "Считайте память ошибок и следите за указателем температуры на тест-драйве.",
            "uk": "Зчитайте пам'ять помилок і стежте за покажчиком температури під час тест-драйву.",
            "fr": "Lisez la mémoire de défauts et surveillez la jauge de température à l'essai."
          },
          "redFlag": {
            "en": "Overheating warning or a temperature that climbs above normal.",
            "pt": "Aviso de sobreaquecimento ou temperatura acima do normal.",
            "ru": "Предупреждение о перегреве или температура выше нормы.",
            "uk": "Попередження про перегрів або температура вище норми.",
            "fr": "Alerte de surchauffe ou température supérieure à la normale."
          }
        }
      ],
      "repair": {
        "remedy": {
          "en": "Replacement of the degas pipe with the updated part; engine repair or replacement if overheating has already damaged it.",
          "pt": "Substituição do tubo de desgaseificação pela peça atualizada; reparação ou substituição do motor se o sobreaquecimento já o danificou.",
          "ru": "Замена патрубка дегазации на обновлённую деталь; ремонт или замена двигателя, если перегрев уже его повредил.",
          "uk": "Заміна патрубка дегазації на оновлену деталь; ремонт або заміна двигуна, якщо перегрів уже його пошкодив.",
          "fr": "Remplacement de la durite de dégazage par la pièce mise à jour ; réparation ou remplacement du moteur si la surchauffe l'a déjà endommagé."
        },
        "cost": null,
        "worstCase": null,
        "manufacturerProgramme": {
          "evidence": [
            "ev_pf_c01"
          ],
          "text": {
            "en": "Ford service action 4S615 (owner letters from April 2015, Non-Coded Action from mid-2017). From October 2018 Ford said it would make a 100% goodwill contribution to the cost of a repair at a Ford dealer for 1.0L Fox cooling issues, including engine replacement, and pay 100% of the cost of Ford parts at independent garages. These are UK terms stated in 2018; current eligibility was not checked.",
            "pt": "Ação de serviço Ford 4S615 (cartas aos proprietários desde abril de 2015, Non-Coded Action desde meados de 2017). A partir de outubro de 2018 a Ford disse que faria uma contribuição de boa vontade de 100% para o custo de uma reparação num concessionário Ford para problemas de refrigeração do 1.0L Fox, incluindo a substituição do motor, e pagaria 100% do custo das peças Ford em oficinas independentes. São condições do Reino Unido declaradas em 2018; a elegibilidade atual não foi verificada.",
            "ru": "Сервисная акция Ford 4S615 (письма владельцам с апреля 2015, Non-Coded Action с середины 2017). С октября 2018 Ford заявила, что в порядке доброй воли компенсирует 100% стоимости ремонта у дилера Ford при проблемах охлаждения 1.0L Fox, включая замену двигателя, и 100% стоимости запчастей Ford в независимых мастерских. Это британские условия, заявленные в 2018; действуют ли они сейчас, не проверялось.",
            "uk": "Сервісна акція Ford 4S615 (листи власникам з квітня 2015, Non-Coded Action з середини 2017). З жовтня 2018 Ford заявила, що в порядку доброї волі компенсує 100% вартості ремонту в дилера Ford за проблем охолодження 1.0L Fox, включно із заміною двигуна, і 100% вартості запчастин Ford у незалежних майстернях. Це британські умови, заявлені у 2018; чи діють вони зараз, не перевірялося.",
            "fr": "Action de service Ford 4S615 (lettres aux propriétaires dès avril 2015, Non-Coded Action dès mi-2017). À partir d'octobre 2018, Ford a déclaré prendre en charge à titre commercial 100 % du coût d'une réparation chez un concessionnaire Ford pour les problèmes de refroidissement du 1.0L Fox, remplacement du moteur compris, et 100 % du coût des pièces Ford dans les garages indépendants. Ce sont des conditions britanniques annoncées en 2018 ; l'éligibilité actuelle n'a pas été vérifiée."
          }
        }
      },
      "evidence": [
        "ev_pf_c01",
        "ev_pf_c02"
      ],
      "prevalence": [
        "pv_pf_cl_fsa",
        "pv_pf_cl_none"
      ]
    },
    {
      "id": "powershift",
      "aliases": [],
      "status": "published",
      "replacedBy": null,
      "revision": 1,
      "updatedAt": "2026-10-13",
      "legacyRule": "ford-known-issues",
      "title": {
        "en": "Ford Fiesta and Focus with the DPS6 Powershift dual-clutch (built 2009-2016, US documentation): input shaft seal leaks, clutch shudder and control module failures",
        "pt": "Ford Fiesta e Focus com a caixa de dupla embraiagem DPS6 Powershift (fabrico 2009-2016, documentação dos EUA): fugas nas vedações do veio de entrada, trepidação da embraiagem e falhas do módulo de controlo",
        "ru": "Ford Fiesta и Focus с двухсцепной коробкой DPS6 Powershift (выпуск 2009-2016, документы США): течь сальников входного вала, вибрация сцепления и отказы блока управления",
        "uk": "Ford Fiesta і Focus із двозчепною коробкою DPS6 Powershift (випуск 2009-2016, документи США): течія сальників вхідного вала, вібрація зчеплення та відмови блока керування",
        "fr": "Ford Fiesta et Focus à double embrayage DPS6 Powershift (produites 2009-2016, documents américains) : fuites des joints d'arbre d'entrée, broutement de l'embrayage et pannes du module de commande"
      },
      "summary": {
        "en": "Ford has extended warranty coverage on the DPS6 dry dual-clutch automatic of the Fiesta and Focus in the US in three programmes: 14M01 (input shaft seals, clutch and calibration, 7 years or 100,000 miles, because leaking seals may contaminate the clutch and cause shudder), 14M02 (transmission control module, 10 years or 150,000 miles) and 19N08 (revised clutch material, 7 years or 100,000 miles, for judder on light acceleration). A US class action over the same gearbox was settled with about 1.9 million class members and final approval on 5 March 2020. No NHTSA recall was found. Documents for European-market cars were not found: this record is based on US documents and is tagged for the US market.",
        "pt": "A Ford alargou a garantia da caixa automática de dupla embraiagem a seco DPS6 do Fiesta e do Focus nos EUA em três programas: 14M01 (vedações do veio de entrada, embraiagem e calibração, 7 anos ou 100 000 milhas, porque vedações com fugas podem contaminar a embraiagem e causar trepidação), 14M02 (módulo de controlo da transmissão, 10 anos ou 150 000 milhas) e 19N08 (material de embraiagem revisto, 7 anos ou 100 000 milhas, para vibração em acelerações suaves). Uma ação coletiva nos EUA sobre a mesma caixa foi resolvida por acordo, com cerca de 1,9 milhões de membros da classe e aprovação final em 5 de março de 2020. Não foi encontrada nenhuma chamada da NHTSA. Não foram encontrados documentos para carros do mercado europeu: este registo baseia-se em documentos dos EUA e está marcado para o mercado dos EUA.",
        "ru": "Ford продлила гарантию на сухую двухсцепную автоматическую коробку DPS6 у Fiesta и Focus в США тремя программами: 14M01 (сальники входного вала, сцепление и калибровка, 7 лет или 100 000 миль, так как текущие сальники могут загрязнять сцепление и вызывать вибрацию), 14M02 (блок управления трансмиссией, 10 лет или 150 000 миль) и 19N08 (изменённый материал сцепления, 7 лет или 100 000 миль, при дёргании на лёгком разгоне). Коллективный иск в США по этой же коробке урегулирован: около 1,9 миллиона участников класса, окончательное утверждение 5 марта 2020. Отзыва NHTSA не найдено. Документов по машинам европейского рынка не найдено: запись основана на документах США и помечена для рынка США.",
        "uk": "Ford подовжила гарантію на суху двозчепну автоматичну коробку DPS6 у Fiesta і Focus у США трьома програмами: 14M01 (сальники вхідного вала, зчеплення та калібрування, 7 років або 100 000 миль, бо сальники, що течуть, можуть забруднювати зчеплення й спричиняти вібрацію), 14M02 (блок керування трансмісією, 10 років або 150 000 миль) і 19N08 (змінений матеріал зчеплення, 7 років або 100 000 миль, за сіпання на легкому розгоні). Колективний позов у США щодо тієї самої коробки врегульовано: близько 1,9 мільйона учасників класу, остаточне затвердження 5 березня 2020. Відкликання NHTSA не знайдено. Документів щодо машин європейського ринку не знайдено: запис ґрунтується на документах США й позначений для ринку США.",
        "fr": "Ford a étendu aux États-Unis la garantie de la boîte automatique à double embrayage sec DPS6 des Fiesta et Focus par trois programmes : 14M01 (joints d'arbre d'entrée, embrayage et calibration, 7 ans ou 100 000 miles, car des joints qui fuient peuvent contaminer l'embrayage et provoquer des à-coups), 14M02 (module de commande de transmission, 10 ans ou 150 000 miles) et 19N08 (matériau d'embrayage révisé, 7 ans ou 100 000 miles, pour des broutements à faible accélération). Une action collective américaine sur la même boîte a été réglée par accord, avec environ 1,9 million de membres de la classe et approbation finale le 5 mars 2020. Aucun rappel NHTSA n'a été trouvé. Aucun document pour les voitures du marché européen n'a été trouvé : cette fiche repose sur des documents américains et est marquée pour le marché américain."
      },
      "checklistPrompt": {
        "en": "Fiesta/Focus with DPS6 automatic (US documents, 2009-2016): shudder, seals, control module and Ford programmes 14M01, 14M02, 19N08 - check",
        "pt": "Fiesta/Focus com automática DPS6 (documentos dos EUA, 2009-2016): trepidação, vedações, módulo de controlo e programas Ford 14M01, 14M02, 19N08 - verificar",
        "ru": "Fiesta/Focus с автоматом DPS6 (документы США, 2009-2016): вибрация, сальники, блок управления и программы Ford 14M01, 14M02, 19N08 — проверить",
        "uk": "Fiesta/Focus з автоматом DPS6 (документи США, 2009-2016): вібрація, сальники, блок керування та програми Ford 14M01, 14M02, 19N08 — перевірити",
        "fr": "Fiesta/Focus à boîte DPS6 (documents américains, 2009-2016) : à-coups, joints, module de commande et programmes Ford 14M01, 14M02, 19N08 - vérifier"
      },
      "component": "transmission.dual_clutch",
      "mechanism": {
        "en": "The DPS6 is a six-speed dual-clutch automatic with dry clutches. Ford's own programmes name three problems. First, leaking input shaft seals may contaminate the clutch with fluid and cause shudder on light acceleration (14M01). Second, the clutch itself can judder or shudder on light acceleration, and Ford revised the clutch material (19N08). Third, electrical circuit failures inside the transmission control module can cause intermittent loss of transmission engagement while driving, no-start and lack of power (14M02). The wording is Ford's; the court settlement did not find the cause.",
        "pt": "A DPS6 é uma caixa automática de dupla embraiagem de seis velocidades com embraiagens a seco. Os programas da própria Ford indicam três problemas. Primeiro, vedações do veio de entrada com fugas podem contaminar a embraiagem com fluido e causar trepidação em acelerações suaves (14M01). Segundo, a própria embraiagem pode vibrar ou trepidar em acelerações suaves, e a Ford reviu o material da embraiagem (19N08). Terceiro, falhas de circuitos elétricos dentro do módulo de controlo da transmissão podem causar perda intermitente de engate da transmissão durante a condução, falta de arranque e falta de potência (14M02). A redação é da Ford; o acordo judicial não determinou a causa.",
        "ru": "DPS6 — шестиступенчатый автомат с двумя сухими сцеплениями. Программы самой Ford называют три проблемы. Первая: текущие сальники входного вала могут загрязнять сцепление жидкостью и вызывать вибрацию при лёгком разгоне (14M01). Вторая: само сцепление может дёргаться или вибрировать при лёгком разгоне, и Ford изменила материал сцепления (19N08). Третья: отказы электрических цепей внутри блока управления трансмиссией могут вызывать периодическую потерю включения передачи на ходу, отсутствие запуска и нехватку мощности (14M02). Формулировки принадлежат Ford; судебное соглашение причину не устанавливало.",
        "uk": "DPS6 — шестиступінчастий автомат із двома сухими зчепленнями. Програми самої Ford називають три проблеми. Перша: сальники вхідного вала, що течуть, можуть забруднювати зчеплення рідиною й спричиняти вібрацію за легкого розгону (14M01). Друга: саме зчеплення може сіпатися або вібрувати за легкого розгону, і Ford змінила матеріал зчеплення (19N08). Третя: збої електричних кіл усередині блока керування трансмісією можуть спричиняти періодичну втрату вмикання передачі на ходу, відсутність запуску й нестачу потужності (14M02). Формулювання належать Ford; судова угода причини не встановлювала.",
        "fr": "La DPS6 est une boîte automatique à six rapports et double embrayage sec. Les programmes de Ford nomment trois problèmes. D'abord, des joints d'arbre d'entrée qui fuient peuvent contaminer l'embrayage par du fluide et provoquer des à-coups à faible accélération (14M01). Ensuite, l'embrayage lui-même peut brouter ou vibrer à faible accélération, et Ford a révisé son matériau (19N08). Enfin, des défaillances de circuits électriques internes au module de commande de transmission peuvent causer une perte intermittente d'enclenchement en roulant, une absence de démarrage et un manque de puissance (14M02). La formulation est celle de Ford ; l'accord judiciaire n'a pas établi la cause."
      },
      "applicability": {
        "models": [
          "ford.fiesta",
          "ford.focus"
        ],
        "when": {
          "all": [
            {
              "gearbox": {
                "ids": [
                  "ford.dps6"
                ]
              }
            },
            {
              "productionDate": {
                "from": "2009-11",
                "to": "2016-12"
              }
            }
          ]
        },
        "markets": [
          "US"
        ],
        "hint": {
          "en": "Only Fiesta and Focus with the DPS6 dry dual-clutch automatic. The Ford programmes cover builds from 3 November 2009 (Fiesta) and 1 August 2010 (Focus) to 5 November 2015; the US class action covers model years up to 2016, so the window here runs to the end of 2016. Manual cars are not affected. No document was found for European-market cars: this record is based on US documents only.",
          "pt": "Apenas Fiesta e Focus com a caixa automática de dupla embraiagem a seco DPS6. Os programas Ford abrangem a produção de 3 de novembro de 2009 (Fiesta) e 1 de agosto de 2010 (Focus) até 5 de novembro de 2015; a ação coletiva nos EUA abrange anos-modelo até 2016, pelo que a janela aqui vai até ao fim de 2016. Os carros com caixa manual não são afetados. Não foi encontrado nenhum documento para carros do mercado europeu: este registo baseia-se apenas em documentos dos EUA.",
          "ru": "Только Fiesta и Focus с роботизированной коробкой DPS6 с двумя сухими сцеплениями. Программы Ford охватывают выпуск с 3 ноября 2009 (Fiesta) и 1 августа 2010 (Focus) по 5 ноября 2015; коллективный иск в США охватывает модельные годы до 2016, поэтому окно здесь продлено до конца 2016. Машины с механикой не затронуты. Документов для машин европейского рынка не найдено: запись основана только на документах США.",
          "uk": "Лише Fiesta і Focus з роботизованою коробкою DPS6 із двома сухими зчепленнями. Програми Ford охоплюють випуск з 3 листопада 2009 (Fiesta) і 1 серпня 2010 (Focus) по 5 листопада 2015; колективний позов у США охоплює модельні роки до 2016, тому вікно тут подовжено до кінця 2016. Машини з механікою не зачеплені. Документів для машин європейського ринку не знайдено: запис базується лише на документах США.",
          "fr": "Uniquement les Fiesta et Focus à boîte automatique à double embrayage sec DPS6. Les programmes Ford couvrent la production du 3 novembre 2009 (Fiesta) et du 1er août 2010 (Focus) au 5 novembre 2015 ; l'action collective américaine couvre les millésimes jusqu'à 2016, la fenêtre va donc ici jusqu'à fin 2016. Les voitures à boîte manuelle ne sont pas concernées. Aucun document n'a été trouvé pour les voitures du marché européen : cette fiche repose uniquement sur des documents américains."
        },
        "notes": {
          "en": "The gearbox record has no gearbox code. The court class covers model years 2011-2016 Fiesta and 2012-2016 Focus with the DPS6; the build window follows the Ford programmes and is extended to the end of 2016 to cover those model years.",
          "pt": "O registo da caixa não tem código de caixa. A classe do processo abrange Fiesta de 2011-2016 e Focus de 2012-2016 com DPS6; a janela de produção segue os programas Ford e é alargada até ao fim de 2016 para cobrir esses anos-modelo.",
          "ru": "У записи коробки нет кода. Класс по иску охватывает Fiesta 2011-2016 и Focus 2012-2016 модельных годов с DPS6; окно выпуска следует программам Ford и продлено до конца 2016, чтобы покрыть эти модельные годы.",
          "uk": "У записі коробки немає коду. Клас за позовом охоплює Fiesta 2011-2016 і Focus 2012-2016 модельних років з DPS6; вікно випуску відповідає програмам Ford і подовжене до кінця 2016, щоб покрити ці модельні роки.",
          "fr": "La fiche de boîte n'a pas de code de boîte. La classe de l'action couvre les Fiesta 2011-2016 et Focus 2012-2016 à DPS6 ; la fenêtre de production suit les programmes Ford et est prolongée jusqu'à fin 2016 pour couvrir ces millésimes."
        }
      },
      "severity": "major",
      "safety": false,
      "critical": false,
      "symptoms": [
        {
          "id": "s1",
          "stage": "early",
          "text": {
            "en": "Shudder or judder on light acceleration, especially from a stop",
            "pt": "Trepidação ou vibração em acelerações suaves, sobretudo a partir de parado",
            "ru": "Вибрация или дёргание при лёгком разгоне, особенно с места",
            "uk": "Вібрація або сіпання за легкого розгону, особливо з місця",
            "fr": "Broutement ou à-coups à faible accélération, surtout à l'arrêt"
          }
        },
        {
          "id": "s2",
          "stage": "early",
          "text": {
            "en": "Transmission warning light or intermittent loss of drive",
            "pt": "Luz de aviso da transmissão ou perda intermitente de tração",
            "ru": "Предупреждение трансмиссии или периодическая потеря тяги",
            "uk": "Попередження трансмісії або періодична втрата тяги",
            "fr": "Voyant de transmission ou perte intermittente de motricité"
          }
        },
        {
          "id": "s3",
          "stage": "late",
          "text": {
            "en": "No-start, lack of power or loss of gear engagement while driving (Ford)",
            "pt": "Falta de arranque, falta de potência ou perda de engate de mudança durante a condução (Ford)",
            "ru": "Отсутствие запуска, нехватка мощности или потеря включения передачи на ходу (Ford)",
            "uk": "Відсутність запуску, нестача потужності або втрата вмикання передачі на ходу (Ford)",
            "fr": "Absence de démarrage, manque de puissance ou perte d'enclenchement en roulant (Ford)"
          }
        }
      ],
      "inspection": [
        {
          "id": "i1",
          "method": "document",
          "tools": [],
          "text": {
            "en": "Ask for the service history: clutch, input shaft seal and control module work, software updates and any Ford programme 14M01, 14M02 or 19N08 repairs.",
            "pt": "Peça o historial de revisões: trabalhos na embraiagem, nas vedações do veio de entrada e no módulo de controlo, atualizações de software e reparações dos programas Ford 14M01, 14M02 ou 19N08.",
            "ru": "Запросите сервисную историю: работы по сцеплению, сальникам входного вала и блоку управления, обновления ПО и ремонты по программам Ford 14M01, 14M02 или 19N08.",
            "uk": "Запросіть сервісну історію: роботи зі зчепленням, сальниками вхідного вала та блоком керування, оновлення ПЗ і ремонти за програмами Ford 14M01, 14M02 або 19N08.",
            "fr": "Demandez l'historique d'entretien : travaux d'embrayage, de joints d'arbre d'entrée et de module de commande, mises à jour logicielles et réparations des programmes Ford 14M01, 14M02 ou 19N08."
          },
          "redFlag": {
            "en": "Repeated transmission visits with no clutch or module record.",
            "pt": "Várias visitas por causa da transmissão sem registo de embraiagem ou módulo.",
            "ru": "Многократные визиты по трансмиссии без записей о сцеплении или блоке.",
            "uk": "Багаторазові візити через трансмісію без записів про зчеплення чи блок.",
            "fr": "Visites répétées pour la transmission sans trace d'embrayage ou de module."
          }
        },
        {
          "id": "i2",
          "method": "obd",
          "tools": [],
          "text": {
            "en": "Read the transmission fault memory and check the software calibration level.",
            "pt": "Leia a memória de avarias da transmissão e verifique o nível de calibração do software.",
            "ru": "Считайте память ошибок трансмиссии и проверьте уровень калибровки ПО.",
            "uk": "Зчитайте пам'ять помилок трансмісії та перевірте рівень калібрування ПЗ.",
            "fr": "Lisez la mémoire de défauts de la transmission et vérifiez le niveau de calibration logicielle."
          },
          "redFlag": {
            "en": "Stored clutch or control module faults.",
            "pt": "Avarias registadas de embraiagem ou módulo de controlo.",
            "ru": "Сохранённые ошибки сцепления или блока управления.",
            "uk": "Збережені помилки зчеплення або блока керування.",
            "fr": "Défauts mémorisés d'embrayage ou de module de commande."
          }
        },
        {
          "id": "i3",
          "method": "listen",
          "tools": [],
          "text": {
            "en": "On a test drive, pull away gently from a stop several times, uphill and in traffic speeds.",
            "pt": "Num teste de condução, arranque suavemente de parado várias vezes, em subida e a velocidades de trânsito.",
            "ru": "На тест-драйве несколько раз плавно трогайтесь с места, в том числе в подъём и на городских скоростях.",
            "uk": "Під час тест-драйву кілька разів плавно рушайте з місця, зокрема на підйомі та на міських швидкостях.",
            "fr": "À l'essai, démarrez doucement à l'arrêt plusieurs fois, en côte et à vitesse urbaine."
          },
          "redFlag": {
            "en": "Shudder, shaking or hesitation when moving off.",
            "pt": "Trepidação, tremores ou hesitação ao arrancar.",
            "ru": "Вибрация, тряска или задержка при трогании.",
            "uk": "Вібрація, тряска або затримка під час рушання.",
            "fr": "Broutement, secousses ou hésitation au démarrage."
          }
        }
      ],
      "repair": {
        "remedy": {
          "en": "Replacement of the input shaft seals, the clutch (revised material for later builds) and the transmission control module, plus software calibration updates, as the Ford programmes describe.",
          "pt": "Substituição das vedações do veio de entrada, da embraiagem (material revisto nas fabricações posteriores) e do módulo de controlo da transmissão, além de atualizações de calibração de software, conforme descrevem os programas da Ford.",
          "ru": "Замена сальников входного вала, сцепления (изменённый материал на поздних сериях) и блока управления трансмиссией, а также обновление калибровки ПО, как описано в программах Ford.",
          "uk": "Заміна сальників вхідного вала, зчеплення (змінений матеріал у пізніших серіях) і блока керування трансмісією, а також оновлення калібрування ПЗ, як описано в програмах Ford.",
          "fr": "Remplacement des joints d'arbre d'entrée, de l'embrayage (matériau révisé sur les séries ultérieures) et du module de commande de transmission, plus mises à jour de calibration logicielle, comme décrit par les programmes Ford."
        },
        "cost": null,
        "worstCase": null,
        "manufacturerProgramme": {
          "evidence": [
            "ev_pf_p01",
            "ev_pf_p02",
            "ev_pf_p03"
          ],
          "text": {
            "en": "US programmes: 14M01 (seals, clutch and calibration, 7 years or 100,000 miles), 14M02 (control module, 10 years or 150,000 miles) and 19N08 (clutch, 7 years or 100,000 miles). The court settlement added buyback arbitration, cash for three or more repair visits and clutch reimbursement. None is known for European-market cars.",
            "pt": "Programas dos EUA: 14M01 (vedações, embraiagem e calibração, 7 anos ou 100 000 milhas), 14M02 (módulo de controlo, 10 anos ou 150 000 milhas) e 19N08 (embraiagem, 7 anos ou 100 000 milhas). O acordo judicial acrescentou arbitragem de recompra, dinheiro para três ou mais visitas de reparação e reembolso da embraiagem. Nenhum é conhecido para carros do mercado europeu.",
            "ru": "Программы США: 14M01 (сальники, сцепление и калибровка, 7 лет или 100 000 миль), 14M02 (блок управления, 10 лет или 150 000 миль) и 19N08 (сцепление, 7 лет или 100 000 миль). Судебное соглашение добавило арбитраж о выкупе, денежную выплату за три и более визитов на ремонт и возмещение расходов на сцепление. Для машин европейского рынка ничего не известно.",
            "uk": "Програми США: 14M01 (сальники, зчеплення та калібрування, 7 років або 100 000 миль), 14M02 (блок керування, 10 років або 150 000 миль) і 19N08 (зчеплення, 7 років або 100 000 миль). Судова угода додала арбітраж щодо викупу, грошову виплату за три й більше візитів на ремонт і відшкодування витрат на зчеплення. Для машин європейського ринку нічого не відомо.",
            "fr": "Programmes américains : 14M01 (joints, embrayage et calibration, 7 ans ou 100 000 miles), 14M02 (module de commande, 10 ans ou 150 000 miles) et 19N08 (embrayage, 7 ans ou 100 000 miles). L'accord judiciaire a ajouté un arbitrage de rachat, une indemnité à partir de trois visites de réparation et le remboursement de l'embrayage. Aucun n'est connu pour les voitures du marché européen."
          }
        }
      },
      "evidence": [
        "ev_pf_p01",
        "ev_pf_p02",
        "ev_pf_p03",
        "ev_pf_p04",
        "ev_pf_p05"
      ],
      "prevalence": [
        "pv_pf_ps_none"
      ]
    },
    {
      "id": "cvt.xtronic",
      "aliases": [],
      "status": "published",
      "replacedBy": null,
      "revision": 1,
      "updatedAt": "2026-10-13",
      "legacyRule": "renault-nissan-1-5-dci-known-issues",
      "title": {
        "en": "Nissan Juke (F15) with Xtronic CVT (Jatco JF016E / RE0F10D): Nissan has extended the CVT warranty and issued a service bulletin for judder and transmission codes (US market)",
        "pt": "Nissan Juke (F15) com CVT Xtronic (Jatco JF016E / RE0F10D): a Nissan alargou a garantia da CVT e emitiu um boletim de serviço para vibração e códigos da transmissão (mercado dos EUA)",
        "ru": "Nissan Juke (F15) с вариатором Xtronic (Jatco JF016E / RE0F10D): Nissan продлила гарантию на вариатор и выпустила сервисный бюллетень по вибрации и кодам трансмиссии (рынок США)",
        "uk": "Nissan Juke (F15) із варіатором Xtronic (Jatco JF016E / RE0F10D): Nissan подовжила гарантію на варіатор і випустила сервісний бюлетень щодо вібрації та кодів трансмісії (ринок США)",
        "fr": "Nissan Juke (F15) avec CVT Xtronic (Jatco JF016E / RE0F10D) : Nissan a prolongé la garantie de la CVT et publié un bulletin de service pour broutement et codes de transmission (marché américain)"
      },
      "summary": {
        "en": "For the US market, Nissan extended the CVT warranty of the 2013-2017 Juke (F15) to 84 months / 84,000 miles in May 2020 and in December 2020 issued bulletin NTB20-091 / AT20-007 for the 2015-2017 Juke with the RE0F10D transmission when codes such as P0776, P2813, P0841 or P17F0 are stored. The repair is a control valve and, if the belt slips, a sub-assembly. No European recall or warranty extension was found, and the US extension does not apply to EU cars.",
        "pt": "Para o mercado dos EUA, a Nissan alargou em maio de 2020 a garantia da CVT do Juke (F15) 2013-2017 para 84 meses / 84 000 milhas e, em dezembro de 2020, emitiu o boletim NTB20-091 / AT20-007 para o Juke 2015-2017 com a transmissão RE0F10D quando estão memorizados códigos como P0776, P2813, P0841 ou P17F0. A reparação é uma válvula de comando e, se a correia deslizar, um subconjunto. Não foi encontrada nenhuma chamada nem extensão de garantia europeia, e a extensão dos EUA não se aplica a automóveis da UE.",
        "ru": "Для рынка США Nissan в мае 2020 года продлила гарантию на вариатор Juke (F15) 2013-2017 годов до 84 месяцев / 84 000 миль, а в декабре 2020 года выпустила бюллетень NTB20-091 / AT20-007 для Juke 2015-2017 с трансмиссией RE0F10D при сохранённых кодах вроде P0776, P2813, P0841 или P17F0. Ремонт: клапан управления и, при проскальзывании ремня, подузел. Европейского отзыва или продления гарантии не найдено, а американское продление на машины ЕС не распространяется.",
        "uk": "Для ринку США Nissan у травні 2020 року подовжила гарантію на варіатор Juke (F15) 2013-2017 років до 84 місяців / 84 000 миль, а в грудні 2020 року випустила бюлетень NTB20-091 / AT20-007 для Juke 2015-2017 із трансмісією RE0F10D за збережених кодів на кшталт P0776, P2813, P0841 або P17F0. Ремонт: клапан керування та, за проковзування паса, підвузол. Європейського відкликання чи подовження гарантії не знайдено, а американське подовження на машини ЄС не поширюється.",
        "fr": "Pour le marché américain, Nissan a prolongé en mai 2020 la garantie de la CVT du Juke (F15) 2013-2017 à 84 mois / 84 000 miles et, en décembre 2020, publié le bulletin NTB20-091 / AT20-007 pour le Juke 2015-2017 avec la transmission RE0F10D lorsque des codes comme P0776, P2813, P0841 ou P17F0 sont mémorisés. La réparation : une valve de commande et, si la courroie patine, un sous-ensemble. Aucun rappel ni prolongation de garantie européens n'ont été trouvés, et la prolongation américaine ne s'applique pas aux voitures de l'UE."
      },
      "checklistPrompt": {
        "en": "Juke with Xtronic CVT: check fluid history, judder under light throttle and stored CVT codes; the US warranty extension does not apply to EU cars",
        "pt": "Juke com CVT Xtronic: verificar o histórico do óleo, vibração com acelerador leve e códigos CVT memorizados; a extensão de garantia dos EUA não se aplica a automóveis da UE",
        "ru": "Juke с вариатором Xtronic: проверить историю замены масла, вибрацию при лёгком газе и сохранённые коды вариатора; американское продление гарантии на машины ЕС не распространяется",
        "uk": "Juke з варіатором Xtronic: перевірити історію заміни оливи, вібрацію при легкому газі та збережені коди варіатора; американське подовження гарантії на машини ЄС не поширюється",
        "fr": "Juke avec CVT Xtronic : vérifier l'historique de l'huile, le broutement à faible charge et les codes CVT mémorisés ; la prolongation de garantie américaine ne s'applique pas aux voitures de l'UE"
      },
      "component": "transmission.cvt",
      "mechanism": {
        "en": "Nissan's bulletin for the RE0F10D describes stored codes (P0776, P2813, P0841, P17F0, P17F1, P1715) and a repair flow that checks for push-belt slippage and replaces the control valve, with a sub-assembly replacement where the belt slips and TCM reprogramming where needed. The root cause is not stated in the documents used here. The 2020 warranty extension covers the CVT assembly, valve body, torque converter and cooler kit.",
        "pt": "O boletim da Nissan para a RE0F10D descreve códigos memorizados (P0776, P2813, P0841, P17F0, P17F1, P1715) e um fluxo de reparação que verifica o deslizamento da correia e substitui a válvula de comando, com substituição do subconjunto se a correia deslizar e reprogramação da TCM quando necessário. A causa de raiz não é indicada nos documentos usados. A extensão de garantia de 2020 cobre o conjunto CVT, o bloco de válvulas, o conversor de binário e o kit do radiador.",
        "ru": "Бюллетень Nissan по RE0F10D описывает сохраняемые коды (P0776, P2813, P0841, P17F0, P17F1, P1715) и порядок ремонта: проверка проскальзывания ремня, замена клапана управления, при проскальзывании ремня — замена подузла, при необходимости — перепрограммирование TCM. Первопричина в использованных документах не названа. Продление гарантии 2020 года покрывает узел вариатора, гидроблок, гидротрансформатор и комплект охладителя.",
        "uk": "Бюлетень Nissan щодо RE0F10D описує коди, що зберігаються (P0776, P2813, P0841, P17F0, P17F1, P1715), і порядок ремонту: перевірка проковзування паса, заміна клапана керування, за проковзування паса — заміна підвузла, за потреби — перепрограмування TCM. Першопричину у використаних документах не названо. Подовження гарантії 2020 року покриває вузол варіатора, гідроблок, гідротрансформатор і комплект охолоджувача.",
        "fr": "Le bulletin de Nissan pour la RE0F10D décrit des codes mémorisés (P0776, P2813, P0841, P17F0, P17F1, P1715) et une procédure qui vérifie le patinage de la courroie poussée et remplace la valve de commande, avec remplacement du sous-ensemble si la courroie patine et reprogrammation du TCM si nécessaire. La cause racine n'est pas indiquée dans les documents utilisés. La prolongation de garantie de 2020 couvre l'ensemble CVT, le bloc hydraulique, le convertisseur de couple et le kit de refroidisseur."
      },
      "applicability": {
        "models": [
          "nissan.juke"
        ],
        "when": {
          "all": [
            {
              "gearbox": {
                "type": [
                  "cvt"
                ]
              }
            },
            {
              "productionDate": {
                "from": "2010-01"
              }
            }
          ]
        },
        "markets": [
          "US"
        ],
        "hint": {
          "en": "Only the Nissan Juke (F15) with the Xtronic CVT. The documented programmes are US-only: the warranty extension covers the 2013-2017 model years and bulletin NTB20-091 the 2015-2017 Juke with the RE0F10D (not NISMO RS). The US warranty extension does not apply to EU cars, and no European recall or extension was found. Manual-gearbox Jukes and the 1.5 dCi (manual only) are not concerned. The JF017E chain CVT is not fitted to the Juke.",
          "pt": "Apenas o Nissan Juke (F15) com CVT Xtronic. Os programas documentados são só dos EUA: a extensão de garantia cobre os anos-modelo 2013-2017 e o boletim NTB20-091 o Juke 2015-2017 com a RE0F10D (exceto NISMO RS). A extensão de garantia dos EUA não se aplica a automóveis da UE e não foi encontrada nenhuma chamada nem extensão europeia. Os Juke de caixa manual e o 1.5 dCi (só manual) não são abrangidos. A CVT de corrente JF017E não equipa o Juke.",
          "ru": "Только Nissan Juke (F15) с вариатором Xtronic. Задокументированные программы действуют только в США: продление гарантии охватывает 2013-2017 модельные годы, бюллетень NTB20-091 — Juke 2015-2017 с RE0F10D (кроме NISMO RS). Американское продление гарантии на машины ЕС не распространяется, европейского отзыва или продления не найдено. Juke с механикой и 1.5 dCi (только механика) не затронуты. Цепной вариатор JF017E на Juke не ставился.",
          "uk": "Лише Nissan Juke (F15) із варіатором Xtronic. Задокументовані програми діють лише в США: подовження гарантії охоплює 2013-2017 модельні роки, бюлетень NTB20-091 — Juke 2015-2017 з RE0F10D (крім NISMO RS). Американське подовження гарантії на машини ЄС не поширюється, європейського відкликання чи подовження не знайдено. Juke з механікою та 1.5 dCi (лише механіка) не зачеплені. Ланцюговий варіатор JF017E на Juke не встановлювався.",
          "fr": "Uniquement le Nissan Juke (F15) avec CVT Xtronic. Les programmes documentés ne valent qu'aux États-Unis : la prolongation de garantie couvre les millésimes 2013-2017 et le bulletin NTB20-091 le Juke 2015-2017 avec la RE0F10D (hors NISMO RS). La prolongation de garantie américaine ne s'applique pas aux voitures de l'UE et aucun rappel ni prolongation européens n'ont été trouvés. Les Juke à boîte manuelle et le 1.5 dCi (manuel uniquement) ne sont pas concernés. La CVT à chaîne JF017E n'équipe pas le Juke."
        }
      },
      "severity": "major",
      "safety": false,
      "critical": false,
      "symptoms": [
        {
          "id": "s1",
          "stage": "early",
          "text": {
            "en": "Judder or shudder when pulling away or under light throttle",
            "pt": "Vibração ao arrancar ou com acelerador leve",
            "ru": "Вибрация при трогании или при лёгком газе",
            "uk": "Вібрація при рушанні або при легкому газі",
            "fr": "Broutement au démarrage ou à faible charge"
          }
        },
        {
          "id": "s2",
          "stage": "late",
          "text": {
            "en": "Stored CVT codes such as P0776, P2813, P0841, P17F0 or P1715",
            "pt": "Códigos CVT memorizados como P0776, P2813, P0841, P17F0 ou P1715",
            "ru": "Сохранённые коды вариатора, например P0776, P2813, P0841, P17F0 или P1715",
            "uk": "Збережені коди варіатора, наприклад P0776, P2813, P0841, P17F0 або P1715",
            "fr": "Codes CVT mémorisés comme P0776, P2813, P0841, P17F0 ou P1715"
          }
        }
      ],
      "inspection": [
        {
          "id": "i1",
          "method": "document",
          "tools": [],
          "text": {
            "en": "Confirm the car has the Xtronic CVT and check the service history for CVT fluid changes and any transmission work.",
            "pt": "Confirme que o automóvel tem a CVT Xtronic e verifique o histórico de serviço quanto a mudanças do óleo da CVT e intervenções na transmissão.",
            "ru": "Убедитесь, что на машине вариатор Xtronic, и проверьте сервисную историю: замены масла вариатора и любые работы с трансмиссией.",
            "uk": "Переконайтеся, що на машині варіатор Xtronic, і перевірте сервісну історію: заміни оливи варіатора та будь-які роботи з трансмісією.",
            "fr": "Confirmez que la voiture a la CVT Xtronic et vérifiez l'historique d'entretien : vidanges d'huile CVT et interventions sur la transmission."
          },
          "redFlag": {
            "en": "No record of CVT fluid changes or of transmission repairs.",
            "pt": "Sem registo de mudanças do óleo da CVT ou de reparações da transmissão.",
            "ru": "Нет записей о замене масла вариатора или ремонте трансмиссии.",
            "uk": "Немає записів про заміну оливи варіатора чи ремонт трансмісії.",
            "fr": "Aucune trace de vidange CVT ni de réparations de la transmission."
          }
        },
        {
          "id": "i2",
          "method": "obd",
          "tools": [
            "obd2 scanner"
          ],
          "text": {
            "en": "Read stored and pending codes from the transmission control unit, looking for P0776, P2813, P0841, P17F0, P17F1 and P1715.",
            "pt": "Leia os códigos memorizados e pendentes da unidade de comando da transmissão, procurando P0776, P2813, P0841, P17F0, P17F1 e P1715.",
            "ru": "Считайте сохранённые и ожидающие коды блока управления трансмиссией, ищите P0776, P2813, P0841, P17F0, P17F1 и P1715.",
            "uk": "Зчитайте збережені та очікувані коди блока керування трансмісією, шукайте P0776, P2813, P0841, P17F0, P17F1 і P1715.",
            "fr": "Lisez les codes mémorisés et en attente du calculateur de transmission, en cherchant P0776, P2813, P0841, P17F0, P17F1 et P1715."
          },
          "redFlag": {
            "en": "Any of these codes stored.",
            "pt": "Qualquer um destes códigos memorizado.",
            "ru": "Любой из этих кодов сохранён.",
            "uk": "Будь-який із цих кодів збережено.",
            "fr": "Un de ces codes est mémorisé."
          }
        },
        {
          "id": "i3",
          "method": "test_drive",
          "tools": [],
          "text": {
            "en": "Test drive from standstill and at light throttle, warm and cold, and watch for judder or hesitation.",
            "pt": "Faça uma prova de condução desde parado e com acelerador leve, a quente e a frio, e atente a vibração ou hesitação.",
            "ru": "Проедьте с места и на лёгком газе, на горячую и на холодную, следите за вибрацией и задержками.",
            "uk": "Проїдьтеся з місця та на легкому газі, на гарячу й на холодну, стежте за вібрацією та затримками.",
            "fr": "Faites un essai au démarrage et à faible charge, à chaud et à froid, et surveillez broutement ou hésitation."
          },
          "redFlag": {
            "en": "Judder or hesitation.",
            "pt": "Vibração ou hesitação.",
            "ru": "Вибрация или задержки.",
            "uk": "Вібрація або затримки.",
            "fr": "Broutement ou hésitation."
          }
        }
      ],
      "repair": {
        "remedy": {
          "en": "Replacement of the control valve; if the push belt slips, replacement of the sub-assembly as well; TCM reprogramming where needed (Nissan bulletin NTB20-091).",
          "pt": "Substituição da válvula de comando; se a correia deslizar, substituição também do subconjunto; reprogramação da TCM quando necessário (boletim Nissan NTB20-091).",
          "ru": "Замена клапана управления; при проскальзывании ремня — также замена подузла; при необходимости перепрограммирование TCM (бюллетень Nissan NTB20-091).",
          "uk": "Заміна клапана керування; за проковзування паса — також заміна підвузла; за потреби перепрограмування TCM (бюлетень Nissan NTB20-091).",
          "fr": "Remplacement de la valve de commande ; si la courroie patine, remplacement aussi du sous-ensemble ; reprogrammation du TCM si nécessaire (bulletin Nissan NTB20-091)."
        },
        "cost": null,
        "worstCase": null,
        "manufacturerProgramme": {
          "evidence": [
            "ev_cv_e01",
            "ev_cv_e02"
          ],
          "text": {
            "en": "US-market programme only: the CVT warranty is extended to 84 months / 84,000 miles for the 2013-2017 Juke. It does not apply to EU cars, and no European programme was found.",
            "pt": "Apenas programa do mercado dos EUA: a garantia da CVT é alargada para 84 meses / 84 000 milhas para o Juke 2013-2017. Não se aplica a automóveis da UE e não foi encontrado nenhum programa europeu.",
            "ru": "Только программа рынка США: гарантия на вариатор продлена до 84 месяцев / 84 000 миль для Juke 2013-2017. На машины ЕС она не распространяется, европейской программы не найдено.",
            "uk": "Лише програма ринку США: гарантію на варіатор подовжено до 84 місяців / 84 000 миль для Juke 2013-2017. На машини ЄС вона не поширюється, європейської програми не знайдено.",
            "fr": "Programme du marché américain uniquement : la garantie de la CVT est prolongée à 84 mois / 84 000 miles pour le Juke 2013-2017. Elle ne s'applique pas aux voitures de l'UE et aucun programme européen n'a été trouvé."
          }
        }
      },
      "evidence": [
        "ev_cv_e01",
        "ev_cv_e02",
        "ev_cv_e06",
        "ev_cv_e07",
        "ev_cv_e08"
      ],
      "prevalence": [
        "pv_cv_none"
      ]
    },
    {
      "id": "rust.arches",
      "aliases": [],
      "status": "deprecated",
      "replacedBy": null,
      "revision": 1,
      "updatedAt": "2026-10-13",
      "legacyRule": "bmw-known-issues",
      "reason": {
        "en": "Unverifiable and fails the publication threshold (4.6): no manufacturer, regulator or court document and no usable specialist source on E90 rear wheel arch rust was found; only owner-forum anecdotes exist, which are tier 3 and can never be the sole basis.",
        "pt": "Não verificável e abaixo do limiar de publicação (4.6): não foi encontrado nenhum documento do fabricante, de um regulador ou de um tribunal, nem nenhuma fonte especializada utilizável sobre ferrugem nas cavas das rodas traseiras do E90; só existem relatos de fóruns de proprietários, que são de nível 3 e nunca podem ser a única base.",
        "ru": "Не проверяется и не проходит порог публикации (4.6): не найдено ни документов производителя, регулятора или суда, ни пригодного профильного источника о коррозии задних арок E90; есть только рассказы с форумов владельцев, это уровень 3, и он никогда не может быть единственным основанием.",
        "uk": "Не перевіряється і не проходить поріг публікації (4.6): не знайдено ні документів виробника, регулятора чи суду, ні придатного профільного джерела про корозію задніх арок E90; є лише розповіді з форумів власників, це рівень 3, і він ніколи не може бути єдиною підставою.",
        "fr": "Invérifiable et sous le seuil de publication (4.6) : aucun document de constructeur, de régulateur ou de tribunal ni aucune source spécialisée exploitable sur la corrosion des passages de roue arrière de l'E90 n'a été trouvé ; seuls existent des témoignages de forums de propriétaires, de niveau 3, qui ne peuvent jamais être la seule base."
      }
    },
    {
      "id": "ep6.chain",
      "aliases": [],
      "status": "deprecated",
      "replacedBy": null,
      "revision": 1,
      "updatedAt": "2026-10-13",
      "legacyRule": "psa-known-issues",
      "reason": {
        "en": "Insufficient independent sources. Only one specialist-press source (L'argus, 10 March 2014) names the PSA 1.6 THP (EP6) timing chain, with a tensioner non-conformity and PSA goodwill cover for cars built to 30 September 2010; the 2026 AutoCopilot page is secondary and cites no PSA document, and the MINI N14 notice MC-10147061 could not be opened (404). The carbon build-up sub-claim has no source and was dropped.",
        "pt": "Fontes independentes insuficientes. Só uma fonte da imprensa especializada (L'argus, 10 de março de 2014) refere a corrente de distribuição do PSA 1.6 THP (EP6), com uma não conformidade do tensor e cobertura comercial da PSA para automóveis fabricados até 30 de setembro de 2010; a página da AutoCopilot de 2026 é secundária e não cita nenhum documento da PSA, e o aviso MINI N14 MC-10147061 não pôde ser aberto (404). A alegação secundária sobre depósitos de carbono não tem fonte e foi retirada.",
        "ru": "Недостаточно независимых источников. Цепь ГРМ PSA 1.6 THP (EP6) называет только один источник профильной прессы (L'argus, 10 марта 2014): несоответствие натяжителя и участие PSA в ремонте для машин, выпущенных до 30 сентября 2010 года; страница AutoCopilot 2026 года вторична и не ссылается на документы PSA, а бюллетень MINI N14 MC-10147061 открыть не удалось (404). Побочное утверждение о нагаре не имеет источника и снято.",
        "uk": "Недостатньо незалежних джерел. Ланцюг ГРМ PSA 1.6 THP (EP6) називає лише одне джерело профільної преси (L'argus, 10 березня 2014): невідповідність натягувача та участь PSA у ремонті для машин, випущених до 30 вересня 2010 року; сторінка AutoCopilot 2026 року вторинна і не посилається на документи PSA, а бюлетень MINI N14 MC-10147061 відкрити не вдалося (404). Побічне твердження про нагар не має джерела і зняте.",
        "fr": "Sources indépendantes insuffisantes. Une seule source de presse spécialisée (L'argus, 10 mars 2014) cite la chaîne de distribution du PSA 1.6 THP (EP6), avec une non-conformité du tendeur et une prise en charge commerciale de PSA pour les voitures produites jusqu'au 30 septembre 2010 ; la page AutoCopilot de 2026 est secondaire et ne cite aucun document PSA, et la note MINI N14 MC-10147061 n'a pas pu être ouverte (404). L'allégation secondaire sur l'encrassement (calamine) n'a pas de source et a été retirée."
      }
    },
    {
      "id": "hdi.turbo",
      "aliases": [],
      "status": "deprecated",
      "replacedBy": null,
      "revision": 1,
      "updatedAt": "2026-10-13",
      "legacyRule": "psa-known-issues",
      "reason": {
        "en": "Insufficient independent sources. The legacy item bundles turbo oil feed, EGR and DPF. A RappelConso search for turbo, HDi and DV6 on Peugeot and Citroen returned no records; the only technical source is an aftermarket turbo maker bulletin (Nissens) that blames external factors, plus forums.",
        "pt": "Fontes independentes insuficientes. O item antigo junta a alimentação de óleo do turbo, a EGR e o FAP. Uma pesquisa no RappelConso por turbo, HDi e DV6 em Peugeot e Citroën não devolveu registos; a única fonte técnica é um boletim de um fabricante de turbos de pós-venda (Nissens), que atribui a culpa a fatores externos, além de fóruns.",
        "ru": "Недостаточно независимых источников. Прежний пункт объединяет подачу масла к турбине, EGR и сажевый фильтр. Поиск в RappelConso по запросам turbo, HDi и DV6 для Peugeot и Citroën записей не дал; единственный технический источник — бюллетень производителя турбин для вторичного рынка (Nissens), который винит внешние факторы, плюс форумы.",
        "uk": "Недостатньо незалежних джерел. Попередній пункт об'єднує подачу оливи до турбіни, EGR і сажовий фільтр. Пошук у RappelConso за запитами turbo, HDi і DV6 для Peugeot і Citroën записів не дав; єдине технічне джерело — бюлетень виробника турбін для вторинного ринку (Nissens), який звинувачує зовнішні чинники, плюс форуми.",
        "fr": "Sources indépendantes insuffisantes. L'ancien point regroupe la lubrification du turbo, l'EGR et le FAP. Une recherche RappelConso sur turbo, HDi et DV6 pour Peugeot et Citroën n'a donné aucune fiche ; la seule source technique est un bulletin d'un fabricant de turbos de rechange (Nissens) qui met en cause des facteurs externes, plus des forums."
      }
    },
    {
      "id": "dci.injectors",
      "aliases": [],
      "status": "deprecated",
      "replacedBy": null,
      "revision": 1,
      "updatedAt": "2026-10-13",
      "legacyRule": "renault-nissan-1-5-dci-known-issues",
      "reason": {
        "en": "Unverifiable and fails the publication threshold: no recall, service bulletin or warranty extension names K9K injector wear or DPF/EGR clogging. The only tier-1 K9K records found are RappelConso A12/01096/20 (K9K Gen8, Kadjar and Megane IV, catalytic converter and NOx) and a 2016-2017 Captur/Kadjar/Juke 1.5 dCi 110 NOx-trap and DPF replacement campaign known only from L'argus (2017). Everything on injectors comes from garage and parts-seller blogs and forums. A narrower entry on the K9K Euro 6 NOx-trap calibration is possible later but needs the original Renault or RappelConso record.",
        "pt": "Não verificável e abaixo do limiar de publicação: nenhuma chamada, boletim de serviço ou extensão de garantia refere desgaste dos injetores K9K ou entupimento do FAP/EGR. Os únicos registos de nível 1 encontrados sobre o K9K são o RappelConso A12/01096/20 (K9K Gen8, Kadjar e Megane IV, catalisador e NOx) e uma campanha de 2016-2017 de substituição do catalisador de NOx e do FAP nos Captur/Kadjar/Juke 1.5 dCi 110, conhecida apenas pelo L'argus (2017). Tudo o que existe sobre injetores vem de blogues de oficinas e vendedores de peças e de fóruns. Uma entrada mais restrita sobre a calibração do catalisador de NOx do K9K Euro 6 é possível no futuro, mas exige o registo original da Renault ou do RappelConso.",
        "ru": "Не проверяется и не проходит порог публикации: ни один отзыв, сервисный бюллетень или продление гарантии не называет износ форсунок K9K или забивание сажевого фильтра/EGR. Единственные найденные записи уровня 1 по K9K — RappelConso A12/01096/20 (K9K Gen8, Kadjar и Megane IV, катализатор и NOx) и кампания 2016-2017 годов по замене NOx-накопителя и сажевого фильтра на Captur/Kadjar/Juke 1.5 dCi 110, известная только по L'argus (2017). Всё о форсунках взято из блогов автосервисов и продавцов запчастей и с форумов. Более узкая запись о калибровке NOx-накопителя K9K Euro 6 возможна позже, но для неё нужен исходный документ Renault или RappelConso.",
        "uk": "Не перевіряється і не проходить поріг публікації: жодне відкликання, сервісний бюлетень чи продовження гарантії не називає знос форсунок K9K або забивання сажового фільтра/EGR. Єдині знайдені записи рівня 1 щодо K9K — RappelConso A12/01096/20 (K9K Gen8, Kadjar і Megane IV, каталізатор і NOx) та кампанія 2016-2017 років із заміни NOx-накопичувача і сажового фільтра на Captur/Kadjar/Juke 1.5 dCi 110, відома лише з L'argus (2017). Усе про форсунки взято з блогів автосервісів і продавців запчастин та з форумів. Вужчий запис про калібрування NOx-накопичувача K9K Euro 6 можливий пізніше, але для нього потрібен первинний документ Renault або RappelConso.",
        "fr": "Invérifiable et sous le seuil de publication : aucun rappel, bulletin technique ou extension de garantie ne cite l'usure des injecteurs K9K ou le colmatage du FAP/EGR. Les seules fiches de niveau 1 trouvées sur le K9K sont RappelConso A12/01096/20 (K9K Gen8, Kadjar et Mégane IV, catalyseur et NOx) et une campagne 2016-2017 de remplacement du piège à NOx et du FAP sur Captur/Kadjar/Juke 1.5 dCi 110, connue seulement par L'argus (2017). Tout ce qui concerne les injecteurs vient de blogs de garages et de vendeurs de pièces et de forums. Une fiche plus étroite sur la calibration du piège à NOx du K9K Euro 6 est possible plus tard, mais elle exige la fiche d'origine de Renault ou de RappelConso."
      }
    },
    {
      "id": "electrics",
      "aliases": [],
      "status": "deprecated",
      "replacedBy": null,
      "revision": 1,
      "updatedAt": "2026-10-13",
      "legacyRule": "renault-nissan-1-5-dci-known-issues",
      "reason": {
        "en": "Too vague to meet the publication threshold: it names no component, model range or build dates and no sourced scope was found. A narrowly scoped, sourced entry can be added later as a new id.",
        "pt": "Demasiado vago para cumprir o limiar de publicação: não indica nenhum componente, gama de modelos nem datas de fabrico, e não foi encontrado nenhum âmbito com fonte. Uma entrada restrita e com fontes pode ser acrescentada mais tarde com um novo id.",
        "ru": "Слишком расплывчато для порога публикации: не названы ни узел, ни модельный ряд, ни годы выпуска, и подтверждённого источниками охвата не найдено. Узкая запись с источниками может быть добавлена позже под новым id.",
        "uk": "Надто розмито для порогу публікації: не названо ні вузол, ні модельний ряд, ні роки випуску, і підтвердженого джерелами охоплення не знайдено. Вузький запис із джерелами можна додати пізніше під новим id.",
        "fr": "Trop vague pour atteindre le seuil de publication : aucun organe, aucune gamme de modèles ni aucune période de production n'est nommé et aucun périmètre sourcé n'a été trouvé. Une fiche étroite et sourcée pourra être ajoutée plus tard sous un nouvel id."
      }
    },
    {
      "id": "opel.chain",
      "aliases": [],
      "status": "deprecated",
      "replacedBy": null,
      "revision": 1,
      "updatedAt": "2026-10-13",
      "legacyRule": "opel-known-issues",
      "reason": {
        "en": "Unverifiable and fails the publication threshold: no recall, service bulletin or manufacturer statement for A14NET / B14NET timing chain wear was found; sources are parts shops and forums, some saying the chain is fine. RappelConso holds only the DV5R chain recall (PSA 1.5 diesel), a different engine.",
        "pt": "Não verificável e abaixo do limiar de publicação: não foi encontrada nenhuma chamada, boletim de serviço ou declaração do fabricante sobre desgaste da corrente de distribuição A14NET / B14NET; as fontes são lojas de peças e fóruns, alguns dos quais dizem que a corrente não tem problemas. O RappelConso só tem a chamada da corrente do DV5R (PSA 1.5 diesel), um motor diferente.",
        "ru": "Не проверяется и не проходит порог публикации: отзывов, сервисных бюллетеней или заявлений производителя об износе цепи ГРМ A14NET / B14NET не найдено; источники — магазины запчастей и форумы, причём часть из них считает цепь беспроблемной. В RappelConso есть только отзыв по цепи DV5R (дизель PSA 1.5), это другой двигатель.",
        "uk": "Не перевіряється і не проходить поріг публікації: відкликань, сервісних бюлетенів чи заяв виробника про знос ланцюга ГРМ A14NET / B14NET не знайдено; джерела — магазини запчастин і форуми, причому частина з них вважає ланцюг безпроблемним. У RappelConso є лише відкликання щодо ланцюга DV5R (дизель PSA 1.5), це інший двигун.",
        "fr": "Invérifiable et sous le seuil de publication : aucun rappel, bulletin technique ni déclaration du constructeur sur l'usure de la chaîne de distribution A14NET / B14NET n'a été trouvé ; les sources sont des vendeurs de pièces et des forums, dont certains jugent la chaîne sans problème. RappelConso ne contient que le rappel de la chaîne du DV5R (diesel PSA 1.5), un autre moteur."
      }
    },
    {
      "id": "opel.waterpump",
      "aliases": [],
      "status": "deprecated",
      "replacedBy": null,
      "revision": 1,
      "updatedAt": "2026-10-13",
      "legacyRule": "opel-known-issues",
      "reason": {
        "en": "Unverifiable and fails the publication threshold: no recall, service bulletin or manufacturer statement was found (RappelConso and NHTSA, including Buick Encore, Cruze, Sonic and Trax, searched); only workshop blogs and forums.",
        "pt": "Não verificável e abaixo do limiar de publicação: não foi encontrada nenhuma chamada, boletim de serviço ou declaração do fabricante (pesquisados o RappelConso e a NHTSA, incluindo Buick Encore, Cruze, Sonic e Trax); só blogues de oficinas e fóruns.",
        "ru": "Не проверяется и не проходит порог публикации: отзывов, сервисных бюллетеней или заявлений производителя не найдено (проверены RappelConso и NHTSA, включая Buick Encore, Cruze, Sonic и Trax); есть только блоги автосервисов и форумы.",
        "uk": "Не перевіряється і не проходить поріг публікації: відкликань, сервісних бюлетенів чи заяв виробника не знайдено (перевірено RappelConso і NHTSA, зокрема Buick Encore, Cruze, Sonic і Trax); є лише блоги автосервісів і форуми.",
        "fr": "Invérifiable et sous le seuil de publication : aucun rappel, bulletin technique ni déclaration du constructeur n'a été trouvé (recherches dans RappelConso et à la NHTSA, y compris Buick Encore, Cruze, Sonic et Trax) ; seulement des blogs de garages et des forums."
      }
    },
    {
      "id": "m271.balanceshaft",
      "aliases": [],
      "status": "deprecated",
      "replacedBy": "m271.timingchain",
      "revision": 1,
      "updatedAt": "2026-10-13",
      "legacyRule": "mercedes-known-issues",
      "reason": {
        "en": "Renamed to m271.timingchain: the sources describe wear of the M271 timing chain, tensioner and camshaft adjusters, and none of them mentions a balance shaft. The old id stays as an alias of the new entry, so answers stored under it still resolve.",
        "pt": "Renomeado para m271.timingchain: as fontes descrevem o desgaste da corrente de distribuição, do tensor e dos variadores da árvore de cames do M271, e nenhuma refere um veio de equilíbrio. O id antigo fica como alias da nova entrada, pelo que as respostas guardadas com ele continuam a ser resolvidas.",
        "ru": "Переименовано в m271.timingchain: источники описывают износ цепи ГРМ, натяжителя и фазовращателей M271, и ни один не упоминает балансирный вал. Старый id остаётся псевдонимом новой записи, поэтому сохранённые под ним ответы по-прежнему находят её.",
        "uk": "Перейменовано на m271.timingchain: джерела описують знос ланцюга ГРМ, натягувача і фазообертачів M271, і жодне не згадує балансирний вал. Старий id лишається псевдонімом нового запису, тому збережені під ним відповіді й далі знаходять його.",
        "fr": "Renommé en m271.timingchain : les sources décrivent l'usure de la chaîne de distribution, du tendeur et des déphaseurs d'arbre à cames du M271, et aucune ne mentionne un arbre d'équilibrage. L'ancien id reste un alias de la nouvelle fiche, de sorte que les réponses enregistrées sous cet id la retrouvent toujours."
      }
    },
    {
      "id": "rust",
      "aliases": [],
      "status": "deprecated",
      "replacedBy": null,
      "revision": 1,
      "updatedAt": "2026-10-13",
      "legacyRule": "mercedes-known-issues",
      "reason": {
        "en": "Too vague to meet the publication threshold: 'older Mercedes models, arches and jacking points' names no model, generation or build dates and no sourced scope was found. A narrowly scoped, sourced entry (for example one model generation) can be added later as a new id.",
        "pt": "Demasiado vago para cumprir o limiar de publicação: «modelos Mercedes mais antigos, cavas das rodas e pontos de elevação» não indica nenhum modelo, geração nem datas de fabrico, e não foi encontrado nenhum âmbito com fonte. Uma entrada restrita e com fontes (por exemplo, uma geração de um modelo) pode ser acrescentada mais tarde com um novo id.",
        "ru": "Слишком расплывчато для порога публикации: «старые модели Mercedes, арки и места под домкрат» не называет ни модель, ни поколение, ни годы выпуска, и подтверждённого источниками охвата не найдено. Узкая запись с источниками (например, одно поколение модели) может быть добавлена позже под новым id.",
        "uk": "Надто розмито для порогу публікації: «старі моделі Mercedes, арки та місця під домкрат» не називає ні модель, ні покоління, ні роки випуску, і підтвердженого джерелами охоплення не знайдено. Вузький запис із джерелами (наприклад, одне покоління моделі) можна додати пізніше під новим id.",
        "fr": "Trop vague pour atteindre le seuil de publication : « anciens modèles Mercedes, passages de roue et points de levage » ne nomme aucun modèle, aucune génération ni aucune période de production et aucun périmètre sourcé n'a été trouvé. Une fiche étroite et sourcée (par exemple une génération de modèle) pourra être ajoutée plus tard sous un nouvel id."
      }
    },
    {
      "id": "multijet.dpf",
      "aliases": [],
      "status": "deprecated",
      "replacedBy": null,
      "revision": 1,
      "updatedAt": "2026-10-13",
      "legacyRule": "fiat-known-issues",
      "reason": {
        "en": "Unverifiable and fails the publication threshold: no recall, service bulletin or Fiat statement; sources are Italian workshop and parts sites and forums. The entry describes general DPF behaviour (short trips prevent regeneration), not an engine-specific defect.",
        "pt": "Não verificável e abaixo do limiar de publicação: nenhuma chamada, boletim de serviço ou declaração da Fiat; as fontes são sites italianos de oficinas e de peças e fóruns. A entrada descreve o comportamento geral de um FAP (os trajetos curtos impedem a regeneração), não um defeito específico do motor.",
        "ru": "Не проверяется и не проходит порог публикации: нет ни отзыва, ни сервисного бюллетеня, ни заявления Fiat; источники — итальянские сайты автосервисов и запчастей и форумы. Запись описывает общее поведение сажевого фильтра (короткие поездки мешают регенерации), а не дефект конкретного двигателя.",
        "uk": "Не перевіряється і не проходить поріг публікації: немає ні відкликання, ні сервісного бюлетеня, ні заяви Fiat; джерела — італійські сайти автосервісів і запчастин та форуми. Запис описує загальну поведінку сажового фільтра (короткі поїздки заважають регенерації), а не дефект конкретного двигуна.",
        "fr": "Invérifiable et sous le seuil de publication : aucun rappel, bulletin technique ni déclaration de Fiat ; les sources sont des sites italiens de garages et de pièces et des forums. La fiche décrit le comportement général d'un FAP (les trajets courts empêchent la régénération), pas un défaut propre au moteur."
      }
    },
    {
      "id": "twinair.oil",
      "aliases": [],
      "status": "deprecated",
      "replacedBy": null,
      "revision": 1,
      "updatedAt": "2026-10-13",
      "legacyRule": "fiat-known-issues",
      "reason": {
        "en": "Unverifiable and fails the publication threshold: no recall, service bulletin or tier-2 press; forums are split between heavy and negligible consumption. A generic Fiat 500 manual excerpt gives a normal maximum of 400 g per 1,000 km, which is a specification, not an acknowledged defect.",
        "pt": "Não verificável e abaixo do limiar de publicação: nenhuma chamada, boletim de serviço ou imprensa de nível 2; os fóruns dividem-se entre consumo elevado e desprezável. Um excerto genérico do manual do Fiat 500 indica um máximo normal de 400 g por 1 000 km, o que é uma especificação, não um defeito reconhecido.",
        "ru": "Не проверяется и не проходит порог публикации: нет ни отзыва, ни сервисного бюллетеня, ни прессы уровня 2; на форумах мнения делятся между большим и ничтожным расходом. Общий фрагмент руководства Fiat 500 указывает нормальный максимум 400 г на 1 000 км — это норма, а не признанный дефект.",
        "uk": "Не перевіряється і не проходить поріг публікації: немає ні відкликання, ні сервісного бюлетеня, ні преси рівня 2; на форумах думки діляться між великою і мізерною витратою. Загальний фрагмент посібника Fiat 500 вказує нормальний максимум 400 г на 1 000 км — це норма, а не визнаний дефект.",
        "fr": "Invérifiable et sous le seuil de publication : aucun rappel, bulletin technique ni presse de niveau 2 ; les forums sont partagés entre une consommation forte et négligeable. Un extrait générique du manuel de la Fiat 500 donne un maximum normal de 400 g pour 1 000 km, ce qui est une spécification, pas un défaut reconnu."
      }
    }
  ]
}
''';
