ProductTypeGenerator = require('../main').ProductTypeGenerator

describe 'ProductTypeGenerator', ->
  beforeEach ->
    @generator = new ProductTypeGenerator

  it 'should initialize', ->
    expect(@generator).toBeDefined()

  it 'should return languages for localized property header', ->
    expect(@generator._languages('label', ['name', 'label.de', 'label.en', 'enumlabel.de', 'enumlabel.en', 'enumlabel.it'])).toEqual ['de', 'en']

  it 'should return no languages for not localized property header', ->
    expect(@generator._languages('name', ['name', 'label.de', 'label.en', 'enumlabel.de', 'enumlabel.en', 'enumlabel.it'])).toEqual []

  it 'should return an object with localized values', ->

    attributeRow =
      name: 'gender'
      type: 'lenum'
      isVariant: 'false'
      isRequired: 'false'
      isSearchable: 'false'
      'label.de': 'Geschlecht'
      'label.en': 'gender'
      enumKey: 'M'
      'enumLabel.en': 'male'
      'enumLabel.de': 'männlich'

    expect(@generator._i18n(attributeRow, 'label')).toEqual {de: 'Geschlecht', en: 'gender'}

  it 'should return an object with no localized values', ->
    expect(@generator._i18n(['name', 'label.de', 'label.en', 'enumlabel.de', 'enumlabel.en', 'enumlabel.it'], 'name')).toEqual []

  it 'should return one attribute definition of type text', ->

    attributeRow =
      name: 'description'
      type: 'text'
      isVariant: 'false'
      isRequired: 'false'
      isSearchable: 'false'
      textInputHint: 'MultiLine'
      'label.de': 'Beschreibung'
      'label.en': 'Description'

    expectedAttributeDefinition =
      description:
        name: 'description'
        label:
          de: 'Beschreibung'
          en: 'Description'
        type: 'text'
        isVariant: 'false'
        isRequired: 'false'
        isSearchable: 'false'
        inputHint: 'MultiLine'

    expect(@generator._createAttributeDefinitions([attributeRow])).toEqual expectedAttributeDefinition

  it 'should return one attribute definition of type ltext', ->

    attributeRow =
      name: 'description'
      type: 'ltext'
      isVariant: 'false'
      isRequired: 'false'
      isSearchable: 'false'
      textInputHint: 'MultiLine'
      'label.de': 'Beschreibung'
      'label.en': 'Description'

    expectedAttributeDefinition =
      description:
        name: 'description'
        label:
          de: 'Beschreibung'
          en: 'Description'
        type: 'ltext'
        isVariant: 'false'
        isRequired: 'false'
        isSearchable: 'false'
        inputHint: 'MultiLine'

    expect(@generator._createAttributeDefinitions([attributeRow])).toEqual expectedAttributeDefinition

  it 'should return one attribute definition of type enum', ->

    attributeRow1 =
      name: 'brand'
      type: 'enum'
      isVariant: 'false'
      isRequired: 'false'
      isSearchable: 'false'
      'label.de': 'Marke'
      'label.en': 'Brand'
      enumKey: 'HUG'
      enumLabel: 'Hugo Boss'

    attributeRow2 =
      name: ''
      type: ''
      isVariant: ''
      isRequired: ''
      sSearchable: ''
      'label.de': ''
      'label.en': ''
      enumKey: 'DUG'
      'enumLabel': 'Dolce&Gabana'

    expectedAttributeDefinition =
      brand:
        name: 'brand'
        label:
          de: 'Marke'
          en: 'Brand'
        type: 'enum'
        isVariant: 'false'
        isRequired: 'false'
        isSearchable: 'false'
        values:  [{ key: 'HUG', label: 'Hugo Boss' }, { key: 'DUG', label: 'Dolce&Gabana' }]

    expect(@generator._createAttributeDefinitions([attributeRow1, attributeRow2])).toEqual expectedAttributeDefinition

  it 'should return one attribute definition of type lenum', ->

    attributeRow1 =
      name: 'gender'
      type: 'lenum'
      isVariant: 'false'
      isRequired: 'false'
      isSearchable: 'false'
      'label.de': 'Geschlecht'
      'label.en': 'gender'
      enumKey: 'M'
      'enumLabel.en': 'male'
      'enumLabel.de': 'männlich'

    attributeRow2 =
      name: ''
      type: ''
      isVariant: ''
      isRequired: ''
      sSearchable: ''
      'label.de': ''
      'label.en': ''
      enumKey: 'W'
      'enumLabel.en': 'female'
      'enumLabel.de': 'weiblich'

    attributeRow3 =
      name: ''
      type: ''
      isVariant: ''
      isRequired: ''
      isSearchable: ''
      'label.de': ''
      'label.en': ''
      enumKey: 'U'
      'enumLabel.en': 'unisex'
      'enumLabel.de': 'unisex'

    expectedAttributeDefinition =
      gender:
        name: 'gender'
        label:
          de: 'Geschlecht'
          en: 'gender'
        type: 'lenum'
        isVariant: 'false'
        isRequired: 'false'
        isSearchable: 'false'
        values:  [{ key: 'M', label: de: 'männlich', en: 'male' }, { key: 'W', label: de: 'weiblich', en: 'female' }, { key: 'U', label: de: 'unisex', en: 'unisex' }]

    expect(@generator._createAttributeDefinitions([attributeRow1, attributeRow2, attributeRow3])).toEqual expectedAttributeDefinition

  it 'should return one attribute definition of type number', ->

    attributeRow =
      name: 'size'
      type: 'number'
      isVariant: 'false'
      isRequired: 'false'
      isSearchable: 'false'
      'label.de': 'Größe'
      'label.en': 'Size'

    expectedAttributeDefinition =
      size:
        name: 'size'
        label:
          de: 'Größe'
          en: 'Size'
        type: 'number'
        isVariant: 'false'
        isRequired: 'false'
        isSearchable: 'false'

    expect(@generator._createAttributeDefinitions([attributeRow])).toEqual expectedAttributeDefinition

  it 'should return one attribute definition of type money', ->

    attributeRow =
      name: 'listPrice'
      type: 'money'
      isVariant: 'false'
      isRequired: 'false'
      isSearchable: 'false'
      'label.de': 'Listenpreis'
      'label.en': 'List price'

    expectedAttributeDefinition =
      listPrice:
        name: 'listPrice'
        label:
          de: 'Listenpreis'
          en: 'List price'
        type: 'money'
        isVariant: 'false'
        isRequired: 'false'
        isSearchable: 'false'

    expect(@generator._createAttributeDefinitions([attributeRow])).toEqual expectedAttributeDefinition


  it 'should return one attribute definition of type date', ->

    attributeRow =
      name: 'releaseDate'
      type: 'date'
      isVariant: 'false'
      isRequired: 'false'
      isSearchable: 'false'
      'label.de': 'Veröffentlichungsdatum'
      'label.en': 'Release date'

    expectedAttributeDefinition =
      releaseDate:
        name: 'releaseDate'
        label:
          de: 'Veröffentlichungsdatum'
          en: 'Release date'
        type: 'date'
        isVariant: 'false'
        isRequired: 'false'
        isSearchable: 'false'

    expect(@generator._createAttributeDefinitions([attributeRow])).toEqual expectedAttributeDefinition

  it 'should return one attribute definition of type time', ->

    attributeRow =
      name: 'releaseTime'
      type: 'time'
      isVariant: 'false'
      isRequired: 'false'
      isSearchable: 'false'
      'label.de': 'Veröffentlichungszeit'
      'label.en': 'Release time'

    expectedAttributeDefinition =
      releaseTime:
        name: 'releaseTime'
        label:
          de: 'Veröffentlichungszeit'
          en: 'Release time'
        type: 'time'
        isVariant: 'false'
        isRequired: 'false'
        isSearchable: 'false'

    expect(@generator._createAttributeDefinitions([attributeRow])).toEqual expectedAttributeDefinition

  it 'should return one attribute definition of type dateTime', ->

    attributeRow =
      name: 'creationDateTime'
      type: 'dateTime'
      isVariant: 'false'
      isRequired: 'false'
      isSearchable: 'false'
      'label.de': 'Herstellungszeit'
      'label.en': 'Creation time'

    expectedAttributeDefinition =
      creationDateTime:
        name: 'creationDateTime'
        label:
          de: 'Herstellungszeit'
          en: 'Creation time'
        type: 'dateTime'
        isVariant: 'false'
        isRequired: 'false'
        isSearchable: 'false'

    expect(@generator._createAttributeDefinitions([attributeRow])).toEqual expectedAttributeDefinition


  it 'should return an array with product type definitions', ->

    productTypeDefinition1 =
      name: 'ProductType1'
      description: 'Description1'

    productTypeDefinition2 =
      name: 'ProductType2'
      description: 'Description2'

    productTypeDefinitions = [productTypeDefinition1, productTypeDefinition2]

    attributeDefinitions = []

    expectedProductTypeDefinition1 =
      name: 'ProductType1'
      description: 'Description1'

    expectedProductTypeDefinition2 =
      name: 'ProductType2'
      description: 'Description2'

    expectedProductTypeDefinitions = [expectedProductTypeDefinition1, expectedProductTypeDefinition2]

    expect(@generator._createProductTypesDefinitions(productTypeDefinitions, attributeDefinitions)).toEqual expectedProductTypeDefinitions


  it 'should return an array with product type definitions with mastersku', ->

    productTypeDefinition1 =
      name: 'ProductType1'
      description: 'Description1'

    productTypeDefinition2 =
      name: 'ProductType2'
      description: 'Description2'

    productTypeDefinitions = [productTypeDefinition1, productTypeDefinition2]

    masterSKU =
      name: 'mastersku'
      label:
        en: 'Master SKU'
      type: 'text'
      isVariant: 'false'
      isRequired: 'true'
      isSearchable: 'false'
      inputHint: 'SingleLine'

    attributeDefinitions = []

    expectedProductTypeDefinition1 =
      name: 'ProductType1'
      description: 'Description1'
      attributes: [masterSKU]

    expectedProductTypeDefinition2 =
      name: 'ProductType2'
      description: 'Description2'
      attributes: [masterSKU]

    expectedProductTypeDefinitions = [expectedProductTypeDefinition1, expectedProductTypeDefinition2]

    expect(@generator._createProductTypesDefinitions(productTypeDefinitions, attributeDefinitions, masterSKU)).toEqual expectedProductTypeDefinitions

  it 'should return an array with product type definitions with attributes', ->

    productTypeDefinition1 =
      name: 'ProductType1'
      description: 'Description1'
      information: 'x'

    productTypeDefinition2 =
      name: 'ProductType2'
      description: 'Description2'
      size: 'X'

    productTypeDefinitions = [productTypeDefinition1, productTypeDefinition2]

    masterSKU =
      name: 'mastersku'
      label:
        en: 'Master SKU'
      type: 'text'
      isVariant: 'false'
      isRequired: 'true'
      isSearchable: 'false'
      inputHint: 'SingleLine'

    size =
      name: 'size'
      label:
        de: 'Größe'
        en: 'Size'
      type: 'number'
      isVariant: 'false'
      isRequired: 'false'
      isSearchable: 'false'
      inputHint: 'SingleLine'

    information =
      name: 'information'
      label:
        de: 'Information'
        en: 'Information'
      type: 'text'
      isVariant: 'false'
      isRequired: 'false'
      isSearchable: 'false'
      inputHint: 'SingleLine'

    attributeDefinitions =
      size: size
      information: information

    expectedProductTypeDefinition1 =
      name: 'ProductType1'
      description: 'Description1'
      attributes: [information, masterSKU]

    expectedProductTypeDefinition2 =
      name: 'ProductType2'
      description: 'Description2'
      attributes: [size, masterSKU]

    expectedProductTypeDefinitions = [expectedProductTypeDefinition1, expectedProductTypeDefinition2]

    expect(@generator._createProductTypesDefinitions(productTypeDefinitions, attributeDefinitions, masterSKU)).toEqual expectedProductTypeDefinitions

  it 'should skip product types with unkown product attributes', ->

    productTypeDefinition1 =
      name: 'ProductType1'
      description: 'Description1'
      unkownAttribute: 'x'

    productTypeDefinition2 =
      name: 'ProductType2'
      description: 'Description2'
      size: 'x'

    productTypeDefinitions = [productTypeDefinition1, productTypeDefinition2]

    size =
      name: 'size'
      label:
        de: 'Größe'
        en: 'Size'
      type: 'number'
      isVariant: 'false'
      isRequired: 'false'
      isSearchable: 'false'
      inputHint: 'SingleLine'

    attributeDefinitions =
      size: size

    expectedProductTypeDefinition1 =
      name: 'ProductType2'
      description: 'Description2'
      attributes: [size]

    expectedProductTypeDefinitions = [expectedProductTypeDefinition1]

    expect(@generator._createProductTypesDefinitions(productTypeDefinitions, attributeDefinitions)).toEqual expectedProductTypeDefinitions

  it 'should return attribute with product type specific name', ->

    productTypeDefinition =
      name: 'myProductType'
      description: 'myDescription'
      size: 'myAttribName'

    size =
      name: 'size'
      label:
        de: 'Größe'
        en: 'Size'
      type: 'number'
      isVariant: 'false'
      isRequired: 'false'
      isSearchable: 'false'
      inputHint: 'SingleLine'

    attributeDefinitions =
      size: size

    expectedProductTypeDefinition =
      name: 'myProductType'
      description: 'myDescription'
      attributes: [
        name: 'myAttribName'
        label:
          de: 'Größe'
          en: 'Size'
        type: 'number'
        isVariant: 'false'
        isRequired: 'false'
        isSearchable: 'false'
        inputHint: 'SingleLine'
      ]

    expect(@generator._createProductTypesDefinitions([productTypeDefinition], attributeDefinitions)).toEqual [expectedProductTypeDefinition]

  it 'should return attribute definition for attribute masterSKU', ->

    expectedAttributeDefinition =
      name: 'mastersku'
      label:
        en: 'Master SKU'
      type: 'text'
      isVariant: 'false'
      isRequired: 'true'
      isSearchable: 'false'
      inputHint: 'SingleLine'

    expect(@generator._createAttributeDefinitionMasterSku()).toEqual expectedAttributeDefinition
