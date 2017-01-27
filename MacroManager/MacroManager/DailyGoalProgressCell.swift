//
//  DailyGoalProgressCell.swift
//  MacroManager
//
//  Created by Aaron James Edwards on 11/17/16.
//  Copyright © 2016 Aaron Edwards. All rights reserved.
//

import UIKit
import Charts

class DailyGoalProgressCell: UITableViewCell {

 
    @IBOutlet weak var progressChart: HorizontalBarChartView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        progressChart.noDataText = "No Data Available"
        progressChart.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuad)
        progressChart.drawBordersEnabled = false
        
        progressChart.xAxis.drawGridLinesEnabled = false
        progressChart.xAxis.drawAxisLineEnabled = false
        progressChart.xAxis.drawLabelsEnabled = false
        progressChart.rightAxis.axisMaximum = 100
        progressChart.setVisibleYRangeMaximum(100.0, axis: .right)
        progressChart.setVisibleYRangeMaximum(100.0, axis: .left)
        progressChart.drawBarShadowEnabled = true
        
        progressChart.leftAxis.drawAxisLineEnabled = false
        progressChart.leftAxis.drawGridLinesEnabled = false
        progressChart.leftAxis.drawLabelsEnabled = false
        
        progressChart.rightAxis.drawAxisLineEnabled = false
        progressChart.rightAxis.drawGridLinesEnabled = false
        progressChart.rightAxis.drawLabelsEnabled = true
    
        progressChart.legend.enabled = false
    }
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
