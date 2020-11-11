class GridDataValue {

  constructor(dataChanged) {
    this.row = dataChanged[0]
    this.col = dataChanged[1]
    this.oldValue = dataChanged[2]
    this.newValue = dataChanged[3]
  }

}