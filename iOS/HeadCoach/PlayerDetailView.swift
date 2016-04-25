
import Foundation
import UIKit
import SnapKit
import ActionSheetPicker_3_0

class PlayerDetailView: UIView {

    /// Height of the primary header view.
    let HEADER_HEIGHT = CGFloat(100)

    /// The height to use for the draft button (when it is visible).
    let DRAFT_HEIGHT = CGFloat(50)

    /// The height for the 'moreStats/GamesButton'
    let DETAIL_BUTTON_HEIGHT = CGFloat(30)

    var delegate: HCPlayerMoreDetailController?
    let playerImage = UIImageView()
    var teamLabel: UILabel!
    var numLabel: UILabel!
    var textContainer: UIView!
    let headerLabelContainer = UIView()
    var statsLabelsContainer: UIView!
    var personalDetailsContainer: UIView!
    var personalDetailsLabel: UILabel!
    
    var gameTable = UITableView()
    let statusText = UILabel()
    var statusTextContainer: UIView!
    var detailContainer: UIView!
    var statCatButton: UIButton!
    var statOverviewContainer: UIView!
    var stat1Container: UIView!
    var stat1Label: UILabel!
    var stat1Text: UILabel!
    var stat2Container: UIView!
    var stat2Label: UILabel!
    var stat2Text: UILabel!
    var stat3Container: UIView!
    var stat3Label: UILabel!
    var stat3Text: UILabel!
    var stat4Container: UIView!
    var stat4Label: UILabel!
    var stat4Text: UILabel!
    var stat5Container: UIView!
    var stat5Label: UILabel!
    var stat5Text: UILabel!
    var stat6Container: UIView!
    var stat6Label: UILabel!
    var stat6Text: UILabel!
    var statTable: UITableView!
    var statTableContainer: UIView!
    var moreStatsButton: UIButton!
    var moreGamesButton: UIButton!
    var bottom: UIView!
    var bottomDiv: UIView!
    var gameDetailContainer: UIView!
    var gameDetailLabels: GameStatView!
    var gameDetail1: GameStatView!
    var gameDetail2: GameStatView!
    var gameDetail3: GameStatView!
    var gameDetail4: GameStatView!
    var gameDetail5: GameStatView!
    var currentSheetVisibility: SheetVisibility!
    
    let draftButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init (player: FDPlayer, hc_player: HCPlayer,delegate: HCPlayerMoreDetailController) {
        self.init(frame : CGRectZero)
        addCustomView(delegate)
        setPlayer(player)
        currentSheetVisibility = SheetVisibility.Mid
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

    
    func setPlayer(player: FDPlayer){
        if(!player.fantasyPosition.isEmpty){
            teamLabel.text = player.fantasyPosition + " for " + player.team
        }else{
            teamLabel.text = player.team
        }

        numLabel.text = "#" + String(player.number)
        statusText.text = player.status
        statusTextContainer.backgroundColor = getStatusBackground(player.status)
        playerImage.load(player.photoURL)
        setNeedsLayout()
        
    }
    
    func getStatusBackground(status: String) -> UIColor{
        switch(status){
            case "Healthy": return UIColor.footballColor(1.5)
            case "Injured": return UIColor.init(red: 188/255.0, green: 81.0/255.0, blue: 81.0/255.0, alpha: 1.0)
            case "Free Agent": return UIColor.init(red: 81/255.0, green: 124/255.0, blue: 188/255.0, alpha: 1.0)
            default: return UIColor.blackColor()
        }
    }
    
    func addCustomView(delegate: HCPlayerMoreDetailController){
        backgroundColor = UIColor.whiteColor()
        
        detailContainer = UIView()
        detailContainer.backgroundColor = UIColor.clearColor()
        detailContainer.layer.masksToBounds = true
        addSubview(detailContainer)
        
        personalDetailsContainer = UIView()
        personalDetailsContainer.backgroundColor = UIColor.init(red: 0.99, green: 0.99, blue: 0.99, alpha: 1)
        detailContainer.addSubview(personalDetailsContainer)

        addSubview(headerLabelContainer)

        // add the background image to the headerLabelContainer
        let img = UIImageView(image: UIImage(named: "blurred_background"))
        img.contentMode = .ScaleAspectFill
        img.alpha = 0.4

        headerLabelContainer.insertSubview(img, atIndex: 0)
        img.snp_makeConstraints { (make) in
            make.edges.equalTo(headerLabelContainer)
        }

        // add a black view behind the headr label container
        let bg = UIView()
        bg.backgroundColor = UIColor.blackColor()
        headerLabelContainer.insertSubview(bg, belowSubview: img)
        bg.snp_makeConstraints { (make) in
            make.edges.equalTo(img)
        }
        
        statTableContainer = UIView()
        statTableContainer.backgroundColor = UIColor.whiteColor()
        statTableContainer.hidden = true
        detailContainer.addSubview(statTableContainer)
        
        statTable = UITableView()
        statTable.backgroundColor = UIColor.whiteColor()
        statTableContainer.addSubview(statTable)

        statCatButton = UIButton.init(type: UIButtonType.System)
        statCatButton.titleLabel!.font = UIFont.systemFontOfSize(16, weight: UIFontWeightLight)
        statCatButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        statCatButton.backgroundColor = UIColor.footballColor(0.8)
        statCatButton.hidden = true
        personalDetailsContainer.addSubview(statCatButton)
        
        statOverviewContainer = UIView()
        detailContainer.addSubview(statOverviewContainer)
        
        stat1Container = UIView()
        statOverviewContainer.addSubview(stat1Container)
        
        stat1Label = UILabel()
        stat1Label.textAlignment = .Center
        stat1Label.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        stat1Label.font = stat1Label.font.fontWithSize(15)
        stat1Container.addSubview(stat1Label)
        
        stat1Text = UILabel()
        stat1Text.textAlignment = .Center
        stat1Text.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        stat1Text.font = stat1Text.font.fontWithSize(14)
        stat1Container.addSubview(stat1Text)
        
        stat2Container = UIView()
        statOverviewContainer.addSubview(stat2Container)
        
        stat2Label = UILabel()
        stat2Label.textAlignment = .Center
        stat2Label.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        stat2Label.font = stat2Label.font.fontWithSize(15)
        stat2Container.addSubview(stat2Label)
        
        stat2Text = UILabel()
        stat2Text.textAlignment = .Center
        stat2Text.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        stat2Text.font = stat2Text.font.fontWithSize(14)
        stat2Container.addSubview(stat2Text)
        
        stat3Container = UIView()
        statOverviewContainer.addSubview(stat3Container)
        
        stat3Label = UILabel()
        stat3Label.textAlignment = .Center
        stat3Label.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        stat3Label.font = stat3Label.font.fontWithSize(15)
        stat3Container.addSubview(stat3Label)
        
        stat3Text = UILabel()
        stat3Text.textAlignment = .Center
        stat3Text.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        stat3Text.font = stat3Text.font.fontWithSize(14)
        stat3Container.addSubview(stat3Text)
        
        stat4Container = UIView()
        statOverviewContainer.addSubview(stat4Container)
        
        stat4Label = UILabel()
        stat4Label.textAlignment = .Center
        stat4Label.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        stat4Label.font = stat4Label.font.fontWithSize(15)
        stat4Container.addSubview(stat4Label)
        
        stat4Text = UILabel()
        stat4Text.textAlignment = .Center
        stat4Text.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        stat4Text.font = stat4Text.font.fontWithSize(14)
        stat4Container.addSubview(stat4Text)
        
        stat5Container = UIView()
        statOverviewContainer.addSubview(stat5Container)
        
        stat5Label = UILabel()
        stat5Label.textAlignment = .Center
        stat5Label.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        stat5Label.font = stat5Label.font.fontWithSize(15)
        stat5Container.addSubview(stat5Label)
        
        stat5Text = UILabel()
        stat5Text.textAlignment = .Center
        stat5Text.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        stat5Text.font = stat5Text.font.fontWithSize(14)
        stat5Container.addSubview(stat5Text)
        
        stat6Container = UIView()
        statOverviewContainer.addSubview(stat6Container)
        
        stat6Label = UILabel()
        stat6Label.textAlignment = .Center
        stat6Label.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        stat6Label.font = stat6Label.font.fontWithSize(15)
        stat6Container.addSubview(stat6Label)
        
        stat6Text = UILabel()
        stat6Text.textAlignment = .Center
        stat6Text.textColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        stat6Text.font = stat6Text.font.fontWithSize(14)
        stat6Container.addSubview(stat6Text)

        numLabel = UILabel()
        numLabel.textColor = UIColor.whiteColor()
        numLabel.font = UIFont.systemFontOfSize(20, weight: UIFontWeightLight)
        headerLabelContainer.addSubview(numLabel)
        
        teamLabel = UILabel()
        teamLabel.textColor = UIColor.whiteColor()
        teamLabel.font = numLabel.font
        headerLabelContainer.addSubview(teamLabel)
        
        personalDetailsLabel = UILabel()
        personalDetailsLabel.textAlignment = .Center
        personalDetailsLabel.text = "Overview"
        personalDetailsLabel.textColor = UIColor.blackColor()
        personalDetailsLabel.font = personalDetailsLabel.font.fontWithSize(16)
        personalDetailsLabel.backgroundColor = UIColor.clearColor()
        personalDetailsContainer.addSubview(personalDetailsLabel)

        statusTextContainer = UIView()
        statusTextContainer.layer.masksToBounds = true
        statusTextContainer.layer.cornerRadius = 3
        headerLabelContainer.addSubview(statusTextContainer)
        
        statusText.font = statusText.font.fontWithSize(14)
        statusText.textAlignment = .Center
        statusText.textColor = UIColor.whiteColor()
        headerLabelContainer.addSubview(statusText)
        
        draftButton.titleLabel!.font = UIFont.systemFontOfSize(20, weight: UIFontWeightLight)
        draftButton.titleLabel?.textColor = UIColor.whiteColor()
        draftButton.titleLabel!.textAlignment = .Center

        addSubview(playerImage)
        
        bottom = UIView()
        bottom.backgroundColor = UIColor.whiteColor()
        detailContainer.addSubview(bottom)
        
        bottomDiv = UIView()
        bottomDiv.backgroundColor = UIColor.whiteColor()
        bottom.addSubview(bottomDiv)
        
        moreStatsButton = UIButton.init(type: UIButtonType.System)
        moreStatsButton.setTitle("More stats", forState: UIControlState.Normal)
        moreStatsButton.titleLabel!.font = moreStatsButton.titleLabel!.font.fontWithSize(12)
        moreStatsButton.tintColor = UIColor.blackColor()
        moreStatsButton.sizeToFit()
        detailContainer.addSubview(moreStatsButton)
        
        moreGamesButton = UIButton.init(type: UIButtonType.System)
        moreGamesButton.setTitle("More games", forState: UIControlState.Normal)
        moreGamesButton.titleLabel!.font = moreGamesButton.titleLabel!.font.fontWithSize(12)
        moreGamesButton.tintColor = UIColor.blackColor()
        moreGamesButton.sizeToFit()
        bottom.addSubview(moreGamesButton)
        
        gameDetailContainer = UIView()
        gameDetailContainer.backgroundColor = UIColor.whiteColor()
        bottom.addSubview(gameDetailContainer)
        
        gameDetailLabels = GameStatView(style: UITableViewCellStyle.Default, reuseIdentifier: "game")
        gameDetailLabels.week.text = "Week"
        gameDetailLabels.opp.text = "Opp"
        gameDetailLabels.points.text = "Pts"
        gameDetailLabels.started.text = "Started"
        gameDetailLabels.setCustomTextColor(UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5))
        gameDetailContainer.addSubview(gameDetailLabels)
        
        gameDetail1 = GameStatView()
        gameDetailLabels.setCustomTextColor(UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75))
        gameDetailContainer.addSubview(gameDetail1)
        
        gameDetail2 = GameStatView()
        gameDetailLabels.setCustomTextColor(UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75))
        gameDetailContainer.addSubview(gameDetail2)
        
        gameDetail3 = GameStatView()
        gameDetailLabels.setCustomTextColor(UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75))
        gameDetailContainer.addSubview(gameDetail3)
        
        gameDetail4 = GameStatView()
        gameDetailLabels.setCustomTextColor(UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75))
        gameDetailContainer.addSubview(gameDetail4)
        
        gameDetail5 = GameStatView()
        gameDetailLabels.setCustomTextColor(UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.75))
        gameDetailContainer.addSubview(gameDetail5)
        
        gameTable.registerClass(GameStatView.self, forCellReuseIdentifier: "game")
        gameTable.dataSource = delegate
        gameTable.delegate = delegate
        gameTable.hidden = true
        bottom.addSubview(gameTable)

        moreStatsButton.addTarget(self, action: #selector(PlayerDetailView.buttonClicked(_:)), forControlEvents: .TouchUpInside)
        moreGamesButton.addTarget(self, action: #selector(PlayerDetailView.buttonClicked(_:)), forControlEvents: .TouchUpInside)
        statCatButton.addTarget(self, action: #selector(PlayerDetailView.buttonClicked(_:)), forControlEvents: .TouchUpInside)
        addSubview(draftButton)
        
        setConstraints()
        setNeedsLayout()
    }
    
    func setConstraints(){
        /// Offset parametr for use with view layouts.
        let OFFSET = CGFloat(12)

        playerImage.backgroundColor = UIColor.whiteColor()
        playerImage.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top).inset(OFFSET)
            make.left.equalTo(self.snp_left).inset(OFFSET)
            make.height.equalTo(HEADER_HEIGHT - 2 * OFFSET)
            make.width.equalTo(HEADER_HEIGHT - 2 * OFFSET)
        }

        headerLabelContainer.clipsToBounds = true
        headerLabelContainer.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self)
            make.height.equalTo(HEADER_HEIGHT)
        }

        numLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(playerImage.snp_right).offset(OFFSET)
            make.top.equalTo(headerLabelContainer).offset(OFFSET/2.0)
            make.height.equalTo(HEADER_HEIGHT / 2.0)
        }

        teamLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(numLabel.snp_right).offset(5)
            make.top.equalTo(numLabel)
            make.bottom.equalTo(numLabel)
        }

        statusTextContainer.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(numLabel.snp_left)
            make.width.equalTo(100)
            make.height.equalTo(HEADER_HEIGHT / 2.0 - 2 * OFFSET)
            make.bottom.equalTo(headerLabelContainer).offset(-OFFSET)
        }

        statusText.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(statusTextContainer).offset(4)
            make.bottom.right.equalTo(statusTextContainer).offset(-4)
        }

        detailContainer.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(draftButton.snp_bottom)
            make.left.right.equalTo(self)
            make.bottom.equalTo(self.snp_bottom)
        }

        personalDetailsContainer.snp_makeConstraints { (make) in
            make.top.equalTo(detailContainer)
            make.left.equalTo(detailContainer)
            make.right.equalTo(detailContainer)
            make.height.equalTo(40)
        }

        personalDetailsLabel.adjustsFontSizeToFitWidth = true
        personalDetailsLabel.snp_makeConstraints { (make) in
            make.center.equalTo(personalDetailsContainer)
        }

        statOverviewContainer.snp_makeConstraints { (make) in
            make.width.equalTo(detailContainer)
            make.top.equalTo(detailContainer)
            make.height.equalTo(detailContainer).dividedBy(5)
        }

        stat1Container.snp_makeConstraints { (make) in
            make.height.equalTo(detailContainer).multipliedBy(0.15)
            make.width.equalTo(detailContainer).dividedBy(3)
            make.left.equalTo(detailContainer)
            make.top.equalTo(personalDetailsContainer.snp_bottom)
        }

        stat1Label.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(stat1Container.snp_centerX)
            make.bottom.equalTo(stat1Container.snp_centerY)
        }

        stat1Text.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(stat1Container.snp_centerX)
            make.top.equalTo(stat1Container.snp_centerY)
        }

        stat2Container.snp_makeConstraints { (make) in
            make.height.equalTo(stat1Container)
            make.width.equalTo(stat1Container)
            make.top.equalTo(stat1Container)
            make.left.equalTo(stat1Container.snp_right)
        }

        stat2Label.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(stat2Container.snp_centerX)
            make.bottom.equalTo(stat2Container.snp_centerY)
        }

        stat2Text.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(stat2Container.snp_centerX)
            make.top.equalTo(stat2Container.snp_centerY)
        }

        stat3Container.snp_makeConstraints { (make) in
            make.height.equalTo(stat1Container)
            make.width.equalTo(stat1Container)
            make.top.equalTo(stat1Container)
            make.left.equalTo(stat2Container.snp_right)
        }

        stat3Label.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(stat3Container.snp_centerX)
            make.bottom.equalTo(stat3Container.snp_centerY)
        }

        stat3Text.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(stat3Container.snp_centerX)
            make.top.equalTo(stat3Container.snp_centerY)
        }

        stat4Container.snp_makeConstraints { (make) in
            make.left.equalTo(stat1Container)
            make.right.equalTo(stat1Container)
            make.height.equalTo(stat1Container)
            make.top.equalTo(stat1Container.snp_bottom)
        }

        stat4Label.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(stat4Container.snp_centerX)
            make.bottom.equalTo(stat4Container.snp_centerY)
        }

        stat4Text.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(stat4Container.snp_centerX)
            make.top.equalTo(stat4Container.snp_centerY)
        }

        stat5Container.snp_makeConstraints { (make) in
            make.left.equalTo(stat2Container)
            make.right.equalTo(stat2Container)
            make.height.equalTo(stat2Container)
            make.top.equalTo(stat2Container.snp_bottom)
        }

        stat5Label.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(stat5Container.snp_centerX)
            make.bottom.equalTo(stat5Container.snp_centerY)
        }

        stat5Text.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(stat5Container.snp_centerX)
            make.top.equalTo(stat5Container.snp_centerY)
        }

        stat6Container.snp_makeConstraints { (make) in
            make.left.equalTo(stat3Container)
            make.right.equalTo(stat3Container)
            make.height.equalTo(stat3Container)
            make.top.equalTo(stat3Container.snp_bottom)
        }

        stat6Label.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(stat6Container.snp_centerX)
            make.bottom.equalTo(stat6Container.snp_centerY)
        }

        stat6Text.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(stat6Container.snp_centerX)
            make.top.equalTo(stat6Container.snp_centerY)
        }

        statCatButton.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(personalDetailsContainer)
            make.centerX.equalTo(personalDetailsContainer)
            make.width.equalTo(personalDetailsContainer)
        }

        statTableContainer.snp_makeConstraints { (make) in
            make.top.equalTo(personalDetailsContainer.snp_bottom)
            make.left.equalTo(detailContainer)
            make.right.equalTo(detailContainer)
            make.bottom.equalTo(detailContainer)
        }

        statTable.snp_makeConstraints { (make) in
            make.top.equalTo(personalDetailsContainer.snp_bottom)
            make.left.equalTo(detailContainer)
            make.right.equalTo(detailContainer)
            make.bottom.equalTo(bottom.snp_top)
        }

        bottom.snp_makeConstraints { (make) in
            make.left.equalTo(detailContainer)
            make.right.equalTo(detailContainer)
            make.bottom.equalTo(detailContainer)
            make.top.equalTo(stat4Container.snp_bottom).offset(DETAIL_BUTTON_HEIGHT)
        }

        bottomDiv.snp_makeConstraints { (make) in
            make.left.equalTo(bottom)
            make.right.equalTo(bottom)
            make.top.equalTo(bottom)
            make.height.equalTo(1)
        }

        moreStatsButton.backgroundColor = UIColor(white: 0.92, alpha: 1.0)
        moreStatsButton.snp_makeConstraints { (make) in
            make.bottom.equalTo(bottom.snp_top)
            make.left.right.equalTo(self)
            make.height.equalTo(DETAIL_BUTTON_HEIGHT)
        }

        moreGamesButton.backgroundColor = UIColor(white: 0.92, alpha: 1.0)
        moreGamesButton.snp_makeConstraints { (make) in
            make.top.equalTo(bottomDiv.snp_bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(DETAIL_BUTTON_HEIGHT)
        }

        gameDetailContainer.snp_makeConstraints { (make) in
            make.left.equalTo(bottom)
            make.right.equalTo(bottom)
            make.bottom.equalTo(bottom)
            make.top.equalTo(moreGamesButton.snp_bottom)
        }

        gameDetailLabels.snp_makeConstraints { (make) in
            make.left.equalTo(gameDetailContainer)
            make.right.equalTo(gameDetailContainer)
            make.top.equalTo(gameDetailContainer)
            make.height.equalTo(gameDetailContainer).dividedBy(6)
        }

        gameDetail1.snp_makeConstraints { (make) in
            make.left.equalTo(gameDetailLabels)
            make.right.equalTo(gameDetailLabels)
            make.top.equalTo(gameDetailLabels.snp_bottom)
            make.height.equalTo(gameDetailLabels)
        }

        gameDetail2.snp_makeConstraints { (make) in
            make.left.equalTo(gameDetailLabels)
            make.right.equalTo(gameDetailLabels)
            make.top.equalTo(gameDetail1.snp_bottom)
            make.height.equalTo(gameDetailLabels)
        }

        gameDetail3.snp_makeConstraints { (make) in
            make.left.equalTo(gameDetailLabels)
            make.right.equalTo(gameDetailLabels)
            make.top.equalTo(gameDetail2.snp_bottom)
            make.height.equalTo(gameDetailLabels)
        }

        gameDetail4.snp_makeConstraints { (make) in
            make.left.equalTo(gameDetailLabels)
            make.right.equalTo(gameDetailLabels)
            make.top.equalTo(gameDetail3.snp_bottom)
            make.height.equalTo(gameDetailLabels)
        }

        gameDetail5.snp_makeConstraints { (make) in
            make.left.equalTo(gameDetailLabels)
            make.right.equalTo(gameDetailLabels)
            make.top.equalTo(gameDetail4.snp_bottom)
            make.height.equalTo(gameDetailLabels)
        }

        gameTable.snp_makeConstraints { (make) in
            make.left.equalTo(bottom)
            make.right.equalTo(bottom)
            make.bottom.equalTo(bottom)
            make.top.equalTo(moreGamesButton.snp_bottom)
        }
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()

        playerImage.layer.masksToBounds=true
        playerImage.layer.cornerRadius = playerImage.bounds.width / 2
        playerImage.contentMode = .ScaleAspectFill
    }
    
    func setOverviewStatData(stat1Label: String, stat1Text: String?, stat2Label: String, stat2Text: String?, stat3Label: String, stat3Text: String?, stat4Label: String, stat4Text: String?, stat5Label: String, stat5Text:String?, stat6Label: String, stat6Text: String?){
        self.stat1Label.text = stat1Label
        self.stat1Text.text = stat1Text == nil ? "-" : stat1Text
        self.stat2Label.text = stat2Label
        self.stat2Text.text = stat2Text == nil ? "-" : stat2Text
        self.stat3Label.text = stat3Label
        self.stat3Text.text = stat3Text == nil ? "-" : stat3Text
        self.stat4Label.text = stat4Label
        self.stat4Text.text = stat4Text == nil ? "-" : stat4Text
        self.stat5Label.text = stat5Label
        self.stat5Text.text = stat5Text == nil ? "-" : stat5Text
        self.stat6Label.text = stat6Label
        self.stat6Text.text = stat6Text == nil ? "-" : stat6Text
    }
    
    func setOverviewGameData(forGameStatView gameStatViewNum: Int, game: Game){
        var gsv: GameStatView!
        switch(gameStatViewNum){
        case 0: gsv = gameDetail1
        case 1: gsv = gameDetail2
        case 2: gsv = gameDetail3
        case 3: gsv = gameDetail4
        case 4: gsv = gameDetail5
        default: gsv = gameDetail1
        }
        gsv.setGame(game)
    }
    
    func buttonClicked(sender: AnyObject?) {
        if sender === moreGamesButton {
            if(currentSheetVisibility == SheetVisibility.Full){
                updateSheet(SheetVisibility.Mid)
            }else if(currentSheetVisibility == SheetVisibility.Mid){
                updateSheet(SheetVisibility.Full)
            }
        }else if sender === moreStatsButton{
            if(currentSheetVisibility == SheetVisibility.Mid){
                updateSheet(SheetVisibility.Gone)
            }else if(currentSheetVisibility == SheetVisibility.Gone){
                updateSheet(SheetVisibility.Mid)
            }
        }else if sender === statCatButton{
            showPicker(sender as! UIView)
        }
    }
    
    func showPicker(sender: UIView) {
        if let vc = delegate {
            var index = 0
            if vc.currentCat != nil && vc.statPickerData.contains(vc.currentCat) {
                index = vc.statPickerData.indexOf(vc.currentCat)!
            }

            ActionSheetStringPicker.showPickerWithTitle("Stats", rows: vc.statPickerData, initialSelection: index, doneBlock: { (picker, index, str) in
                vc.currentCat = vc.statPickerData[index]
                self.statCatButton.setTitle("Category: \(vc.currentCat)", forState: .Normal)
                self.statTable.reloadData()
             }, cancelBlock: { (picker) in }, origin: sender)
        }
    }
    
    func updateSheet(newVisibility: SheetVisibility){
        switch(newVisibility){
        case SheetVisibility.Gone:
            if(currentSheetVisibility == SheetVisibility.Mid || currentSheetVisibility == SheetVisibility.Full){
                currentSheetVisibility = SheetVisibility.Gone
            }
            break
        case SheetVisibility.Mid:
            if(currentSheetVisibility == SheetVisibility.Full || currentSheetVisibility == SheetVisibility.Gone){
                currentSheetVisibility = SheetVisibility.Mid
            }
            break
        case SheetVisibility.Full:
            if(currentSheetVisibility == SheetVisibility.Mid || currentSheetVisibility == SheetVisibility.Gone){
                currentSheetVisibility = SheetVisibility.Full
            }
            break
        }
        updateSheetSize(newVisibility)
    }
    
    func updateSheetSize(newVisibility: SheetVisibility){
        switch(newVisibility){
        case SheetVisibility.Gone:
            bottom.snp_remakeConstraints(closure: { (make) in
                make.left.equalTo(detailContainer)
                make.right.equalTo(detailContainer)
                make.bottom.equalTo(detailContainer)
                make.top.equalTo(detailContainer.snp_bottom)
            })
            self.statTableContainer.hidden = false
            self.statCatButton.hidden = false
            UIView.animateWithDuration(0.5, animations: {
                self.statTableContainer.alpha = 1.0
                self.moreGamesButton.alpha = 0.0
                self.statCatButton.alpha = 1.0
                self.statOverviewContainer.alpha = 0.0
                }, completion: { b in
                    if(b){
                        self.moreGamesButton.hidden = true
                        self.statOverviewContainer.hidden = true
                    }
            })
            personalDetailsLabel.hidden = true
            moreStatsButton.setTitle("Less", forState: UIControlState.Normal)
            break
        case SheetVisibility.Mid:
            bottom.snp_remakeConstraints(closure: { (make) in
                make.left.equalTo(detailContainer)
                make.right.equalTo(detailContainer)
                make.bottom.equalTo(detailContainer)
                make.top.equalTo(stat4Container.snp_bottom).offset(DETAIL_BUTTON_HEIGHT)
            })
            personalDetailsLabel.snp_remakeConstraints(closure: { (make) in
                make.center.equalTo(personalDetailsContainer)
            })
            self.statOverviewContainer.hidden = false
            self.moreStatsButton.hidden = false
            self.moreGamesButton.hidden = false
            self.personalDetailsLabel.hidden = false
            UIView.animateWithDuration(0.5, animations: {
                self.statTableContainer.alpha = 0.0
                self.gameTable.alpha = 0.0
                self.moreGamesButton.alpha = 1.0
                self.moreStatsButton.alpha = 1.0
                self.statCatButton.alpha = 0.0
                self.statOverviewContainer.alpha = 1.0
                self.personalDetailsLabel.text = "Overview"
                }, completion: { b in
                    if(b){
                        self.gameTable.hidden = true
                        self.statTableContainer.hidden = true
                    }
            })
            moreGamesButton.setTitle("More games", forState: UIControlState.Normal)
            moreStatsButton.setTitle("More stats", forState: UIControlState.Normal)
            break
        case SheetVisibility.Full:
            bottom.snp_remakeConstraints(closure: { (make) in
                make.left.equalTo(detailContainer)
                make.right.equalTo(detailContainer)
                make.bottom.equalTo(detailContainer)
                make.top.equalTo(personalDetailsContainer.snp_bottom)
            })
            gameTable.hidden = false
            UIView.animateWithDuration(0.5, animations: {
                self.statTableContainer.alpha = 0.0
                self.moreStatsButton.alpha = 0.0
                self.gameTable.alpha = 1.0
                }, completion: { b in
                    if(b){
                        self.statTableContainer.hidden = true
                        self.moreStatsButton.hidden = true
                    }
            })
            personalDetailsLabel.hidden = false
            personalDetailsLabel.text = "Performance"
            moreGamesButton.setTitle("Less", forState: UIControlState.Normal)
            break
        }
        UIView.animateWithDuration(0.5){
            self.detailContainer.layoutIfNeeded()
        }
    }
    
    func setUpTableView(initialCategory: String, delegate: HCPlayerMoreDetailController){
        statCatButton.setTitle("Category: \(initialCategory)", forState: UIControlState.Normal)
        statTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "stat")
        statTable.delegate = delegate
        statTable.dataSource = delegate
        statTable.setNeedsLayout()
    }
    
    enum SheetVisibility: Int{
        case Gone = 0
        case Mid = 1
        case Full = 2
    }
}